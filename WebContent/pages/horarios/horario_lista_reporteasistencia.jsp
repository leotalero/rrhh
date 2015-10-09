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
		$("#asistencialistado").tablesorter({ 
			debug: false,
	        headers: {7:{sorter:'datetime'},8:{sorter:'datetime'}},
	        cssHeader: "headerSort",
	        cssAsc: "headerSortUp",
	        cssDesc: "headerSortDown",
	        sortMultiSortKey: "shiftKey"
	    });

		$("#asistencialistado").fixedtableheader();
	
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
		<c:when test="${fn:length(reporteaasistencias) eq 0}">
			<div class="msgInfo1" align="left">No se encontraron registros de asistencia.</div>
		</c:when>		
		<c:otherwise>
			<div>
			<div id="usuario_acciones" style="padding: 5px 0px 0px 0px;">			
<%--			<b>Ventas selecionadas:</b>&nbsp;&nbsp;&nbsp;<span class="enlace" id="enviar_correo_usuario">enviar por correo</span>--%>
			
			<div style="float: right;"><span class="texto1">Ordenar múltiples columnas: (Shift+[clic columna])</span></div>
			</div>
			<div style="clear: both;"></div>
			<div id="divempleados" >
			<table style="width:100%" border="0" id="asistencialistado" class="tExcel tRowSelect">
			  <col style="width: 20px;"/>
			  <col style="width: 20px;"/>
		 	 <col style="width: 20px;"/>
			  <col style="width: 30px;"/>
			  <col style="width: 50px;"/>
			  <col style="width: 50px;"/>
			 
			
			  <thead>
			  <tr class="td3">
			    <th>#</th>			    
				<th><span title="Tipo documento">Tipo documento</span></th>
				<th><span title="Número identificación">Número identificación</span></th>
				<th><span title="Nombres">Nombres</span></th>
				<th><span title="Apellidos">Apellidos</span></th>	
				<th><span title="Area">Area asignada</span></th>
			  	<th><span title="Cargo">Cargo</span></th>
			  				  				  	
			  	<th>Horario programado de ingreso</th>
			  	<th>Horario programado de salida</th>
			  	<th>Minutos Flex.</th>
			  	<th>Ingreso</th>
			  	<th>Salida</th>
			  	<th>Minutos de diferencia de ingreso</th>
			  	<th>Minutos de diferencia de salida</th>
			  	<th>Minutos trabajados</th>
			   	<th>Estado asistencia</th>	
			   	<th>Ip</th>
			   	<th>Ip publica</th>
			  </tr>
			  </thead>
			  <tbody>
			  <c:forEach items="${reporteaasistencias}" var="reporteasistencia" varStatus="loop">
			 <%--  <tr style="color: ${empleado.estado==2?'':'red'};"> --%>
			 <tr>
			  	<td><c:out value="${loop.index+1}"/></td>			  		
			  	<td><c:out value="${reporteasistencia.identificaciontipo.abreviatura}"/></td>
			  	<td><c:out value="${reporteasistencia.empleadoidentificacion.numeroidentificacion}"/></td>
			  	<td><c:out value="${reporteasistencia.empleado.nombres}"/></td>  
			  	<td><c:out value="${reporteasistencia.empleado.apellidos}"/></td>  
			  	<td><c:out value="${reporteasistencia.area.nombrearea}"/></td>
			  
			 	<td><c:out value="${reporteasistencia.cargo.nombrecargo}"/></td>	
			  	<td><fmt:formatDate value="${reporteasistencia.asistencia.fechainicioprogramado}" pattern="dd/MM/yyyy H:mm"/></td>	
			  	<td><fmt:formatDate value="${reporteasistencia.asistencia.fechafinprogramado}" pattern="dd/MM/yyyy H:mm"/></td>	
			  	<td>
			  	<c:out value="${reporteasistencia.asistencia.minutosflexibilidad}"/>
		  	  	</td>
			  	<td><fmt:formatDate value="${reporteasistencia.asistencia.fechainiciomarcado}" pattern="dd/MM/yyyy H:mm"/></td>
			  	<td><fmt:formatDate value="${reporteasistencia.asistencia.fechafinmarcado}" pattern="dd/MM/yyyy H:mm"/></td>
			  	<%-- <td style="color: ${reporteasistencia.asistencia.calculoentrada<0?'':'red'};"><c:out value="${reporteasistencia.asistencia.calculoentrada}"/></td>
			  	 --%>
			  	 <td style="color: ${reporteasistencia.asistencia.clasificacion.color};"><c:out value="${reporteasistencia.asistencia.calculoentrada}"/></td>
			  	 
			  	 
			  	<td>
			  	<c:out value="${reporteasistencia.asistencia.calculosalida}"/>
		  	  	</td>
			  
			  	<td>
			  	<c:out value="${reporteasistencia.asistencia.calculomintrabajados}"/>
		  	  	</td>
			  	<%-- <td style="color: ${reporteasistencia.asistencia.estadoasistencia!='Tarde'?'':'red'};"><c:out value="${reporteasistencia.asistencia.estadoasistencia}"/></td>
			   	 --%>
			   	 <td style="color: ${reporteasistencia.asistencia.clasificacion.color};"><c:out value="${reporteasistencia.asistencia.estadoasistencia}"/></td>
			   	
			   	<td>
			  	<c:out value="${reporteasistencia.asistencia.ip}"/>
		  	  	</td>
		  	  	<td>
			  	<c:out value="${reporteasistencia.asistencia.publicip}"/>
		  	  	</td>
			   </tr>			 
			  </c:forEach>			  
			  </tbody>
			</table>
			</div>
			</div>
	</c:otherwise>
</c:choose> 
</div>