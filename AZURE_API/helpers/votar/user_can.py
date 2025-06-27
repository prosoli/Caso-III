from sqlalchemy import select
from database import SessionLocal
from Models.votar.models import (
    User, PermissionResource, PermissionAction, Permission, 
    UserRole, RolePermission
)

def user_can(id_user: int, resource_name: str, action_name: str) -> bool:
    with SessionLocal() as session:
        # 1) Usuario activo
        user = session.get(User, id_user)
        if not user or not user.enable or user.deleted:
            return False

        # 2) Resource & Action
        resource = session.scalar(
            select(PermissionResource)
            .where(
                PermissionResource.name == resource_name,
                PermissionResource.enabled == True,
                PermissionResource.deleted == False
            )
        )
        action = session.scalar(
            select(PermissionAction)
            .where(PermissionAction.name == action_name)
        )
        if not resource or not action:
            return False

        # 3) Permiso
        stmt = (
            select(Permission)
            .join(RolePermission, RolePermission.id_permission == Permission.id_permission)
            .join(UserRole, UserRole.id_role == RolePermission.id_role)
            .where(
                UserRole.idUser == id_user,
                UserRole.enabled == True,
                UserRole.deleted == False,
                Permission.id_permisionResource == resource.id_permissionResource,
                Permission.id_permissionAction == action.id_permissionAction,
                Permission.enabled == True,
                Permission.deleted == False
            )
        )
        return session.scalar(stmt) is not None