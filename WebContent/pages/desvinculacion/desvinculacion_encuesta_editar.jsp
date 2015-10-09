<%@ include file="/taglibs.jsp"%>
<script type="text/javascript">

	$(document).ready(function() {	
		$("#dmMensajeDesvinculacion").dialog({   				
			width: 400,
			height: 200,   				
			modal: true,
			autoOpen: false,
			resizable: true
		});
		
		
// 		if(length(contratorespuestas) > 0){
// 			$('#btnCrearPropiedadCorrespondencia').attr("disabled", false);
// 		}else{
// 			$('#btnCrearPropiedadCorrespondencia').attr("disabled", true);	
// 		}
		
		
		$('#btnCrearPropiedadCorrespondencia').attr("disabled", true);
		
		$("#btnCancelarEditarDesvinculacion").button();
		$("#btnGuardarEntrevista").button();
		$("#btnCrearPropiedadCorrespondencia").button();
		
		var icons = {
				 header: "ui-icon-circle-triangle-e",
				 activeHeader: "ui-icon-circle-triangle-s"
				 };
		
		 $( "#accordioneditable" ).accordion({
			 heightStyle: "fill",
		      icons: icons,
			collapsible: true
			 });
		 
		 $( "#accordionconrespuestaseditable" ).accordion({
			 heightStyle: "fill",
		      icons: icons,
			collapsible: true
			 });
		
		 $("#accordionconrespuestas").find("input,button,textarea").attr("disabled", "disabled");
		 
		 $("#fDesvinculacionEditar").validate({
				//errorLabelContainer: "#msnBuscarCargue",
				errorClass: "invalid",
				rules: {
					idestadodesvinculacion: {
						required: true,
						
						min:1
					},
					correoCorrespondencia:{
						required: true,
						maxlength:300,
					},
					direccionCorrespondencia:{
						required: true,
						maxlength:300,
					},
					observacionCorrespondencia:{
						required: false,
						maxlength:300
					}
					
				},
				messages: {
					idestadodesvinculacion: {
						required: "Seleccione una opci�n para el estado de desvinculaci�n",
					},
					correoCorrespondencia:{
						required: "Campo requerido para envio de liquidaci�n.",
						maxlength:"No puede ingresar mas de 300 car�teres.",
					},
					direccionCorrespondencia:{
						required: "Campo requerido para envio de liquidaci�n.",
						maxlength:"No puede ingresar mas de 300 car�teres.",
					},
					observacionCorrespondencia:{
						maxlength:"No puede ingresar mas de 300 car�teres.",
					}
					
				},
				submitHandler: function(form) {				
					guardarDesvinculacion(form);
				}
			});
		 
	});
	function CancelarEditarDesvinculacion(idcontrato) {
		$('#dmGuardarDesvinculacion').dialog('close');
		visualizarDesvinculacion(idcontrato);
	}
	 
	 function guardarDesvinculacion(form) {
		
		$("[name=btnGuardarEntrevista]").attr('disabled',true);;
		$("#dmMensajeDesvinculacion").dialog("open");
		$("#dmMensajeDesvinculacion").html(getHTMLLoaging16(' Creando'));
		$.ajax({
			cache: false,
			contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
            type: $(form).attr('method'),            
            url: $(form).attr('action'),
            data: $(form).serialize(),
            dataType: "text",
            error: function(jqXHR, textStatus, errorThrown) {
            	$("[name=btnGuardarEntrevista]").attr('disabled',false);
            	$('#btnCrearPropiedadCorrespondencia').attr("disabled", false);
                $("#dmMensajeDesvinculacion").html(jqXHR.statusText);
	        },
            success: function(data) {    
            	if(validarEntero(data)){
            		
            		$("#dmMensajeDesvinculacion").dialog("close");
                	$("#dmGuardarDesvinculacion").dialog("close");
                	
                	visualizarDesvinculacion(data);
                } else {
                	$("[name=btnGuardarEntrevista]").attr('disabled',false);
                	$('#btnCrearPropiedadCorrespondencia').attr("disabled",false);
                    $("#dmMensajeDesvinculacion").html('Error desconocido');					
                }            		 
            }
        });
	}
	 
	 
	 	/**
		 * Crear Propiedad de Correspondencia.
		 */
		function crearPropiedadCorrespondenciaEmpleado(idempleado,idContrato){
// 			alert('idContrato = '+idContrato);
// 			alert('idEmpleado = '+idempleado);
		 	$("#dmNuevaPropiedadCorrespondencia").dialog("open");
		 	$("#dmNuevaPropiedadCorrespondencia").html(getHTMLLoaging30());
		 	
		 	$.ajax({
		 		cache: false,
		 		contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
		         type: 'POST',
		         url: "${ctx}/page/empleado?action=empleadoNuevaPropiedadCorrespondencia&idempleado="+idempleado+"&idContrato="+idContrato,
		         dataType: "text",
		         error: function(jqXHR, textStatus, errorThrown) {
		             alert(jqXHR.statusText);
		         },
		         success: function(data) {		                    	                    	
		            	$("#dmNuevaPropiedadCorrespondencia").html(data);     
		         }
		     });
		}

		/**
		 *  
		 */
		function verEditarPropiedadCorrespondenciaEditar(idempleadopropiedad,idempleado,idContrato){
			$("#dmEditarPropiedad").dialog("open");
			$("#dmEditarPropiedad").html(getHTMLLoaging30());
			$.ajax({
				cache: false,
				contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
		        type: 'POST',
		        url: "${ctx}/page/desvinculacion?action=editarPropiedadeCorrespondencia&idempleado="+idempleado+"&idempleadopropiedad="+idempleadopropiedad+"&idContrato="+idContrato,
		        dataType: "text",
		        error: function(jqXHR, textStatus, errorThrown) {
		            alert(jqXHR.statusText);
		        },
		        success: function(data) {		                    	                    	
		           	$("#dmEditarPropiedad").html(data);     
		        }
		    });
		}
		
		function actualizarPropiedades(idempleado){
			$("#dmPropiedades").html(getHTMLLoaging30());
			$.ajax({
				cache: false,
				contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
		        type: 'POST',
		        url: "${ctx}/page/empleado?action=empleado_propiedades&idempleado="+idempleado,
		        dataType: "text",
		        error: function(jqXHR, textStatus, errorThrown) {
		            alert(jqXHR.statusText);
		        },
		        success: function(data) {
		        	//	$("#dmMensajeEmpleado").dialog("close");
		            $("#dmPropiedades").html(data);
		        }
		    });
		}
		
		
		
		/**
		 * Crear Propiedad de Correspondencia al editar la encuesta.
		 */
		function verCrearNuevaPropiedadCorrespondenciaEmpleado(idempleado,idContrato){
// 			alert('idContrato = '+idContrato);
// 			alert('idEmpleado = '+idempleado);
		 	$("#dmNuevaPropiedadCorrespondencia").dialog("open");
		 	$("#dmNuevaPropiedadCorrespondencia").html(getHTMLLoaging30());
		 	
		 	$.ajax({
		 		cache: false,
		 		contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
		         type: 'POST',
		         url: "${ctx}/page/empleado?action=empleadoVerNuevaPropiedadCorrespondencia&idempleado="+idempleado+"&idContrato="+idContrato,
		         dataType: "text",
		         error: function(jqXHR, textStatus, errorThrown) {
		             alert(jqXHR.statusText);
		         },
		         success: function(data) {		                    	                    	
		            	$("#dmNuevaPropiedadCorrespondencia").html(data);     
		         }
		     });
		}
	 	
		
		function verEditarPropiedadCorrespondenciaEdit(idEmpleadoPropiedad,idEmpleado,idContrato){

			$("#dmDesvinculacionEditarPropiedad").dialog("open");
			$("#dmDesvinculacionEditarPropiedad").html(getHTMLLoaging30());
			$.ajax({
				cache: false,
				contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
		        type: 'POST',
		        url: "${ctx}/page/desvinculacion?action=verEditarPropiedadCorrespondencia&idEmpleadoPropiedad="+idEmpleadoPropiedad+"&idEmpleado="+idEmpleado+"&idContrato="+idContrato,
		        dataType: "text",
		        error: function(jqXHR, textStatus, errorThrown) {
		            alert(jqXHR.statusText);
		        },
		        success: function(data) {		                    	                    	
		           	$("#dmDesvinculacionEditarPropiedad").html(data);     
		        }
		    });
		}
		
		
		/**
		 * Destabilita el registro de empleado_propiead (Correspondencia) por su idempleadopropiedad.
		 */
		function deshabilitarPropiedadCorrespondenciaEdit(idempleadopropiedad,idempleado,idContrato) {
// 			alert('Ajax a deshabilitar propiedad: con idcontrato = '+idContrato);
			if(idempleadopropiedad==''){
				
			}else{
				if(confirm('�Esta seguro de deshabilitar la propiedad del empleado [${empleado.codempleado}] ${empleado.nombres} ${empleado.apellidos}?')){
					
					$.ajax({
						cache: false,
						contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
			            type: 'post',            
			            url: '${ctx}/page/desvinculacion?action=deshabilitarPropiedadCorrespondencia&idempleadopropiedad='+idempleadopropiedad+'&idcontrato='+idContrato,
			            data: '',
			            dataType: "text",
			            error: function(jqXHR, textStatus, errorThrown) {       		
			                $("#dmMensajeEmpleado").html(jqXHR.statusText);
				        },
			            success: function(data) {
			            	if(validarEntero(data)){
// 								alert("Data = "+data);
								$("#dmMensajeEmpleado").dialog("close");
			                	$("#dmDesvinculacion").dialog("close");
			                	verDesvinculacion(data);
			                } else {
			                    $("#dmMensajeEmpleado").html('Error desconocido');					
			                }
			            }
			        });	 
				}
			}
		}
		
		/**
		 * Habilita un registro de la relaci�n empleado_propiedad (Correspondencia) por su idempleadopropiedad.
		 */
		function habilitarPropiedadCorrespondenciaEdit(idempleadopropiedad,idempleado,idContrato) {		
			
			if(idempleadopropiedad==''){
				
			}else{
				if(confirm('�Esta seguro de habilitar la propiedad del empleado [${empleado.codempleado}] ${empleado.nombres} ${empleado.apellidos}?')){
					
					$.ajax({
						cache: false,
						contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
			            type: 'post',            
			            url: '${ctx}/page/desvinculacion?action=habilitarPropiedadCorrespondencia&idempleadopropiedad='+idempleadopropiedad+'&idContrato='+idContrato,
			            data: '',
			            dataType: "text",
			            error: function(jqXHR, textStatus, errorThrown) {      		
			                $("#dmMensajeEmpleado").html(jqXHR.statusText);
				        },
			            success: function(data) {
			            	if(validarEntero(data)){
			            		alert('Data:'+data);
			            		$("#dmMensajeEmpleado").dialog("close");
			                	$("#dmDesvinculacion").dialog("close");
			                	verDesvinculacion(data);
			                } else {
			                    $("#dmMensajeEmpleado").html('Error desconocido');					
			                }
			            }
			        });	 
				}
			}
		}
		
		/**
		 Esta funci�n oculta y muestra el div de los datos de correspondencia segun lo siguiente:
	 	 - Lo muestra si y solo si el estado de desvinculaci�n es PROCEDER RETIRO. ( Estado 1)
	 	 - Lo oculta si y solo si el estado de desvinculaci�n es RETENER. (Estado 2)
		*/
		function manejarDivCorrespondencia(estadoDesvinculacion){
			if(estadoDesvinculacion == 1){ //Retener
				correoCorrespondencia.disabled = true;
				direccionCorrespondencia.disabled = true;
				observacionCorrespondencia.disabled = true;
				$("#divCorrespondencia").css("display", "none"); 
			}else if(estadoDesvinculacion == 2){//Proceder retiro
				correoCorrespondencia.disabled = false;
				direccionCorrespondencia.disabled = false;
				observacionCorrespondencia.disabled = false;
				$("#divCorrespondencia").css("display", "block"); 
			}
		}
		
</script>

<div align="left">
<c:choose>
		<c:when test="${empty contrato}">
			<div class="msgInfo1" align="left">No existe contrato.</div>
		</c:when>
		<c:otherwise>


<div></div>
<form name="fDesvinculacionEditar" id="fDesvinculacionEditar" action="${ctx}/page/desvinculacion" method="post">
<input type="hidden" name="action" value="guardar_Desvinculacion"/>
<input type="hidden" name="idcontrato" value="${contrato.idcontrato}"/>
<input type="hidden" name="idempleado" value="${contrato.idempleado}"/>
<button type="button" id=btnCancelarEditarDesvinculacion name="btnCancelarEditarDesvinculacion" onclick="CancelarEditarDesvinculacion(${contrato.idcontrato});">Cancelar</button>&nbsp;&nbsp;&nbsp;

<br/>

<!------------------------------------
	Informaci�n del empleado.         
 ------------------------------------>
<fieldset><legend class="e6">Empleado</legend>
	<table border="0" width="100%" class="caja">
			<col style="width: 15%"/>
			<col/>
			
			
			<tr>
			<th nowrap="nowrap" style="text-align: right;">Tipo de identificaci�n:</th>
			<td><c:out value="${empleado.identificaciontipo.abreviatura}"/> - <c:out value="${empleado.identificaciontipo.tipo}"/></td>
			</tr>
			<tr>
			<th nowrap="nowrap" style="text-align: right;">Num. Identificaci�n:</th>
			<td><c:out value="${empleado.empleadoidentificacion.numeroidentificacion}"/></td>
			</tr>
			
			<tr>
			<th nowrap="nowrap" style="text-align: right;">Nombres:</th>
			<td><c:out value="${empleado.nombres}"/></td>
			</tr>
			<tr>
			<th nowrap="nowrap" style="text-align: right;">Apellidos:</th>
			<td><c:out value="${empleado.apellidos}"/></td>
			</tr>
			<tr>
				<th nowrap="nowrap" style="text-align: right;">Cargo:</th>
				<td><c:out value="${contrato.cargo.nombrecargo}"/></td>
				</tr>
				
				<tr>
				<th nowrap="nowrap" style="text-align: right;">Area:</th>
				<td><c:out value="${contrato.area.nombrearea}"/></td>
				</tr>
				<tr>
				<th nowrap="nowrap" style="text-align: right;">Area asignada:</th>
				<td><c:out value="${contrato.areaasignada.nombrearea}"/></td>
			</tr>
				
	</table>
</fieldset>
<br/>
<!---------------------------------
	Encuesta de desvinculaci�n. 
 ---------------------------------->
<fieldset>
<legend class="e6">Encuesta de desvinculaci�n</legend>

	<c:if test="${fn:length(contratorespuestas) > 0}" >

	<script type="text/javascript">
			$('#btnCrearPropiedadCorrespondencia').attr("disabled", false);
	</script>
	
	<div id="accordionconrespuestaseditable">
		<c:forEach items="${preguntas}" var="pregunta" varStatus="loop">
					<h3 align="center">${pregunta.pregunta}</h3>
					<div>
					<p>
					
							
					 <c:if test="${pregunta.idpreguntatipo == 2}">
									 
						<table style="border: 2;float:none; ; width: 100%" id="correspondencias" class="tExcel tRowSelect">
									  
							<tr>
							
						
							 <td>
								<textarea  id="respupreguntaeditar${pregunta.idpregunta}" name="respupreguntaeditar${pregunta.idpregunta}" cols=110 rows=8 maxlength="3950" spellcheck="true" >${contrarespuesta.respuesta.texto} </textarea>
							
								 <c:forEach items="${contratorespuestas}" var="contrarespuesta" varStatus="loop">
									<c:if test="${contrarespuesta.respuesta.pregunta.idpregunta==pregunta.idpregunta}">
										<script type="text/javascript">
									
										//document.getElementById("respupreguntaeditar${pregunta.idpregunta}").value="${contrarespuesta.respuesta.texto}"; 
										 document.getElementById("respupreguntaeditar${pregunta.idpregunta}").value="${contrarespuesta.respuesta.texto}"; 
										
										</script>
									 </c:if>
								 </c:forEach>
								 
							</td>
								
							</tr>	
							
						</table>
					 </c:if>
						
					<c:if test="${pregunta.idpreguntatipo == 1}">
						<c:forEach items="${pregunta.opciones}" var="opcion" varStatus="loop">
							 <table style="border: 2;float:none; ; width: 100%" id="correspondencias" class="tExcel tRowSelect">
									  
							<tr>
							
							<td>  <input value="${opcion.idopcion}" type="checkbox"  id="opcioneditar${opcion.idopcion}" name="opcioneditar${opcion.idopcion}" /> <c:out value="${opcion.opcion}"/>  </td> 
								
							  <c:forEach items="${contratorespuestas}" var="contrarespuesta" varStatus="loop">
								 <c:if test="${contrarespuesta.respuesta.opcion.idopcion==opcion.idopcion}">
									<script type="text/javascript">
								
									document.getElementById("opcioneditar${opcion.idopcion}").checked=true;
									</script>
								
								 </c:if>
								
								 </c:forEach>
							 
							
							
							</tr>	
							
							</table>			
						 
						 </c:forEach>
					 </c:if>
					
					
					</p>
					</div>
					
		</c:forEach>
					</div>
</c:if>
		
<c:if test="${fn:length(contratorespuestas) eq 0}">
		<script type="text/javascript">
			$('#btnCrearPropiedadCorrespondencia').attr("disabled", true);
		</script>

		<div class="msgInfo1" align="left">Complete la entrevista de desvinculaci�n.</div>
		
		<div id="accordioneditable">
					
					 <c:forEach items="${preguntas}" var="pregunta" varStatus="loop">
					<h3 align="center">${pregunta.pregunta}</h3>
					<div>
					<p>
					
							
					 <c:if test="${pregunta.idpreguntatipo == 2}">
									 
						<table style="border: 2;float:none; ; width: 100%" id="correspondencias" class="tExcel tRowSelect">
									  
							<tr>
							
						
							 <td>
								<textarea  id="respupreguntaeditar${pregunta.idpregunta}" name="respupreguntaeditar${pregunta.idpregunta}" cols=110 rows=8 maxlength="3950" spellcheck="true"  >{contrarespuesta.respuesta.texto} </textarea>
								<script type="text/javascript">
								
							
								document.getElementById("respupreguntaeditar${pregunta.idpregunta}").value="${contrarespuesta.respuesta.texto}"; 
								
								</script>
							</td>
								
							</tr>	
							
						</table>
					 </c:if>
						
					<c:if test="${pregunta.idpreguntatipo == 1}">
						<c:forEach items="${pregunta.opciones}" var="opcion" varStatus="loop">
							 <table style="border: 2;float:none; ; width: 100%" id="correspondencias" class="tExcel tRowSelect">
									  
							<tr>
							
							<td>  <input value="${opcion.idopcion}" type="checkbox"  id="opcioneditar${opcion.idopcion}" name="opcioneditar${opcion.idopcion}" /> <c:out value="${opcion.opcion}"/>  </td> 
						
							</tr>	
							
							</table>			
						 
						 </c:forEach>
					 </c:if>
					
					
					</p>
					</div>
					
					</c:forEach>
					</div>
					
					
		
</c:if>
	

	
	<table style="border: 2;float:none; ; width:100%" id="correspondencias" class="tExcel tRowSelect">
									  
		<tr>
				<th nowrap="nowrap" style="text-align: right;">Estado de desvinculaci�n:</th>
					<td>
					<select name="idestadodesvinculacion" onchange="manejarDivCorrespondencia(this.value);">
<!-- 	DESARROLLO  <select name="idestadodesvinculacion"> -->
						<option value=""></option>
							<c:forEach items="${estadosdesvinculacion}" var="estadodesvinculacion" varStatus="loop">
								<option value="${estadodesvinculacion.idestadodesvinculacion}"><c:out value="${estadodesvinculacion.idestadodesvinculacion}"/> - <c:out value="${estadodesvinculacion.nombreestado}"/></option>
							</c:forEach>
					</select>
					<script type="text/javascript">$("#fDesvinculacionEditar [name=idestadodesvinculacion]").val("${contrato.idestadodesvinculacion}");</script>
	
					</td>
		</tr>
<!-- 		<tr> -->
<!-- 			<th nowrap="nowrap" style="text-align: right;">Correo:</th> -->
<!-- 			<td> -->
<!-- 				<textarea id="observacion" name="observacion" rows="3" cols="50"></textarea> -->
<!-- 			</td> -->
<!-- 		</tr> -->

</table>

<br/>

<!-- --------------------------- -->
<!-- Datos de correspondencia    -->
<!-- --------------------------- -->

<c:if test="${editar == 1}">
	<div id="divCorrespondencia">
		<fieldset>
			<legend class="e6">Correspondencia</legend>
			<table id="tablaCorrespondencia" border="0" width="100%" class="caja">
			<col style="width: 15%"/>
			<col/>
			
			<!-- Correo correspondencia -->
			<tr>
				<th nowrap="nowrap" style="text-align: right;">Correo correspondencia:</th>
				<td>
					<input type="text" id="correoCorrespondencia" name="correoCorrespondencia" value=""  style="width: 99%;"/>
				</td>
			</tr>
			
			<!-- Direcci�n correspondencia -->
			<tr>
				<th nowrap="nowrap" style="text-align: right;">Direcci�n correspondencia:</th>
				<td>
					<input type="text" id="direccionCorrespondencia" name="direccionCorrespondencia" value=""  style="width:99%;"/>
				</td>
			</tr>
			
			<!-- Observaci�n -->
			<tr>
				<th nowrap="nowrap" style="text-align: right;">Observaci�n:</th>
				<td>
					<textarea id="observacionCorrespondencia" name="observacionCorrespondencia" rows="3" cols="50" style="width:99%;"></textarea>
				</td>
			</tr>
			</table>
		</fieldset>
	</div>
</c:if> 
<br/>
<!-- Boton de guardar la encuesta -->
<div align="center">
	<button type="submit" id="btnGuardarEntrevista" name="btnGuardarEntrevista">Guardar</button>
</div>

</fieldset>
<br/>

</form>

<br/>
</c:otherwise>
</c:choose>
</div>
<div style="padding: 30px 0px;"></div>
<div id="dmMensajeDesvinculacion" title="Mensaje"></div>
