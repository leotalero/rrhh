<%@ include file="/taglibs.jsp"%>


<script type="text/javascript">

	jQuery.validator.addMethod("loginregex", function(value, element) {
	    return this.optional(element) || /^[a-zA-Z0-9\_]+$/.test(value);
	});
	
	$(document).ready(function() {
		//$("#idarea [value='${contrato.idarea}']").attr("selected","selected");
		//$("#idcargo [value='${contrato.idcargo}']").attr("selected","selected");
		
		$("[name=btnCrearEmpleado]").button();	
		$("[name=btnCrearCancelarContrato]").button();

		$("#fCrearContrato").validate({
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
				idtipomoneda:{
					required:true
				},
				sueldoactualuno:{
					required:true,
					number:true
				},
				sueldoactualdos:{
					required:true,
					number:true,
					equalTo:"#sueldoactualuno"
				},
				sueldoactualtres:{
					required:true,
					number:true,
					equalTo:"#sueldoactualdos"
				},
				idtipocontrato:{
					required:true
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
				idtipomoneda:{
					required:"Seleccione un tipo de moneda"
				},
				sueldoactualuno:{
					required:"Campo requerido.",
					number: "Ingrese valores numéricos."
				},
				sueldoactualdos:{
					required:"Campo requerido.",
					number:"Ingrese valores numéricos.",
					equalTo: "Los sueldos no coinciden"
				},
				sueldoactualtres:{
					required:"Campo requerido.",
					number:"Ingrese valores numéricos.",
					equalTo: "Lo sueldos no coinciden"
				},
				idtipocontrato:{
					required: "Seleccione una opción."
				}
			},
			submitHandler: function(form) {
				crearContrato(form);
			}
		});

		$("#tipobusquedausuario").change( function() {
			var data =  $(this).val();
			$(".classtipobusquedausuario").hide();
			if(data==1){
				$("#tipobusquedausuario_creacion").show();
			}else if(data==2){
				$("#tipobusquedausuario_nombre").show();
			}else if(data==3){
				$("#tipobusquedausuario_numidentificacion").show();
			}else if(data==4){
				$("#tipobusquedausuario_usuario").show();
			}else if(data==5){
				$("#tipobusquedausuario_codusuario").show();
			}else if(data==6){
				$("#tipobusquedausuario_idaplicacion").show();
			}else if(data==7){
				$("#tipobusquedausuario_idgrupo").show();
			}
			 
		});

		$("#fCrearContrato [name=idarea]").multiselect({
		    /*header: true,*/
		    height: 175,
		    minWidth: 225,
		    classes: '',
		  //  checkAllText: 'Marcar todos',
		  //  uncheckAllText: 'Desmarcar todos',
		    noneSelectedText: 'Seleccionar Area',
		    //selectedText: '# selecionado(s)',
		    selectedList: 1,
		    show: null,
		    hide: null,
		    autoOpen: false,
		    multiple: false,
		    position: {},
		   
		    appendTo: "body"
		}).multiselectfilter({                         
		     label: 'Filtro:&nbsp;',               
		  placeholder: '',
		  autoReset: false
		});

		
		$("#fCrearContrato [name=idareaasignada]").multiselect({
		    /*header: true,*/
		    height: 175,
		    minWidth: 225,
		    classes: '',
		  //  checkAllText: 'Marcar todos',
		  //  uncheckAllText: 'Desmarcar todos',
		    noneSelectedText: 'Seleccionar Area',
		    //selectedText: '# selecionado(s)',
		    selectedList: 1,
		    show: null,
		    hide: null,
		    autoOpen: false,
		    multiple: false,
		    position: {},
		   
		    appendTo: "body"
		}).multiselectfilter({                         
		     label: 'Filtro:&nbsp;',               
		  placeholder: '',
		  autoReset: false
		});

		
		var dates = $("#fechafirma, #fechainicio")
		.datepicker(
		{
			dateFormat : "dd/mm/yy",
			//maxDate : '+0D',
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
				var option = this.id == "fechafirma" ? "minDate"
						: "maxDate", instance = $(this)
						.data("datepicker"), date = $.datepicker
						.parseDate(instance.settings.dateFormat || $.datepicker._defaults.dateFormat, selectedDate, instance.settings); 
				dates.not(this).datepicker("option", option, date);
			}
		});
		
		
	});

	
	
	
	function crearContrato(form) {
		$("[name=btnCrearEmpleado]").attr('disabled',true);;
		$("[name=btnCrearCancelarContrato]").attr('disabled',true);;
		$("#dmMensajeEmpleado").dialog("open");
		$("#dmMensajeEmpleado").html(getHTMLLoaging16(' Creando'));
		
		$.ajax({
			cache: false,
			contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
            type: $(form).attr('method'),            
            url: $(form).attr('action'),
            data: $(form).serialize(),
            dataType: "text",
            error: function(jqXHR, textStatus, errorThrown) {
            	$("[name=btnCrearEmpleado]").attr('disabled',false);
        		$("[name=btnCrearCancelarContrato]").attr('disabled',false);
                $("#dmMensajeEmpleado").html(jqXHR.statusText);
	        },
            success: function(data) {    
            	if(validarEntero(data)){
            	//	alert("ok");
            		$("#dmMensajeEmpleado").dialog("close");
                	$("#dmNuevoContrato").dialog("close");
                	actualizarDetalleEmpleado(data);
                } else {
                	$("[name=btnCrearEmpleado]").attr('disabled',false);
            		$("[name=btnCrearCancelarContrato]").attr('disabled',false);
                    $("#dmMensajeEmpleado").html('Error desconocido');					
                }            		 
            }
        });
	}

	
	
	
	function validarEntero(valor){ 
    	valor = parseInt(valor);
     	//Compruebo si es un valor numérico 
     	if (isNaN(valor)) { 
           	 //entonces (no es numero) devuelvo el valor cadena vacia 
           	 return false;
     	}else{ 
           	 //En caso contrario (Si era un número) devuelvo el valor 
           	 return true;
     	} 
	}
	
	/*
	* Este método escribe el salario ingresado
	* Cuando los tres campos coninciden.
	*/
	function escribirSalario(){
		var uno  = $("#sueldoactualuno").val();
		var dos  = $("#sueldoactualdos").val();
		var tres = $("#sueldoactualtres").val();
		
		if(uno==dos && dos==tres && uno==tres){
			//tres = $.parseNumber(tres, {format:"#,###.00", locale:"us"});
			//alert(tres);
			$("#salarioEscrito").text(tres+" ("+tres.length+" dígitos)");
		}
	}
	
	/**
	 * Carga los cargos de un area espefica que ha sido seleccionada.
	 * @param idarea. El area seleccionada.
	 * @param idcontrato. El id del contrato.
	 */
	function cargos(idarea,idcontrato){
		
		$("#divCargo").html(getHTMLLoaging30());
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
	           	$("#divCargo").html(data);     
	        }
	    });
	}
	
</script>

<div align="left">

<div>
</div>

<form name="fCrearContrato" id="fCrearContrato" action="${ctx}/page/contrato" method="post">

<input type="hidden" name="action" value="contrato_insertar"/>
<input type="hidden" name="empleado" value="${empleado}"/>
<input type="hidden" name="idempleado" value="${empleado.idempleado}"/>
<input type="hidden" name="idcontrato" value="${contrato.idcontrato}"/>
<div><button type="button" id="btnCrearCancelarContrato" name="btnCrearCancelarContrato" onclick="$('#dmNuevoContrato').dialog('close');">Cancelar</button>&nbsp;&nbsp;&nbsp;<button type="submit" id="btnCrearEmpleado" name="btnCrearEmpleado">Crear</button></div>
<br/>
<fieldset><legend class="e6">Contrato</legend>
<table border="0" width="100%" class="caja">
<col style="width: 15%"/>
<col/>
<tr>


<tr>
	<th nowrap="nowrap" style="text-align: right;">Empresa:</th>
	<td>
		<select name="idempresa" onchange="sucursal(this.value)">
		<option value=""></option>
		<c:forEach items="${empresas}" var="empresa" varStatus="loop">
		<option value="${empresa.idempresa}"><c:out value="${empresa.nombreempresa}"/></option>
		</c:forEach>
		</select>
	</td>
</tr>
<tr >
	<th nowrap="nowrap" style="text-align: right;">Sucursal:</th>
	<td>
	<div id="divSucursal">
		<select name="idsucursal">
		<option value=""></option>
		
		</select>
	</div>	
	</td>
</tr>



<tr >
	<th nowrap="nowrap" style="text-align: right;">Area:</th>
	<td>
		<select name="idarea"  onchange="cargos(this.value)"  multiple="multiple" size="5" >
		<option value=""></option>
		<c:forEach items="${areas}" var="area" varStatus="loop">
		<option  value="${area.idarea}"><c:out value="${area.nombrearea}"/></option>
		</c:forEach>
		</select>
	</td>
</tr>
<tr >
	<th nowrap="nowrap" style="text-align: right;">Cargo:</th>
	<td>
	<div id="divCargo">
		<select name="idcargo" id="idcargo">
		<option value=""></option>
		
		</select>
	</div>	
	</td>
</tr>
<tr >
	<th nowrap="nowrap" style="text-align: right;">Area asignada:</th>
	<td>
		<select name="idareaasignada"    multiple="multiple" size="5" >
		<option value=""></option>
		<c:forEach items="${areas}" var="area" varStatus="loop">
		<option  value="${area.idarea}"><c:out value="${area.nombrearea}"/></option>
		</c:forEach>
		</select>
	</td>
</tr>
<tr>
<th nowrap="nowrap" style="text-align: right;">Número de contrato:</th>
<td><input type="text" name="numerocontrato" value="" style="width: 50%;"/></td>
</tr>
<tr>
<th nowrap="nowrap" style="text-align: right;">Fecha firma:</th>
	<td>
	<input type="text" name="fechafirma" id="fechafirma" value="<fmt:formatDate value="${now}" pattern="dd/MM/yyyy" />" style="width: 50%;"/>
	</td>
</tr>
<tr>
	<th nowrap="nowrap" style="text-align: right;">Fecha Inicio:</th>
	<td><input type="text" name="fechainicio" id="fechainicio" value="<fmt:formatDate value="${now}" pattern="dd/MM/yyyy" />" style="width: 50%;"/></td>
</tr>

<!-- Tipos de contrato. -->
<tr>
	<th nowrap="nowrap" style="text-align: right;">Tipo de contrato:</th>
	<td>
		<select name="idtipocontrato">
			<option value=""></option>
			<c:forEach items="${tiposcontratos}" var="tipocontrato" varStatus="loop">
				<option value="${tipocontrato.idcontratotipo}">
					<c:out value="${tipocontrato.nombrecontratotipo}"/>
				</option>
			</c:forEach>
		</select>
	</td>
</tr>

<!-- 
	Permisos para crear sueldo de empleados. 
	213 - Gerente RRHH / Interno
	214 - Director RRHH / Interno
	215 - Analista Senior RRHH / Interno
-->
<!-- 
<c:if test="${sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 213 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 214 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 215}">
	<tr>
		<th nowrap="nowrap" style="text-align: right;">Sueldo actual:</th>
		<td>
			<input type="password" id="sueldoactualuno" name="sueldoactualuno" value="" style="width: 50%;" onpaste="return false"/>
		</td>
	</tr>
	<tr>
		<th nowrap="nowrap" style="text-align: right;">Confirme Sueldo:</th>
		<td>
			<input type="password" id="sueldoactualdos" name="sueldoactualdos" value="" style="width: 50%;" onpaste="return false"/>
		</td>
	</tr>
	<tr>
		<th nowrap="nowrap" style="text-align: right;">Confirme Sueldo:</th>
		<td>
			<input type="password" id="sueldoactualtres" name="sueldoactualtres" value="" style="width: 50%;" onpaste="return false"/>
		</td>
	</tr>
</c:if>
-->

</table>
</fieldset>
<br/>

<!-- SALARIO DEL EMPLEADO -->
<fieldset>
	<legend class="e6">Salario</legend>
	<table border="0" width="100%" class="caja">
		<col style="width: 15%"/>
		<col/>
		<tr>
		
		<!-- Tipos de moneda -->
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
			</td>
		</tr>
		
		<!-- Sueldos -->
		<tr>
			<th nowrap="nowrap" style="text-align: right;">Sueldo actual:</th>
			<td>
				<input type="password" id="sueldoactualuno" name="sueldoactualuno" value="" style="width: 50%;" onpaste="return false" onkeyup="escribirSalario()"/>
			</td>
		</tr>
		
		<tr>
			<th nowrap="nowrap" style="text-align: right;">Confirme Sueldo:</th>
			<td>
				<input type="password" id="sueldoactualdos" name="sueldoactualdos" value="" style="width: 50%;" onpaste="return false" onkeyup="escribirSalario()"/>
			</td>
		</tr>
		<tr>
			<th nowrap="nowrap" style="text-align: right;">Confirme Sueldo:</th>
			<td>
				<input type="password" id="sueldoactualtres" name="sueldoactualtres" value="" style="width: 50%;" onpaste="return false" onkeyup="escribirSalario()"/>
			</td>
		</tr>
		
		<tr>
			<th nowrap="nowrap" style="text-align: right;">Sueldo Escrito:</th>
			<td>
				<p id="salarioEscrito"></p>
			</td>
		</tr>
		
	</table>
</fieldset>

<!-- salarioEscrito -->


<br/>
<br/>
<div><button type="button" id="btnCrearCancelarContrato" name="btnCrearCancelarContrato" onclick="$('#dmNuevoContrato').dialog('close');">Cancelar</button>&nbsp;&nbsp;&nbsp;<button type="submit" id="btnCrearEmpleado" name="btnCrearEmpleado">Crear</button></div>
</form>

</div>
<div style="padding: 30px 0px;"></div>