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
		
		
		
		$("#cargoareaasignada").tablesorter({ 
			debug: false,
	       
	        cssHeader: "headerSort",
	        cssAsc: "headerSortUp",
	        cssDesc: "headerSortDown",
	        sortMultiSortKey: "shiftKey"
	    });

		$("#empleados").fixedtableheader();
	
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
		<c:when test="${fn:length(areas) eq 0}">
			<div class="msgInfo1" align="left">No se encontraron coincidencias.</div>
		</c:when>		
		<c:otherwise>
			<div>
			<div id="usuario_acciones" style="padding: 5px 0px 0px 0px;">			
<%--			<b>Ventas selecionadas:</b>&nbsp;&nbsp;&nbsp;<span class="enlace" id="enviar_correo_usuario">enviar por correo</span>--%>
			
			<div style="float: right;"><span class="texto1">Ordenar múltiples columnas: (Shift+[clic columna])</span></div>
			</div>
			<div style="clear: both;"></div>
			<div id="divempleados" >
			<table style="width:100%" border="0" id="cargoareaasignada" class="tExcel tRowSelect">
	
			 
			
			  <thead>
			  <tr class="td3">
			    <th>#</th>		
			    <th><span title="Identificación Cargo">Id. cargo</span></th>	
			    <th><span title=Cargo">Cargo</span></th> 
			    	<th><span title="Identificación Area">Id. area asignada</span></th>    
			    	 	<th><span title="Area asignada">Area asignada</span></th>   
				<th><span title="Identificación Area">Id. area a mostrar</span></th>
				<th><span title="Nombre Area">Nombre area a mostrar</span></th>

			  
			  	<th>Fechacrea</th>
			  	<th>Usuario crea.</th>
			   	<th>Fechamod</th>	
			  	<th>Usuario mod.</th>			  	
			  	<th>Acciones</th>
			  </tr>
			  </thead>
			  <tbody>
			  <c:forEach items="${areas}" var="area" varStatus="loop">
			  <tr style="color: ${area.estado==2?'':'red'};">
			  	<td><c:out value="${loop.index+1}"/></td>	
			  	<td><c:out value="${area.idcargo}"/></td>	
			  	<td><c:out value="${area.cargo.nombrecargo}"/></td>	
			  	<td><c:out value="${area.idareaasignada}"/></td>	
			  	<td><c:out value="${area.areaasignada.nombrearea}"/></td>	  		
			  	<td><c:out value="${area.idarea}"/></td>
			  	<td><c:out value="${area.nombrearea}"/> </td>
			   
			  	<td><fmt:formatDate value="${area.fechacrea}" pattern="dd/MM/yyyy H:mm"/></td>
			  	<td><c:out value="${area.idusuariocrea} "/></td>
			 	<td><fmt:formatDate value="${area.fechamod}" pattern="dd/MM/yyyy H:mm"/></td>	
			  	<td><c:out value="${area.idusuariomod} "/></td>		  		  	
			  	<td valign="middle" align="center">	
			  	<c:if test="${area.estado==2}">
	
		<span class="enlace" onclick="deshabilitarArea(${area.idcargo},${area.idareaasignada},${area.idarea});" title="Deshabilitar"><img alt="Deshabilitar" src="${ctx}/imagen/control_deshabilitar.gif"></span>
							
		</c:if> 
		<c:if test="${area.estado==3}">
		<span class="enlace" onclick="habilitarArea(${area.idcargo},${area.idareaasignada},${area.idarea});" title="Activar"><img alt="Activar" src="${ctx}/imagen/control_habilitar.gif"></span>
		</c:if></td>	
			  </tr>		
			  	 
			  </c:forEach>			  
			  </tbody>
			</table>
			</div>
			</div>
	</c:otherwise>
</c:choose> 
</div>