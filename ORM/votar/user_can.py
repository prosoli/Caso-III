from sqlalchemy import select                          
from database import SessionLocal                       
from Models.votar.models import (                        
    User, PermissionResource, PermissionAction, Permission, 
    UserRole, RolePermission
)

def user_can(id_user: int, resource_name: str, action_name: str) -> bool:
    with SessionLocal() as session:                      # abre una nueva sesion con la base de datos
        # 1) Usuario activo
        user = session.get(User, id_user)                # Intenta cargar el usuario por su PK
        if not user or not user.enable or user.deleted:  # Si no existe, esta deshabilitado o marcado como eliminado
            return False                              

        # 2) Resource y Action
        resource = session.scalar(                        # Busca el recurso por nombre en la tabla PermissionResource
            select(PermissionResource)
            .where(
                PermissionResource.name == resource_name,
                PermissionResource.enabled == True,      # Asegura que el recurso este activo
                PermissionResource.deleted == False      # Asegura que no este marcado como eliminado
            )
        )
        action = session.scalar(                          # Busca la acción SELECT/INSERT/UPDATE/DELETE por nombre
            select(PermissionAction)
            .where(PermissionAction.name == action_name)
        )
        if not resource or not action:                    # Si no encontro recurso o accion vzlida
            return False                              

        # 3) Permiso
        stmt = (                                         # Construye la query para verificar permiso efectivo
            select(Permission)
            .join(RolePermission,                        # Une Permission con RolePermission
                  RolePermission.id_permission == Permission.id_permission)
            .join(UserRole,                              # Une RolePermission con UserRole
                  UserRole.id_role == RolePermission.id_role)
            .where(
                UserRole.idUser == id_user,                  # Filtra por este usuario
                UserRole.enabled == True,                     # Rol habilitado
                UserRole.deleted == False,                    # Rol no eliminado
                Permission.id_permisionResource == resource.id_permissionResource,  # Coincide recurso
                Permission.id_permissionAction == action.id_permissionAction,       # Coincide acción
                Permission.enabled == True,                     # Permiso habilitado
                Permission.deleted == False                     # Permiso no eliminado
            )
        )
        return session.scalar(stmt) is not None          # Ejecuta la query y devuelve True si encontro al menos un registro
