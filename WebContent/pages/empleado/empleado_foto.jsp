<%@ include file="/taglibs.jsp"%>
<style>
#croppic {
			width: 245px;
			height: 245px;
			position:relative; /* or fixed or absolute */
			margin:15px;
			
		}
</style>
<script type="text/javascript">
	$(document).ready(function() {		
		
		
		
		
		$("#fEditarfotoEmpleado [name=btnEditarfoto]").button();
		$("#fEditarfotoEmpleado [name=btnEditarCancelarSubirfoto]").button();		
	
	
		$("#fEditarfotoEmpleado").validate({
			//errorLabelContainer: "#msnBuscarCargue",
			errorClass: "invalid",
			rules: {
				myOutputId:{
					required: true
				}
			},
			messages: {
				myOutputId: {
					required: "Ingrese una foto."
				}
			},
			submitHandler: function(form) {
				EditarFoto(form);
			}
		});

		
	});
	
	
	
	function editarCancelarsubirfoto(idempleado) {
		$('#dmEditarfoto').dialog('close');
		//visualizarDetalleEmpleado(idempleado);
	}
 
	function EditarFoto(form) {
		//alert("envia");
		$("[name=btnEditarfoto]").attr('disabled',true);
		$("[name=btnEditarCancelarSubirfoto]").attr('disabled',true);
		$("#dmMensajeEmpleado").dialog("open");
		$("#dmMensajeEmpleado").html(getHTMLLoaging16(' Grabando'));
		$.ajax({
			cache: false,
			contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
            type: $(form).attr('method'),            
            url: $(form).attr('action'),
            data: $(form).serialize(),
            dataType: "text",
            error: function(jqXHR, textStatus, errorThrown) {
            	$("[name=btnEditarfoto]").attr('disabled',false);
        		$("[name=btnEditarCancelarSubirfoto]").attr('disabled',false);
                $("#dmMensajeEmpleado").html(jqXHR.statusText);
	        },
            success: function(data) {    
            	if(validarEntero(data)){
            		$("#dmMensajeEmpleado").dialog("close");
            		$("#dmEditarEmpleado").dialog("close");
                	$("#dmEditarfoto").dialog("close");
            		visualizarDetalleEmpleado(data);
                } else {
                	$("[name=btnEditarfoto]").attr('disabled',false);
            		$("[name=btnEditarCancelarSubirfoto]").attr('disabled',false);
                    $("#dmMensajeEmpleado").html('Error desconocido');					
                }            		 
            }
        });
	}

 
	
	
	
	var croppicHeaderOptions = {
			outputUrlId:'myOutputId',
			uploadUrl:'${ctx}/page/empleadofoto?action=uploadimagen',
			cropData:{
				"dummyData":1,
				"idempleado":'${empleado.idempleado}',
				"dummyData2":"asdas"
			},
			uploadData:{
				"dummyData":1,
				"idempleado":'${empleado.idempleado}',
				"dummyData2":"asdas"
			},
			//cropUrl:'${ctx}/page/empleadofoto?action=imagen',
			//loadPicture:'${ctx}/imagen/camera.png',
			cropUrl:'${ctx}/page/empleadofoto?action=cropimagen',
			customUploadButtonId:'cropContainerHeaderButton',
			modal:false,
			processInline:true,
			loaderHtml:'<div class="loader bubblingG"><span id="bubblingG_1"></span><span id="bubblingG_2"></span><span id="bubblingG_3"></span></div> ',
			  onBeforeImgUpload: function(){ console.log('onBeforeImgUpload') },
			onAfterImgUpload: function(){ console.log('onAfterImgUpload') },
			onImgDrag: function(){ console.log('onImgDrag') },
			onImgZoom: function(){ console.log('onImgZoom') },
			onBeforeImgCrop: function(){ console.log('onBeforeImgCrop') },
			onAfterImgCrop:function(){console.log('onAfterImgCrop') },
			onError:function(errormessage){ console.log('onError:'+errormessage) } 
	}	
	var croppic = new Croppic('croppic', croppicHeaderOptions);
	
	
	
</script>

 	
<div align="left">
<c:choose>
		<c:when test="${empty empleado}">
			<div class="msgInfo1" align="left">No existe el empleado.</div>
		</c:when>
		<c:otherwise>


<div></div>
<form name="fEditarfotoEmpleado" id="fEditarfotoEmpleado"  action="${ctx}/page/empleadofoto" method="post">
<input type="hidden" name="action" value="empleado_editar_foto"/>
<input type="hidden" name="idempleado" value="${empleado.idempleado}"/>
<div><button type="button" id="btnEditarCancelarSubirfoto" name="btnEditarCancelarSubirfoto" onclick="editarCancelarsubirfoto(${empleado.idempleado});">Cancelar</button>&nbsp;&nbsp;&nbsp;<button type="submit" id="btnEditarfoto" name="btnEditarfoto">Grabar</button></div>

<br/>
<fieldset><legend class="e6">Foto empleado</legend>
<div class="texto1">1. Cargue una foto haciendo click en la camara</div>  

<div class="texto1">2. Ajuste la foto con los controles y haga click en el icono verde para dejar la definitiva</div> 

<div class="texto1">3. Haga click en guardar para subir la foto</div> 
				
<table border="0" width="100%" class="caja">
<col style="width: 50%"/>
<col/>
 <tr>
	
	
	<td align="center">
	<div align="center" style="overflow: hidden">
		
			<div id="croppic"></div>
			
			<span class="btn" id="cropContainerHeaderButton">click pasa subir foto<img alt="Cargar foto" src="${ctx}/imagen/camera.png"></span>
	</div>
	<div>
	<input  type="text" name="myOutputId" id="myOutputId" readonly="readonly">
	</div>
	</td>
</tr>
<tr>

</table>
</fieldset>
<br/>
<div>
<button type="button" id="btnEditarCancelarSubirfoto" name="btnEditarCancelarSubirfoto" onclick="editarCancelarsubirfoto(${empleado.idempleado});">Cancelar</button>&nbsp;&nbsp;&nbsp;
<button type="submit" id="btnEditarfoto" name="btnEditarfoto">Grabar</button></div>
</form>
<br/>


<%-- <fieldset><legend class="e6">Cuentas asociadas</legend>
<br/>
<div>
<form name="fCrearUsuarioCuenta" id="fCrearUsuarioCuenta" action="${ctx}/page/usuariocuenta" method="post">
<input type="hidden" name="action" value="usuariocuenta_insertar"/>
<input type="hidden" name="idusuario" value="${usuario.idusuario}"/>
<table border="0" width="100%" class="caja">
<col style="width: 30%"/>
<col />
<col style="width: 20%"/>
<tr>
<th>Cuenta tipo</th>
<th>Cuenta</th>
<th></th>
</tr>
<tbody>
<tr>
<td valign="middle">
<select name="idcuenta">
<option value=""></option>
<c:forEach items="${cuentas}" var="cuenta" varStatus="loop">
<option value="${cuenta.idcuenta}"><c:out value="${cuenta.idcuenta}"/> - <c:out value="${cuenta.nombre}"/></option>
</c:forEach>
</select>
</td>
<td valign="middle"><input type="text" name="dato" value=""/></td>
<td><button type="submit" id="btnCrearUsuarioCuenta" name="btnCrearUsuarioCuenta">Asociar cuenta</button></td>
</tr>
</tbody>
</table>
</form>
</div>
<br/>
<c:choose>
	<c:when test="${fn:length(usuariocuentas) eq 0}">
		<div class="msgInfo1" align="left">No tiene asignado ninguna cuenta.</div>
	</c:when>		
	<c:otherwise>
	<table border="0" width="100%" class="tExcel tRowSelect">
	<col style="width: 6px"/>
	<col />
	<col />
	<col style="width: 50px"/>
	<col style="width: 95px"/>
	<col style="width: 50px"/>
	<col style="width: 95px"/>	
	<col style="width: 75px"/>
	<tr>
	<th>Cod. Cuenta</th>
	<th>Cuenta tipo</th>
	<th>Cuenta</th>
	<th>User crea</th>
	<th>Fecha crea</th>
	<th>User mod</th>
	<th>Fecha mod</th>	
	<th>Estado</th>	
	</tr>
	<tbody>
	
	<c:forEach items="${usuariocuentas}" var="usuariocuenta" varStatus="loop">
	<tr style="color: ${usuariocuenta.estado==2?'':'red'};">
	<td><c:out value="${usuariocuenta.cuenta.idcuenta}"/></td>
	<td><c:out value="${usuariocuenta.cuenta.nombre}"/></td>
	<td><c:out value="${usuariocuenta.dato}"/></td>
	<td><c:out value="${usuariocuenta.idusuariocrea}"/></td>
	<td><fmt:formatDate value="${usuariocuenta.fechacrea}" pattern="dd/MM/yyyy H:mm"/></td>
	<td><c:out value="${usuariocuenta.idusuariomod}"/></td>
	<td><fmt:formatDate value="${usuariocuenta.fechamod}" pattern="dd/MM/yyyy H:mm"/></td>
	<td><c:out value="${usuariocuenta.estadob.nombre}"/></td>	
	</tr>
	</c:forEach>			  
	</tbody>
	</table>
	</c:otherwise>
</c:choose>

</fieldset> --%>
<br/>


<%-- <fieldset><legend class="e6">Aplicaciones</legend>
<br/>
<div>
<form name="fCrearUsuarioAplicacion" id="fCrearUsuarioAplicacion" action="${ctx}/page/usuarioaplicacion" method="post">
<input type="hidden" name="action" value="usuarioaplicacion_insertar"/>
<input type="hidden" name="idusuario" value="${usuario.idusuario}"/>
<table border="0" width="100%" class="caja">
<col style="width: 30%"/>
<col />
<col style="width: 20%"/>
<tr>
<th>Aplicación</th>
<th>Grupo / Tipo</th>
<th></th>
</tr>
<tbody>
<tr>
<td valign="middle">
<select name="idaplicacion">
<option value=""></option>
<c:forEach items="${aplicaciones}" var="aplicacion" varStatus="loop">
<option value="${aplicacion.idaplicacion}"><c:out value="${aplicacion.idaplicacion}"/> - <c:out value="${aplicacion.nombre}"/></option>
</c:forEach>
</select>
</td>
<td valign="middle"><div id="divGrupoAplicacion"></div></td>
<td><button type="submit" id="btnCrearUsuarioAplicacion" name="btnCrearUsuarioAplicacion">Asociar aplicación</button></td>
</tr>
</tbody>
</table>
</form>
</div>
<br/>
<c:choose>
		<c:when test="${fn:length(usuarioaplicaciones) eq 0}">
			<div class="msgInfo1" align="left">No tiene asignado ninguna aplicación.</div>
		</c:when>		
		<c:otherwise>
		<table border="0" width="100%" class="tExcel tRowSelect">
		<col style="width: 6px"/>
		<col />
		<col />
		<col style="width: 50px"/>
		<col style="width: 95px"/>
		<col style="width: 50px"/>
		<col style="width: 95px"/>	
		<col style="width: 75px"/>
		<tr>
		<th>Cod Aplicación</th>
		<th>Aplicación</th>
		<th>Grupo / Tipo</th>
		<th>User crea</th>
		<th>Fecha crea</th>
		<th>User mod</th>
		<th>Fecha mod</th>	
		<th>Estado</th>
		</tr>
		<tbody>
		
		<c:forEach items="${usuarioaplicaciones}" var="usuarioaplicacion" varStatus="loop">
		<tr style="color: ${usuarioaplicacion.estado==2?'':'red'};">
		<td><c:out value="${usuarioaplicacion.aplicacion.idaplicacion}"/></td>
		<td><c:out value="${usuarioaplicacion.aplicacion.nombre}"/></td>
		<td><c:out value="${usuarioaplicacion.grupo.nombre}"/> / <c:out value="${usuarioaplicacion.grupo.grupotipo.nombre}"/></td>
		<td><c:out value="${usuarioaplicacion.idusuariocrea}"/></td>
		<td><fmt:formatDate value="${usuarioaplicacion.fechacrea}" pattern="dd/MM/yyyy H:mm"/></td>
		<td><c:out value="${usuarioaplicacion.idusuariomod}"/></td>
		<td><fmt:formatDate value="${usuarioaplicacion.fechamod}" pattern="dd/MM/yyyy H:mm"/></td>
		<td><c:out value="${usuarioaplicacion.estadob.nombre}"/></td>
		</tr>			 
		</c:forEach>
				  
		</tbody>
		</table>
		</c:otherwise>
</c:choose>

</fieldset> --%>
<br/>
</c:otherwise>
</c:choose>
</div>
<div style="padding: 30px 0px;"></div>

