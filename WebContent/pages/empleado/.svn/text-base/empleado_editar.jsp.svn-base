<%@ include file="/taglibs.jsp"%>
<style>
#croppic {
			width: 245px;
			height: 220px;
			position:relative; /* or fixed or absolute */
			margin:5px;
			
		}
</style>
<script type="text/javascript">
	jQuery.validator.addMethod("loginregex", function(value, element) {
	    return this.optional(element) || /^[a-zA-Z0-9\_]+$/.test(value);
	});
	
	/* var croppicContaineroutputMinimal = {
			uploadUrl:'${ctx}/page/empleadofoto?action=imagen',
			cropUrl:'${ctx}/page/empleadofoto?action=imagen', 
			uploadData:{
				"idempleado":'${idempleado}',
				"dummyData2":"text"
			},
			modal:false,
			doubleZoomControls:true,
		    rotateControls: true,
			loaderHtml:'<div class="loader bubblingG"><span id="bubblingG_1"></span><span id="bubblingG_2"></span><span id="bubblingG_3"></span></div> '
	}
	var cropContaineroutput = new Croppic('foto', croppicContaineroutputMinimal); */
	
	
	
	
	
	$(document).ready(function() {		
		
		
		
		
		
		$("#fEditarEmpleado [name=btnSubirfoto]").button();
		$("#fEditarEmpleado [name=btnEditarEmpleado]").button();
		$("#fEditarEmpleado [name=btnEditarCancelarEmpleado]").button();		
		$("#fCrearUsuarioAplicacion [name=btnCrearUsuarioAplicacion]").button();
		$("#fCrearUsuarioCuenta [name=btnCrearUsuarioCuenta]").button();
	
		var dates = $("#fechanacimiento, #txtTo")
		.datepicker(
		{
			dateFormat : "dd/mm/yy",
			maxDate : '+0D',
			//minDate : '-0D',
			minyear:'-80Y',
			numberOfMonths : 1,
			 changeMonth: true,
			 changeYear: true,
			//showAnim: 'fold',
			dayNamesMin : [ 'Do', 'Lu', 'Ma',
					'Mi', 'Ju', 'Vi', 'Sa' ],
			monthNames : [ 'Enero', 'Febrero',
					'Marzo', 'Abril', 'Mayo',
					'Junio', 'Julio', 'Agosto',
					'Septiembre', 'Octubre',
					'Noviembre', 'Diciembre' ],
			monthNamesShort : [ 'Ene', 'Feb',
					'Mar', 'Abr', 'May', 'Jun',
					'Jul', 'Ago', 'Sep', 'Oct',
					'Nov', 'Dic' ],
			onSelect : function(selectedDate) {
				var option = this.id == "fechanacimiento" ? "minDate"
						: "maxDate", instance = $(this)
						.data("datepicker"), date = $.datepicker
						.parseDate(instance.settings.dateFormat || $.datepicker._defaults.dateFormat, selectedDate, instance.settings); 
				dates.not(this).datepicker("option", option, date);
			}
		});

		$("#fEditarEmpleado").validate({
			//errorLabelContainer: "#msnBuscarCargue",
			errorClass: "invalid",
			rules: {
				
				ididentificaciontipo:{
					required: true,
					min:1
				},
				numidentificacion:{
					required: true,
					digits: true
				},
				ciudadexpedicion:{
					required: true					
				},
				idgenero:{
					required: true
					
				},
				fechanacimiento:{
					required: true
				},
				nombres:{
					required: true
				},
				apellidos:{
					required: true
				}
			},
			messages: {
				
				ididentificaciontipo:{
					required: "Seleccione una opción para tipo de identificación",
					digits: "Seleccione una opción para tipo de identificación"
				},
				numidentificacion: {
					required: "Ingrese un valor.",
					digits: "Ingrese solo dígitos"
				},
				ciudadexpedicion: {
					required: "Ingrese un valor."
				},
				idgenero: {
					required: "Ingrese un valor.",
					
				},
				fechanacimiento: {
					required: "Ingrese un valor."
				},	
				nombres: {
					required: "Ingrese un valor."
				},	
				apellidos: {
					required: "Ingrese un valor."
				}
			},
			submitHandler: function(form) {
				editarUsuario(form);
			}
		});

		$("#fCrearUsuarioAplicacion").validate({
			//errorLabelContainer: "#msnBuscarCargue",
			errorClass: "invalid",
			rules: {
				idaplicacion:{
					required: true
				},
				idgrupo:{
					required: true
				},
				idusuario:{
					required: true
				}
			},
			messages: {
				idaplicacion: {
					required: "Seleccione un valor."
				},
				idgrupo: {
					required: "Seleccione un valor."
				},
				idusuario: {
					required: "Ingrese un valor."
				}
			},
			submitHandler: function(form) {
				crearUsuarioAplicacion(form);
			}
		});

		$("#fCrearUsuarioAplicacion [name=idaplicacion]").change( function() {
			var idaplicacion =  $(this).val();
			if(idaplicacion==''){
				$("#divGrupoAplicacion").html('');
			}else{
				$("#fCrearUsuarioAplicacion [name=idaplicacion]").attr('disabled',true);	
				$.ajax({
					cache: false,
					contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
		            type: 'post',            
		            url: '${ctx}/page/grupo?action=grupo_aplicacion&idaplicacion='+idaplicacion,
		            data: '',
		            dataType: "text",
		            error: function(jqXHR, textStatus, errorThrown) {
			            alert(jqXHR.statusText);
		            	$("#fCrearUsuarioAplicacion [name=idaplicacion]").attr('disabled',false);
			        },
		            success: function(data) {
		            	$("#fCrearUsuarioAplicacion [name=idaplicacion]").attr('disabled',false);
		                $("#divGrupoAplicacion").html(data);
		            }
		        });	 
			}
		});
		
	});

	function crearUsuarioAplicacion(form) {
		$("[name=btnCrearUsuarioAplicacion]").attr('disabled',true);;
		$("#dmMensajeEmpleado").dialog("open");
		$("#dmMensajeEmpleado").html(getHTMLLoaging16(' Creando'));
		$.ajax({
			cache: false,
			contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
            type: $(form).attr('method'),            
            url: $(form).attr('action'),
            data: $(form).serialize(),
            dataType: "text",
            error: function(jqXHR, textStatus, errorThrown) {
            	$("[name=btnCrearUsuarioAplicacion]").attr('disabled',false);        		
                $("#dmMensajeEmpleado").html(jqXHR.statusText);
	        },
            success: function(data) {    
            	if(validarEntero(data)){
            		$("#dmMensajeEmpleado").dialog("close");
                	$("#dmNuevoUsuario").dialog("close");
            		visualizarEdicionUsuario(data);
                } else {
                	$("[name=btnCrearUsuarioAplicacion]").attr('disabled',false);
                    $("#dmMensajeEmpleado").html('Error desconocido');					
                }            		 
            }
        });
	}
	
	
	$("#fCrearUsuarioCuenta").validate({
		//errorLabelContainer: "#msnBuscarCargue",
		errorClass: "invalid",
		rules: {
			idcuenta:{
				required: true
			},
			dato:{
				required: true
			},
			idusuario:{
				required: true
			}
		},
		messages: {
			idcuenta: {
				required: "Seleccione un valor."
			},
			dato: {
				required: "Ingrese un valor."
			},
			idusuario: {
				required: "Ingrese un valor."
			}
		},
		submitHandler: function(form) {
			crearUsuarioCuenta(form);
		}
	});
	
	function crearUsuarioCuenta(form) {
		$("[name=btnCrearUsuarioCuenta]").attr('disabled',true);;
		$("#dmMensajeEmpleado").dialog("open");
		$("#dmMensajeEmpleado").html(getHTMLLoaging16(' Creando'));
		$.ajax({
			cache: false,
			contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
            type: $(form).attr('method'),            
            url: $(form).attr('action'),
            data: $(form).serialize(),
            dataType: "text",
            error: function(jqXHR, textStatus, errorThrown) {
            	$("[name=btnCrearUsuarioCuenta]").attr('disabled',false);        		
                $("#dmMensajeEmpleado").html(jqXHR.statusText);
	        },
            success: function(data) {    
            	if(validarEntero(data)){
            		$("#dmMensajeEmpleado").dialog("close");
                	$("#dmNuevoUsuario").dialog("close");
            		visualizarEdicionUsuario(data);
                } else {
                	$("[name=btnCrearUsuarioCuenta]").attr('disabled',false);
                    $("#dmMensajeEmpleado").html('Error desconocido');					
                }            		 
            }
        });
	}

	function editarCancelarEmpleado(idempleado) {
		$('#dmEditarEmpleado').dialog('close');
		visualizarDetalleEmpleado(idempleado);
	}

	function editarUsuario(form) {
		$("[name=btnEditarEmpleado]").attr('disabled',true);
		$("[name=btnEditarCancelarEmpleado]").attr('disabled',true);
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
            	$("[name=btnEditarEmpleado]").attr('disabled',false);
        		$("[name=btnEditarCancelarEmpleado]").attr('disabled',false);
                $("#dmMensajeEmpleado").html(jqXHR.statusText);
	        },
            success: function(data) {    
            	if(validarEntero(data)){
            		$("#dmMensajeEmpleado").dialog("close");
                	$("#dmEditarEmpleado").dialog("close");
            		visualizarDetalleEmpleado(data);
                } else {
                	$("[name=btnEditarEmpleado]").attr('disabled',false);
            		$("[name=btnEditarCancelarEmpleado]").attr('disabled',false);
                    $("#dmMensajeEmpleado").html('Error desconocido');					
                }            		 
            }
        });
	}

 
	
	
	
	afterCrop= function (data) {
        var that = this;
		try {
			response = jQuery.parseJSON(data);           	
		}
		catch(err) {
			response = typeof data =='object' ? data : jQuery.parseJSON(data);           	
		}	    
       	
        if (response.status == 'success') {

            if (that.options.imgEyecandy)
				that.imgEyecandy.hide();

            that.destroy();
			
            that.obj.append('<img class="croppedImg" src="' + response.url + '">');
            if (that.options.outputUrlId !== '') { $('#' + that.options.outputUrlId).val(response.url); }

            that.croppedImg = that.obj.find('.croppedImg');

            that.init();

            that.hideLoader();
	    }
        if (response.status == 'error') {
            if (that.options.onError) that.options.onError.call(that,response.message);
			that.hideLoader();
			setTimeout( function(){ that.reset(); },2000)	
        }

        if (that.options.onAfterImgCrop) that.options.onAfterImgCrop.call(that);
    };
	
	
	
	
	
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
<form name="fEditarEmpleado" id="fEditarEmpleado"  action="${ctx}/page/empleado" method="post">
<input type="hidden" name="action" value="empleado_editar"/>
<input type="hidden" name="idempleado" value="${empleado.idempleado}"/>
<div><button type="button" id="btnEditarCancelarEmpleado" name="btnEditarCancelarEmpleado" onclick="editarCancelarEmpleado(${empleado.idempleado});">Cancelar</button>&nbsp;&nbsp;&nbsp;<button type="submit" id="btnEditarEmpleado" name="btnEditarEmpleado">Grabar</button></div>

<br/>
<fieldset><legend class="e6">Empleado</legend>

<table border="0" width="100%" class="caja">
<col style="width: 50%"/>
<col/>

<tr>
<th nowrap="nowrap" style="text-align: right;">Codigo de empleado:</th>
<td><c:out value="${empleado.codempleado}"/></td>
</tr>

<tr>
	<th nowrap="nowrap" style="text-align: right;">Tipo de identificación:</th>
	<td>
		<select name="ididentificaciontipo">
		<option value=""></option>
		<c:forEach items="${tiposidentificacion}" var="tipoidentificacion" varStatus="loop">
		<option value="${tipoidentificacion.ididentificaciontipo}"><c:out value="${tipoidentificacion.abreviatura}"/> - <c:out value="${tipoidentificacion.tipo}"/></option>
		</c:forEach>
		</select>
		<script type="text/javascript">$("#fEditarEmpleado [name=ididentificaciontipo]").val("${empleado.empleadoidentificacion.ididentificaciontipo}");</script>
	</td>
</tr>
<tr>
<th nowrap="nowrap" style="text-align: right;">Num. Identificación:</th>
<td><input type="text" name="numidentificacion" value="${empleado.empleadoidentificacion.numeroidentificacion}" style="width: 50%;"/></td>
</tr>
<tr>
<th nowrap="nowrap" style="text-align: right;">Ciudad expedición:</th>
<td><input type="text" name="ciudadexpedicion" value="${empleado.empleadoidentificacion.ciudadexpedicion}" style="width: 50%;"/></td>
</tr>
<tr>
<th nowrap="nowrap" style="text-align: right;">Genero:</th>
	<td>
		<select name="idgenero">
		<option value=""></option>
		<c:forEach items="${generos}" var="genero" varStatus="loop">
		<option value="${genero.idgenero}"><c:out value="${genero.nombregenero}"/></option>
		</c:forEach>
		</select>
		<script type="text/javascript">$("#fEditarEmpleado [name=idgenero]").val("${empleado.genero.idgenero}");</script>
	
</tr>

<tr>
<th nowrap="nowrap" style="text-align: right;">Fecha de nacimiento:</th>
<td><input type="text" name="fechanacimiento" id="fechanacimiento" value="<fmt:formatDate value="${empleado.fechanacimiento}" pattern="dd/MM/yyyy" />" style="width: 50%;"/></td>
</tr>

<tr>
<th nowrap="nowrap" style="text-align: right;">Nombres:</th>
<td><input type="text" name="nombres" value="${empleado.nombres}" style="width: 50%;"/></td>
</tr>
<tr>
<th nowrap="nowrap" style="text-align: right;">Apellidos:</th>
<td><input type="text" name="apellidos" value="${empleado.apellidos}"style="width: 50%;"/></td>
</tr>

<tr>
<th nowrap="nowrap" style="text-align: right;">Creado por:</th>
<td><c:out value="${empleado.idusuariocrea}"/></td>
</tr>
<tr>
<th nowrap="nowrap" style="text-align: right;">Fecha creación:</th>
<td><fmt:formatDate value="${empleado.fechacrea}" pattern="dd/MM/yyyy H:mm"/></td>
</tr>
<tr>
<th nowrap="nowrap" style="text-align: right;">Modificado por:</th>
<td><c:out value="${empleado.idusuariomod==0?'':empleado.idusuariomod}"/></td>
</tr>
<tr>
<th nowrap="nowrap" style="text-align: right;">Fecha modificación:</th>
<td><fmt:formatDate value="${empleado.fechamod}" pattern="dd/MM/yyyy H:mm"/></td>
</tr>
<tr>
<th style="text-align: right;">Estado:</th>
<td><c:out value="${empleado.estado}"/></td>
</tr>
</table>
</fieldset>
<br/>
<div>
<button type="button" id="btnEditarCancelarEmpleado" name="btnEditarCancelarEmpleado" onclick="editarCancelarEmpleado(${empleado.idempleado});">Cancelar</button>&nbsp;&nbsp;&nbsp;
<button type="submit" id="btnEditarEmpleado" name="btnEditarEmpleado">Grabar</button></div>
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

