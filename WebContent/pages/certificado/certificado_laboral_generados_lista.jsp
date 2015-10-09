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
		$("#dmMensajeCertificado").dialog({   				
			width: 400,
			height: 200,   				
			modal: true,
			autoOpen: false,
			resizable: true
		});
		
		$("[name=btnGenerarCertificado]").button();
		
		$("#certificados").tablesorter({ 
			debug: false,
	      
	        cssHeader: "headerSort",
	        cssAsc: "headerSortUp",
	        cssDesc: "headerSortDown",
	        sortMultiSortKey: "shiftKey"
	    });

		$("#contratos").fixedtableheader();
		
		$("[name=btnGenerarCertificado]").click(function() {
			generarcertificado('${contrato.idempleado}');
			alert("."+'${contrato.idempleado}');
		});
		
	});

	/* function generarcertificado(idempleado) {		
		if(idempleado==''){
			
		}else{
		
				$("[name=btnGenerarCertificado]").attr('disabled',true);;
				$("#dmMensajeCertificado").dialog("open");
				$("#dmMensajeCertificado").html(getHTMLLoaging16(' Activando'));
				$.ajax({
					cache: false,
					contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
		            type: 'post',            
		            url: '${ctx}/page/documentos?action=generar_certificado&idempleado='+idempleado,
		            data: '',
		            dataType: "text",
		            error: function(jqXHR, textStatus, errorThrown) {
		            	$("[name=btnGenerarCertificado]").attr('disabled',false);        		
		                $("#dmMensajeCertificado").html(jqXHR.statusText);
			        },
		            success: function(data) {
		            	  		$("#dmMensajeCertificado").dialog("close");
		               
		               
		            }
		        });	 
			
		}
	} */


	
</script>
<div align="left" >
<form name="fplanilla" id="fplanilla"  action="${ctx}/page/documentos"  method="post"  target="_blank">
	  <input type="hidden" name="action" value="generar_certificado"/>


	<input type="hidden" name="idempleado" value="${contrato.idempleado}">
<c:choose>
		<c:when test="${fn:length(certificados) eq 0}">
			<div class="msgInfo1" align="left">No se encontraron certificados.</div>
		</c:when>		
		<c:otherwise>
		<fieldset style="width: auto"><legend class="e6" >Certificados</legend>	
			<div>
			<div id="usuario_acciones" style="padding: 5px 0px 0px 0px;">			
<%--			<b>Ventas selecionadas:</b>&nbsp;&nbsp;&nbsp;<span class="enlace" id="enviar_correo_usuario">enviar por correo</span>--%>
			
			<div style="float: right;"><span class="texto1">Ordenar múltiples columnas: (Shift+[clic columna])</span></div>
			</div>
			<div style="clear: both;"></div>
			<div id="divcontratos" >
			<table style="width:100%" border="0" id="certificados" class="tExcel tRowSelect">
			
			
			  <thead>
			  <tr class="td3">
			    <th>#</th>		
			    <th><span title="Descargar Archivo">Descargar</span></th>	    
				<th><span title="Id">Id</span></th>
				
				<th><span title="Nombres">Nombres</span></th>
				<th><span title="Apellidos">Apellidos</span></th>
		
			  	<th><span title="Nombre documento">Documento tipo</span></th>
			  	<th><span title="Numero identificacion">Número identificación</span></th>  
			  	<th>Codigo certificado</th>				  	
			  	<th>Codigo verificación</th>
			  	<th>Usuario crea</th>
			  	<th>Fechacrea crea</th>
			  	<th>Usuario mod</th>
			  	<th>Fecha mod</th>
			  </tr>
			  </thead>
			  <tbody>
			  <c:forEach items="${certificados}" var="certificado" varStatus="loop">
			  <%-- <tr style="color: ${contrato.estado==2?'':'red'};"> --%>
			   <tr>
			  	<td><c:out value="${loop.index+1}"/></td>
			  	<td>
			  	<c:if test="${certificado.estado==2}">
			  	<a href="${ctx}/page/certificado?action=verArchivo&idempleadodocumento=${certificado.idempleadodocumentogenerado}" target="_blank"><img alt="descargar archivo" src="${ctx}/imagen/pdf.gif"></a>
											&nbsp;
			</c:if>
				</td>										  		
			  	<td><c:out value="${certificado.idempleadodocumentogenerado}"/></td>
			  
			  	<td><c:out value="${certificado.empleado.nombres}"/></td>
			  	<td><c:out value="${certificado.empleado.apellidos}"/></td>  
			 		
			  	<td><c:out value="${certificado.empleado.identificaciontipo.abreviatura}"/> - <c:out value="${certificado.empleado.identificaciontipo.tipo}"/></td>	
			  	<td><c:out value="${certificado.empleado.empleadoidentificacion.numeroidentificacion}"/></td>	
			 	<td><c:out value="${certificado.codigocertificado}"/></td>
			 	<td><c:out value="${certificado.codigoverificacion}"/></td>
			 	
			 	
			  	<td><c:out value="${certificado.idusuariocrea} "/></td>
			 	<td><fmt:formatDate value="${certificado.fechacrea}" pattern="dd/MM/yyyy H:mm"/></td>	
			  	<td><c:out value="${certificado.idusuariomod} "/></td>
			  	<td><fmt:formatDate value="${certificado.fechamod}" pattern="dd/MM/yyyy H:mm"/></td>			  		  	
			  	<%-- <td valign="middle" align="center"><span class="enlace" onclick="visualizarDetalleEmpleado(${contrato.idcontrato});" title="Detalle"><img alt="Detalle" src="${ctx}/imagen/ico-editar.gif"></span></td>	
			 --%>  
			 </tr>			 
			  </c:forEach>			  
			  </tbody>
			</table>
			</div>
			</div>
			</fieldset>
	</c:otherwise>
</c:choose> 

<div align="left">
<%-- 	<c:if test="${sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 1 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 213 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 214}"> --%>
	<%-- <c:if test="${sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 1 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 212 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 213 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 214}">
	 --%>	
	 
	
</div>
</form>
</div>

<div id="dmMensajeCertificado" title="Mensaje"></div>