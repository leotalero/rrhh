<%@ include file="/taglibs.jsp"%>

<script type="text/javascript">
	$(document).ready(function() {
		
		$("[name=btnNuevaAfiliacion]").button();
		
		$("[name=btnCrear]").button();
		
		$("[name=lnkUpdateAfiliacion]").click(function() {
			actualizarAfiliacion('${empleado.idempleado}');
		});
		
	});
	
	/*
	 * Actualizar datos de la tabla afiliaciones.
	 */
	function actualizarAfiliacion(idempleado){
		$("#dmAfiliaciones").html(getHTMLLoaging30());
		$.ajax({
			cache: false,
			contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
	        type: 'POST',
	        url: "${ctx}/page/afiliacion?action=afiliacion_propiedades&idempleado="+idempleado,
	        dataType: "text",
	        error: function(jqXHR, textStatus, errorThrown) {
	            alert(jqXHR.statusText);
	        },
	        success: function(data) {
	        	$("#dmAfiliaciones").html(data);
	        }
	    });
	}
	
	 /**
	  * Ver editar empleado afiliación.
	  */
	  function VerEditarEmpleadoAfiliacion(idempleadoafiliacion,idempleado){
	 		$("#dmEditarAfiliacion").dialog("open");
	 		$("#dmEditarAfiliacion").html(getHTMLLoaging30());
	 		$.ajax({
	 			cache: false,
	 			contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
	 	        type: 'POST',
	 	        url: "${ctx}/page/afiliacion?action=empleado_vereditarafiliacion&idempleado="+idempleado+"&idempleadoafiliacion="+idempleadoafiliacion,
	 	        dataType: "text",
	 	        error: function(jqXHR, textStatus, errorThrown) {
	 	            alert(jqXHR.statusText);
	 	        },
	 	        success: function(data) {		                    	                    	
	 	           	$("#dmEditarAfiliacion").html(data);     
	 	        }
	 	    });
	 }
	
	
	/**
	 * Deshabilitar un empleado afiliacion.
	 */
	function deshabilitarEmpleadoAfiliacion(idempleadoafiliacion,idempleado) {		
		
		if(idempleadoafiliacion==''){
			
		}else{
			if(confirm('¿Esta seguro de deshabilitar la afiliación del empleado [${empleado.codempleado}] ${empleado.nombres} ${empleado.apellidos}?')){
				$.ajax({
					cache: false,
					contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
		            type: 'post',            
		            url: '${ctx}/page/afiliacion?action=afiliacion_deshabilitar&idempleadoafiliacion='+idempleadoafiliacion+'&idempleado='+idempleado,
		            data: '',
		            dataType: "text",
		            error: function(jqXHR, textStatus, errorThrown) {        		
		                $("#dmMensajeAfiliacion").html(jqXHR.statusText);
			        },
		            success: function(data) {
		            	if(validarEntero(data)){
		                	actualizarAfiliacion(data);
		                } else {
		                    $("#dmMensajeAfiliacion").html('Error desconocido');					
		                }
		            }
		        });	 
			}
		}
	}
	
	
	/**
	 * Activar un empleado afiliacion.
	 */
	 function habilitarEmpleadoAfiliacion(idempleadoafiliacion,idempleado) {		
			
			if(idempleadoafiliacion==''){
				
			}else{
				if(confirm('¿Esta seguro de habilitar esta afiliación al empleado [${empleado.codempleado}] ${empleado.nombres} ${empleado.apellidos}?')){
					
					$.ajax({
						cache: false,
						contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
			            type: 'post',            
			            url: '${ctx}/page/afiliacion?action=empleadoafiliacion_habilitar&idempleadoafiliacion='+idempleadoafiliacion+'&idempleado='+idempleado,
			            data: '',
			            dataType: "text",
			            error: function(jqXHR, textStatus, errorThrown) {
			                $("#dmMensajeAfiliacion").html(jqXHR.statusText);
				        },
			            success: function(data) {
			            	if(validarEntero(data)){
			                	actualizarAfiliacion(data);
			                } else {
			                    $("#dmMensajeAfiliacion").html('Error desconocido');					
			                }
			            }
			        });	 
				}
			}
		}
	
	
	 /*function entidadeditar(idafiliaciontipo){
		
			if(idafiliaciontipo!=""){
				$("#divEntidadEditar").html(getHTMLLoaging30());
				$.ajax({
					cache: false,
					contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
		            type: 'POST',
		            dataType : 'text',
		            url: "${ctx}/page/afiliacion?afiliacion?action=cargar_entidades&idafiliaciontipo="+idafiliaciontipo,
		            error: function(jqXHR, textStatus, errorThrown) {
		                alert(jqXHR.statusText);
			        },
		            success: function(data) {	
		               	$("#divEntidadEditar").html(data);     
		            }
		        });
			}else{
				alert("seleccione un tipo de afiliación.");
			}
		}*/
	 
</script>


<div align="left" id="dmAfiliaciones">
<c:choose>
		<c:when test="${empty empleadoafiliacion}">
				<c:if test="${empleado.estado==2}">
					<c:if test="${sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 1 ||sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 212 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 213 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 214 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 215}">
						<button type="button" id="btnNuevaAfiliacion" name="btnNuevaAfiliacion" onclick="CrearAfiliacion(${empleado.idempleado});">Realizar Afiliación</button>&nbsp;&nbsp;&nbsp;
					</c:if>
				</c:if>
			<div class="msgInfo1" align="left">El empleado no tiene afiliaciones registradas.</div>
		</c:when>
		<c:otherwise>
<br/>

<br/>


	<div id="idTabsEmpleadoAfiliacion">
		<c:choose>
		<c:when test="${empty empleadoafiliacion}">
			<div class="msgInfo1" align="left">No cuenta con afiliaciones registradas.</div>
		</c:when>
		<c:otherwise>
<%-- 			<c:if test="${sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 1 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 214 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 215 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 216}"> --%>
			<c:if test="${sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 1 ||sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 212 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 213 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 214 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 215}">
				<c:if test="${empleado.estado==2}">
					<button type="button" id="btnNuevaAfiliacion" name="btnNuevaAfiliacion" onclick="CrearAfiliacion(${empleado.idempleado});">Realizar Afiliación</button>&nbsp;&nbsp;&nbsp;
				</c:if>
			</c:if>
		<fieldset style="width: auto"><legend class="e6"  >Afiliaciones</legend>	
		
				<table style="font " border="0" width="100%" class="tExcel tRowSelect" >
				
				
						<tr>
							<th>Tipo</th>
							<th>Entidad</th>
							<th>Fecha Inicio</th>
							<th>Fecha Fin</th>
							<th>Observación</th>
							<th>User crea</th>
							<th>Fecha crea</th>
							<th>User mod</th>
							<th>Fecha mod</th>	
							<th>Estado</th>	
							<th>Acción</th>	
						</tr>
				<tbody>
						
						
						 <c:forEach items="${empleadoafiliacion}" var="empleadoafiliacion" varStatus="loop">
							
								<tr style="color: ${empleadoafiliacion.estado==2?'':'red'};">
								<td class="e6" ><c:out value="${empleadoafiliacion.afiliacionTipo.tipoafiliacion}"/></td>
								<td class="e6" ><c:out value="${empleadoafiliacion.afiliacionEntidad.nombreentidad}"/></td>
								<td><fmt:formatDate value="${empleadoafiliacion.fechainicio}" pattern="dd/MM/yyyy"/></td>
								<td><fmt:formatDate value="${empleadoafiliacion.fechafin}" pattern="dd/MM/yyyy"/></td>
								<td><c:out value="${empleadoafiliacion.observacion}"/></td>
								
								<td><c:out value="${empleadoafiliacion.idusuariocrea}"/></td>
								<td><fmt:formatDate value="${empleadoafiliacion.fechacrea}" pattern="dd/MM/yyyy"/></td>
								<td><c:out value="${empleadoafiliacion.idusuariomod}"/></td>
								<td><fmt:formatDate value="${empleadoafiliacion.fechamod}" pattern="dd/MM/yyyy"/></td>
								<td>
								<c:if test="${empleadoafiliacion.estado==2}">
								<c:out value="Activo"/>
								</c:if>
								<c:if test="${empleadoafiliacion.estado==3}">
								<c:out value="Desactivado"/>
								</c:if>
								
								</td>
								
								<td>
<%-- 							<c:if test="${sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 1 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 214 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 215 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 216}"> --%>
							<c:if test="${sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 1 ||sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 212 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 213 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 214 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 215}">
								<c:if test="${empleado.estado==2}">
									
									<c:if test="${empleadoafiliacion.estado==2}">
								
										<span class="enlace" onclick="deshabilitarEmpleadoAfiliacion(${empleadoafiliacion.idempleadoafiliacion},${empleado.idempleado});" title="Deshabilitar">
											<img alt="Deshabilitar" src="${ctx}/imagen/control_deshabilitar.gif">
										</span>
										<span class="enlace" onclick="VerEditarEmpleadoAfiliacion(${empleadoafiliacion.idempleadoafiliacion},${empleado.idempleado});" title="Editar">
											<img alt="Editar" src="${ctx}/imagen/control_editar.gif">
										</span>
									
									</c:if>
									<c:if test="${empleadoafiliacion.estado==3}">
										<span class="enlace" onclick="habilitarEmpleadoAfiliacion(${empleadoafiliacion.idempleadoafiliacion},${empleado.idempleado});" title="Activar">
											<img alt="Activar" src="${ctx}/imagen/control_habilitar.gif">
										</span>
									</c:if>
									
								</c:if>
							</c:if>	
									
<%-- 									</c:if> --%>
								</tr>
							
								</c:forEach>	
								
								
						</tbody>
						</table>
				
			
			</fieldset>
		</c:otherwise>
		</c:choose>		
	</div>

<br/>


<div>

<span class="enlace" id='lnkUpdateAfiliacion' name='lnkUpdateAfiliacion'>&nbsp;Actualizar<span>&nbsp;</span></a></span>&nbsp;&nbsp;&nbsp;
</div>

</c:otherwise>
</c:choose>
</div>




<div style="padding: 30px 0px;"></div>