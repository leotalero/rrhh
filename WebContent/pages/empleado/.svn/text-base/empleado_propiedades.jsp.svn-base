<%@ include file="/taglibs.jsp"%>
<script type="text/javascript">


	$.tablesorter.addParser({ 
	    id: 'datetime', 
	    is: function(s) { 
	        return false; 
	    }, 
	    format: function(s) { 
	    	if (s.length > 0) {
	    		return $.tablesorter.formatFloat(Date.parseExact(s,'dd/MM/yyyy').getTime());
	    	} else {
	    	    return 0;
	    	}
	    }, 
	    type: 'numeric' 
	});

	$(document).ready(function() {
		$("[name=btnEdicionEmpleado]").button();
		$("[name=btnDeshabilitarEmpleado]").button();
		$("[name=btnActivarEmpleado]").button();	
		$("[name=btnEdicionEmpleadoContrasena]").button();
		$("[name=btnEdicionContrato]").button();
		$("[name=btnDeshabilitarContrato]").button();
		$("[name=btnActivarContrato]").button();
		$("[name=btnCrearPropiedad]").button();
		
		$("[name=lnkUpdatePropiedades]").click(function() {
			actualizarPropiedades('${empleado.idempleado}');
		});
		
		$("#tabsUsuarioDetalle").tabs({
			cache: true,
			spinner: ' '+getHTMLLoaging14(''),			
			ajaxOptions: {
				cache: false,
				error: function( xhr, status, index, anchor ) {
					$( anchor.hash ).html(
						"No se pudo cargar esta pestaña. Informe a su área de tecnología." );
				}
			}
		});
		
		/**
		 * Para ordenar la tabla de propiedades. 
		 */
		$("#tablaEmpleadoPropiedades").tablesorter({ 
			debug: false,
// 	        headers: {
// 	        	5:{sorter:'datetime'},
// 	        	7:{sorter:'datetime'},
// 	        	9:{ sorter: false}
// 	        },
	        cssHeader: "headerSort",
	        cssAsc: "headerSortUp",
	        cssDesc: "headerSortDown",
	        sortMultiSortKey: "shiftKey"
	    });

		$("#tablaEmpleadoPropiedades").fixedtableheader();

		
	});
	




	function deshabilitarEmpleadoPropiedad(idempleadopropiedad,idempleado) {		
		
		if(idempleadopropiedad==''){
			
		}else{
			if(confirm('¿Esta seguro de deshabilitar la propiedad del empleado [${empleado.codempleado}] ${empleado.nombres} ${empleado.apellidos}?')){
				
				$.ajax({
					cache: false,
					contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
		            type: 'post',            
		            url: '${ctx}/page/empleado?action=propiedad_deshabilitar&idempleadopropiedad='+idempleadopropiedad+'&idempleado='+idempleado,
		            data: '',
		            dataType: "text",
		            error: function(jqXHR, textStatus, errorThrown) {
		            	//$("[name=btnDeshabilitarEmpleado]").attr('disabled',false);        		
		                $("#dmMensajeEmpleado").html(jqXHR.statusText);
			        },
		            success: function(data) {
		            	if(validarEntero(data)){
		            	//	$("#dmMensajeEmpleado").dialog("close");
		                //	$("#dmDetalleEmpleado").dialog("close");
		                	actualizarPropiedades(data);
		                } else {
		                	//$("[name=btnDeshabilitarEmpleado]").attr('disabled',false);
		                    $("#dmMensajeEmpleado").html('Error desconocido');					
		                }
		            }
		        });	 
			}
		}
	}	
	
	function habilitarEmpleadoPropiedad(idempleadopropiedad,idempleado) {		
		
		if(idempleadopropiedad==''){
			
		}else{
			if(confirm('¿Esta seguro de habilitar la propiedad del empleado [${empleado.codempleado}] ${empleado.nombres} ${empleado.apellidos}?')){
				
				$.ajax({
					cache: false,
					contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
		            type: 'post',            
		            url: '${ctx}/page/empleado?action=propiedad_habilitar&idempleadopropiedad='+idempleadopropiedad+'&idempleado='+idempleado,
		            data: '',
		            dataType: "text",
		            error: function(jqXHR, textStatus, errorThrown) {      		
		                $("#dmMensajeEmpleado").html(jqXHR.statusText);
			        },
		            success: function(data) {
		            	if(validarEntero(data)){
		                	actualizarPropiedades(data);
		                } else {
		                    $("#dmMensajeEmpleado").html('Error desconocido');					
		                }
		            }
		        });	 
			}
		}
	}	
	
	
	
	$("[name=lnkUpdatePropiedades]").click(function() {
		actualizarPropiedades('${empleado.idempleado}');
	});
	
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
	        	$("#dmPropiedades").html(data);   
	        }
	    });
	}

	function VereditarpropiedadEmpleado(idempleadopropiedad,idempleado){
		//alert("editar prop");
		$("#dmEditarPropiedad").dialog("open");
		$("#dmEditarPropiedad").html(getHTMLLoaging30());
		$.ajax({
			cache: false,
			contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
	        type: 'POST',
	        url: "${ctx}/page/empleado?action=empleado_vereditarpropiedad&idempleado="+idempleado+"&idempleadopropiedad="+idempleadopropiedad,
	        dataType: "text",
	        error: function(jqXHR, textStatus, errorThrown) {
	            alert(jqXHR.statusText);
	        },
	        success: function(data) {		                    	                    	
	           	$("#dmEditarPropiedad").html(data);     
	        }
	    });
	}
	
	
	function Vercrearpropiedadempleado(idempleado){
		//alert("");
		$("#dmNuevaPropiedad").dialog("open");
		$("#dmNuevaPropiedad").html(getHTMLLoaging30());
		$.ajax({
			cache: false,
			contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
	        type: 'POST',
	        url: "${ctx}/page/empleado?action=empleado_vernuevapropiedad&idempleado="+idempleado,
	        dataType: "text",
	        error: function(jqXHR, textStatus, errorThrown) {
	            alert(jqXHR.statusText);
	        },
	        success: function(data) {		                    	                    	
	           	$("#dmNuevaPropiedad").html(data);     
	        }
	    });
	}
	
</script>

<div align="left" id="dmPropiedades">
<c:choose>
		<c:when test="${empty empleadopropiedades}">
			<c:if test="${sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 1 ||sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 212 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 213 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 214 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 215}">
				<c:if test="${empleado.estado==2}">
					<button type="button" id="btnCrearPropiedad" name="btnCrearPropiedad" onclick="Vercrearpropiedadempleado(${empleado.idempleado});">Crear</button>&nbsp;&nbsp;&nbsp;
				</c:if>
			</c:if>
			<div class="msgInfo1" align="left">No existen propiedades para ese empleado.</div>
		</c:when>
		<c:otherwise>



<br/>

<br/>


	<div id="idTabsEmpleadoPropiedades">
		<c:choose>
		<c:when test="${empty empleadopropiedades}">
			<c:if test="${sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 1 ||sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 212 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 213 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 214 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 215}">
					<c:if test="${empleado.estado==2}">
						<button type="button" id="btnCrearPropiedad" name="btnCrearPropiedad" onclick="Vercrearpropiedadempleado(${empleado.idempleado});">Crear</button>&nbsp;&nbsp;&nbsp;
					</c:if>
			</c:if>
			<div class="msgInfo1" align="left">No cuenta con propiedades asociadas.</div>
		</c:when>
		<c:otherwise>
<%-- 			<c:if test="${sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 1 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 214 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 215 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 216}"> --%>
			<c:if test="${sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 1 ||sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 212 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 213 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 214 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 215}">
					<c:if test="${empleado.estado==2}">
						<button type="button" id="btnCrearPropiedad" name="btnCrearPropiedad" onclick="Vercrearpropiedadempleado(${empleado.idempleado});">Crear</button>&nbsp;&nbsp;&nbsp;
					</c:if>
			</c:if>
		<fieldset style="width: auto"><legend class="e6"  >Propiedades</legend>	
		
				
				
				<table id="tablaEmpleadoPropiedades" style="font " border="0" width="100%" class="tExcel tRowSelect" >
				
				
			
				<!-- Cabecera de la tabla -->
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
			  	
			  	<!-- Cuerpo de la tabla -->
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
	<%-- 							<c:if test="${sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 1 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 214 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 215 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 216}"> --%>
											<c:if test="${sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 1 ||sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 212 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 213 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 214 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 215}">
												<c:if test="${empleado.estado==2}">
													<c:if test="${empleadopropiedad.estado==2}">
															<span class="enlace" onclick="deshabilitarEmpleadoPropiedad(${empleadopropiedad.idempleadopropiedad},${empleado.idempleado});" title="Deshabilitar"><img alt="Deshabilitar" src="${ctx}/imagen/control_deshabilitar.gif"></span>
															<span class="enlace" onclick="VereditarpropiedadEmpleado(${empleadopropiedad.idempleadopropiedad},${empleado.idempleado});" title="Editar"><img alt="Editar" src="${ctx}/imagen/control_editar.gif"></span>
													</c:if> 
													<c:if test="${empleadopropiedad.estado==3}">
															<span class="enlace" onclick="habilitarEmpleadoPropiedad(${empleadopropiedad.idempleadopropiedad},${empleado.idempleado});" title="Activar"><img alt="Activar" src="${ctx}/imagen/control_habilitar.gif"></span>
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

<br/>


<div>

<span class="enlace" id='lnkUpdatePropiedades' name='lnkUpdatePropiedades'><a href="${ctx}/page/desvinculacion?action=${proceso.nombreproceso}&idcontrato=${contrato.idcontrato}&idproceso=${proceso.idproceso}">&nbsp;Actualizar<span>&nbsp;</span></a></span>&nbsp;&nbsp;&nbsp;
</div>

</c:otherwise>
</c:choose>
</div>

<div style="padding: 30px 0px;"></div>

