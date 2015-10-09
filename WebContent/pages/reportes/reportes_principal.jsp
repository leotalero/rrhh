<%@ include file="/taglibs.jsp"%>


<script type="text/javascript">
	$(document)
			.ready(
					function() {
						$('#tableauVizreportesreportes').html('');
						initializeViz();

						$("#dmMensajeHorario").dialog({
							width : 400,
							height : 200,
							modal : true,
							autoOpen : false,
							resizable : true
						});

						/**
						 * Botones.
						 */
						$("[name=btnBuscarEmpleadoHisto]").button();
						$("[name=btnBuscarEmpleadoContrato]").button();
						$("[name=btnBuscarUsuarioRepo]").button();
						$("[name=btnBuscarEmpleadoInfoAdicional]").button();
						$("[name=btnBuscarEmpleadoProcesoDisciplinario]").button();
						$("[name=botonGenerarExcelIngresosDePersonal]").button();

						$("#fReporteEmpleadoUltimoContrato").validate({
							errorClass : "invalid",
							rules : {
								idestadoREmpleadoContra : {
									required : true,
									min : 1
								}
							},
							messages : {
								idestadoREmpleadoContra : {
									required : "Seleccione un Estado",
								}
							},
							submitHandler : function(form) {
								submitformexcel(form);
							}
						});

						/*
						 * Validación formulario de reporte de informacion adicional. 
						 */
						$("#fReporteInformacionAdicionalEmpleado")
								.validate(
										{
											errorClass : "invalid",
											rules : {
												idEstadoReporteEmpleadoInfoAdicional : {
													required : true,
													min : 1
												}
											},
											messages : {
												idEstadoReporteEmpleadoInfoAdicional : {
													required : "Seleccione un Estado",
												}
											},
											submitHandler : function(form) {
												generarReporteInformacionAdicionalEmpleado(form);
											}
										});

						/*
						 * Validación formulario de reporte procesos disciplinarios. 
						 */
						$("#fReporteProcesosDisciplinarios").validate({
							errorClass : "invalid",
							rules : {
								idEstadoReporteProcesoDisciplinario : {
									required : true,
									min : 1
								}
							},
							messages : {
								idEstadoReporteProcesoDisciplinario : {
									required : "Seleccione un Estado",
								}
							},
							submitHandler : function(form) {
								generarReporteProcesosDisciplinarios(form);
							}
						});

						/*
						 * Validación formulario de reporte de ingresos de personal. 
						 */
						$("#fReporteIngresosDePersonal").validate({
							errorClass : "invalid",
							rules : {
								fechaIngresoDesde: {
									required : true
								},
								fechaIngresoHasta: {
									required : true
								}
							},
							messages : {
								fechaIngresoDesde: {
									required : "Seleccione una fecha valida."
								},
								fechaIngresoHasta: {
									required : "Seleccione una fecha valida."
								}
							},
							submitHandler : function(form) {
								generarReporteIngresosDePersonal(form);
							}
						});
						
						$("#fReporteEmpleadoHistorico").validate({
							//errorLabelContainer: "#msnBuscarCargue",
							errorClass : "invalid",
							rules : {
								idestadoREmpleadoHistorico : {
									required : true,
									min : 1
								}

							},
							messages : {

								idestadoREmpleadoHistorico : {
									required : "Seleccione un Estado",

								}
							},
							submitHandler : function(form) {
								submitformexcelhisto(form);
							}

						});

						$(
								"#fReporteEmpleadoUltimoContrato [name=idestadoREmpleadoContra]")
								.multiselect({
									/*header: true,*/
									height : 175,
									minWidth : 225,
									//classes: '',
									checkAllText : 'Marcar todos',
									uncheckAllText : 'Desmarcar todos',
									noneSelectedText : 'Seleccionar estado',
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

						$(
								"#fReporteEmpleadoHistorico [name=idestadoREmpleadoHistorico]")
								.multiselect({
									/*header: true,*/
									height : 175,
									minWidth : 225,
									// classes: '',
									checkAllText : 'Marcar todos',
									uncheckAllText : 'Desmarcar todos',
									noneSelectedText : 'Seleccionar Estado',
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

						/**
						 * Configuración de multiselect para reporte de información adicional.	
						 */
						$(
								"#fReporteInformacionAdicionalEmpleado [name=idEstadoReporteEmpleadoInfoAdicional]")
								.multiselect({
									height : 175,
									minWidth : 225,
									checkAllText : 'Marcar todos',
									uncheckAllText : 'Desmarcar todos',
									noneSelectedText : 'Seleccionar estado',
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

						/**
						 * Configuración de multiselect para reportede procesos disciplinarios.
						 */
						$("#fReporteProcesosDisciplinarios [name=idEstadoReporteProcesoDisciplinario]")
								.multiselect({
									height : 175,
									minWidth : 225,
									checkAllText : 'Marcar todos',
									uncheckAllText : 'Desmarcar todos',
									noneSelectedText : 'Seleccionar estado',
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

						/* 
						 * Evento para cambiar el tipo de busqueda.
						 */
						$("#Dtipobusquedausuario")
								.change(
										function() {
											var data = $(this).val();
// 											$(".classtipobusquedausuario").hide();

											$("#Dtipobusquedausuario_creacion").hide();
											$("#Dtipobusquedausuario_nombre").hide();
											$("#Dtipobusquedausuario_numidentificacion").hide();
											$("#Dtipobusquedausuario_usuario").hide();
											
											if (data == 1) {
												$("#Dtipobusquedausuario_creacion").show();
											} else if (data == 2) {
												$("#Dtipobusquedausuario_nombre").show();
											} else if (data == 3) {
												$("#Dtipobusquedausuario_numidentificacion").show();
											} else if (data == 4) {
												$("#Dtipobusquedausuario_usuario").show();
											} else if (data == 5) {
												$("#Dtipobusquedausuario_codusuario").show();
											} else if (data == 6) {
												$("#Dtipobusquedausuario_idaplicacion").show();
											} else if (data == 7) {
												$("#Dtipobusquedausuario_idgrupo").show();
											} else if (data == 8) {
												$("#Dtipobusquedausuario_idcuenta").show();
											}

										});

						$("#fReporteEmpleadoDesvinculacion")
								.validate(
										{
											errorLabelContainer : "#msnBuscarEmpleado",
											errorClass : "invalid",
											rules : {
												Dtipobusqueda : {
													required : true
												},
												Dfrom : {
													required : function(element) {
														return $(
																"#Dtipobusquedausuario")
																.val() == 1;
													}
												},
												Dto : {
													required : function(element) {
														return $(
																"#Dtipobusquedausuario")
																.val() == 1;
													}
												},
												Dnombre : {
													required : function(element) {
														return $(
																"#Dtipobusquedausuario")
																.val() == 2;
													}
												},
												Dnumidentificacion : {
													required : function(element) {
														return $(
																"#Dtipobusquedausuario")
																.val() == 3;
													},
													digits : function(element) {
														return $(
																"#Dtipobusquedausuario")
																.val() == 3;
													}
												},
												Dusuario : {
													required : function(element) {
														return $(
																"#Dtipobusquedausuario")
																.val() == 4;
													}
												},
												codusuario : {
													required : function(element) {
														return $(
																"#Dtipobusquedausuario")
																.val() == 5;
													}
												},
												idaplicacion : {
													required : function(element) {
														return $(
																"#Dtipobusquedausuario")
																.val() == 6;
													}
												},
												idgrupo : {
													required : function(element) {
														return $(
																"#Dtipobusquedausuario")
																.val() == 7;
													}
												},
												idcuenta : {
													required : function(element) {
														return $(
																"#Dtipobusquedausuario")
																.val() == 8;
													}
												}
											},
											messages : {
												Dtipobusqueda : {
													required : "Selecione un tipo de búsqueda."
												},
												Dfrom : {
													required : "Seleccione una fecha válida."
												},
												Dto : {
													required : "Seleccione una fecha válida."
												},
												Dnombre : {
													required : "Ingrese un valor."
												},
												Dnumidentificacion : {
													required : "Ingrese un valor.",
													digits : "Ingrese solo dígitos"
												},
												Dusuario : {
													required : "Ingrese un valor."
												},
												codusuario : {
													required : "Ingrese un valor."
												},
												idaplicacion : {
													required : "Ingrese un valor."
												},
												idgrupo : {
													required : "Ingrese un valor."
												},
												idcuenta : {
													required : "Ingrese un valor."
												}

											},
											submitHandler : function(form) {
												actualizarBusquedaDeUsuarioDesvin(form);
											}

										});
						var dates = $("#Dfrom_b_usuario, #Dto_b_usuario")
								.datepicker(
										{
											dateFormat : "dd/mm/yy",
											maxDate : '0',
											numberOfMonths : 1,
											dayNamesMin : [ 'Do', 'Lu', 'Ma',
													'Mi', 'Ju', 'Vi', 'Sa' ],
											monthNames : [ 'Enero', 'Febrero',
													'Marzo', 'Abril', 'Mayo',
													'Junio', 'Julio', 'Agosto',
													'Septiembre', 'Octubre',
													'Noviembre', 'Diciembre' ],
											monthNamesShort : [ 'Ene', 'Feb',
													'Mar', 'Abr', 'May', 'Jun',
													'Jul', 'Ago', 'Sep', 'Oct',
													'Nov', 'Dic' ],
											onSelect : function(selectedDate) {
												var option = this.id == "Dfrom_b_usuario" ? "minDate"
														: "maxDate", instance = $(
														this)
														.data("datepicker"), date = $.datepicker
														.parseDate(
																instance.settings.dateFormat
																		|| $.datepicker._defaults.dateFormat,
																selectedDate,
																instance.settings);
												dates.not(this).datepicker(
														"option", option, date);
											}
										});
						
						
						/* Configuración de Fechas de ingreso de personal */
						var fechasIngresoDePersonal = $("#fechaIngresoDesde, #fechaIngresoHasta").datepicker({
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
										var option = this.id == "fechaIngresoDesde" ? "minDate" : "maxDate",
											instance = $( this ).data( "datepicker" ),
											date = $.datepicker.parseDate(
												instance.settings.dateFormat ||
												$.datepicker._defaults.dateFormat,
												selectedDate, instance.settings );
										fechasIngresoDePersonal.not( this ).datepicker( "option", option, date );
							}
						});

					});

	function actualizarBusquedaDeUsuarioDesvin(form) {
		$("#DcajaBuscarUsuario").html(getHTMLLoaging30());
		$("#btnBuscarUsuarioRepo").attr('disabled', true);
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
						$("#DcajaBuscarUsuario").html(data);
						$("#btnBuscarUsuarioRepo").attr('disabled', false);
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

	function submitformexcel(form) {
		form.setAttribute("action",
				"${ctx}/page/reportes?action=empleadosreportecontrato");
		form.setAttribute("target", "#dmHorarioBusquedaListado");
		$("#fReporteEmpleadoUltimoContrato").submit();
	}

	function submitformexcelhisto(form) {
		form.setAttribute("action","${ctx}/page/reportes?action=empleadosreportehistorico");
		form.setAttribute("target", "#dmHorarioBusquedaListado");
		$("#fReporteEmpleadoHistorico").submit();
	}

	/**
	 * Enviar formulario para reporte de información adicional.
	 */
	function generarReporteInformacionAdicionalEmpleado(form) {
		var estadoSeleccionado = $('#idEstadoReporteEmpleadoInfoAdicional').val();

		if(estadoSeleccionado!=null){
			form.setAttribute("action","${ctx}/page/reportes?action=reporteInformacionAdicional");
			form.setAttribute("target", "#dmHorarioBusquedaListado");
			$("#fReporteInformacionAdicionalEmpleado").submit();
		}else{
			alert('Seleccione un estado para empleados.');
		}
		
	}

	/**
	 * Enviar formulario para reporte de procesos disciplinarios.
	 */
	function generarReporteProcesosDisciplinarios(form) {
		var selectedValues = $('#idEstadoReporteProcesoDisciplinario').val();

		if(selectedValues!=null){
// 			alert('Se va a enviar el formulario y generar el reporte.');
	 		form.setAttribute("action","${ctx}/page/reportes?action=reporteProcesoDisciplinario");
	 		form.setAttribute("target", "#dmHorarioBusquedaListado");
	 		$("#fReporteProcesosDisciplinarios").submit();
		}else{
			alert('Seleccione un estado para empleados.');
		}
		
	}

	/**
	 * Enviar formulario para reporte de ingresos de personal.
	 */
	function generarReporteIngresosDePersonal(form) {
		form.setAttribute("action","${ctx}/page/reportes?action=reporteIngresoPersonal");
	 	form.setAttribute("target", "#dmHorarioBusquedaListado");
	 	$("#fReporteIngresosDePersonal").submit();
	}
	
	function initializeViz() {
		var placeholderDiv = document.getElementById("tableauVizreportes");
		//var url2 = "http://${server}/trusted/${ticket}/views/ProyectoIntranet/Tendencias?:embed=y&:display_count=no&${parametros}";
		var url2 = "http://${server}/trusted/${ticket}/views/ProyectoIntranet/Tendencias?:embed=y&:display_count=no";
		viz = new tableauSoftware.Viz(placeholderDiv, url2);
		
		 //alert(url2);
	}
</script>
<div align="left">

	<input type="hidden" name="action" value="" /> <input type="hidden"
		name="idempleado" value="${empleado.idempleado}" /> <input
		type="hidden" name="idcontrato" value="${contrato.idcontrato}" /> <input
		type="hidden" name="idhorarioasignado"
		value="${horarioasignado.idhorarioasignado}" /> <br />

	<!----------------------------------------------------->
	<!--          Reporte de empleados                   -->
	<!----------------------------------------------------->

	<form name="fReporteEmpleadoUltimoContrato"
		id="fReporteEmpleadoUltimoContrato" action="${ctx}/page/reportes"
		method="post">
		<input type="hidden" name="action" value="empleadosreportecontrato" />
		<fieldset>
			<legend class="e6">Reporte empleados </legend>
			<table border="0" width="100%" class="caja">
				<col style="width: 30%" />
				<col />



				<tr>
					<th>Estado empleado:</th>

					<th>Generar</th>


				</tr>
				<tbody>
					<tr>
						<td><select name="idestadoREmpleadoContra"
							id="idestadoREmpleadoContra" multiple="multiple" size="2">
								<option value="2"><c:out value="${estadoActivo}" /></option>
								<option value="3"><c:out value="${estadoDeshabilitado}" /></option>
						</select></td>

						<td align="center"><button type="submit"
								id="btnBuscarEmpleadoContrato" name="btnBuscarEmpleadoContrato">Generar
								Excel</button></td>

					</tr>

				</tbody>




			</table>



		</fieldset>
	</form>
	<br /> <br />

	<!----------------------------------------------------->
	<!-- Reporte de empleados con historico de Contratos -->
	<!----------------------------------------------------->
	<form name="fReporteEmpleadoHistorico" id="fReporteEmpleadoHistorico"
		action="${ctx}/page/reportes" method="post">
		<input type="hidden" name="action" value="empleadosreportehistorico" />
		<fieldset>
			<legend class="e6">Reporte de empleados con historico de
				Contratos</legend>
			<table border="0" width="100%" class="caja">
				<col style="width: 30%" />
				<col />

				<tbody>

					<tr>
						<th>Estado empleado:</th>
						<th>Generar</th>
					</tr>
					<tr>

						<td><select name="idestadoREmpleadoHistorico"
							id="idestadoREmpleadoHistorico" multiple="multiple" size="2">
								<option value="2"><c:out value="${estadoActivo}" /></option>
								<option value="3"><c:out value="${estadoDeshabilitado}" /></option>
						</select></td>

						<td align="center"><button type="submit"
								id="btnBuscarEmpleadoHisto" name=btnBuscarEmpleadoHisto>Generar
								Excel</button>
						</td>

					</tr>

				</tbody>
			</table>
		</fieldset>
	</form>

	<br /> <br />

	<!---------------------------------------------------->
	<!-- Reporte de información adicional por empleado. -->
	<!---------------------------------------------------->

	<form name="fReporteInformacionAdicionalEmpleado"
		id="fReporteInformacionAdicionalEmpleado"
		action="${ctx}/page/reportes" method="post">
		<!-- Accion a relaizar. -->
		<input type="hidden" name="action" value="reporteInformacionAdicional" />

		<fieldset>
			<legend class="e6">Reporte Información Adicional de
				Empleados </legend>
			<table border="0" width="100%" class="caja">
				<col style="width: 30%" />
				<col />

				<!-- Encabezado -->
				<tr>
					<th>Estado empleado:</th>
					<th>Generar</th>
				</tr>
				<!-- Cuerpo -->
				<tbody>
					<tr>
						<td>
							<!-- Lista estado de empleados --> <select
							name="idEstadoReporteEmpleadoInfoAdicional"
							id="idEstadoReporteEmpleadoInfoAdicional" multiple="multiple"
							size="2" required>
								<option value="2"><c:out value="${estadoActivo}" /></option>
								<option value="3"><c:out value="${estadoDeshabilitado}" /></option>
						</select>
						</td>
						<td align="center">
							<button type="submit" id="btnBuscarEmpleadoInfoAdicional"
								name="btnBuscarEmpleadoInfoAdicional">Generar Excel</button>
						</td>
					</tr>
				</tbody>
			</table>

		</fieldset>
	</form>

	<br /> <br />

	<!-- Fin  reporte información adicional de empleados -->

	<!-------------------------------------------------------------------------->
	<!-- Reporte de procesos disciplinarios por ultimo contrato de empleados  -->
	<!-------------------------------------------------------------------------->
	<form name="fReporteProcesosDisciplinarios" id="fReporteProcesosDisciplinarios" action="${ctx}/page/reportes" method="post">
		<input type="hidden" name="action" value="reporteProcesoDisciplinario" />
		<fieldset>
			<legend class="e6">Reporte Procesos Disciplinarios</legend>
			<table border="0" width="100%" class="caja">
				<col style="width: 30%" />
				<col />

				<tr>
					<th>Estado empleado:</th>
					<th>Generar</th>
				</tr>

				<tbody>
					<tr>
						<td>
							<select
								name="idEstadoReporteProcesoDisciplinario"
								id="idEstadoReporteProcesoDisciplinario" multiple="multiple"
								size="2" required>
									<option value="2"><c:out value="${estadoActivo}" /></option>
									<option value="3"><c:out value="${estadoDeshabilitado}" /></option>
							</select>
						</td>
						<td align="center">
							<button type="submit" id="btnBuscarEmpleadoProcesoDisciplinario"
								name="btnBuscarEmpleadoProcesoDisciplinario">Generar Excel</button>
						</td>
					</tr>
				</tbody>
			</table>

		</fieldset>
	</form>

	<br /> <br />
	<!-- Fin  reporte proceso disciplinario -->


	<!------------------------------------------------------------>
	<!-- Reporte de ingresos de personal en un rango de fechas. -->
	<!------------------------------------------------------------>
	<form name="fReporteIngresosDePersonal" id="fReporteIngresosDePersonal" action="${ctx}/page/reportes" method="post">
		<input type="hidden" name="action" value="reporteIngresoPersonal" />
		<fieldset>
			<legend class="e6">Reporte Ingresos de Personal</legend>
			<table border="0" width="100%" class="caja">
				<col style="width: 30%" />
				<col />

				<tr>
					<th>Fechas de Ingreso:</th>
					<th>Generar</th>
				</tr>

				<tbody>
					<tr>
						<td>
							<strong>Desde:</strong> 
							<input type="text" name="fechaIngresoDesde" id="fechaIngresoDesde" value="<fmt:formatDate value="${now}" pattern="dd/MM/yyyy" />" />
							&nbsp;&nbsp;
							<strong>hasta:</strong> 
							<input type="text" name="fechaIngresoHasta" id="fechaIngresoHasta" value="<fmt:formatDate value="${now}" pattern="dd/MM/yyyy" />" />
						</td>
						<td align="center">
							<button type="submit" id="botonGenerarExcelIngresosDePersonal"
								name="botonGenerarExcelIngresosDePersonal">Generar Excel</button>
						</td>
					</tr>
				</tbody>
			</table>

		</fieldset>
	</form>

	<br /> <br />
	<!-- Fin  reporte ingreso de personal -->

	<fieldset>
		<legend class="e6">Reporte de desvinculación</legend>
		<div id="pruebarestive" align="center">
			<table cellspacing="2" width="100%" border="0" cellpadding="2">
				<col />
				<col style="width: 5px;" />
				<col style="width: 200px;" />
				<tr valign="middle">
					<td class="td3">

						<form name="fReporteEmpleadoDesvinculacion"
							id="fReporteEmpleadoDesvinculacion" action="${ctx}/page/reportes"
							method="post">
							<input type="hidden" name="action"
								value="empleadosreportedesvinculacion" />
							<table width="100%" border="0">
								<tr class="td3" valign="middle">

									<!-- Tipos de busqueda -->
									<td height="33" align="right" valign="middle" width="300">
										Buscar por: 
										<select name="Dtipobusqueda" id="Dtipobusquedausuario">
											<option value="2">Nombre</option>
											<option value="3">Num. identificación</option>
											<option value="1">Fecha de creación</option>
										</select> &nbsp;&nbsp; &nbsp;&nbsp;
									</td>

									<!-- Caja(s) de busqueda -->
									<td valign="middle" align="left" width="360">
										<div id="Dtipobusquedausuario_usuario"
											class="classtipobusquedausuario" style="display: none;">
											<input type="text" name="Dusuario">
										</div>
										<div id="Dtipobusquedausuario_numidentificacion"
											class="classtipobusquedausuario" style="display: none;">
											<input type="text" name="Dnumidentificacion">
										</div>
										<div id="Dtipobusquedausuario_nombre"
											class="classtipobusquedausuario" style="display: block;">
											<input type="text" name="Dnombre" size="50">
										</div>
										<div id="Dtipobusquedausuario_codusuario"
											class="classtipobusquedausuario" style="display: none;">
											<input type="text" name="codusuario">
										</div>

										<div id="Dtipobusquedausuario_creacion"
											class="classtipobusquedausuario" style="display: none;">
											desde: <input type="text" name="Dfrom" id="Dfrom_b_usuario"
												value="<fmt:formatDate value="${now}" pattern="dd/MM/yyyy" />" />
											&nbsp;&nbsp;hasta: <input type="text" name="Dto"
												id="Dto_b_usuario"
												value="<fmt:formatDate value="${now}" pattern="dd/MM/yyyy" />" />
										</div>
									</td>

									<!-- Boton Buscar -->
									<td valign="middle" align="left">
										<button type="submit" id="btnBuscarUsuarioRepo"
											name="btnBuscarUsuarioRepo">Buscar empleado</button>
									</td>
								</tr>
							</table>
						</form>
					</td>
				</tr>
			</table>


			<div align="center" id="msnBuscarEmpleado"></div>
			<div align="center" id="DcajaBuscarUsuario"></div>
	</fieldset>

	<!-- <div id="dmEditarContrato" title="Editar Contrato"></div>
<div id="dmDetalleEmpleado" title="Detalle Empleado"></div>
<div id="dmNuevaPropiedad" title="Nueva Propiedad"></div>
<div id="dmEditarPropiedad" title="Editar Propiedad"></div> -->

	<!-- 4907977973712 -->
	<br /> <br />


	<!-- <div >
<fieldset><legend class="e6">Reporte de Asistencia</legend>
 <iframe width="100%" height="650" frameborder="0" scrolling="no" src="http://www.sistemcobro.com/jasperserver-pro/flow.html?_flowId=dashboardRuntimeFlow&dashboardResource=/public/SistemCobro/DEV/Intranet/Dashboard/PN___Asistencia&j_username=jasURL&j_password=jasS1st3m&theme=default&decorate=no" ></iframe>
 <a class="graph_view" style="display:none;" target="blank_"href="http://www.sistemcobro.com/jasperserver-pro/flow.html?_flowId=dashboardRuntimeFlow&dashboardResource=/public/SistemCobro/DEV/Intranet/Dashboard/PN___Asistencia&j_username=jasURL&j_password=jasS1st3m&theme=default&decorate=no">GRAPH</a>
</fieldset>
</div>


<div id="dmHorarioBusquedaListado" title="Reporte"></div>

<div id="dmMensajeHorario" title="Mensaje"></div>
<div style="padding: 30px 0px;"></div>
</div>

<fieldset><legend class="e6">Reporte de Encuestas de Desvinculacion</legend>

         <div style="width: 100%"  id ="tableauVizreportes"></div>
   
</fieldset>
 -->
 <div>
 <fieldset><legend class="e6">Reporte de Asistencia</legend>

         <div style="width: 100%"  id ="tableauVizreportes"></div>
   
</fieldset>
</div>