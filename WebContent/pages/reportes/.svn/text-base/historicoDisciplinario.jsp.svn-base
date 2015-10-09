<%@ include file="/taglibs.jsp"%>


<script type="text/javascript">
	$(document)
			.ready(
					function() {
						

						/**
						 * Botones.
						 */
						$("[name=botonMostrarHistorico]").button();
						

						/*
						 * Validación formulario de reporte procesos disciplinarios. 
						 */
						$("#fReporteHistoricoDisciplinario").validate({
							errorClass : "invalid",
							rules : {
								idAreaSeleccionada : {
									required : true,
									min : 1
								}
							},
							messages : {
								idAreaSeleccionada : {
									required : "Seleccione una área.",
								}
							},
							submitHandler : function(form) {

								var areasSeleccionados = $('#idAreaSeleccionada').val();
								if(areasSeleccionados!=null){
									buscarHistoricoDisciplinario(form);	
								}else{
									alert('Para buscar, Seleccione al menos una área.');
								}
							}
						});

						
						/**
						 * Configuración de multiselect para las areas del historico discplinari
						 */
						$("#fReporteHistoricoDisciplinario [name=idAreaSeleccionada]")
								.multiselect({
									height : 175,
									minWidth : 225,
									checkAllText : 'Marcar todos',
									uncheckAllText : 'Desmarcar todos',
									noneSelectedText : 'Seleccione opción',
									selectedText : '# selecionado(s)',
									selectedList : 1,
									show : null,
									hide : null,
									autoOpen : false,
									multiple : true,
									position : {},
									appendTo : "body",
								}).multiselectfilter({
									label : 'Filtro:&nbsp;',
									placeholder : '',
									autoReset : false
								});

						var dates = $("#fechaFiltroDesde, #fechaFiltroHasta").datepicker({
							dateFormat : "dd/mm/yy",
							maxDate : '0',
							numberOfMonths: 1,
							dayNamesMin : [ 'Do', 'Lu', 'Ma', 'Mi',
									'Ju', 'Vi', 'Sa' ],
							monthNames : [ 'Enero', 'Febrero', 'Marzo',
									'Abril', 'Mayo', 'Junio', 'Julio',
									'Agosto', 'Septiembre', 'Octubre',
									'Noviembre', 'Diciembre' ],
							monthNamesShort : [ 'Ene', 'Feb', 'Mar',
									'Abr', 'May', 'Jun', 'Jul', 'Ago',
									'Sep', 'Oct', 'Nov', 'Dic' ],
							onSelect: function( selectedDate ) {
										var option = this.id == "fechaFiltroDesde" ? "minDate" : "maxDate",
											instance = $( this ).data( "datepicker" ),
											date = $.datepicker.parseDate(
												instance.settings.dateFormat ||
												$.datepicker._defaults.dateFormat,
												selectedDate, instance.settings );
										dates.not( this ).datepicker( "option", option, date );
							}
						});
						
	});

// 	function actualizarBusquedaDeUsuarioDesvin(form) {
	function buscarHistoricoDisciplinario(form) {
// 		alert("Bien.");
		$("#cajaHistoricoDisciplinario").html(getHTMLLoaging30());
		$("#botonMostrarHistorico").attr('disabled', true);
		$.ajax({
					cache : false,
					contentType : 'application/x-www-form-urlencoded; charset=iso-8859-1;',
					type : 'POST',
					url : $(form).attr('action'),
					data : $(form).serialize(),
					dataType : "text",
					error : function(jqXHR, textStatus, errorThrown) {
						alert(jqXHR.statusText);
					},
					success : function(data) {
						$("#cajaHistoricoDisciplinario").html(data);
						$("#botonMostrarHistorico").attr('disabled', false);
					}
				});
	}

	function validarEntero(valor) {
		valor = parseInt(valor);
		//Compruebo si es un valor numérico 
		if (isNaN(valor)) {
			//entonces (no es numero) devuelvo el valor cadena vacia 
			return false;
		} else {
			//En caso contrario (Si era un número) devuelvo el valor 
			return true;
		}
	}

	
</script>


<div align="left">

	<!-------------------------------------------------------------------------->
	<!--               Reporte de historico disciplinarico                    -->
	<!-------------------------------------------------------------------------->

	<fieldset>
		<legend class="e6">Histórico Disciplinario</legend>
<c:choose>
		<c:when test="${empty areas}">
			<div class="msgInfo1" align="left">No tiene áreas a cargo para gestionar los procesos disciplinarios.</div>
		</c:when>
		<c:otherwise>
		
		
		<div id="pruebarestive" align="center">
			<table cellspacing="2" width="100%" border="0" cellpadding="2">
				<col />
				<col style="width: 5px;" />
				<col style="width: 200px;" />
				<tr valign="middle">
					<td class="td3">

						<form name="fReporteHistoricoDisciplinario" id="fReporteHistoricoDisciplinario" action="${ctx}/page/reportes" method="post">
<!-- 						<input type="hidden" name="action" value="empleadosreportedesvinculacion" /> -->
							<input type="hidden" name="action" value="reporteHistoricoDisciplinario" />
							
							<table width="100%" border="0">
								<tr class="td3" valign="middle">
									
									<!-- Lista Areas -->
									<td>
										Seleccione área :
										<select name="idAreaSeleccionada"  id="idAreaSeleccionada"   multiple="multiple" size="5">
											<c:forEach items="${areas}" var="area" varStatus="loop">
												<option  value="${area.idarea}"><c:out value="${area.nombrearea}"/></option>
											</c:forEach>
										</select> 
									</td>
									
									<!-- Fecha inicio y Fecha fin (No mayor a hoy)-->
									<td>
										desde: <input type="text" name="fechaFiltroDesde" id="fechaFiltroDesde" value="<fmt:formatDate value="${now}" pattern="dd/MM/yyyy" />" />
										&nbsp;&nbsp;
										hasta: <input type="text" name="fechaFiltroHasta" id="fechaFiltroHasta" value="<fmt:formatDate value="${now}" pattern="dd/MM/yyyy" />" />
									</td>
							
									<!-- Boton Buscar -->
									<td valign="middle" align="left">
										<button type="submit" id="botonMostrarHistorico"name="botonMostrarHistorico">Buscar</button>
									</td>
								</tr>
							</table>
						</form>
					</td>
				</tr>
			</table>

			<div align="center" id="mensajeBuscarHistorico"></div>
			<div align="center" id="cajaHistoricoDisciplinario"></div>
			</c:otherwise>
			</c:choose>
			
	</fieldset>

	<br /> <br />

</div>