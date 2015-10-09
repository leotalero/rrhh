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
		
		
		$("#fGenerarCertificadolaboral [name=btnGenerarCertificado]").button();
		
		 $("#fGenerarCertificadolaboral").validate({
			errorLabelContainer: "#msnBuscarEmpleado",
			errorClass: "invalid",
			rules: {
				
			},
			messages: {
				
				
			},
			submitHandler: function(form) {	
				
			//	alert("va");
				  $("#fGenerarCertificadolaboral").submit();
				
			}
		}); 
		 
	
	})
	function BusquedaDeCertificados(idempleado){
	//alert("envia");
		$("#dmCertificadoHistorial").html(getHTMLLoaging30()); 
       //	$("#btnBuscarCertificado").attr('disabled',true);;	 				
		$.ajax({
			cache: false,
			contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
            type: 'post',            
            url: '${ctx}/page/empleado?action=buscar_certificados&idempleado='+idempleado,
            data: '',
            dataType: "text",
            error: function(jqXHR, textStatus, errorThrown) {
            	$("[name=btnGenerarCertificado]").attr('disabled',false);        		
                $("#dmMensajeCertificado").html(jqXHR.statusText);
	        },
            success: function(data) {
            	 $("#dmCertificadoHistorial").html(data);
               
               
            }
        });	
	}

	$("[name=lnkUpdateUsuarioDetalle]").click(function() {
		BusquedaDeCertificados('${empleado.idempleado}');
	});
	
</script>
<div align="left" >
<fieldset><legend class="e6">Certificado laboral</legend>
<form name="fGenerarCertificadolaboral" id="fGenerarCertificadolaboral" action="${ctx}/page/certificado" method="post" target="_blank">
<input type="hidden" name="action" value="generar_certificado"/>
<input type="hidden" name="idempleado" id="idempleadoCerti" value="${empleado.idempleado}"/>

	<table border="0" width="100%" class="caja">
	<%-- <c:if test="${empleado.estado==2}">
			<button type="button" id="btnCrearContrato" name="btnCrearContrato" onclick="CrearContrato(${empleado.idempleado});">Crear contrato</button>&nbsp;&nbsp;&nbsp;
	</c:if>	 --%>
		<tr>
			<td>
			<c:if test="${sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 212 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 1 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 213 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 214 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 215}">
				<c:if test="${mensaje=='No tiene:'}">
				
				<button type="submit" id="btnGenerarCertificado" name="btnGenerarCertificado" >Generar certificado</button>&nbsp;&nbsp;&nbsp;
			
				</c:if>
				<c:if test="${mensaje!='No tiene:'}">
				
					<div class="msgInfo1" align="left">${mensaje}</div>
				</c:if>
				
			</c:if>
			<span class="enlace" id='lnkUpdateUsuarioDetalle' name='lnkUpdateUsuarioDetalle'>Actualizar</span>&nbsp;&nbsp;&nbsp;
			<script type="text/javascript">
			BusquedaDeCertificados("${empleado.idempleado}");</script>
			</td>
		</tr>
	</table>
</form>
</fieldset>

<div style="width: 95%" id="dmCertificadoHistorial" title="certificados"></div>


</div>