<%@ include file="/taglibs.jsp"%>
<script type="text/javascript">
	jQuery.validator.addMethod("loginregex", function(value, element) {
	    return this.optional(element) || /^[a-zA-Z0-9\_]+$/.test(value);
	});
	
	$(document).ready(function() {	
	
		$("#idarea [value='${contrato.idarea}']").attr("selected","selected");
		$("#idareaasignadaeditar [value='${contrato.idareaasignada}']").attr("selected","selected");
		
		$("#idcargo [value='${contrato.idcargo}']").attr("selected","selected");
		
		$("#tabsHorarios").tabs({
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
		
		
		$("#fEditarContrato [name=idarea]").multiselect({
		    /*header: true,*/
		    height: 175,
		    minWidth: 225,
		    classes: '',
		  //  checkAllText: 'Marcar todos',
		  //  uncheckAllText: 'Desmarcar todos',
		    noneSelectedText: 'Seleccionar Area',
		   // selectedText: '# selecionado(s)',
		    selectedList: 1,
		    show: null,
		    hide: null,
		    autoOpen: false,
		    multiple: false,
		    position: {},
		    appendTo: "body",
		   


		}).multiselectfilter({                         
		     label: 'Filtro:&nbsp;',               
		  placeholder: '',
		  autoReset: false
		});
		
		$("#fEditarContrato [name=idareaasignadaeditar]").multiselect({
		    /*header: true,*/
		    height: 175,
		    minWidth: 225,
		    classes: '',
		  //  checkAllText: 'Marcar todos',
		  //  uncheckAllText: 'Desmarcar todos',
		    noneSelectedText: 'Seleccionar Area asignada',
		   // selectedText: '# selecionado(s)',
		    selectedList: 1,
		    show: null,
		    hide: null,
		    autoOpen: false,
		    multiple: false,
		    position: {},
		    appendTo: "body",
		   


		}).multiselectfilter({                         
		     label: 'Filtro:&nbsp;',               
		  placeholder: '',
		  autoReset: false
		});

		$("#fEditarContrato [name=idcargo]").multiselect({
		    /*header: true,*/
		    height: 175,
		    minWidth: 225,
		    classes: '',
		  //  checkAllText: 'Marcar todos',
		  //  uncheckAllText: 'Desmarcar todos',
		    noneSelectedText: 'Seleccionar Cargo',
		   // selectedText: '# selecionado(s)',
		    selectedList: 1,
		    show: null,
		    hide: null,
		    autoOpen: false,
		    multiple: false,
		    position: {},
		    appendTo: "body",
		   


		}).multiselectfilter({                         
		     label: 'Filtro:&nbsp;',               
		  placeholder: '',
		  autoReset: false
		});

		
		$("#fEditarContrato [name=btnEditarContrato]").button();
		$("#fEditarContrato [name=btnEditarCancelarContrato]").button();		
		$("#fCrearUsuarioAplicacion [name=btnCrearUsuarioAplicacion]").button();
		$("#fCrearContratoHorario [name=btnCrearUsuarioHorario]").button();
	
		var dates = $("#fechafirma, #fechainicio,#fechafin")
		.datepicker(
		{
			dateFormat : "dd/mm/yy",
			maxDate : '+30D',
			//minDate : '-0D',
			minyear:'-80Y',
			numberOfMonths : 1,
			 changeMonth: true,
			 changeYear: true,
			//showAnim: 'fold',
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
				var option = this.id == "fechafirma" ? "minDate" : "maxDate",
						instance = $( this ).data( "datepicker" ),
						date = $.datepicker.parseDate(
							instance.settings.dateFormat ||
							$.datepicker._defaults.dateFormat,
							selectedDate, instance.settings );
					dates.not( this ).datepicker( "option", option, date );
			}
		});
		
	
		
		
		
		
		var dates = $("#validezinicio, #validezfin")
		.datepicker(
		{
			dateFormat : "dd/mm/yy",
			maxDate : '+80Y',
			minDate : '${fechamin}',
			//minyear:'-0D',
			numberOfMonths : 1,
			 changeMonth: true,
			 changeYear: true,
			//showAnim: 'fold',
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
				var option = this.id == "validezinicio" ? "minDate" : "maxDate",
						instance = $( this ).data( "datepicker" ),
						date = $.datepicker.parseDate(
							instance.settings.dateFormat ||
							$.datepicker._defaults.dateFormat,
							selectedDate, instance.settings );
				dates.not( this ).datepicker( "option", option, date );
			}
		
	
		});
		
		
		
		$("#fEditarContrato").validate({
			//errorLabelContainer: "#msnBuscarCargue",
			errorClass: "invalid",
			rules: {
				
				idempresa: {
					required: true,
					min:1
				},
				idsucursal:{
					required: true,
					min:1
				},
				idarea:{
					required: true,
					min:1
					
				},
				idcargo:{
					required: true,
					min:1
					
				},
				numerocontrato:{
					required: true
					
				},
				fechafirma:{
					required: true
				},
				fechainicio:{
					required: true
				},
// 				sueldoactualuno:{
// 					required: true,
// 					digits:true,
					
// 				},
// 				sueldoactualdos:{
// 					required: true,
// 					digits:true,
// 					equalTo: "#sueldoactualuno"
// 				},
// 				sueldoactualtres:{
// 					required: true,
// 					digits:true,
// 					equalTo: "#sueldoactualdos"
// 				},
				idtipocontratoasignado:{
					required: true
				}
			},
			messages: {
				
				idempresa: {
					required: "Seleccione una opción para Empresa",
					
					
				},
				idsucursal: {
					required: "Seleccione una opción para Sucursal",
					
				},
				idarea: {
					required: "Seleccione una opción para Area",
				},
				idcargo: {
					required: "Seleccione una opción para Cargo",
				},
				numerocontrato: {
					required: "Campo requerido",
				},
				fechafirma: {
					required: "Campo requerido",
				},
				fechainicio: {
					required: "Campo requerido",
				},
// 				sueldoactualuno:{
// 					required: "Campo requerido",
// 					digits: "Ingrese solo digitos"					
// 				},
// 				sueldoactualdos:{
// 					required: "Campo requerido",
// 					digits: "Ingrese solo digitos",
// 					equalTo : "Los sueldos no coinciden"
// 				},
// 				sueldoactualtres:{
// 					required: "Campo requerido",
// 					digits: "Ingrese solo digitos",
// 					equalTo : "Los sueldos no coinciden"
// 				},
				idtipocontratoasignado:{
					required: "Seleccione una opción."
				}
				
			},
			submitHandler: function(form) {
				editarEmpleado(form);	
			}
		});

		$("#fCrearUsuarioAplicacion").validate({
			//errorLabelContainer: "#msnBuscarCargue",
			errorClass: "invalid",
			rules: {
				idaplicacion:{
					required: true
				},
				idgrupo:{
					required: true
				},
				idusuario:{
					required: true
				}
			},
			messages: {
				idaplicacion: {
					required: "Seleccione un valor."
				},
				idgrupo: {
					required: "Seleccione un valor."
				},
				idusuario: {
					required: "Ingrese un valor."
				}
			},
			submitHandler: function(form) {
				crearUsuarioAplicacion(form);
			}
		});

		$("#fCrearUsuarioAplicacion [name=idaplicacion]").change( function() {
			var idaplicacion =  $(this).val();
			if(idaplicacion==''){
				$("#divGrupoAplicacion").html('');
			}else{
				$("#fCrearUsuarioAplicacion [name=idaplicacion]").attr('disabled',true);	
				$.ajax({
					cache: false,
					contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
		            type: 'post',            
		            url: '${ctx}/page/grupo?action=grupo_aplicacion&idaplicacion='+idaplicacion,
		            data: '',
		            dataType: "text",
		            error: function(jqXHR, textStatus, errorThrown) {
			            alert(jqXHR.statusText);
		            	$("#fCrearUsuarioAplicacion [name=idaplicacion]").attr('disabled',false);
			        },
		            success: function(data) {
		            	$("#fCrearUsuarioAplicacion [name=idaplicacion]").attr('disabled',false);
		                $("#divGrupoAplicacion").html(data);
		            }
		        });	 
			}
		});
		
	});

	function crearUsuarioAplicacion(form) {
		$("[name=btnCrearUsuarioAplicacion]").attr('disabled',true);;
		$("#dmMensajeContrato").dialog("open");
		$("#dmMensajeContrato").html(getHTMLLoaging16(' Creando'));
		$.ajax({
			cache: false,
			contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
            type: $(form).attr('method'),            
            url: $(form).attr('action'),
            data: $(form).serialize(),
            dataType: "text",
            error: function(jqXHR, textStatus, errorThrown) {
            	$("[name=btnCrearUsuarioAplicacion]").attr('disabled',false);        		
                $("#dmMensajeContrato").html(jqXHR.statusText);
	        },
            success: function(data) {    
            	if(validarEntero(data)){
            		$("#dmMensajeContrato").dialog("close");
                	$("#dmNuevoUsuario").dialog("close");
            		visualizarEdicionEmpleado(data);
                } else {
                	$("[name=btnCrearUsuarioAplicacion]").attr('disabled',false);
                    $("#dmMensajeContrato").html('Error desconocido');					
                }            		 
            }
        });
	}
	
	
	$("#fCrearContratoHorario").validate({
		//errorLabelContainer: "#msnBuscarCargue",
		errorClass: "invalid",
		rules: {
			idcuenta:{
				required: true
			},
			dato:{
				required: true
			},
			idusuario:{
				required: true
			}
		},
		messages: {
			idcuenta: {
				required: "Seleccione un valor."
			},
			dato: {
				required: "Ingrese un valor."
			},
			idusuario: {
				required: "Ingrese un valor."
			}
		},
		submitHandler: function(form) {
			crearUsuarioHorario(form);
		}
	});
	
	function crearUsuarioHorario(form) {
		$("[name=btnCrearUsuarioHorario]").attr('disabled',true);;
		$("#dmMensajeContrato").dialog("open");
		$("#dmMensajeContrato").html(getHTMLLoaging16(' Creando'));
		$.ajax({
			cache: false,
			contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
            type: $(form).attr('method'),            
            url: $(form).attr('action'),
            data: $(form).serialize(),
            dataType: "text",
            error: function(jqXHR, textStatus, errorThrown) {
            	$("[name=btnCrearUsuarioHorario]").attr('disabled',false);        		
                $("#dmMensajeContrato").html(jqXHR.statusText);
	        },
            success: function(data) {    
            	if(validarEntero(data)){
            		$("#dmMensajeContrato").dialog("close");
                	//$("#dmNuevoUsuario").dialog("close");
                	visualizarEditarContrato(data);
                } else {
                	$("[name=btnCrearUsuarioHorario]").attr('disabled',false);
                    $("#dmMensajeContrato").html('Error desconocido');					
                }            		 
            }
        });
	}

	function editarCancelarContrato(idempleado) {
		$('#dmEditarContrato').dialog('close');
		visualizarDetalleEmpleado(idempleado);
	}

	function editarEmpleado(form) {
		$("[name=btnEditarContrato]").attr('disabled',true);
		$("[name=btnEditarCancelarContrato]").attr('disabled',true);
		$("#dmMensajeContrato").dialog("open");
		$("#dmMensajeContrato").html(getHTMLLoaging16(' Grabando'));
		$.ajax({
			cache: false,
			contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
            type: $(form).attr('method'),            
            url: $(form).attr('action'),
            data: $(form).serialize(),
            dataType: "text",
            error: function(jqXHR, textStatus, errorThrown) {
            	$("[name=btnEditarContrato]").attr('disabled',false);
        		$("[name=btnEditarCancelarContrato]").attr('disabled',false);
                $("#dmMensajeContrato").html(jqXHR.statusText);
	        },
            success: function(data) {    
            	if(validarEntero(data)){
            		$("#dmMensajeContrato").dialog("close");
                	$("#dmEditarContrato").dialog("close");
            		visualizarDetalleEmpleado(data);
                } else {
                	$("[name=btnEditarContrato]").attr('disabled',false);
            		$("[name=btnEditarCancelarContrato]").attr('disabled',false);
                    $("#dmMensajeContrato").html('Error desconocido');					
                }            		 
            }
        });
	}
	function sucursaleditar(idempresa,idcontrato){
		//$("#cajaBuscarBase").html('');
		//$("#productotipo").val(idproductotipo);
		//alert("contrato:"+idcontrato);
	
		if(idempresa!=""){
			
		
		$("#divSucursalEditar").html(getHTMLLoaging30());
		$.ajax({
			cache: false,
			contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
            type: 'POST',
            dataType : 'text',
            url: "${ctx}/page/contrato?action=cargar_sucursales&idempresa="+idempresa+"&idcontrato="+idcontrato,
            error: function(jqXHR, textStatus, errorThrown) {
                alert(jqXHR.statusText);
	        },
            success: function(data) {	
            	
               	$("#divSucursalEditar").html(data);     
            }
        });
		}else{
			alert("seleccione una empresa!!");
		}
	}
	function cargoseditar(idarea,idcontrato){
		//$("#cajaBuscarBase").html('');
		//$("#productotipo").val(idproductotipo);
		
		$("#divCargoEditar").html(getHTMLLoaging30());
		$.ajax({
			cache: false,
			contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
            type: 'POST',
            dataType : 'text',
            url: "${ctx}/page/contrato?action=cargar_cargos&idarea="+idarea+"&idcontrato="+idcontrato,
            error: function(jqXHR, textStatus, errorThrown) {
                alert(jqXHR.statusText);
	        },
            success: function(data) {	
            	
               	$("#divCargoEditar").html(data);     
            }
        });
	}
	sucursaleditar("${contrato.idempresa}","${contrato.idcontrato}");
	//cargoseditar("${contrato.idarea}","${contrato.idcontrato}");



</script>
<input type="hidden" name="temporal" id="temporal" value="${fechamin}" style="width: 95%;"/>
<div align="left">
<c:choose>
		<c:when test="${empty contrato}">
			<div class="msgInfo1" align="left">No existe contrato.</div>
		</c:when>
		<c:otherwise>


<div></div>
<form name="fEditarContrato" id="fEditarContrato" action="${ctx}/page/contrato" method="post">
<input type="hidden" name="action" value="contrato_editar"/>
<input type="hidden" name="idcontrato" value="${contrato.idcontrato}"/>
<input type="hidden" name="idempleado" value="${contrato.idempleado}"/>
<%-- <input type="hidden" name="salarioOculto" value="${empleadosalario.salario}"/> --%>

<div>
	<button type="button" id="btnEditarCancelarContrato" name="btnEditarCancelarContrato" onclick="editarCancelarContrato(${contrato.idempleado});">Cancelar</button>
	&nbsp;&nbsp;&nbsp;
	<button type="submit" id="btnEditarContrato" name="btnEditarContrato">Grabar</button>
</div>

<br/>
<fieldset><legend class="e6">Contrato</legend>
<table border="0" width="100%" class="caja">
<col style="width: 15%"/>
<col/>



<tr>
	<th nowrap="nowrap" style="text-align: right;">Empresa:</th>
	<td>
		<select name="idempresa" onchange="sucursaleditar(this.value,${contrato.idcontrato})">
		<option value=""></option>
		<c:forEach items="${empresas}" var="empresa" varStatus="loop">
		<option value="${empresa.idempresa}"><c:out value="${empresa.nombreempresa}"/></option>
		</c:forEach>
		</select>
		
		
		<script type="text/javascript">$("#fEditarContrato [name=idempresa]").val("${contrato.idempresa}");</script>
		
	</td>
</tr>
<tr >
	<th nowrap="nowrap" style="text-align: right;">Sucursal:</th>
	<td>
	<div id="divSucursalEditar">
		<select name="idsucursal">
		<option value=""></option>
			<c:forEach items="${sucursales}" var="sucursal" varStatus="loop">
				<option value="${sucursal.idsucursal}"><c:out value="${sucursal.idsucursal}" /> - <c:out value="${sucursal.nombresucursal}" /></option>
			</c:forEach>
		</select>
		<script type="text/javascript">$("#fEditarContrato [name=idsucursal]").val("${contrato.idsucursal}");</script>
	</div>	
	</td>
</tr>

<tr >
	<th nowrap="nowrap" style="text-align: right;">Area:</th>
	<td>
		<select name="idarea" id="idarea"  onchange="cargoseditar(this.value,${contrato.idcontrato})"  multiple="multiple" size="5">
		<option value=""></option>
		<c:forEach items="${areas}" var="area" varStatus="loop">
		<option  value="${area.idarea}"><c:out value="${area.nombrearea}"/></option>
		</c:forEach>
		</select>
		<script type="text/javascript">
		
		$("#fEditarContrato [name=idarea]").val("${contrato.idarea}");
	//alert("area ${contrato.idarea}");
	
	</script>
	
	</td>
</tr>
<tr >
	<th nowrap="nowrap" style="text-align: right;">Cargo:</th>
	<td>
	<div id="divCargoEditar">
		<select name="idcargo" id="idcargo" multiple="multiple" size="5">
		<option value=""></option>
		<c:forEach items="${cargos}" var="cargo" varStatus="loop">
		<option  value="${cargo.idcargo}"><c:out value="${cargo.nombrecargo}" /></option>
		</c:forEach>
		
		</select>
		<script type="text/javascript">$("#fEditarContrato [name=idcargo]").val("${contrato.idcargo}");</script>
	
	</div>	
	</td>
</tr>
<tr >
	<th nowrap="nowrap" style="text-align: right;">Area asignada:</th>
	<td>
		<select name="idareaasignadaeditar" id="idareaasignadaeditar"  multiple="multiple" size="5">
		<option value=""></option>
		<c:forEach items="${areas}" var="area" varStatus="loop">
		<option  value="${area.idarea}"><c:out value="${area.nombrearea}"/></option>
		</c:forEach>
		</select>
		<script type="text/javascript">
		
		$("#fEditarContrato [name=idareaasignadaeditar]").val("${contrato.idareaasignada}");

	
	</script>
	
	</td>
</tr>
<tr >
	<th nowrap="nowrap" style="text-align: right;">Motivo retiro:</th>
	<td>
		<select name="idmotivoretiro" >
			<option value=""></option>
			<c:forEach items="${motivos}" var="motivo" varStatus="loop">
				<option value="${motivo.idretiromotivo}"><c:out value="${motivo.idretiromotivo}"/> - <c:out value="${motivo.nombremotivo}"/></option>
			</c:forEach>
		</select>
		<script type="text/javascript">
			$("#fEditarContrato [name=idmotivoretiro]").val("${contrato.retiromotivo.idretiromotivo}");
		</script>
	</td>
</tr>
<tr>
<th nowrap="nowrap" style="text-align: right;">Número de contrato:</th>
<td><input type="text" name="numerocontrato" value="${contrato.numerocontrato}" style="width: 50%;"/></td>
</tr>


<!-- Listado de tipos de contrato --> 
<tr>
	<th nowrap="nowrap" style="text-align: right;">Tipo contrato:</th>
	<td>
		<select name="idtipocontratoasignado">
			<option value=""></option>
			<c:forEach items="${tiposcontrato}" var="tipocontrato" varStatus="loop">
				<option value="${tipocontrato.idcontratotipo}">
					<c:out value="${tipocontrato.nombrecontratotipo}"/>
				</option>
			</c:forEach>
		</select>
		<script type="text/javascript">
			$("#fEditarContrato [name=idtipocontratoasignado]").val("${contrato.contratotipo.idcontratotipo}");
		</script>
	</td>
</tr>

<tr>
<th nowrap="nowrap" style="text-align: right;">Fecha firma:</th>
<td><input type="text" name="fechafirma" id="fechafirma" value="<fmt:formatDate value="${contrato.fechafirma}" pattern="dd/MM/yyyy" />" style="width: 50%;"/></td>
</tr>
<tr>
<th nowrap="nowrap" style="text-align: right;">Fecha inicio:</th>
<td><input type="text" name="fechainicio" id="fechainicio" value="<fmt:formatDate value="${contrato.fechainicio}" pattern="dd/MM/yyyy" />" style="width: 50%;"/></td>
</tr>

<tr>
	<th nowrap="nowrap" style="text-align: right;">Fecha final contrato:</th>
	<td><input type="text" name="fechafin" id="fechafin" value="<fmt:formatDate value="${contrato.fechafin}" pattern="dd/MM/yyyy" />" style="width: 50%;"/></td>
</tr>

<!-- 
	Permisos para editar sueldo de empleados. 
	213 - Gerente RRHH / Interno
	214 - Director RRHH / Interno
-->
<!-- 
<c:if test="${sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 213 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 214}">
	<tr>
		<th nowrap="nowrap" style="text-align: right;">Sueldo actual:</th>
		<td>
			<input type="password" id="sueldoactualuno" name="sueldoactualuno" value="${contrato.salario}" style="width: 50%;" onpaste="return false"/>
		</td>
	</tr>
	<tr>
		<th nowrap="nowrap" style="text-align: right;">Confirme Sueldo:</th>
		<td>
			<input type="password" id="sueldoactualdos" name="sueldoactualdos" value="${contrato.salario}" style="width: 50%;" onpaste="return false"/>
		</td>
	</tr>
	<tr>
		<th nowrap="nowrap" style="text-align: right;">Confirme Sueldo:</th>
		<td>
			<input type="password" id="sueldoactualtres" name="sueldoactualtres" value="${contrato.salario}" style="width: 50%;" onpaste="return false"/>
		</td>
	</tr>
</c:if>
-->

</table>
</fieldset>
<br/>

<!-- SALARIO DEL EMPLEADO -->
<!-- 
<fieldset>
	<legend class="e6">Salario</legend>
	<table border="0" width="100%" class="caja">
		<col style="width: 15%"/>
		<col/>
		<tr>
		
		<tr>
			<th nowrap="nowrap" style="text-align: right;">Tipo Moneda:</th>
			<td>
				<select name="idtipomoneda">
				<option value=""></option>
				<c:forEach items="${tiposmoneda}" var="moneda" varStatus="loop">
					<option value="${moneda.idtipomoneda}">
						<c:out value="${moneda.simbolo} - ${moneda.nombretipomoneda} - ${moneda.codigoiso}"/>
					</option>
				</c:forEach>
				</select>
				<script type="text/javascript">
					$("#fEditarContrato [name=idtipomoneda]").val("${empleadosalario.idtipomoneda}");
				</script>
			</td>
		</tr>
		
		<tr>
			<th nowrap="nowrap" style="text-align: right;">Sueldo actual:</th>
			<td>
				<input type="password" id="sueldoactualuno" name="sueldoactualuno" value="${empleadosalario.salario}" style="width: 50%;" onpaste="return false"/>
			</td>
		</tr>
		
		<tr>
			<th nowrap="nowrap" style="text-align: right;">Confirme Sueldo:</th>
			<td>
				<input type="password" id="sueldoactualdos" name="sueldoactualdos" value="${empleadosalario.salario}" style="width: 50%;" onpaste="return false"/>
			</td>
		</tr>
		<tr>
			<th nowrap="nowrap" style="text-align: right;">Confirme Sueldo:</th>
			<td>
				<input type="password" id="sueldoactualtres" name="sueldoactualtres" value="${empleadosalario.salario}" style="width: 50%;" onpaste="return false"/>
			</td>
		</tr>
	</table>
</fieldset>
<br/>
<br/>
-->


<div>
<button type="button" id="btnEditarCancelarContrato" name="btnEditarCancelarContrato" onclick="editarCancelarContrato(${contrato.idempleado});">Cancelar</button>&nbsp;&nbsp;&nbsp;
<button type="submit" id="btnEditarContrato" name="btnEditarContrato">Grabar</button></div>
</form>
<br/>



<br/>


<br/>
</c:otherwise>
</c:choose>
</div>
<div style="padding: 30px 0px;"></div>

