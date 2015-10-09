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
		$("#empleadoslistado").tablesorter({ 
			debug: false,
	        cssHeader: "headerSort",
	        cssAsc: "headerSortUp",
	        cssDesc: "headerSortDown",
	        sortMultiSortKey: "shiftKey"
	    });

		$("#empleadoslistado").fixedtableheader();
	
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
		<c:when test="${fn:length(empleados) eq 0}">
			<div class="msgInfo1" align="left">No se encontraron empleados.</div>
		</c:when>		
		<c:otherwise>
			<div>
			<div id="usuario_acciones" style="padding: 5px 0px 0px 0px;">			
<%--			<b>Ventas selecionadas:</b>&nbsp;&nbsp;&nbsp;<span class="enlace" id="enviar_correo_usuario">enviar por correo</span>--%>
			
			<div style="float: right;"><span class="texto1">Ordenar múltiples columnas: (Shift+[clic columna])</span></div>
			</div>
			<div style="clear: both;"></div>
			<div id="divempleados" >
			<table style="width:100%" border="0" id="empleadoslistado" class="tExcel tRowSelect">
			  <col style="width: 20px;"/>
			  <col style="width: 20px;"/>
		 	 <col style="width: 20px;"/>
			  <col style="width: 30px;"/>
			  <col style="width: 50px;"/>
			  <col style="width: 50px;"/>
			 
			
			  <thead>
			  <tr class="td3">
			    <th>#</th>			    
				<th><span title="Código de usuario">Codigo de usuario</span></th>
				<th><span title="Estado usuario">Estado</span></th>
				<th><span title="Area">Area</span></th>
				<th><span title="Area asignada">Area asignada</span></th>
				<th><span title="Actual">Documento actual</span></th>
				<th><span title="Tipo de Documento">Tipo de documento</span></th>	
			  	<th><span title="Número de identificación">Identificación</span></th>
			  				  				  	
			  	<th>Nombres</th>
			  	<th>Apellidos</th>
			  	<th>Fecha nacimiento</th>
			  	<th>Fechacrea</th>
			  	<th>Usuario crea.</th>
			   	<th>Fechamod</th>	
			  	<th>Usuario mod.</th>			  	
			  	<th>Acciones</th>
			  </tr>
			  </thead>
			  <tbody>
			  <c:forEach items="${empleados}" var="empleado" varStatus="loop">
			  <tr style="color: ${empleado.estado==2?'':'red'};">
			  	<td><c:out value="${loop.index+1}"/></td>			  		
			  	<td><c:out value="${empleado.codempleado}"/></td>
			  	<td><c:out value="${empleado.estado==2?'+':usuario.estado==3?'.':'-'}"/></td>
			  	<td><c:out value="${empleado.ultimocontrato.area.nombrearea}"/></td>
			  	<td><c:out value="${empleado.ultimocontrato.areaasignada.nombrearea}"/></td>
			  	<td><c:out value="${empleado.empleadoidentificacion.actual==1?'+':empleado.empleadoidentificacion.actual==3?'.':'-'}"/></td>  
			 	<td><c:out value="${empleado.identificaciontipo.abreviatura}"/> - <c:out value="${empleado.identificaciontipo.tipo}"/></td>	
			  	<td><c:out value="${empleado.empleadoidentificacion.numeroidentificacion}"/></td>	
			  	<td><c:out value="${empleado.nombres}"/> </td>
			    <td><c:out value="${empleado.apellidos} "/></td>
			  
			    <td><fmt:formatDate value="${empleado.fechanacimiento}" pattern="dd/MM/yyyy"/></td>
			  	<td><fmt:formatDate value="${empleado.fechacrea}" pattern="dd/MM/yyyy H:mm"/></td>
			  	<td><c:out value="${empleado.idusuariocrea} "/></td>
			 	<td><fmt:formatDate value="${empleado.fechamod}" pattern="dd/MM/yyyy H:mm"/></td>	
			  	<td><c:out value="${empleado.idusuariomod} "/></td>		  		  	
			  	<td valign="middle" align="center"><span class="enlace" onclick="visualizarDetalleEmpleado(${empleado.idempleado});" title="Detalle"><img alt="Detalle" src="${ctx}/imagen/ico-editar.gif"></span></td>	
			  </tr>			 
			  </c:forEach>			  
			  </tbody>
			</table>
			</div>
			</div>
	</c:otherwise>
</c:choose> 
</div>