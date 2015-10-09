<%@ include file="/taglibs.jsp"%>

<script type="text/javascript">
	$(document).ready(function() {
		
		$("[name=btnNuevaEducacion]").button();
		
		$("[name=btnCrear]").button();
		
		$("[name=lnkUpdateEducacion]").click(function() {
			actualizarEducacion('${empleado.idempleado}');
		});
		
		
		
		$("[name=btnEdicionEmpleado]").button();
		$("[name=btnDeshabilitarEmpleado]").button();
		$("[name=btnActivarEmpleado]").button();	
		$("[name=btnEdicionEmpleadoContrasena]").button();
		$("[name=btnEdicionContrato]").button();
		$("[name=btnDeshabilitarContrato]").button();
		$("[name=btnActivarContrato]").button();
		
		$("[name=btnNuevoBanco]").button();
		
	});
	
	/*
	 * Actualizar datos de la tabla Educación.
	 */
	function actualizarEducacion(idempleado){
		$("#dmEducacion").html(getHTMLLoaging30());
		$.ajax({
			cache: false,
			contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
	        type: 'POST',
	        url: "${ctx}/page/educacion?action=educacion_propiedades&idempleado="+idempleado,
	        dataType: "text",
	        error: function(jqXHR, textStatus, errorThrown) {
	            alert(jqXHR.statusText);
	        },
	        success: function(data) {
	        	$("#dmEducacion").html(data);
	        }
	    });
	}
	
	/**
	 * Deshabilitar un empleado educación.
	 */
	function deshabilitarEmpleadoEducacion(idempleadoeducacion,idempleado) {		
		
		if(idempleadoeducacion==''){
			
		}else{
			if(confirm('¿Esta seguro de deshabilitar el nivel educativo del empleado [${empleado.codempleado}] ${empleado.nombres} ${empleado.apellidos}?')){
				$.ajax({
					cache: false,
					contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
		            type: 'post',            
		            url: '${ctx}/page/educacion?action=educacion_deshabilitar&idempleadoeducacion='+idempleadoeducacion+'&idempleado='+idempleado,
		            data: '',
		            dataType: "text",
		            error: function(jqXHR, textStatus, errorThrown) {        		
		                $("#dmMensajeEducacion").html(jqXHR.statusText);
			        },
		            success: function(data) {
		            	if(validarEntero(data)){
		                	actualizarEducacion(data);
		                } else {
		                    $("#dmMensajeEducacion").html('Error desconocido');					
		                }
		            }
		        });	 
			}
		}
	}
	
	
	 /**
	   * Ver editar empleado educación.
	   */
	   function VerEditarEmpleadoEducacion(idempleadoeducacion,idempleado){
	  		$("#dmEditarEducacion").dialog("open");
	  		$("#dmEditarEducacion").html(getHTMLLoaging30());
	  		$.ajax({
	  			cache: false,
	  			contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
	  	        type: 'POST',
	  	        url: "${ctx}/page/educacion?action=empleado_vereditareducacion&idempleado="+idempleado+"&idempleadoeducacion="+idempleadoeducacion,
	  	        dataType: "text",
	  	        error: function(jqXHR, textStatus, errorThrown) {
	  	            alert(jqXHR.statusText);
	  	        },
	  	        success: function(data) {	
	  	           	$("#dmEditarEducacion").html(data);     
	  	        }
	  	    });
	  }
	
	/**
	 * Activar un empleado educacion.
	 */
	 function habilitarEmpleadoEducacion(idempleadoeducacion,idempleado) {		
			
			if(idempleadoeducacion==''){
				
			}else{
				if(confirm('¿Esta seguro de habilitar este nivel educativo al empleado [${empleado.codempleado}] ${empleado.nombres} ${empleado.apellidos}?')){
					
					$.ajax({
						cache: false,
						contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
			            type: 'post',            
			            url: '${ctx}/page/educacion?action=empleadoeducacion_habilitar&idempleadoeducacion='+idempleadoeducacion+'&idempleado='+idempleado,
			            data: '',
			            dataType: "text",
			            error: function(jqXHR, textStatus, errorThrown) {
			                $("#dmMensajeEducacion").html(jqXHR.statusText);
				        },
			            success: function(data) {
			            	if(validarEntero(data)){
			                	actualizarEducacion(data);
			                } else {
			                    $("#dmMensajeEducacion").html('Error desconocido');					
			                }
			            }
			        });	 
				}
			}
		}
	
</script>


<div align="left" id="dmEducacion">
<c:choose>
		<c:when test="${empty empleadoeducacion}">
				<c:if test="${sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 1 ||sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 212 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 213 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 214 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 215}">
					<c:if test="${empleado.estado==2}">
						<button type="button" id="btnNuevaEducacion" name="btnNuevaEducacion" onclick="CrearEducacion(${empleado.idempleado});">Crear</button>&nbsp;&nbsp;&nbsp;
					</c:if>
				</c:if>
			<div class="msgInfo1" align="left">El empleado no tiene datos educativos registrados.</div>
		</c:when>
		<c:otherwise>

<br/>

<br/>


	<div id="idTabsEmpleadoEducacion">
		<c:choose>
		<c:when test="${empty empleadoeducacion}">
			<div class="msgInfo1" align="left">No cuenta con datos educativos registrados.</div>
		</c:when>
		<c:otherwise>
<%-- 			<c:if test="${sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 1 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 214 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 215 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 216}"> --%>
				<c:if test="${sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 1 ||sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 212 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 213 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 214 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 215}">
					<c:if test="${empleado.estado==2}">
						<button type="button" id="btnNuevaEducacion" name="btnNuevaEducacion" onclick="CrearEducacion(${empleado.idempleado});">Crear</button>&nbsp;&nbsp;&nbsp;
					</c:if>
				</c:if>
		<fieldset style="width: auto"><legend class="e6"  >Educación</legend>	
		
				
				
				<table style="font " border="0" width="100%" class="tExcel tRowSelect" >
				
				
						<tr>
							<th>Nivel</th>
							<th>Institución</th>
							<th>Título</th>
							<th>Carrera</th>
							<th>Fecha Inicio</th>
							<th>Fecha Fin</th>
							<th>Estado carrera</th>
							<th>Observación</th>
							<th>User crea</th>
							<th>Fecha crea</th>
							<th>User mod</th>
							<th>Fecha mod</th>	
							<th>Estado</th>	
							<th>Acción</th>	
						</tr>
				<tbody>
						
						
						 <c:forEach items="${empleadoeducacion}" var="empleadoeducacion" varStatus="loop">
							
								<tr style="color: ${empleadoeducacion.estado==2?'':'red'};">
								<td class="e6" ><c:out value="${empleadoeducacion.nivelEducacion.nombreEducacionNivel}"/></td>
								<td><c:out value="${empleadoeducacion.institucion}"/></td>
								<td><c:out value="${empleadoeducacion.titulo}"/></td>
								<td><c:out value="${empleadoeducacion.carrera}"/></td>
								<td><fmt:formatDate value="${empleadoeducacion.fechaInicio}" pattern="dd/MM/yyyy"/></td>
								<td><fmt:formatDate value="${empleadoeducacion.fechafin}" pattern="dd/MM/yyyy"/></td>
								<td><c:out value="${empleadoeducacion.estadoEducacion.nombreEducacionEstado}"/></td>
								<td><c:out value="${empleadoeducacion.observacion}"/></td>
								
								<td><c:out value="${empleadoeducacion.idusuariocrea}"/></td>
								<td><fmt:formatDate value="${empleadoeducacion.fechacrea}" pattern="dd/MM/yyyy"/></td>
								<td><c:out value="${empleadoeducacion.idusuariomod}"/></td>
								<td><fmt:formatDate value="${empleadoeducacion.fechamod}" pattern="dd/MM/yyyy"/></td>
								<td>
									<c:if test="${empleadoeducacion.estado==2}">
										<c:out value="Activo"/>
									</c:if>
									<c:if test="${empleadoeducacion.estado==3}">
										<c:out value="Desactivado"/>
									</c:if>
								
								</td>
								
								<td>
<%-- 							<c:if test="${sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 1 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 214 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 215 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 216}"> --%>
							<c:if test="${sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 1 ||sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 212 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 213 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 214 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 215}">	
								<c:if test="${empleado.estado==2}">
									<c:if test="${empleadoeducacion.estado==2}">
										<span class="enlace" onclick="deshabilitarEmpleadoEducacion(${empleadoeducacion.idEmpleadoEducacion},${empleado.idempleado});" title="Deshabilitar">
											<img alt="Deshabilitar" src="${ctx}/imagen/control_deshabilitar.gif">
										</span>
										<span class="enlace" onclick="VerEditarEmpleadoEducacion(${empleadoeducacion.idEmpleadoEducacion},${empleado.idempleado});" title="Editar">
											<img alt="Editar" src="${ctx}/imagen/control_editar.gif">
										</span>
									</c:if> 
									<c:if test="${empleadoeducacion.estado==3}">
										<span class="enlace" onclick="habilitarEmpleadoEducacion(${empleadoeducacion.idEmpleadoEducacion},${empleado.idempleado});" title="Activar">
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

<span class="enlace" id='lnkUpdateEducacion' name='lnkUpdateEducacion'>&nbsp;Actualizar<span>&nbsp;</span></a></span>&nbsp;&nbsp;&nbsp;
</div>

</c:otherwise>
</c:choose>
</div>




<div style="padding: 30px 0px;"></div>