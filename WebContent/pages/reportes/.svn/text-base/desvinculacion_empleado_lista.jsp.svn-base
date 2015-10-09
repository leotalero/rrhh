 <%@ include file="/taglibs.jsp"%>
<style type="text/css">
    body {
        padding:5px;
    }
    .pie_progress svg {
        width: 50px;
    }
    @media all and (max-width: 768px) {
        .pie_progress svg {
            width: 90%;
            max-width:50px;
        }
    }
</style>
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
		$("#Dempleados").tablesorter({ 
			debug: false,
	      //  headers: {11:{sorter:'datetime'},13:{sorter:'datetime'}, 14: { sorter: false}},
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
	
	
	function fillporcentaje(idcontratoproceso,porcentaje) {
	
		
		$(document).ready(function() {
			  
			 $("#progress"+idcontratoproceso).asPieProgress({
		            namespace: 'pie_progress',
		           	
		            	
		        });
			
			var por= Number(porcentaje);
			
		 $("#progress"+idcontratoproceso).asPieProgress('go',por);
		 
		 
		});
	}
</script>
<div align="left" >

<c:choose>
		<c:when test="${fn:length(empleados) eq 0}">
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
			<table style="width:100%" border="0" id="Dempleados" class="tExcel tRowSelect">
			  <col style="width: 20px;"/>
			  <col style="width: 20px;"/>
		 	 <col style="width: 20px;"/>
			  <col style="width: 30px;"/>
			  <col style="width: 50px;"/>
			  <col style="width: 50px;"/>
			 
			
			  <thead>
			  <tr class="td3">
			    <th>#</th>		
			    <th>
			    	<span title="Tipo de Documento">Tipo de documento</span>
			    </th>		
			    <th>
			    	<span title="Número de identificación">Identificación</span>
			    </th>    
				<th>Nombres</th>
				<th>Apellidos</th>
				<th>
					<span title="Estado Desvinculación">Estado desvinculación</span>
				</th>
				<th>
					<span title="Cargo">Cargo</span>
				</th>
				<!-- ----------------------------------------- -->
				<!-- Agregar columnas de area y area asignada. -->
				<!-- ----------------------------------------- -->
				<th>
					Área
				</th>
				<th>
					Área Asignada
				</th>
				<!-- ----------------------------------------- -->
				<!-- Fin agregación -->
				<!-- ----------------------------------------- -->
				<th>
					<span title="estado contrato">Estado contrato</span>
				</th>
				<th>
					<span title="estado empleado">Estado empleado</span>
				</th>
				<th>
					<span title="fecha final contrato">Fecha fin contrato</span>
				</th>
				<th>
					<span title="fecha">Fecha entrevista</span>
				</th>
				<c:forEach items="${procesos}" var="proceso" varStatus="loop">
					<%-- <th class="cabecera" colspan="3"><span id='textovertical_f_${loop.index}' class="270-degrees" ><fmt:formatDate value="${frecuencia}" pattern="${formato}"/></span></th>
			 --%>	
			<th rowspan="3"> <span id='textovertical_f_${loop.index}' class="270-degrees">${proceso.nombreproceso}</span></th>
			 </c:forEach> 		  	
			<!--   	<th>Acciones</th> -->
			  </tr>
			  </thead>
			  <tbody>
			  <c:forEach items="${empleados}" var="empleado" varStatus="loop">
			  <tr style="color: ${empleado.empleado.estado==2?'':'red'};">
			  	<td><c:out value="${loop.index+1}"/></td>			  		
			 	<td><c:out value="${empleado.empleado.identificaciontipo.abreviatura}"/> - <c:out value="${empleado.empleado.identificaciontipo.tipo}"/></td>	
			
			  	<td><c:out value="${empleado.empleado.empleadoidentificacion.numeroidentificacion}"/></td>	
			  	<td><c:out value="${empleado.empleado.nombres}"/> </td>
			    <td><c:out value="${empleado.empleado.apellidos} "/></td>
			   <td><c:out value="${empleado.estadodesvinculacion.nombreestado} "/></td>
			   <td><c:out value="${empleado.contrato.cargo.nombrecargo} "/></td>
			   <td><c:out value="${empleado.contrato.area.nombrearea} "/></td>
			   <td><c:out value="${empleado.contrato.areaasignada.nombrearea} "/></td>
			
			    <td style="color: ${empleado.contrato.estado==2?'':'red'};"><c:out value="${empleado.contrato.estado==2?'+':empleado.contrato.estado==3?'-':'.'}"/></td>
			    
			     <td style="color: ${empleado.empleado.estado==2?'':'red'};"><c:out value="${empleado.empleado.estado==2?'+':empleado.empleado.estado==3?'-':'.'}"/></td>
			   	<td><fmt:formatDate value="${empleado.contrato.fechafin}" pattern="dd/MM/yyyy"/></td>
			   <td><fmt:formatDate value="${empleado.fechacrea}" pattern="dd/MM/yyyy"/></td>	
			   <c:forEach items="${empleado.valores}" var="valor" >
			  	
				  		
						<%-- 	<td align="center" title="Porcentaje: " >
								<c:out value="${valor.porcentaje}"/>
							</td> --%>
							<td>
									   <div class="pie_progress" id="progress${valor.proceso.idproceso}_${loop.index+1}"  data-barcolor="${valor.proceso.color}" data-barsize="20" role="progressbar" data-goal="100">
						                    <div class="pie_progress__content">${valor.porcentaje}%</div>
						                  <script type="text/javascript">fillporcentaje("${valor.proceso.idproceso}_${loop.index+1}","${valor.porcentaje}");</script>
						                </div>
						     </td>
			
							
						
					
				</c:forEach>
			   
			  	<%-- <td><c:out value="${empleado.idusuariocrea} "/></td>
			 	<td><fmt:formatDate value="${empleado.fechamod}" pattern="dd/MM/yyyy H:mm"/></td>	
			  	<td><c:out value="${empleado.idusuariomod} "/></td>		  		  	
			  	<td valign="middle" align="center"><span class="enlace" onclick="visualizarDetalleEmpleado(${empleado.idempleado});" title="Detalle"><img alt="Detalle" src="${ctx}/imagen/ico-editar.gif"></span></td>	
			 --%>  </tr>			 
			  </c:forEach>			  
			  </tbody>
			</table>
			</div>
			</div>
	</c:otherwise>
</c:choose> 
</div>