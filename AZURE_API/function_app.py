import azure.functions as func

from Endpoints_SP.get_usuarios_sp import get_usuarios_sp

from Endpoints_ORM.get_usuarios_orm import get_usuarios_orm

app = func.FunctionApp()

#Aca se definen las rutas que seran parte del api

#EndPoint por SP
app.route(route="get_usuarios_sp", auth_level=func.AuthLevel.ANONYMOUS)(get_usuarios_sp) #EJEMPLO poner el nombre del archivo importado



#EndPoint con ORM
app.route(route="get_usuarios_orm", auth_level=func.AuthLevel.ANONYMOUS)(get_usuarios_orm)




