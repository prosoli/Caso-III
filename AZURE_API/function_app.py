import azure.functions as func

from Endpoints_SP.get_usuarios_sp import get_usuarios_sp
from Endpoints_SP.invertir_sp import invertir
from Endpoints_SP.revisarPropuesta_sp import revisarPropuesta_sp

from Endpoints_SP.crearActualizarPropuesta import crearActualizarPropuesta
from Endpoints_ORM.get_usuarios_orm import get_usuarios_orm
from Endpoints_ORM.configurarVotacion_orm import configurarVotacionORM





app = func.FunctionApp()

#Aca se definen las rutas que seran parte del api

#EndPoint por SP-------------------------------------------------------------------------------------------------
@app.function_name(name="crearActualizarPropuesta")
@app.route(route="crearActualizarPropuesta", methods=["POST"], auth_level=func.AuthLevel.ANONYMOUS)
def run_crearActualizarPropuesta(req: func.HttpRequest) -> func.HttpResponse:
    return crearActualizarPropuesta(req)
app.route(route="get_usuarios_sp", auth_level=func.AuthLevel.ANONYMOUS)(get_usuarios_sp) #EJEMPLO poner el nombre del archivo importado
app.route(route="invertir", auth_level=func.AuthLevel.ANONYMOUS)(invertir)
app.route(route="revisarPropuesta_sp", auth_level=func.AuthLevel.ANONYMOUS)(revisarPropuesta_sp)

#EndPoint con ORM------------------------------------------------------------------------------------------------
app.route(route="get_usuarios_orm", auth_level=func.AuthLevel.ANONYMOUS)(get_usuarios_orm)

#Configurar votaciones por ORM
app.route(route="configurarVotacionORM", auth_level=func.AuthLevel.ANONYMOUS)(configurarVotacionORM)








