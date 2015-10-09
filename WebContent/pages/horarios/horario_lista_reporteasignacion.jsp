<%@ include file="/taglibs.jsp"%>
<script type="text/javascript">
	$.tablesorter.addParser({ 
	    id: 'datetime', 
	    is: function(s) { 
	        return false; 
	    }, 
	    format: function(s) { 
	    	if (s.length > 0) {
	    		return $.tablesorter.formatFloat(Date.parseExact(s,'dd/MM/yyyy H:mm').getTime());
	    	} else {
	    	    return 0;
	    	}
	    }, 
	    type: 'numeric' 
	});
	
	$(document).ready(function() {
		<c:forEach items="${frequencias}" var="frecuencia" varStatus="loop">			
		$("#textovertical_f_${loop.index}").flipv();
	</c:forEach>
	
	

			$("#asignacionlistado").tablesorter({ 
				debug: false,
		        cssHeader: "headerSort",
		        cssAsc: "headerSortUp",
		        cssDesc: "headerSortDown",
		        sortMultiSortKey: "shiftKey"
		    });

			$("#asignacionlistado").fixedtableheader();
	
	});

	function eliminarusuario(cedula){
		if(confirm("¿Desea eliminar al usuario con cédula "+cedula+"?")){
			$.ajax({
	            type: 'POST',
	            url: "${ctx}/servlet/usuario?action=usuario_eliminar&cedula="+cedula,
	            dataType: "text",
	            success: function(data) {		                    	                    	
	            	actualizarBusquedaDeUsuario('#fBuscarusuario');   
	            }
	        });
		}
	}	
	
</script>
<div align="left" >

<c:choose>
		<c:when test="${fn:length(reporteasignaciones) eq 0}">
			<div class="msgInfo1" align="left">No se encontraron registros de asignacion.</div>
		</c:when>		
		<c:otherwise>
			<div>
			<div id="usuario_acciones" style="padding: 5px 0px 0px 0px;">			
<%--			<b>Ventas selecionadas:</b>&nbsp;&nbsp;&nbsp;<span class="enlace" id="enviar_correo_usuario">enviar por correo</span>--%>
			
			<div style="float: right;"><span class="texto1">Ordenar múltiples columnas: (Shift+[clic columna])</span></div>
			</div>
			<div style="clear: both;"></div>
			<div id="divempleados" >
			<table style="width:100%" border="0" id="asignacionlistado" class="tExcel tRowSelect">
			  <col style="width: 20px;"/>
			  <col style="width: 20px;"/>
		 	
			
			  <thead>
			  <tr class="td3">
			    <th>#</th>			    
				<th><span title="Número identificación">Número identificación</span></th>
				<th><span title="Nombres">Nombre</span></th>
				<!-- <th><span title="Apellidos">Apellidos</span></th> -->	
				<th><span title="Area">Area asignada</span></th>
			  	<th><span title="Cargo">Cargo</span></th>
			  	
			  	<c:forEach items="${frequencias}" var="frecuencia" varStatus="loop">
					<%-- <th class="cabecera" colspan="3"><span id='textovertical_f_${loop.index}' class="270-degrees" ><fmt:formatDate value="${frecuencia}" pattern="${formato}"/></span></th>
			 --%>	
			<th rowspan="3"> <span id='textovertical_f_${loop.index}' class="270-degrees"><fmt:formatDate  value="${frecuencia}" pattern="${formato}"/></span></th>
			 </c:forEach> 		  	
			  
			  
			  
			  </tr>
			  </thead>
			  <tbody>
			  <c:forEach items="${reporteasignaciones}" var="reporteasignacion" varStatus="loop">
			 <%--  <tr style="color: ${empleado.estado==2?'':'red'};"> --%>
			 <tr>
			  	<td><c:out value="${loop.index+1}"/></td>			  		
			 <%--  	<td><c:out value="${reporteasignacion.identificaciontipo.abreviatura}"/></td> --%>
			  	<td><c:out value="${reporteasignacion.empleadoidentificacion.numeroidentificacion}"/></td>
			  	<td><c:out value="${reporteasignacion.empleado.nombres}"/> <c:out value="${reporteasignacion.empleado.apellidos}"/></td>  
			  	<td><c:out value="${reporteasignacion.area.nombrearea}"/></td>
			 	<td><c:out value="${reporteasignacion.cargo.nombrecargo}"/></td>	
			 	<c:forEach items="${reporteasignacion.valores}" var="valor">
			  		
				  		
							<td align="right" title="Horario: " >
								<c:out value="${valor.fechas}"/>
							</td>
						
					
				</c:forEach>	
			  	
			  	</tr>			 
			  </c:forEach>			  
			  </tbody>
			</table>
			</div>
			</div>
	</c:otherwise>
</c:choose> 
</div>