<%@ include file="/taglibs.jsp"%>


<style type="text/css">
    body {
        padding:5px;
    }
    .pie_progress svg {
        width: 70px;
    }
    @media all and (max-width: 768px) {
        .pie_progress svg {
            width: 90%;
            max-width:70px;
        }
    }
</style>
<script type="text/javascript">

	
	$(document).ready(function() {
		
		//Editar Propiedad.
		$("#dmDesvinculacionEditarPropiedad").dialog({   				
			width: 800,
			height: 400,   				
			modal: true,
			autoOpen: false,
			resizable: true
		});
		
		
		$("#dmNuevaPropiedadCorrespondencia").dialog({   				
			width:600,
			height: 300,   				
			modal: true,
			autoOpen: false,
			resizable: true
		});
		
		  
		$("#dmMensajeDesvinculacion").dialog({   				
			width: 400,
			height: 200,   				
			modal: true,
			autoOpen: false,
			resizable: true
		});
		 
		$("#dmGuardarDesvinculacion").dialog({   				
			width: 800,
			height: 600,   				
			modal: true,
			autoOpen: false,
			resizable: true
		});
		$("#dmDesvinculacionEditar").dialog({   				
			width: 650,
			height: 400,   				
			modal: true,
			autoOpen: false,
			resizable: true
		});
		
		$("#dmAbreEditarEnviarCorreo").dialog({   				
			width: 600,
			height: 400,   				
			modal: true,
			autoOpen: false,
			resizable: true
		});
		
	
		$("#btnCancelarDesvinculacion").button();
		$("#btnEnviarCorreo").button();
		$("#btnEditarEntrevista").button();
		$("#btnCrearPropiedadCorrespondencia").button();
		
		
		
		 var icons = {
				 header: "ui-icon-circle-triangle-e",
				 activeHeader: "ui-icon-circle-triangle-s"
				 };
		 $( "#accordion" ).accordion({
			 heightStyle: "fill",
		      icons: icons,
			collapsible: true
			 });
		
		
		 
			 $( "#accordionconrespuestas" ).accordion({
				 heightStyle: "fill",
			      icons: icons,
				collapsible: true
				 });
		
		 $("#accordionconrespuestas").find("input,button,textarea").attr("disabled", "disabled");
		 
		 
		 $("#tabsOpcionesDesvinculacionProcesos").tabs({
				
				cache: true,
				spinner: ' '+getHTMLLoaging14(''),			
				ajaxOptions: {
					cache: false,
					error: function( xhr, status, index, anchor ) {
						$( anchor.hash ).html(
							"No se pudo cargar esta pestaña. Informe a su área de tecnología." );
					}
				}
			})  .addClass('ui-tabs-vertical ui-helper-clearfix');
		
		
	});
	function CancelarDesvinculacion(idempleado) {
		$('#dmDesvinculacion').dialog('close');
		visualizarDetalleEmpleado(idempleado);
	}
	function fillporcentaje(idcontratoproceso,porcentaje) {
	
		
		$(document).ready(function() {
			  
			 $("#progress"+idcontratoproceso).asPieProgress({
		            namespace: 'pie_progress',
		           	
		            	
		        });
			
			var por= Number(porcentaje);
			
		 $("#progress"+idcontratoproceso).asPieProgress('go',por);
		 
		 
		});
	}
	
	/* function crearUsuarioAplicacion(form) {
		$("[name=btnCrearUsuarioAplicacion]").attr('disabled',true);;
		$("#dmMensajeContrato").dialog("open");
		$("#dmMensajeContrato").html(getHTMLLoaging16(' Creando'));
		$.ajax({
			cache: false,
			contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
            type: $(form).attr('method'),            
            url: $(form).attr('action'),
            data: $(form).serialize(),
            dataType: "text",
            error: function(jqXHR, textStatus, errorThrown) {
            	$("[name=btnCrearUsuarioAplicacion]").attr('disabled',false);        		
                $("#dmMensajeContrato").html(jqXHR.statusText);
	        },
            success: function(data) {    
            	if(validarEntero(data)){
            		$("#dmMensajeContrato").dialog("close");
                	$("#dmNuevoUsuario").dialog("close");
            		visualizarEdicionEmpleado(data);
                } else {
                	$("[name=btnCrearUsuarioAplicacion]").attr('disabled',false);
                    $("#dmMensajeContrato").html('Error desconocido');					
                }            		 
            }
        });
	}
	 */
	
	
	 function visualizarEditarDesvinculacion(idcontrato){
			$("#dmGuardarDesvinculacion").dialog("open");
			AbreEditarDesvinculacion(idcontrato);
	 }
	 
		function AbreEditarDesvinculacion(idcontrato) {		
			
			$("#dmGuardarDesvinculacion").html(getHTMLLoaging30());
			$.ajax({
				cache: false,
				contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
		        type: 'POST',
		        url: "${ctx}/page/desvinculacion?action=ver_editar_Desvinculacion&idcontrato="+idcontrato,
		        dataType: "text",
		        error: function(jqXHR, textStatus, errorThrown) {
		            alert(jqXHR.statusText);
		        },
		        success: function(data) {
		           	$("#dmGuardarDesvinculacion").html(data);     
		        }
		    });
		}
	
		
		
		
		 function visualizarEnviarCorreo(idcontrato){
			
			$("#dmAbreEditarEnviarCorreo").dialog("open");  
			AbreEditarEnviarCorreo(idcontrato);
		}
		function AbreEditarEnviarCorreo(idcontrato) {		

			$("#dmAbreEditarEnviarCorreo").html(getHTMLLoaging30());
			$.ajax({
				cache: false,
				contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
		        type: 'POST',
		        url: "${ctx}/page/desvinculacion?action=ver_enviar_correo&idcontrato="+idcontrato,
		        dataType: "text",
		        error: function(jqXHR, textStatus, errorThrown) {
		            alert(jqXHR.statusText);
		        },
		        success: function(data) {	                    	                    	
		           	$("#dmAbreEditarEnviarCorreo").html(data);     
		        }
		    });
		}
		
		
		
		
		
		 function ActualizarProcesos(idcontrato){
				
				$("#dmGuardarDesvinculacion").dialog("open");  
				AbreEditarDesvinculacion(idcontrato);
			}
		 
		function AbreEditarDesvinculacion(idcontrato) {		

				$("#dmGuardarDesvinculacion").html(getHTMLLoaging30());
				$.ajax({
					cache: false,
					contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
			        type: 'POST',
			        url: "${ctx}/page/desvinculacion?action=ver_editar_Desvinculacion&idcontrato="+idcontrato,
			        dataType: "text",
			        error: function(jqXHR, textStatus, errorThrown) {
			            alert(jqXHR.statusText);
			        },
			        success: function(data) {	                    	                    	
			           	$("#dmGuardarDesvinculacion").html(data);     
			        }
			    });
		}
		
			function actualizarPropiedadesProcesos(nombreproceso,idcontrato,idproceso){
				if(idproceso==1){
					$("#dmDesvinculacionActivos").html(getHTMLLoaging30());
            	}else if(idproceso==2){
            		$("#dmDesvinculacionUsuarios").html(getHTMLLoaging30());
            	}else if(idproceso==3){
            		$("#dmDesvinculacionArchivos").html(getHTMLLoaging30());
            	}
				
				$.ajax({
					cache: false,
					contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
			        type: 'POST',
			        url: "${ctx}/page/desvinculacion?action="+nombreproceso+"&idcontrato="+idcontrato+"&idproceso="+idproceso,
			        dataType: "text",
			        error: function(jqXHR, textStatus, errorThrown) {
			            alert(jqXHR.statusText);
			        },
			        success: function(data) {
			        	
			            	//	$("#dmMensajeEmpleado").dialog("close");
			            	if(idproceso==1){
			            		$("#dmDesvinculacionActivos").html(data);
			            	}else if(idproceso==2){
			            		$("#dmDesvinculacionUsuarios").html(data);
			            	}else if(idproceso==3){
			            		$("#dmDesvinculacionArchivos").html(data);
			            	}
			                	
			               	                    	
			           	   
			        }
			    });
			}
			
			
			
			function actualizarContratoProceso(contratoproceso){
				
				$("#dmDesvinculacion").html(getHTMLLoaging30());
				$.ajax({
					cache: false,
					contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
			        type: 'POST',
			        url: "${ctx}/page/desvinculacion?action=actualizarcontrato_proceso&idcontratoproceso="+contratoproceso,
			        dataType: "text",
			        error: function(jqXHR, textStatus, errorThrown) {
			            alert(jqXHR.statusText);
			        },
			        success: function(data) {
			        	visualizarDesvinculacion(data);    
			        }
			    });
			}
			
			function editarContratoPropiedad(idcontratopropiedad,idcontrato,idproceso) {		
				
				if(idcontratopropiedad==''){
					
				}else{
						//$("[name=btnDeshabilitarEmpleado]").attr('disabled',true);;
						$("#dmDesvinculacionEditar").dialog("open");
						$("#dmDesvinculacionEditar").html(getHTMLLoaging16('abriendo'));
						$.ajax({
							cache: false,
							contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
				            type: 'post',            
				            url: '${ctx}/page/desvinculacion?action=ver_editar&idcontratoprocesopropiedad='+idcontratopropiedad+'&idcontrato='+idcontrato+"&idproceso="+idproceso,
				            data: '',
				            dataType: "text",
				            error: function(jqXHR, textStatus, errorThrown) {
				            	//$("[name=btnDeshabilitarEmpleado]").attr('disabled',false);        		
				                $("#dmMensajeDesvinculacion").html(jqXHR.statusText);
					        },
				            success: function(data) {
				            	$("#dmDesvinculacionEditar").html(data);
				            }
				        });	 
					
				}
			}	
			
		var temp = 0;
		
		/**
		 * Crear Propiedad de Correspondencia.
		 */
		function VercrearPropiedadCorrespondenciaEmpleado(idempleado,idContrato){
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
		
		function VereditarpropiedadEmpleadoCorrespondencia(idempleadopropiedad,idempleado,idContrato){
			$("#dmEditarPropiedad").dialog("open");
			$("#dmEditarPropiedad").html(getHTMLLoaging30());
			
			$.ajax(
				{
					cache: false,
					contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
			        type: 'POST',
			        url: "${ctx}/page/empleado?action=empleado_vereditarpropiedad&idempleado="+idempleado+"&idempleadopropiedad="+idempleadopropiedad+"&idContrato="+idContrato,
			        dataType: "text",
			        error: function(jqXHR, textStatus, errorThrown) {
			            alert(jqXHR.statusText);
			        },
			        success: function(data) {		                    	                    	
			           	$("#dmEditarPropiedad").html(data);     
			        }
		    	}
				);
		}
		
		function verEditarPropiedadCorrespondencia(idEmpleadoPropiedad,idEmpleado,idContrato){

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
		function deshabilitarPropiedadCorrespondencia(idempleadopropiedad,idempleado,idContrato) {
// 			alert('Ajax a deshabilitar propiedad: con idcontrato = '+idContrato);
			if(idempleadopropiedad==''){
				
			}else{
				if(confirm('¿Esta seguro de deshabilitar la propiedad del empleado [${empleado.codempleado}] ${empleado.nombres} ${empleado.apellidos}?')){
					
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
		 * Habilita un registro de la relación empleado_propiedad (Correspondencia) por su idempleadopropiedad.
		 */
		function habilitarPropiedadCorrespondencia(idempleadopropiedad,idempleado,idContrato) {		
			
			if(idempleadopropiedad==''){
				
			}else{
				if(confirm('¿Esta seguro de habilitar la propiedad del empleado [${empleado.codempleado}] ${empleado.nombres} ${empleado.apellidos}?')){
					
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
// 			            		alert('Data:'+data);
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
		
		
</script>

<div id="dmGuardarDesvinculacion" title="Encuesta desvinculación"></div>
<div id="dmAbreEditarEnviarCorreo" title="Enviar correo"></div>
<div align="left">
<c:choose>
		<c:when test="${empty contrato}">
			<div class="msgInfo1" align="left">No existe contrato.</div>
		</c:when>
		<c:otherwise>


<div></div>
<form name="fDesvinculacion" id="fDesvinculacion" action="${ctx}/page/desvinculacion" method="post">
<input type="hidden" name="action" value="ver_editar_Desvinculacion"/>
<input type="hidden" name="idcontrato" value="${contrato.idcontrato}"/>
<input type="hidden" name="idempleado" value="${contrato.idempleado}"/>
<input type="hidden" name="tieneCorrespondencia" value="${tieneCorrespondencia}"/>

<button type="button" id="btnCancelarDesvinculacion" name="btnCancelarDesvinculacion" onclick="CancelarDesvinculacion(${contrato.idempleado});">Cancelar</button>&nbsp;&nbsp;&nbsp;


<br/>
<!---------------------------------
    Información del Empleado. 
 ---------------------------------->
<fieldset><legend class="e6">Empleado</legend>
	<table border="0" width="100%" class="caja">
			<col style="width: 15%"/>
			<col/>
			
			
			<tr>
			<th nowrap="nowrap" style="text-align: right;">Tipo de identificación:</th>
			<td><c:out value="${empleado.identificaciontipo.abreviatura}"/> - <c:out value="${empleado.identificaciontipo.tipo}"/></td>
			</tr>
			<tr>
			<th nowrap="nowrap" style="text-align: right;">Num. Identificación:</th>
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

<!---------------------------------------------
    Encuesta de desvinculación.
 --------------------------------------------->
<fieldset>
<legend class="e6">Encuesta de desvinculación</legend>
<div>
<!-- Estado de desvinculación -->
<table style="border: 2;float:none; ; width:100%" id="correspondencias" class="tExcel tRowSelect">
		<col style="width:50%"/>						  
		<tr>
			<th nowrap="nowrap" style="text-align: right;">Estado de desvinculación:</th>
			<td>
				<c:out value="${estadodesvinculacion.nombreestado}"/>
			</td>
		</tr>
</table>

</div>
<!-- No tiene respuestas a una encuesta -->
<c:if test="${fn:length(contratorespuestas) eq 0}">
	<button type="button" onclick="visualizarEditarDesvinculacion(${contrato.idcontrato});" id="btnEditarEntrevista" name="btnEditarEntrevista">Nuevo</button>
	<div class="msgInfo1" align="left">No tiene respuestas para la entrevista de desvinculación.</div>		
</c:if>

<!-- Tiene respuestas a una encuesta -->
<c:if test="${fn:length(contratorespuestas) > 0}" >
<button type="button" onclick="visualizarEditarDesvinculacion(${contrato.idcontrato});" id="btnEditarEntrevista" name="btnEditarEntrevista">Editar</button>
<button type="button" onclick="visualizarEnviarCorreo(${contrato.idcontrato});" id="btnEnviarCorreo" name="btnEnviarCorreo">Enviar correo</button>
	<div id="accordionconrespuestas" contenteditable="false" >
					
					<c:forEach items="${preguntas}" var="pregunta" varStatus="loop">
						<h3 align="center"> ${pregunta.pregunta} </h3>
					<div>
					<p>
					
							
					 <c:if test="${pregunta.idpreguntatipo == 2}">
									 
						<table style="border: 2;float:none; ; width: 100%" id="correspondencias" class="tExcel tRowSelect">
									  
							<tr>
							
						
							 <td>
								<%-- <textarea  id="respupregunta${pregunta.idpregunta}" name="respupregunta${pregunta.idpregunta}" cols=110 rows=8 maxlength="3950" spellcheck="true" ></textarea>
								 --%>
								 <c:forEach items="${contratorespuestas}" var="contrarespuesta" varStatus="loop">
								
								 <c:if test="${contrarespuesta.respuesta.pregunta.idpregunta==pregunta.idpregunta}">
										
										<c:if test="${empty fn:trim(contrarespuesta.respuesta.texto)}">
									
											<div class="msgInfo1" align="left">No tiene respuesta.</div>
											
										</c:if> 
										
										<c:if test="${not empty fn:trim(contrarespuesta.respuesta.texto)}">
											<c:out value="${contrarespuesta.respuesta.texto}"/>
										</c:if> 
								
								<script type="text/javascript">
							
								//document.getElementById("respupregunta${pregunta.idpregunta}").value="${contrarespuesta.respuesta.texto}"; 
								</script>
								 </c:if>
								
							 	
								 </c:forEach>
								 
								
							</td>
								
							</tr>	
							
						</table>
					 </c:if>
						
					<c:if test="${pregunta.idpreguntatipo == 1}">
					 <c:set var="total" value="0"/>
						<c:forEach items="${pregunta.opciones}" var="opcion" varStatus="loop">
							
							 <table style="border: 2;float:none; ; width: 100%" id="correspondencias" class="tExcel tRowSelect">
									  
							<tr>
							
								
								
								
							  <c:forEach items="${contratorespuestas}" var="contrarespuesta" varStatus="loop">
								
								 <c:if test="${contrarespuesta.respuesta.opcion.idopcion==opcion.idopcion}">
									<td>  <input value="${opcion.idopcion}" type="checkbox"  id="opcion${opcion.idopcion}" name="opcion${opcion.idopcion}" /> <c:out value="${opcion.opcion}"/>  </td> 
							
									<script type="text/javascript">
							
									
									document.getElementById("opcion${opcion.idopcion}").checked=true;
									
									</script>
									<c:set var="total" value="${total + 1}"/>
								 </c:if>
								
								</c:forEach>
							
							
								
							</tr>	
							
							</table>			
						 
						 </c:forEach>
						 <c:if test="${total==0}">
							<div class="msgInfo1" align="left">No tiene respuesta.</div>
							</c:if>
					 </c:if>
					
					
					</p>
					</div>
					
					</c:forEach>
					</div>
</c:if>
	
	



	


</fieldset>
<br/>
<c:if test="${estadodesvinculacion.idestadodesvinculacion==2}">


<!------------------------------------------------ 
 
	INFORMACIÓN DE CORRESPONDENCIA.
	
------------------------------------------------->
 
<fieldset>

	<legend class="e6">Correspondencia</legend>
			<div align="left" id="dmPropiedades">
			<c:choose>
					<c:when test="${empty empleadopropiedades}">
						<c:if test="${sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 1 ||sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 212 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 213 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 214 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 215}">
							<c:if test="${empleado.estado==2}">
								<button type="button" id="btnCrearPropiedadCorrespondencia" name="btnCrearPropiedadCorrespondencia" onclick="VercrearPropiedadCorrespondenciaEmpleado(${empleado.idempleado},${contrato.idcontrato});">Crear</button>&nbsp;&nbsp;&nbsp;
							</c:if>
						</c:if>
						<div class="msgInfo1" align="left">Debe crear el Correo y Dirección de correspondencia.</div>
					</c:when>
					<c:otherwise>
			
			<br/>
			
				<div id="idTabsEmpleadoPropiedades">
					<c:choose>
					<c:when test="${empty empleadopropiedades}">
						<c:if test="${sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 1 ||sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 212 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 213 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 214 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 215}">
								<c:if test="${empleado.estado==2}">
									<button type="button" id="btnCrearPropiedadCorrespondencia" name="btnCrearPropiedadCorrespondencia" onclick="VercrearPropiedadCorrespondenciaEmpleado(${empleado.idempleado},${contrato.idcontrato});">Crear</button>&nbsp;&nbsp;&nbsp;
								</c:if>
						</c:if>
						<div class="msgInfo1" align="left">No cuenta con propiedades asociadas.</div>
					</c:when>
					<c:otherwise>
					<c:if test="${sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 1 ||sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 212 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 213 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 214 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 215}">
						<c:if test="${empleado.estado==2}">
							<button type="button" id="btnCrearPropiedadCorrespondencia" name="btnCrearPropiedadCorrespondencia" onclick="VercrearPropiedadCorrespondenciaEmpleado(${empleado.idempleado},${contrato.idcontrato});">Crear</button>&nbsp;&nbsp;&nbsp;
						</c:if>
					</c:if>
		<fieldset style="width: auto"><legend class="e6"  >Propiedades</legend>	
		
				<table id="tablaEmpleadoPropiedades" style="font " border="0" width="100%" class="tExcel tRowSelect" >
				
				<thead>
			  		<tr class="td3">
						<th>Propiedad</th>
						<th>Prioridad</th>
						<th>Dato</th>
						<th>Observación</th>
						<th>User crea</th>
						<th>Fecha crea</th>
						<th>User mod</th>
						<th>Fecha mod</th>	
						<th>Estado</th>	
						<th>Acción</th>	
					</tr>
			  	</thead>
			  	
				<tbody>
					<c:forEach items="${propiedades}" var="propiedad" varStatus="loop">
						<c:forEach items="${empleadopropiedades}" var="empleadopropiedad" varStatus="loop">
							<tr style="color: ${empleadopropiedad.estado==2?'':'red'};">
								<c:if test="${empleadopropiedad.propiedad.idpropiedad == propiedad.idpropiedad }">
									<td class="e6" ><c:out value="${propiedad.nombrepropiedad}"/></td>
									<td><c:out value="${empleadopropiedad.prioridad.nombreprioridad}"/></td>
									<td><c:out value="${empleadopropiedad.dato}"/></td>
									<td><c:out value="${empleadopropiedad.observacion}"/></td>
									<td><c:out value="${empleadopropiedad.idusuariocrea}"/></td>
									<td><fmt:formatDate value="${empleadopropiedad.fechacrea}" pattern="dd/MM/yyyy H:mm"/></td>
									<td><c:out value="${empleadopropiedad.idusuariomod}"/></td>
									<td><fmt:formatDate value="${empleadopropiedad.fechamod}" pattern="dd/MM/yyyy H:mm"/></td>
									<td>
									<c:if test="${empleadopropiedad.estado==2}">
									<c:out value="Activo"/>
									</c:if>
									<c:if test="${empleadopropiedad.estado==3}">
									<c:out value="Desactivado"/>
									</c:if>
									
									</td>
									
									<td>
											<c:if test="${sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 1 ||sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 212 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 213 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 214 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 215}">
												<c:if test="${empleado.estado==2}">
													<c:if test="${empleadopropiedad.estado==2}">
															<span class="enlace" onclick="deshabilitarPropiedadCorrespondencia(${empleadopropiedad.idempleadopropiedad},${empleado.idempleado},${contrato.idcontrato});" title="Deshabilitar"><img alt="Deshabilitar" src="${ctx}/imagen/control_deshabilitar.gif"></span> 															
															<span class="enlace" onclick="verEditarPropiedadCorrespondencia(${empleadopropiedad.idempleadopropiedad},${empleado.idempleado},${contrato.idcontrato});" title="Editar"><img alt="Editar" src="${ctx}/imagen/control_editar.gif"></span>
													</c:if> 
													<c:if test="${empleadopropiedad.estado==3}">
															<span class="enlace" onclick="habilitarPropiedadCorrespondencia(${empleadopropiedad.idempleadopropiedad},${empleado.idempleado},${contrato.idcontrato});" title="Activar"><img alt="Activar" src="${ctx}/imagen/control_habilitar.gif"></span>
													</c:if>
												</c:if>
											</c:if>
									</c:if>
								</tr>
							</c:forEach>
						</c:forEach>
				 	</tbody>
				</table>
				
			
			</fieldset>
		</c:otherwise>
		</c:choose>		
	</div>
		</c:otherwise>
		</c:choose>
		</div>

</fieldset>
<!-- -----------------------------------
	
	Fin información de correspondencia.

---------------------------------------->
<br/>
<fieldset>
<legend class="e6">Procesos</legend>
<div>

		<c:choose>
			<c:when test="${fn:length(contratoprocesos) eq 0}">
				<div class="msgInfo1" align="left">No tiene procesos asociados.</div>
			</c:when>		
			<c:otherwise>
			<table border="0" width="95%" class="tExcel tRowSelect">
			<col style="width:200px"/>
			
			
			<tr>
			<th>Proceso</th>
			<th>Estado del proceso</th>
			<th>Porcentaje completado</th>
			<th>Usuario crea</th>
			<th>Fecha crea</th>
			<th>Usuario mod</th>
			<th>Fecha mod</th>	
			<th>Estado</th>
			
<!-- 		<th>Estado</th> -->
			
			</tr>
			<tbody>
			
			<c:forEach items="${contratoprocesos}" var="contratoproceso" varStatus="loop">
			<tr style="color: ${contratoproceso.estado==2?'':'red'};">
			<td><c:out value="${contratoproceso.proceso.nombreproceso} "/></td>
			<td><c:out value="${contratoproceso.procesoestado.nombreestado}"/></td>
			<td>
			   <div class="pie_progress" id="progress${contratoproceso.idcontratoproceso}"  data-barcolor="${contratoproceso.proceso.color}" data-barsize="20" role="progressbar" data-goal="100">
                    <div class="pie_progress__content">${contratoproceso.porcentaje}%</div>
                  <script type="text/javascript">fillporcentaje("${contratoproceso.idcontratoproceso}","${contratoproceso.porcentaje}");</script>
                </div>
             </td>
			

			<td><c:out value="${contratoproceso.idusuariocrea}"/></td>
			<td><fmt:formatDate value="${contratoproceso.fechacrea}" pattern="dd/MM/yyyy H:mm"/></td>
			<td><c:out value="${contratoproceso.idusuariomod}"/></td>
			<td><fmt:formatDate value="${contratoproceso.fechamod}" pattern="dd/MM/yyyy H:mm"/></td>
			<td>
			<c:if test="${contratoproceso.estado==2}">
			<c:out value="Activo"/>
			</c:if>
			<c:if test="${contratoproceso.estado==3}">
			<c:out value="Desactivado"/>
			</c:if>
			
			</td>
			
			
			<c:if test="${sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 1 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 214 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 215 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 216}">
							
				<c:if test="${contratoproceso.estado==2}">
			
				<%-- <span class="enlace" onclick="deshabilitarHorarioAsignado(${horarioasignado.idhorarioasignado});" title="Deshabilitar"><img alt="Deshabilitar" src="${ctx}/imagen/control_deshabilitar.gif"></span>
				<span class="enlace" onclick="VereditarHorarioAsignado(${horarioasignado.idhorarioasignado},${contrato.idcontrato});" title="Editar"><img alt="Editar" src="${ctx}/imagen/control_editar.gif"></span>
					 --%>				
				</c:if> 
				<c:if test="${contratoproceso.estado==3}">
				<%-- <span class="enlace" onclick="habilitarHorarioAsignado(${horarioasignado.idhorarioasignado});" title="Activar"><img alt="Activar" src="${ctx}/imagen/control_habilitar.gif"></span>
				 --%>
				 </c:if>
			</c:if>
			
			</tr>
			</c:forEach>			  
			</tbody>
			</table>
			
			<div id="tabsOpcionesDesvinculacionProcesos" class="tab tab-vert">
									<ul>
									<c:forEach items="${procesos}" var="proceso" varStatus="loop">
										<li><a href="${ctx}/page/desvinculacion?action=${proceso.nombreproceso}&idcontrato=${contrato.idcontrato}&idproceso=${proceso.idproceso}">&nbsp;${proceso.nombreproceso}<span>&nbsp;</span></a></li>	
										
									</c:forEach>	
									</ul>
			</div>
			
			
			
			
			</c:otherwise>
		</c:choose>
	</div>
</fieldset>

</c:if>

<br/>
</form>
<br/>
</c:otherwise>
</c:choose>
</div>

<br/>
<div style="padding: 30px 0px;"></div>
<div id="dmDesvinculacionEditar" title="Editar"></div>
<div id="dmDesvinculacionEditarPropiedad" title="Editar Correspondencia"></div>
<div id="dmNuevaPropiedadCorrespondencia" title="Nueva Correspondencia"></div>
