<%@ include file="/taglibs.jsp"%>

<script type="text/javascript">
	$(document).ready(function() {
		
		$("[name=btnNuevoFamiliar]").button();
		
		$("[name=btnCrear]").button();
		
		$("[name=lnkUpdateFamilia]").click(function() {
			actualizarFamilia('${empleado.idempleado}');
		});
		
	});
	
	/*
	 * Actualizar datos de la tabla de familiares.
	 */
	function actualizarFamilia(idempleado){
		$("#dmFamilia").html(getHTMLLoaging30());
		$.ajax({
			cache: false,
			contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
	        type: 'POST',
	        url: "${ctx}/page/familia?action=familia_propiedades&idempleado="+idempleado,
	        dataType: "text",
	        error: function(jqXHR, textStatus, errorThrown) {
	            alert(jqXHR.statusText);
	        },
	        success: function(data) {
	        	$("#dmFamilia").html(data);
	        }
	    });
	}
	
	/**
	 * Deshabilitar un familiar.
	 */
	function deshabilitarEmpleadoFamilia(idempleadofamilia,idempleado) {		
		
		if(idempleadofamilia==''){
			
		}else{
			if(confirm('¿Esta seguro de deshabilitar este familiar del empleado [${empleado.codempleado}] ${empleado.nombres} ${empleado.apellidos}?')){
				$.ajax({
					cache: false,
					contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
		            type: 'post',            
		            url: '${ctx}/page/familia?action=familia_deshabilitar&idempleadofamilia='+idempleadofamilia+'&idempleado='+idempleado,
		            data: '',
		            dataType: "text",
		            error: function(jqXHR, textStatus, errorThrown) {        		
		                $("#dmMensajeFamilia").html(jqXHR.statusText);
			        },
		            success: function(data) {
		            	if(validarEntero(data)){
		                	actualizarFamilia(data);
		                } else {
		                    $("#dmMensajeFamilia").html('Error desconocido');					
		                }
		            }
		        });	 
			}
		}
	}
	
	
	  /**
	    * Ver editar empleado familia.
	    */
	    function VerEditarEmpleadoFamilia(idempleadofamilia,idempleado){
	   		$("#dmEditarFamilia").dialog("open");
	   		$("#dmEditarFamilia").html(getHTMLLoaging30());
	   		$.ajax({
	   			cache: false,
	   			contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
	   	        type: 'POST',
	   	        url: "${ctx}/page/familia?action=empleado_vereditarfamilia&idempleado="+idempleado+"&idempleadofamilia="+idempleadofamilia,
	   	        dataType: "text",
	   	        error: function(jqXHR, textStatus, errorThrown) {
	   	            alert(jqXHR.statusText);
	   	        },
	   	        success: function(data) {	
	   	           	$("#dmEditarFamilia").html(data);     
	   	        }
	   	    });
	   }
	
	/**
	 * Activar un familiar.
	 */
	 function habilitarEmpleadoFamilia(idempleadofamilia,idempleado) {		
			
			if(idempleadofamilia==''){
				
			}else{
				if(confirm('¿Esta seguro de habilitar este familiar al empleado [${empleado.codempleado}] ${empleado.nombres} ${empleado.apellidos}?')){
					
					$.ajax({
						cache: false,
						contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
			            type: 'post',            
			            url: '${ctx}/page/familia?action=empleadofamilia_habilitar&idempleadofamilia='+idempleadofamilia+'&idempleado='+idempleado,
			            data: '',
			            dataType: "text",
			            error: function(jqXHR, textStatus, errorThrown) {
			                $("#dmMensajeFamilia").html(jqXHR.statusText);
				        },
			            success: function(data) {
			            	if(validarEntero(data)){
			                	actualizarFamilia(data);
			                } else {
			                    $("#dmMensajeFamilia").html('Error desconocido');					
			                }
			            }
			        });	 
				}
			}
		}
	
</script>


<div align="left" id="dmFamilia">
<c:choose>
		<c:when test="${empty empleadofamilia}">
		    <c:if test="${sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 1 ||sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 212 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 213 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 214 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 215}">
				<c:if test="${empleado.estado==2}">
					<button type="button" id="btnNuevoFamiliar" name="btnNuevoFamiliar" onclick="CrearFamiliar(${empleado.idempleado});">Registrar familiar</button>&nbsp;&nbsp;&nbsp;
				</c:if>
			</c:if>
			<div class="msgInfo1" align="left">El empleado no tiene familiares registrados.</div>
		</c:when>
		<c:otherwise>

<br/>

<br/>


	<div id="idTabsEmpleadoFamilia">
		<c:choose>
		<c:when test="${empty empleadofamilia}">
			<div class="msgInfo1" align="left">No cuenta con familiares registrados.</div>
		</c:when>
		<c:otherwise>
<%-- 			<c:if test="${sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 1 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 214 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 215 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 216}"> --%>
			<c:if test="${sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 1 ||sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 212 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 213 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 214 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 215}">
				<c:if test="${empleado.estado==2}">
					<button type="button" id="btnNuevoFamiliar" name="btnNuevoFamiliar" onclick="CrearFamiliar(${empleado.idempleado});">Registrar familiar</button>&nbsp;&nbsp;&nbsp;
				</c:if>
			</c:if>
		<fieldset style="width: auto"><legend class="e6"  >Familiares</legend>	
		
				
				
				<table style="font " border="0" width="100%" class="tExcel tRowSelect" >
				
				
						<tr>
							<th>Parentesco</th>
							<th>Genero</th>
							<th>Tipo Identificación</th>
							<th>Número documento</th>
							<th>Nombre</th>
							<th>Fecha Nacimiento</th>
							<th>Observación</th>
							<th>User crea</th>
							<th>Fecha crea</th>
							<th>User mod</th>
							<th>Fecha mod</th>	
							<th>Estado</th>	
							<th>Acción</th>	
						</tr>
				<tbody>
						
						
						 <c:forEach items="${empleadofamilia}" var="empleadofamilia" varStatus="loop">
							
								<tr style="color: ${empleadofamilia.estado==2?'':'red'};">
								
								<td class="e6" >
									<c:out value="${empleadofamilia.parentesco.nombreparentesco}"/>
								</td>
								<td>
									<c:out value="${empleadofamilia.genero.nombregenero}"/>
								</td>
								<td>
									<c:out value="${empleadofamilia.tipoIdentificacion.tipo}"/>
								</td>
								<td>
									<c:out value="${empleadofamilia.numeroIdentificacion}"/>
								</td>
								<td>
									<c:out value="${empleadofamilia.nombrefamilia} ${empleadofamilia.apellidoFamilia}"/>
								</td>
								<td>
									<fmt:formatDate value="${empleadofamilia.fechaNacimiento}" pattern="dd/MM/yyyy"/>
								</td>
								<td>
									<c:out value="${empleadofamilia.observacion}"/>
								</td>
								<!-- Auditoria -->
								<td>
									<c:out value="${empleadofamilia.idusuariocrea}"/>
								</td>
								<td>
									<fmt:formatDate value="${empleadofamilia.fechacrea}" pattern="dd/MM/yyyy"/>
								</td>
								<td>
									<c:out value="${empleadofamilia.idusuariomod}"/>
								</td>
								<td>
									<fmt:formatDate value="${empleadofamilia.fechamod}" pattern="dd/MM/yyyy"/>
								</td>
								<td>
									<c:if test="${empleadofamilia.estado==2}">
										<c:out value="Activo"/>
									</c:if>
									<c:if test="${empleadofamilia.estado==3}">
										<c:out value="Desactivado"/>
									</c:if>								
								</td>
								
								<td>
<%-- 							<c:if test="${sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 1 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 214 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 215 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 216}"> --%>
							<c:if test="${sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 1 ||sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 212 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 213 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 214 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 215}">
								<c:if test="${empleado.estado==2}">
									<c:if test="${empleadofamilia.estado==2}">
										<!-- Deshabilitar -->
										<span class="enlace" onclick="deshabilitarEmpleadoFamilia(${empleadofamilia.idEmpleadoFamilia},${empleado.idempleado});" title="Deshabilitar">
											<img alt="Deshabilitar" src="${ctx}/imagen/control_deshabilitar.gif">
										</span>
										<!-- Editar -->
										<span class="enlace" onclick="VerEditarEmpleadoFamilia(${empleadofamilia.idEmpleadoFamilia},${empleado.idempleado});" title="Editar">
											<img alt="Editar" src="${ctx}/imagen/control_editar.gif">
										</span>
									</c:if> 
									<c:if test="${empleadofamilia.estado==3}">
									    <!-- Activar -->
										<span class="enlace" onclick="habilitarEmpleadoFamilia(${empleadofamilia.idEmpleadoFamilia},${empleado.idempleado});" title="Activar">
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

<span class="enlace" id='lnkUpdateFamilia' name='lnkUpdateFamilia'>&nbsp;Actualizar<span>&nbsp;</span></a></span>&nbsp;&nbsp;&nbsp;
</div>

</c:otherwise>
</c:choose>
</div>




<div style="padding: 30px 0px;"></div>