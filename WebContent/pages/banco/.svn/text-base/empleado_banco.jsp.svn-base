<%@ include file="/taglibs.jsp"%>

<script type="text/javascript">
	$(document).ready(function() {
		$("[name=btnCrear]").button();
		
		$("[name=btnNuevoBanco]").button();
		
		$("[name=lnkUpdateBanco]").click(function() {
			actualizarBanco('${empleado.idempleado}');
		});
		
		
		
	});
	
	/*
	 * Actualizar datos de la tabla bancos.
	 */
	function actualizarBanco(idempleado){
		$("#dmBancos").html(getHTMLLoaging30());
		$.ajax({
			cache: false,
			contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
	        type: 'POST',
	        url: "${ctx}/page/banco?action=banco_propiedades&idempleado="+idempleado,
	        dataType: "text",
	        error: function(jqXHR, textStatus, errorThrown) {
	            alert(jqXHR.statusText);
	        },
	        success: function(data) {
	        	$("#dmBancos").html(data);
	        }
	    });
	}
	
	
	/**
	 * Ver editar empleado banco.
	 */
	 function VerEditarEmpleadoBanco(idempleadobanco,idempleado){
			//alert('Entro a VerEditarEmpleadoBanco');
			$("#dmEditarBanco").dialog("open");
			$("#dmEditarBanco").html(getHTMLLoaging30());
			$.ajax({
				cache: false,
				contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
		        type: 'POST',
		        url: "${ctx}/page/banco?action=empleado_vereditarbanco&idempleado="+idempleado+"&idempleadobanco="+idempleadobanco,
		        dataType: "text",
		        error: function(jqXHR, textStatus, errorThrown) {
		            alert(jqXHR.statusText);
		        },
		        success: function(data) {		                    	                    	
		           	$("#dmEditarBanco").html(data);     
		        }
		    });
	}
	
	
	/**
	 * Deshabilitar un empleado banco.
	 */
	function deshabilitarEmpleadoBanco(idempleadobanco,idempleado) {		
		
		//alert("idempleado"+idempleado+" ->"+idempleadobanco);
		
		if(idempleadobanco==''){
			
		}else{
			if(confirm('¿Esta seguro de deshabilitar la cuenta bancaria del empleado [${empleado.codempleado}] ${empleado.nombres} ${empleado.apellidos}?')){
				$.ajax({
					cache: false,
					contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
		            type: 'post',            
		            url: '${ctx}/page/banco?action=banco_deshabilitar&idempleadobanco='+idempleadobanco+'&idempleado='+idempleado,
		            data: '',
		            dataType: "text",
		            error: function(jqXHR, textStatus, errorThrown) {        		
		                $("#dmMensajeBanco").html(jqXHR.statusText);
			        },
		            success: function(data) {
		            	if(validarEntero(data)){
		                	actualizarBanco(data);
		                } else {
		                    $("#dmMensajeBanco").html('Error desconocido');					
		                }
		            }
		        });	 
			}
		}
	}
	
	
	/**
	 * Activar un empleado banco.
	 */
	 function habilitarEmpleadoBanco(idempleadobanco,idempleado) {		
			
			if(idempleadobanco==''){
				
			}else{
				if(confirm('¿Esta seguro de habilitar este banco al empleado [${empleado.codempleado}] ${empleado.nombres} ${empleado.apellidos}?')){
					
					$.ajax({
						cache: false,
						contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
			            type: 'post',            
			            url: '${ctx}/page/banco?action=empleadobanco_habilitar&idempleadobanco='+idempleadobanco+'&idempleado='+idempleado,
			            data: '',
			            dataType: "text",
			            error: function(jqXHR, textStatus, errorThrown) {
			                $("#dmMensajeBanco").html(jqXHR.statusText);
				        },
			            success: function(data) {
			            	if(validarEntero(data)){
			                	actualizarBanco(data);
			                } else {
			                    $("#dmMensajeBanco").html('Error desconocido');					
			                }
			            }
			        });	 
				}
			}
		}
	
</script>


<div align="left" id="dmBancos">
<c:choose>
		<c:when test="${empty empleadobanco}">
<%-- 			<button type="button" id="btnCrear" name="btnCrear" onclick="Vercrearpropiedad(${empleado.idempleado});">Crear</button>&nbsp;&nbsp;&nbsp; --%>
				<c:if test="${empleado.estado==2}">
					<button type="button" id="btnNuevoBanco" name="btnNuevoBanco" onclick="CrearBanco(${empleado.idempleado});">Registrar Cuenta</button>&nbsp;&nbsp;&nbsp;
				</c:if>
			<div class="msgInfo1" align="left">El empleado no tiene cuentas bancarias registradas.</div>
		</c:when>
		<c:otherwise>

<br/>

<br/>


	<div id="idTabsEmpleadoBanco">
		<c:choose>
		<c:when test="${empty empleadobanco}">
			<c:if test="${sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 213 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 1 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 214 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 215}">
				<c:if test="${empleado.estado==2}">
					<button type="button" id="btnNuevoBanco" name="btnNuevoBanco" onclick="CrearBanco(${empleado.idempleado});">Registrar Cuenta</button>&nbsp;&nbsp;&nbsp;
				</c:if>
			</c:if>
			<div class="msgInfo1" align="left">No cuenta con cuentas bancarias.</div>
		</c:when>
		<c:otherwise>
			<c:if test="${sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 213 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 1 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 214 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 215}">
<%-- 					<button type="button" id="btnCrear" name="btnCrear" onclick="Vercrearpropiedad(${empleado.idempleado});">Crear</button>&nbsp;&nbsp;&nbsp; --%>
				<c:if test="${empleado.estado==2}">
					<button type="button" id="btnNuevoBanco" name="btnNuevoBanco" onclick="CrearBanco(${empleado.idempleado});">Registrar Cuenta</button>&nbsp;&nbsp;&nbsp;
				</c:if>
			</c:if>
		<fieldset style="width: auto"><legend class="e6"  >Cuentas Bancarias</legend>	
		
				
				
				<table style="font " border="0" width="100%" class="tExcel tRowSelect" >
				
				
						<tr>
							<th>Banco</th>
							<th>N° Cuenta</th>
							<th>Vigente desde</th>
							<th>User crea</th>
							<th>Fecha crea</th>
							<th>User mod</th>
							<th>Fecha mod</th>	
							<th>Estado</th>	
							<th>Acción</th>	
						</tr>
				<tbody>
						
						
						 <c:forEach items="${empleadobanco}" var="empleadobanco" varStatus="loop">
							
								<tr style="color: ${empleadobanco.estado==2?'':'red'};">
								<td class="e6" ><c:out value="${empleadobanco.banco.nombrebanco}"/></td>
								<td><c:out value="${empleadobanco.numerocuenta}"/></td>
								
								<td><fmt:formatDate value="${empleadobanco.vigentedesde}" pattern="dd/MM/yyyy"/></td>
								<td><c:out value="${empleadobanco.idusuariocrea}"/></td>
								<td><fmt:formatDate value="${empleadobanco.fechacrea}" pattern="dd/MM/yyyy"/></td>
								<td><c:out value="${empleadobanco.idusuariomod}"/></td>
								<td><fmt:formatDate value="${empleadobanco.fechamod}" pattern="dd/MM/yyyy"/></td>
								<td>
								<c:if test="${empleadobanco.estado==2}">
								<c:out value="Activo"/>
								</c:if>
								<c:if test="${empleadobanco.estado==3}">
								<c:out value="Desactivado"/>
								</c:if>
								
								</td>
								
								<td>
							<c:if test="${sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 1 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 214 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 215 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 216}">
			
									<c:if test="${empleado.estado==2}">
										<c:if test="${empleadobanco.estado==2}">
											<span class="enlace" onclick="deshabilitarEmpleadoBanco(${empleadobanco.idempleadobanco},${empleado.idempleado});" title="Deshabilitar">
												<img alt="Deshabilitar" src="${ctx}/imagen/control_deshabilitar.gif">
											</span>
											<span class="enlace" onclick="VerEditarEmpleadoBanco(${empleadobanco.idempleadobanco},${empleado.idempleado});" title="Editar">
												<img alt="Editar" src="${ctx}/imagen/control_editar.gif">
											</span>
										</c:if>
									
									<c:if test="${empleadobanco.estado==3}">
										<span class="enlace" onclick="habilitarEmpleadoBanco(${empleadobanco.idempleadobanco},${empleado.idempleado});" title="Activar">
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

<span class="enlace" id='lnkUpdateBanco' name='lnkUpdateBanco'>&nbsp;Actualizar<span>&nbsp;</span></a></span>&nbsp;&nbsp;&nbsp;
</div>

</c:otherwise>
</c:choose>
</div>




<div style="padding: 30px 0px;"></div>