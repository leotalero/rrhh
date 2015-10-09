<%@ include file="/taglibs.jsp"%>

<script type="text/javascript">
	$(document).ready(function() {
		$("[name=btnEdicionEmpleado]").button();
		$("[name=btnDeshabilitarEmpleado]").button();
		$("[name=btnActivarEmpleado]").button();	
		
		$("[name=btnEdicionEmpleadoContrasena]").button();
		$("[name=btnEdicionContrato]").button();
		$("[name=btnDeshabilitarContrato]").button();
		$("[name=btnActivarContrato]").button();
		$("[name=btnCrearContrato]").button();
		$("[name=btnHorario]").button();
		$("[name=btnDesvinculacion]").button();
		$("[name=btnEditarSalario]").button();
		
		//Boton Crear Nuevo Banco
		$("[name=btnNuevoBanco]").button();
		//Boton Proceso disciplinario.
		$("[name=btnProcesoDisciplinario]").button();
		
		$("[name=btnSubirfoto]").button();
// 		 var icons = {
// 				 header: "ui-icon-circle-triangle-e",
// 				 activeHeader: "ui-icon-circle-triangle-s"
// 				 };
		 
// 		 $( "#accordion" ).accordion({
// 			 heightStyle: "fill",
// 		      icons: icons,
// 			collapsible: true
// 			 });
		
// 		$(function() {
// 		    $( "#accordion" ).accordion();
// 		 });
		
		$( "#accordion" ).accordion({
			"collapsible":true, 
			active:2 
		});
		
		
		$("[name=lnkUpdateUsuarioDetalle]").click(function() {
			actualizarDetalleEmpleado('${empleado.idempleado}');
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
	});
	
	function activarEmpleado(idempleado) {		
		if(idempleado==''){
			
		}else{
			if(confirm('¿Esta seguro de activar al empleado [${empleado.codempleado}] ${empleado.nombres}?')){
				$("[name=btnActivarEmpleado]").attr('disabled',true);;
				$("#dmMensajeEmpleado").dialog("open");
				$("#dmMensajeEmpleado").html(getHTMLLoaging16(' Activando'));
				$.ajax({
					cache: false,
					contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
		            type: 'post',            
		            url: '${ctx}/page/empleado?action=empleado_activar&idempleado='+idempleado,
		            data: '',
		            dataType: "text",
		            error: function(jqXHR, textStatus, errorThrown) {
		            	$("[name=btnActivarEmpleado]").attr('disabled',false);        		
		                $("#dmMensajeEmpleado").html(jqXHR.statusText);
			        },
		            success: function(data) {
		            	if(validarEntero(data)){
		            		$("#dmMensajeEmpleado").dialog("close");
		                	$("#dmDetalleEmpleado").dialog("close");
		                	visualizarDetalleUsuario(data);
		                } else {
		                	$("[name=btnActivarEmpleado]").attr('disabled',false);
		                    $("#dmMensajeEmpleado").html('Error desconocido');					
		                }
		            }
		        });	 
			}
		}
	}

	function deshabilitarEmpleado(idempleado) {		
		
		//alert("idempleado"+idempleado);
		if(idempleado==''){
			
		}else{
			if(confirm('¿Esta seguro de deshabilitar al empleado [${empleado.codempleado}] ${empleado.nombres} ${empleado.apellidos}?')){
				$("[name=btnDeshabilitarEmpleado]").attr('disabled',true);;
				$("#dmMensajeEmpleado").dialog("open");
				$("#dmMensajeEmpleado").html(getHTMLLoaging16(' Eliminando'));
				$.ajax({
					cache: false,
					contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
		            type: 'post',            
		            url: '${ctx}/page/empleado?action=empleado_deshabilitar&idempleado='+idempleado,
		            data: '',
		            dataType: "text",
		            error: function(jqXHR, textStatus, errorThrown) {
		            	$("[name=btnDeshabilitarEmpleado]").attr('disabled',false);        		
		                $("#dmMensajeEmpleado").html(jqXHR.statusText);
			        },
		            success: function(data) {
		            	if(validarEntero(data)){
		            		$("#dmMensajeEmpleado").dialog("close");
		                	$("#dmDetalleEmpleado").dialog("close");
		                	visualizarDetalleEmpleado(data);
		                } else {
		                	$("[name=btnDeshabilitarEmpleado]").attr('disabled',false);
		                    $("#dmMensajeEmpleado").html('Error desconocido');					
		                }
		            }
		        });	 
			}
		}
	}	
	
	function CrearContrato(idempleado) {		
		if(idempleado==''){
			
		}else{
			visualizarCrearContrato(idempleado);		
		}
	}
	
	//Crear Nuevo Banco
	function CrearBanco(idempleado) {	
		if(idempleado==''){
		}else{
			visualizarCrearBanco(idempleado);
		}
	}
	
	//Crear Nueva Afiliación
	function CrearAfiliacion(idempleado) {	
		if(idempleado==''){
		}else{
			//alert('Hay vamos');
			visualizarCrearAfiliacion(idempleado);
		}
	}
	
	//Crear Nuevo proceso Disciplinario
	function CrearProcesoDisciplinario(idcontrato) {	
		if(idcontrato==''){
		}else{
			visualizarCrearProcesoDisciplinario(idcontrato); //En empleado busqueda.
		}
	}
	
	
	//Crear Nuevo familiar
	function CrearFamiliar(idempleado) {	
		if(idempleado==''){
		}else{
			visualizarCrearFamiliar(idempleado);
		}
	}
	
	function CrearEducacion(idempleado){
		if(idempleado==''){
		}else{
			visualizarCrearEducacion(idempleado);
		}
	}
	
	function vereditarContrato(idcontrato) {		
		if(idcontrato==''){
			
		}else{
			visualizarEditarContrato(idcontrato);		
		}
	}
	function verHorario(idcontrato) {		
		if(idcontrato==''){
			
		}else{
			//alert("...");
			$("#dmEditarHorario").dialog("close");
			visualizarEditarHorario(idcontrato);		
		}
	}
	
	
	
	
	function visualizarEditarHorario(idcontrato){
		//alert("editar conttrato");
		//alert(".");
		$("#dmEditarHorario").dialog("close");
		//$("#dmEditarHorario").dialog("open");  
		AbreEditarHorario(idcontrato);
	}
	
	
	function AbreEditarHorario(idcontrato) {		
		$("#dmEditarHorario").dialog("open");
		$("#dmEditarHorario").html(getHTMLLoaging30());
		$.ajax({
			cache: false,
			contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
	        type: 'POST',
	        url: "${ctx}/page/contrato?action=ver_editar_horario&idcontrato="+idcontrato,
	        dataType: "text",
	        error: function(jqXHR, textStatus, errorThrown) {
	            alert(jqXHR.statusText);
	        },
	        success: function(data) {	                    	                    	
	           	$("#dmEditarHorario").html(data);     
	        }
	    });
	}
	
	
	
	
	//Ver Proceso Disciplinario del contrato
	function verProcesoDisciplinario(idcontrato) {		
		if(idcontrato==''){
		}else{
			visualizarProcesoDisciplinario(idcontrato); //Este método está en empleado_busqueda.jsp
		}
	}
	
	/* Editar salarios.
	*/
	function verEditarSalario(idcontrato,idempleado) {
		if(idcontrato=='' || idempleado==''){
			
		}else{
			visualizarEditarSalario(idcontrato,idempleado);		
		}
	}
	
	
	
	
	function verDesvinculacion(idcontrato) {		
		if(idcontrato==''){
			
		}else{
			visualizarDesvinculacion(idcontrato);		
		}
	}
	
	function visualizarDesvinculacion(idcontrato){
		$("#dmDesvinculacion").dialog("open");  
		AbreDesvinculacion(idcontrato);
	}

	function AbreDesvinculacion(idcontrato) {
		$("#dmDesvinculacion").html(getHTMLLoaging30());
		$.ajax({
			cache: false,
			contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
	        type: 'POST',
	        url: "${ctx}/page/desvinculacion?action=ver_desvinculacion&idcontrato="+idcontrato,
	        dataType: "text",
	        error: function(jqXHR, textStatus, errorThrown) {
	            alert(jqXHR.statusText);
	        },
	        success: function(data) {	                    	                    	
	           	$("#dmDesvinculacion").html(data);     
	        }
	    });
	}
	

	function verdeshabilitarContrato(idcontrato) {		
		if(idcontrato==''){
			
		}else{
			deshabilitarContrato(idcontrato);		
		}
	}
	
	function verdeshabilitarContrato(idcontrato) {		
		if(idcontrato==''){
			
		}else{
			deshabilitarContrato(idcontrato);		
		}
	}
	
	function verhabilitarContrato(idcontrato) {		
		if(idcontrato==''){
			
		}else{
			habilitarContrato(idcontrato);		
		}
	}
	
function configuraraDesplegable(idContrato){
	
	$(function() {
	    $( "#accordion" ).accordion();
	 });
// 	alert(""+idcontrato);
	
	$( "#accordion"+idContrato ).accordion({
		"collapsible":true, 
		active:2 
	});
	
// 	$("#salarios").forEach(function(salario,indice){
// 				if(salario.idcontrato==idContrato){
// 					$('#salarioLabel'+idContrato).text(''+salario);
// 				}
// 			});
		
	
}

function abrireditarfoto(idempleado) {		
	if(idempleado==''){
		
	}else{
		//if(confirm('¿Esta seguro de activar al empleado [${empleado.codempleado}] ${empleado.nombres}?')){
			$("[name=btnSubirfoto]").attr('disabled',true);;
			$("#dmEditarfoto").dialog("open");
			$("#dmEditarfoto").html(getHTMLLoaging16(' Activando'));
			$.ajax({
				cache: false,
				contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
	            type: 'post',            
	            url: '${ctx}/page/empleado?action=abrir_editarfoto&idempleado='+idempleado,
	           // data: '',
	           // dataType: "text",
	            error: function(jqXHR, textStatus, errorThrown) {
	            	$("[name=btnActivarEmpleado]").attr('disabled',false);        		
	                $("#dmEditarfoto").html(jqXHR.statusText);
		        },
	            success: function(data) {
	            	
	               
	                	$("[name=btnSubirfoto]").attr('disabled',false);
	                    $("#dmEditarfoto").html(data);					
	               
	            }
	        });	 
		}
	
}
</script>

<div align="left">
<input type="hidden" name="salarios" value="${salarios}"/>

<c:choose>
		<c:when test="${empty empleado}">
			<div class="msgInfo1" align="left">No existe el empleado.</div>
		</c:when>
		<c:otherwise>

<div>
<c:if test="${empleado.estado==2}">
 <c:if test="${sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 1 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 214 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 215}">
	<button type="submit" id="btnEdicionEmpleado" name="btnEdicionEmpleado" onclick="$('#dmDetalleEmpleado').dialog('close');visualizarEdicionEmpleado(${empleado.idempleado});">Editar</button>&nbsp;&nbsp;&nbsp;
	<button type="button" id="btnDeshabilitarEmpleado" name="btnDeshabilitarEmpleado" onclick="deshabilitarEmpleado(${empleado.idempleado});">Deshabilitar</button>&nbsp;&nbsp;&nbsp;
</c:if>
</c:if>

<c:if test="${empleado.estado==3}">
<c:if test="${sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 1 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 214 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 215}">

<button type="button" id="btnActivarEmpleado" name="btnActivarEmpleado" onclick="activarEmpleado(${empleado.idempleado});">Activar</button>&nbsp;&nbsp;&nbsp;
</c:if>
</c:if>
<span class="enlace" id='lnkUpdateUsuarioDetalle' name='lnkUpdateUsuarioDetalle'>Actualizar</span>&nbsp;&nbsp;&nbsp;
</div>

<br/>

<fieldset><legend class="e6">Empleado</legend>
<table border="0" width="100%" class="caja">
<col style="width: 33%"/>
<col style="width: 33%"/>
<col style="width: 33%"/>
 <tr class="td3">
 <th nowrap="nowrap" style="text-align: center;">Informacion:</th>
  <th nowrap="nowrap" style="text-align: center;">Detalle:</th>
<th nowrap="nowrap" style="text-align: center;">Foto:</th>


 </tr>


	


<tr>

<th nowrap="nowrap" style="text-align: right;">Código de empleado:</th>

<td><c:out value="${empleado.codempleado}"/></td>
<td rowspan="13" align="center" valign="middle" >

		
			<div class="avatargrande" align="left">
			
				<c:if test="${fotourlencode !=null }">
				<img  class="avatargrande" src="${fotourlencode}">
				</c:if>
				<c:if test="${fotourlencode ==null }">
					<img class="avatargrande" src="http://www.boursematch.com/assets/images/avatar_default.gif">
				</c:if>
				
				
			</div>
				<c:if test="${empleado.estado==2}">
				 <c:if test="${sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 1 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 214 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 215}">
					 
					<button type="button" id="btnSubirfoto" name="btnSubirfoto" onclick="abrireditarfoto(${empleado.idempleado});">Editar Foto</button>
				</c:if>
				</c:if>
			 
		
	
</td>
</tr>
<tr>
	<th nowrap="nowrap" style="text-align: right;">Tipo de identificación:</th>
	<td><c:out value="${empleado.identificaciontipo.abreviatura}"/> - <c:out value="${empleado.identificaciontipo.tipo}"/></td>
</tr>
<tr>
<th nowrap="nowrap" style="text-align: right;">Num. Identificación:</th>
<td><c:out value="${empleado.empleadoidentificacion.numeroidentificacion}"/></td>
</tr>
<tr>
<th nowrap="nowrap" style="text-align: right;">Ciudad. expedición:</th>
<td><c:out value="${empleado.empleadoidentificacion.ciudadexpedicion}"/></td>
</tr>
<tr>
<th nowrap="nowrap" style="text-align: right;">Género:</th>
<td><c:out value="${empleado.genero.nombregenero}"/></td>
</tr>
<tr>
<th nowrap="nowrap" style="text-align: right;">Fecha de nacimiento:</th>
<td><fmt:formatDate value="${empleado.fechanacimiento}" pattern="dd/MM/yyyy"/></td>
</tr>
<tr>
<th nowrap="nowrap" style="text-align: right;">Nombres:</th>
<td><c:out value="${empleado.nombres}"/></td>
</tr>
<tr>
<th nowrap="nowrap" style="text-align: right;">Apellidos:</th>
<td><c:out value="${empleado.apellidos}"/></td>
</tr>

<tr>
<th nowrap="nowrap" style="text-align: right;">Creado por:</th>
<td><c:out value="${empleado.idusuariocrea}"/></td>
</tr>
<tr>
<th nowrap="nowrap" style="text-align: right;">Fecha creación:</th>
<td><fmt:formatDate value="${empleado.fechacrea}" pattern="dd/MM/yyyy H:mm"/></td>
</tr>
<tr>
<th nowrap="nowrap" style="text-align: right;">Modificado por:</th>
<td><c:out value="${empleado.idusuariomod==0?'':empleado.idusuariomod}"/></td>
</tr>
<tr>
<th nowrap="nowrap" style="text-align: right;">Fecha modificación:</th>
<td><fmt:formatDate value="${empleado.fechamod}" pattern="dd/MM/yyyy H:mm"/></td>
</tr>
<tr>
<th style="text-align: right;">Estado:</th>
<td><c:out value="${empleado.estado}"/></td>
</tr>
</table>
</fieldset>
<br/>


<br/>


<br/>

<div id="tabsUsuarioDetalle">
	<ul>		
		<c:if test="${sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 1 
		            ||sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 212 
		            || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 213 
		            || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 214 
		            || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 215 
		            || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 216 }">
			<li>
				<a href="#idTabsEmpleadoDetalleContratos">&nbsp;Contratos<span>&nbsp;</span></a>
			</li>
		</c:if>
		
		<li><a href="${ctx}/page/empleado?action=empleado_propiedades&idempleado=${empleado.idempleado}">&nbsp;Propiedades<span>&nbsp;</span></a></li>
		<c:if test="${sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 1 ||sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 212 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 213 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 214 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 215}">
			<li><a href="${ctx}/page/banco?action=banco_propiedades&idempleado=${empleado.idempleado}">&nbsp;Cuentas Bancarias<span>&nbsp;</span></a></li>
		</c:if>
		<li><a href="${ctx}/page/afiliacion?action=afiliacion_propiedades&idempleado=${empleado.idempleado}">&nbsp;Afiliaciones<span>&nbsp;</span></a></li>
		<li><a href="${ctx}/page/educacion?action=educacion_propiedades&idempleado=${empleado.idempleado}">&nbsp;Educación<span>&nbsp;</span></a></li>
		
		<c:if test="${sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 1 ||sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 212 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 213 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 214 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 215}">
			<li>
				<a href="${ctx}/page/familia?action=familia_propiedades&idempleado=${empleado.idempleado}">&nbsp;Familia<span>&nbsp;</span></a>
			</li>
		</c:if>
		<c:if test="${sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 1 ||sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 212 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 213 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 214 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 215}">
			<li><a href="${ctx}/page/documento?action=documento_propiedades&idempleado=${empleado.idempleado}">&nbsp;Documentos<span>&nbsp;</span></a></li>
		</c:if>
		<c:if test="${sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 1 ||sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 212 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 213 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 214 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 215}">
			<li><a href="${ctx}/page/empleado?action=certificados&idempleado=${empleado.idempleado}">&nbsp;Certificados<span>&nbsp;</span></a></li>
		</c:if>
		<c:if test="${ultimocontratoid!=0}">
		
			<%-- <li><a href="${ctx}/page/contrato?action=ver_editar_horario&idcontrato=${ultimocontratoid}">&nbsp;Horario<span>&nbsp;</span></a></li>
		 --%><li><a href="#dmEditarHorario" onclick="verHorario(${ultimocontratoid})">&nbsp;Horario<span>&nbsp;</span></a></li>
		
		</c:if>
		<c:if test="${sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 1 ||sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 212 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 213 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 214 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 215}">
			<li><a href="${ctx}/page/empleado?action=dashboard&idempleado=${empleado.idempleado}">&nbsp;Dashboard<span>&nbsp;</span></a></li>
		</c:if>
	</ul>


<!-- División para contratos. -->

<c:if test="${sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 1 
				||sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 212 
				|| sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 213 
				|| sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 214 
				|| sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 215 
				|| sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 216}">
	<div id="idTabsEmpleadoDetalleContratos">
	
	<c:if test="${sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 214 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 215 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 213}">
		<c:if test="${empleado.estado==2}">
			<button type="button" id="btnCrearContrato" name="btnCrearContrato" onclick="CrearContrato(${empleado.idempleado});">Crear contrato</button>&nbsp;&nbsp;&nbsp;
		</c:if>	
	</c:if>	
		<c:choose>
		<c:when test="${empty contratos}">
			<div class="msgInfo1" align="left">No cuenta con contratos asociados.</div>
		</c:when>
		<c:otherwise>
		 <c:forEach items="${contratos}" var="contrato" varStatus="loop">
				
				<fieldset style="color: red;">
				
				<legend class="e6" style="color: ${contrato.estado==2?'':'red'};" >Contrato</legend>
				
				<table style="font " border="0" width="100%" class="caja">
				
				<col style="width: 150px;"/>
				<col style="color: ${contrato.estado==2?'':'red'};"/>
				
				<tr>
				<c:if test="${empleado.estado==2}">
						<c:if test="${contrato.estado==2}">
							<c:if test="${sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 214 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 215 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 213}">
								<button type="button" id="btnEdicionContrato" name="btnEdicionContrato" onclick="vereditarContrato(${contrato.idcontrato});">Editar</button>&nbsp;&nbsp;&nbsp;
							</c:if>
							<button type="button" id="btnHorario" name="btnHorario" onclick="verHorario(${contrato.idcontrato});">Horario</button>&nbsp;&nbsp;&nbsp;
							
							<c:if test="${sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 1 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 214 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 215}">
								
								<button type="button" id="btnDesvinculacion" name="btnDesvinculacion" onclick="verDesvinculacion(${contrato.idcontrato});">Desvinculación</button>&nbsp;&nbsp;&nbsp;
							</c:if>
<%-- 							<c:if test="${sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 1 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 214 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 215}"> --%>
							<c:if test="${sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 214 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 215 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 213}">
								<button type="button" id="btnDeshabilitarContrato" name="btnDeshabilitarContrato" onclick="verdeshabilitarContrato(${contrato.idcontrato});">Deshabilitar</button>&nbsp;&nbsp;&nbsp;
							</c:if>
							<!-- Salario -->
							<c:if test="${sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 213 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 214}">
								<button type="button" id="btnEditarSalario" name="btnEditarSalario" onclick="verEditarSalario(${contrato.idcontrato},${empleado.idempleado});">Salario</button>&nbsp;&nbsp;&nbsp;
							</c:if>                                                                                                                   
							<!--------------------------------->
							<!-- Boton Proceso Disciplinario -->
							<!--------------------------------->
							
							<c:if test="${sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 1  
	 						           || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 212  
	 						           || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 213  
	 						           || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 214  
	 						           || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 215  
	 						           || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 216}"> 
								<button type="button" id="btnProcesoDisciplinario" name="btnProcesoDisciplinario" onclick="verProcesoDisciplinario(${contrato.idcontrato});">Proceso Disciplinario</button>&nbsp;&nbsp;&nbsp;
							</c:if> 

							<!--------------------------------->
							<!-- Boton Proceso Disciplinario -->
							<!--------------------------------->
							
						</c:if>
						<c:if test="${contrato.estado==3}">
<%-- 							<c:if test="${sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 1 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 214 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 215}"> --%>
							<c:if test="${sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 214 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 215 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 213}">
								<button type="button" id="btnActivarContrato" name="btnActivarContrato" onclick="verhabilitarContrato(${contrato.idcontrato});">Activar</button>&nbsp;&nbsp;&nbsp;
							</c:if>
						</c:if>
					
			
			</c:if>
				</tr>
			
				<c:if test="${sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 1 
					||sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 212 
					|| sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 213 
					|| sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 214 
					|| sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 215 }">
			
				<tr>
				<th nowrap="nowrap" style="text-align: right;">Identificador único:</th>
				<td><c:out value="${contrato.idcontrato}"/></td>
				</tr>
				<tr>
				<th nowrap="nowrap" style="text-align: right;">Empresa:</th>
				<td><c:out value="${contrato.empresa.nombreempresa}"/></td>
				</tr>
				<tr>
				<th nowrap="nowrap" style="text-align: right;">Sucursal:</th>
				<td><c:out value="${contrato.sucursal.nombresucursal}"/></td>
				</tr>
				<tr>
				<th nowrap="nowrap" style="text-align: right;">Cargo:</th>
				<td><c:out value="${contrato.cargo.nombrecargo}"/></td>
				</tr>
				
				<tr>
				<th nowrap="nowrap" style="text-align: right;">Area:</th>
				<td><c:out value="${contrato.area.nombrearea}"/></td>
				</tr>
				<tr>
				<th nowrap="nowrap" style="text-align: right;">Area asignada:</th>
				<td><c:out value="${contrato.areaasignada.nombrearea}"/></td>
				</tr>
				<tr>
				<th nowrap="nowrap" style="text-align: right;">Motivo Retiro:</th>
				<td><c:out value="${contrato.retiromotivo.nombremotivo}"/></td>
				</tr>
				
				
				<tr>
					<th nowrap="nowrap" style="text-align: right;">Número contrato:</th>
					<td><c:out value="${contrato.numerocontrato}"/></td>
				</tr>
				<!-- Tipo de contrato -->
				<tr>
					<th nowrap="nowrap" style="text-align: right;">Tipo contrato:</th>
					<td><c:out value="${contrato.contratotipo.nombrecontratotipo}"/></td>
				</tr>
<!-- 				Sueldo -->
<%-- 				<c:if test="${sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 214 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 213 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 212}"> --%>
<!-- 					<tr> -->
<!-- 						<th nowrap="nowrap" style="text-align: right;">Sueldo:</th> -->
<%-- 						<td><c:out value="${contrato.salario}"/></td> --%>
<!-- 					</tr>			 -->
<%-- 				</c:if> --%>
				
				<tr>
				<th nowrap="nowrap" style="text-align: right;">Fecha firma:</th>
				<td><fmt:formatDate value="${contrato.fechafirma}" pattern="dd/MM/yyyy"/></td>
				
				</tr>
				<tr>
				<th nowrap="nowrap" style="text-align: right;">Fecha inicio:</th>
				<td><fmt:formatDate value="${contrato.fechainicio}" pattern="dd/MM/yyyy"/></td>
				</tr>
				<tr>
				<th nowrap="nowrap" style="text-align: right;">Fecha fin:</th>
				<td><fmt:formatDate value="${contrato.fechafin}" pattern="dd/MM/yyyy"/></td>
				</tr>	
				<tr>
				<th nowrap="nowrap" style="text-align: right;">Usuario creación:</th>
				<td><c:out value="${contrato.idusuariocrea}"/></td>
				</tr>
				<tr>
				<th nowrap="nowrap" style="text-align: right;">Fecha crea:</th>
				<td><fmt:formatDate value="${contrato.fechacrea}" pattern="dd/MM/yyyy"/></td>
				</tr>
				<tr>
				<th nowrap="nowrap" style="text-align: right;">Usuario modificación:</th>
				<td><c:out value="${contrato.idusuariomod}"/></td>
				</tr>
				<tr>
				<th nowrap="nowrap" style="text-align: right;">Fecha mod:</th>
				<td><fmt:formatDate value="${contrato.fechamod}" pattern="dd/MM/yyyy"/></td>
				</tr>	
				
				</c:if>
				
				</table>
				<br/>
				
				<c:if test="${sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 212 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 213 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 214}">
					<div id="accordion${contrato.idcontrato}" contenteditable="false" >
					   <h2>    Salario</h2>
						  <div>
<%-- 						  	<p id="parrafoSalario${contrato.idcontrato}"> ${ contrato.infosalarial }</p> --%>
						  	<p id="parrafoSalario${contrato.idcontrato}"> ${ contrato.tipoMoneda.simbolo } ${ contrato.contratoSalario.salario } ${ contrato.tipoMoneda.nombretipomoneda} ${ contrato.tipoMoneda.codigoiso}</p>
						  </div>
					</div>
				</c:if>
				<br/>
				<script type="text/javascript">
					configuraraDesplegable("${contrato.idcontrato}");
				</script>
				</fieldset>
			</c:forEach>
		</c:otherwise>
		</c:choose>		
	</div>

</c:if>

	<!-- División para el detalle de los bancos del empleado. -->
	<!--
	<div id="idTabsEmpleadoDetalleBancos">
		<c:if test="${sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 1 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 214 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 215}">
			<c:if test="${empleado.estado==2}">
				<button type="button" id="btnNuevoBanco" name="btnNuevoBanco" onclick="CrearBanco(${empleado.idempleado});">Crear banco</button>&nbsp;&nbsp;&nbsp;
			</c:if>	
		</c:if>
	</div>
	-->
	
</div>
<br/>


<div>
<c:if test="${empleado.estado==2}">
 <c:if test="${sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 1 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 214 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 215}">
	 
	<button type="submit" id="btnEdicionEmpleado" name="btnEdicionEmpleado" onclick="$('#dmDetalleEmpleado').dialog('close');visualizarEdicionEmpleado(${empleado.idempleado});">Editar</button>&nbsp;&nbsp;&nbsp;
	<button type="button" id="btnDeshabilitarEmpleado" name="btnDeshabilitarEmpleado" onclick="deshabilitarEmpleado(${empleado.idempleado});">Deshabilitar</button>&nbsp;&nbsp;&nbsp;
</c:if>
</c:if>

<c:if test="${empleado.estado==3}">
<c:if test="${sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 1 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 214 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 215}">

	<button type="button" id="btnActivarEmpleado" name="btnActivarEmpleado" onclick="activarEmpleado(${empleado.idempleado});">Activar</button>&nbsp;&nbsp;&nbsp;
</c:if>
</c:if>
<span class="enlace" id='lnkUpdateUsuarioDetalle' name='lnkUpdateUsuarioDetalle'>Actualizar</span>&nbsp;&nbsp;&nbsp;
</div>

</c:otherwise>
</c:choose>
</div>




<div style="padding: 30px 0px;"></div>

