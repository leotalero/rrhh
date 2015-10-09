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
		$("#dmNuevaPropiedad").dialog({   				
			width: 630,
			height:400,   				
			modal: true,
			autoOpen: false,
			resizable: true
		});
		
		$("#fDesvinculacionUsuarios [name=btnCrearUsuario]").button();
	
		$("#fDesvinculacionUsuarios [name=btnGuardarEstadoproceso]").button();
		
		
		
		 $("#fDesvinculacionUsuarios").validate({
				//errorLabelContainer: "#msnBuscarCargue",
				errorClass: "invalid",
				rules: {
					idestadodesvinculacion: {
						required: true,
						
						min:1
							},
				 	idestadoproceso: {
						required: true,
						
						min:1
					},
					porcentajepuesto: {
							required: true,
							
							min:0
						}
					
				},
				messages: {
					idestadodesvinculacion: {
						required: "Seleccione una opción para el estado de desvinculación",
					},
					idestadoproceso: {
						required: "Seleccione una opción para el estado del proceso",
					},
					porcentajepuesto: {
						required: "Seleccione una opción para el porcentaje de avance",
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
                $("#dmMensajeDesvinculacion").html(jqXHR.statusText);
	        },
            success: function(data) {    
            	if(validarEntero(data)){
            		
            		$("#dmMensajeDesvinculacion").dialog("close");
                	$("#dmGuardarDesvinculacion").dialog("close");
                	
                	visualizarDesvinculacion(data);
                } else {
                	$("[name=btnGuardarEntrevista]").attr('disabled',false);
                    $("#dmMensajeDesvinculacion").html('Error desconocido');					
                }            		 
            }
        });
	}
	
	
	 function fillporcentajeactivos(idcontratoproceso,porcentaje) {
			
			
			$(document).ready(function() {
				  
				
				 $(".pie_progress").asPieProgress({
										
			         namespace: 'pie_progress',
			         
			        	 numberCallback: function(n) {
			        		
			        		 	  var percentage = this.getPercentage(n);
			        		
			        		 	  return percentage + '%';
			        	
			        		 	},
			        		
			        		 	
			        });
				 
				var por= Number(porcentaje);
			
			 $("#progressactivo"+idcontratoproceso).asPieProgress('go',por);
		
			});
		}
	
	
function  cambioestado(idestadoproceso,idcontratoproceso,porcentaje){
	
	if(idestadoproceso==1){//si es en proceso
		var porcentajepu=$("#fDesvinculacionUsuarios [name=porcentajepuesto]").val();
		
		
		fillporcentajeactivos(idcontratoproceso,porcentajepu);
	 	if(porcentajepu==100){
	 		
	 		$("#fDesvinculacionUsuarios [name=idestadoproceso]").val(2);
	 	}else{
	 	
	 		$("#fDesvinculacionUsuarios [name=idestadoproceso]").val(1);
	 	}
		
	}else if(idestadoproceso==2){//si es completado
		fillporcentajeactivos(idcontratoproceso,100);
		 $("#fDesvinculacionUsuarios [name=porcentajepuesto]").val(100);
	}
}

function Vercrearpropiedad(idcontrato,idproceso){
	
	$("#dmNuevaPropiedad").dialog("open");
	$("#dmNuevaPropiedad").html(getHTMLLoaging30());
	$.ajax({
		cache: false,
		contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
        type: 'POST',
        url: "${ctx}/page/desvinculacion?action=desvinculacion_vernuevapropiedad&idcontrato="+idcontrato+"&idproceso="+idproceso,
        dataType: "text",
        error: function(jqXHR, textStatus, errorThrown) {
            alert(jqXHR.statusText);
        },
        success: function(data) {		                    	                    	
           	$("#dmNuevaPropiedad").html(data);     
        }
    });
}


$("[name=lnkUpdatePropiedadesusuarios]").click(function() {
	
	actualizarPropiedadesProcesos('${contratoproceso.proceso.nombreproceso}','${contrato.idcontrato}','${contratoproceso.proceso.idproceso}');
});

function Actualizarcontr_pro (contratoproceso) {
	
	actualizarContratoProceso(contratoproceso);
	
};

function deshabilitarContratoPropiedad(idcontratopropiedad,idcontrato) {		
	
	//alert("idempleado"+idempleado);
	if(idcontratopropiedad==''){
		
	}else{
		if(confirm('¿Esta seguro de deshabilitar la propiedad del contrato [${contrato.idcontrato}] ${empleado.nombres} ${empleado.apellidos}?')){
			//$("[name=btnDeshabilitarEmpleado]").attr('disabled',true);;
			$("#dmMensajeDesvinculacion").dialog("open");
			$("#dmMensajeDesvinculacion").html(getHTMLLoaging16('deshabilitando'));
			$.ajax({
				cache: false,
				contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
	            type: 'post',            
	            url: '${ctx}/page/desvinculacion?action=propiedad_deshabilitar&idcontratoprocesopropiedad='+idcontratopropiedad+'&idcontrato='+idcontrato,
	            data: '',
	            dataType: "text",
	            error: function(jqXHR, textStatus, errorThrown) {
	            	//$("[name=btnDeshabilitarEmpleado]").attr('disabled',false);        		
	                $("#dmMensajeDesvinculacion").html(jqXHR.statusText);
		        },
	            success: function(data) {
	            	if(validarEntero(data)){
	            	//	$("#dmMensajeEmpleado").dialog("close");
	               	$("#dmMensajeDesvinculacion").dialog("close");
	               actualizarPropiedadesProcesos('${contratoproceso.proceso.nombreproceso}',data,'${contratoproceso.proceso.idproceso}');

	                } else {
	                	//$("[name=btnDeshabilitarEmpleado]").attr('disabled',false);
	                    $("#dmMensajeDesvinculacion").html('Error desconocido');					
	                }
	            }
	        });	 
		}
	}
}	

function habilitarContratoPropiedad(idcontratopropiedad,idcontrato) {		
	
	//alert("idempleado"+idempleado);
	if(idcontratopropiedad==''){
		
	}else{
		if(confirm('¿Esta seguro de habilitar la propiedad del contrato [${contrato.idcontrato}] ${empleado.nombres} ${empleado.apellidos}?')){
			//$("[name=btnDeshabilitarEmpleado]").attr('disabled',true);;
			$("#dmMensajeDesvinculacion").dialog("open");
			$("#dmMensajeDesvinculacion").html(getHTMLLoaging16('habilitando'));
			$.ajax({
				cache: false,
				contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
	            type: 'post',            
	            url: '${ctx}/page/desvinculacion?action=propiedad_habilitar&idcontratoprocesopropiedad='+idcontratopropiedad+'&idcontrato='+idcontrato,
	            data: '',
	            dataType: "text",
	            error: function(jqXHR, textStatus, errorThrown) {
	            	//$("[name=btnDeshabilitarEmpleado]").attr('disabled',false);        		
	                $("#dmMensajeDesvinculacion").html(jqXHR.statusText);
		        },
	            success: function(data) {
	            	if(validarEntero(data)){
	            	//	$("#dmMensajeEmpleado").dialog("close");
	               	$("#dmMensajeDesvinculacion").dialog("close");
	               actualizarPropiedadesProcesos('${contratoproceso.proceso.nombreproceso}',data,'${contratoproceso.proceso.idproceso}');

	                } else {
	                	//$("[name=btnDeshabilitarEmpleado]").attr('disabled',false);
	                    $("#dmMensajeDesvinculacion").html('Error desconocido');					
	                }
	            }
	        });	 
		}
	}
}	

function Vereditarpropiedad(idcontratopropiedad,idcontrato,idproceso) {
	
	editarContratoPropiedad(idcontratopropiedad,idcontrato,idproceso);
	
};
</script>

<div align="left" id="dmDesvinculacionUsuarios">
<c:choose>
		<c:when test="${empty contrato}">
			<div class="msgInfo1" align="left">No existe contrato.</div>
		</c:when>
		<c:otherwise>


<div></div>
<form name="fDesvinculacionUsuarios" id="fDesvinculacionUsuarios" action="${ctx}/page/desvinculacion" method="post">
<input type="hidden" name="action" value="Guardarcontrato_proceso"/>
<input type="hidden" name="idcontrato" value="${contrato.idcontrato}"/>
<input type="hidden" name="idempleado" value="${contrato.idempleado}"/>
<input type="hidden" name="nombreproceso" value="${contratoproceso.proceso.nombreproceso}"/>
<input type="hidden" name="idproceso" value="${contratoproceso.proceso.idproceso}"/>
<input type="hidden" name="idcontratoproceso" value="${contratoproceso.idcontratoproceso}"/>
<br/>

<div id="idTabsUsuariosPropiedades">
		 <button type="button" id="btnCrearUsuario" name="btnCrearUsuario" onclick="Vercrearpropiedad(${contrato.idcontrato},${contratoproceso.proceso.idproceso});">Crear</button>&nbsp;&nbsp;&nbsp;
		
		 <c:choose>
			
		<c:when test="${empty contratoprocesopropiedades}">
			<div class="msgInfo1" align="left">No cuenta con propiedades en Usuarios.</div>
		</c:when>
		<c:otherwise>
			
			
		<fieldset style="width: auto"><legend class="e6" >${contratoproceso.proceso.nombreproceso}</legend>	
		
				
				<span class="enlace" id='lnkUpdatePropiedadesusuarios' name='lnkUpdatePropiedadesusuarios'><a href="${ctx}/page/desvinculacion?action=${proceso.nombreproceso}&idcontrato=${contrato.idcontrato}&idproceso=${proceso.idproceso}"">&nbsp;Actualizar<span>&nbsp;</span></a></span>&nbsp;&nbsp;&nbsp;
				
				<table style="font " border="0" width="100%" class="tExcel tRowSelect" >
				
				
			
				
				
						<tr>
						<th>Tipo de Usuario</th>
						<th>Detalle</th>
					
						<th>Observaciones</th>
						<th>Usuario crea</th>
						<th>Fecha crea</th>
						<th>Usuario mod</th>
						<th>Fecha mod</th>	
						<th>Estado</th>	
						<th>Acción</th>	
						
						</tr>
						<tbody>
						
						
						
							
								
							
								<c:forEach items="${contratoprocesopropiedades}" var="propiedad" varStatus="loop">
								
								<tr style="color: ${propiedad.estado==2?'':'red'};">
								
								<td class="e6" ><c:out value="${propiedad.procesopropiedad.nombrepropiedad}"/></td>
								
								<td><c:out value="${propiedad.dato}"/></td>
								<td><c:out value="${propiedad.observacion}"/></td>
								<td><c:out value="${propiedad.idusuariocrea}"/></td>
								<td><fmt:formatDate value="${propiedad.fechacrea}" pattern="dd/MM/yyyy H:mm"/></td>
								<td><c:out value="${propiedad.idusuariomod}"/></td>
								<td><fmt:formatDate value="${propiedad.fechamod}" pattern="dd/MM/yyyy H:mm"/></td>
								<td>
								<c:if test="${propiedad.estado==2}">
								<c:out value="Activo"/>
								</c:if>
								<c:if test="${propiedad.estado==3}">
								<c:out value="Desactivado"/>
								</c:if>
								
								</td>
								
								<td>
							<c:if test="${sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 1 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 214 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 215 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 216}">
			
									<c:if test="${propiedad.estado==2}">
								
									<span class="enlace" onclick="deshabilitarContratoPropiedad(${propiedad.idcontratoprocesopropiedad},${contrato.idcontrato});" title="Deshabilitar"><img alt="Deshabilitar" src="${ctx}/imagen/control_deshabilitar.gif"></span>
									<span class="enlace" onclick="Vereditarpropiedad(${propiedad.idcontratoprocesopropiedad},${contrato.idcontrato},${contratoproceso.proceso.idproceso});" title="Editar"><img alt="Editar" src="${ctx}/imagen/control_editar.gif"></span>
								
									</c:if> 
									<c:if test="${propiedad.estado==3}">
									<span class="enlace" onclick="habilitarContratoPropiedad(${propiedad.idcontratoprocesopropiedad},${contrato.idcontrato});" title="Activar"><img alt="Activar" src="${ctx}/imagen/control_habilitar.gif"></span>
									</c:if>
							</c:if>	
									
									
								</tr>
							
								</c:forEach>	
								
								
					
						</tbody>
						
					
						
						</table>
				
			
			</fieldset> 
			</c:otherwise> 
				</c:choose>		
			<br/>
			
			<fieldset style="width: auto"><legend class="e6" >Estado Proceso</legend>	
			<button type="submit" id="btnGuardarEstadoproceso" name="btnGuardarEstadoproceso">Guardar</button>&nbsp;&nbsp;&nbsp;
			
					<table style="border: 2;float:none; ; width:100%" id="correspondencias" class="tExcel tRowSelect">
						<col style="width: 50%;"/>			  
							<tr hidden="hidden">
									<th nowrap="nowrap" style="text-align: right;">Estado de Proceso:</th>
										<td>
										<select name="idestadoproceso" onchange="cambioestado(this.value,${contratoproceso.idcontratoproceso},porcentajepuesto.value)" >
											<option value=""></option>
												<c:forEach items="${procesoestados}" var="procesoestado" varStatus="loop">
													<option value="${procesoestado.idprocesoestado}"><c:out value="${procesoestado.idprocesoestado}"/> - <c:out value="${procesoestado.nombreestado}"/></option>
												</c:forEach>
										</select>
										<script type="text/javascript">
										$("#fDesvinculacionUsuarios [name=idestadoproceso]").val("${contratoproceso.idprocesoestado}");
										</script>
						
										</td>
							</tr>
							<tr>
									<th nowrap="nowrap" style="text-align: right;">Estado de Proceso:</th>
										<td>
										<select name="porcentajepuesto" style="width: 100%" id="porcentajepuesto" onchange="cambioestado(1,${contratoproceso.idcontratoproceso},this.value)" >
											<option value="0">0%</option>
											<option value="10">10%</option>
											<option value="25">25%</option>
											<option value="30">30%</option>
											<option value="50">50%</option>
											<option value="75">75%</option>
											<option value="90">90%</option>
											<option value="100">100%</option>
											
										</select>
										<script type="text/javascript">
										$("#fDesvinculacionUsuarios [name=porcentajepuesto]").val("${contratoproceso.porcentaje}");
										</script>
						
										</td>
							</tr>
							<tr>
									<td colspan="2" align="center">
										   <div class="pie_progress" id="progressactivo${contratoproceso.idcontratoproceso}"  data-barcolor="${contratoproceso.proceso.color}" data-barsize="30"   size="150px" role="progressbar" data-goal="100">
							                    <div class="pie_progress__number" style="font-size: small;" >${contratoproceso.porcentaje}%</div>
							                  <script type="text/javascript">fillporcentajeactivos("${contratoproceso.idcontratoproceso}","${contratoproceso.porcentaje}");</script>
							                </div>
							           </td>
                 			</tr>
					</table>
			
			</fieldset>

	
	</div>
<br/>

<br/>

</form>
<br/>



<br/>


<br/>
</c:otherwise>
</c:choose>
</div>
<div style="padding: 30px 0px;"></div>
<div id="dmMensajeDesvinculacion" title="Mensaje"></div>
<div id="dmNuevaPropiedad" title="Nuevo Activo"></div>
