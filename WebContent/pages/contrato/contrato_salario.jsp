<%@ include file="/taglibs.jsp"%>

<script type="text/javascript">
$(document).ready(function(){
	
	$("[name=btnEditarCancelarContratoSalario]").button();	
	$("[name=btnEditarContratoSalario]").button();
	
	//Validaciones
	$("#fEditarContratoSalario").validate({
		errorClass: "invalid",
		rules: {
			idtipomoneda_editar: {
				required: true,
				min:1
			},
			sueldoactualuno_editar:{
				required:true,
// 				digits:true
				number: true
			},
			sueldoactualdos_editar:{
				required:true,
// 				digits:true
				number: true,
				equalTo:"#sueldoactualuno_editar"
			},
			sueldoactualtres_editar:{
				required:true,
// 				digits:true,
				number: true,
				equalTo:"#sueldoactualdos_editar"
			},
		},
		
		messages: {
			
			idtipomoneda_editar: {
				required: "Seleccione una opción para tipo de moneda."
			},
			sueldoactualuno_editar:{
				required:"Campo requerido.",
				number: "Ingrese valores numéricos."
			},
			sueldoactualdos_editar:{
				required:"Campo requerido.",
				number:"Ingrese valores numéricos.",
				equalTo: "Los sueldos no coinciden"
			},
			sueldoactualtres_editar:{
				required:"Campo requerido.",
				number:"Ingrese valores numéricos.",
				equalTo: "Lo sueldos no coinciden"
			}
		},
		submitHandler: function(form) {				
//  			crearBanco(form);
 			editarContratoSalario(form);
		}
	}); 
	
});


function editarCancelarContratoSalario(idempleado) {
	$('#dmEditarSalario').dialog('close');
 	visualizarDetalleEmpleado(idempleado);
}

//Editar Contrato salario.
function editarContratoSalario(form) {
		$("[name=btnEditarContratoSalario]").attr('disabled',true);
		$("[name=btnEditarCancelarContratoSalario]").attr('disabled',true);
		
		$("#dmMensajeSalario").dialog("open");
		$("#dmMensajeSalario").html(getHTMLLoaging16('Creando'));
		
		$.ajax({
			cache: false,
			contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
            type: $(form).attr('method'),            
            url: $(form).attr('action'),
            data: $(form).serialize(),
            dataType: "text",
            error: function(jqXHR, textStatus, errorThrown) {
            	$("[name=btnEditarContratoSalario]").attr('disabled',false);
        		$("[name=btnEditarCancelarContratoSalario]").attr('disabled',false);
                $("#dmMensajeSalario").html(jqXHR.statusText);
	        },
            success: function(data) {
            	if(validarEntero(data)){
            		$("#dmMensajeSalario").dialog("close");
                	$("#dmEditarSalario").dialog("close");
//                 	alert('Dato que llego : '+data);
                	visualizarDetalleEmpleado(data);
                } else {
                	$("[name=btnEditarContratoSalario]").attr('disabled',false);
            		$("[name=btnEditarCancelarContratoSalario]").attr('disabled',false);
                    $("#dmMensajeSalario").html('Error desconocido');					
                }            		 
            }
        });
	}

/*Validar número entero.*/
function validarEntero(valor){ 
    	valor = parseInt(valor);
     	if (isNaN(valor)) { 
           	 return false;
     	}else{ 
           	 return true;
     	} 
	}

/*
* Este método escribe el salario ingresado
* Cuando los tres campos coninciden.
*/
function escribirSalario(){
	var uno  = $("#sueldoactualuno_editar").val();
	var dos  = $("#sueldoactualdos_editar").val();
	var tres = $("#sueldoactualtres_editar").val();
	
	if(uno==dos && dos==tres && uno==tres){
		$("#escrito").text(tres+" ("+tres.length+" dígitos)");
	}
}

</script>


<!-- ############################################################################################## -->


<%-- <input type="hidden" name="temporal" id="temporal" value="${fechamin}" style="width: 95%;"/> --%>
<div align="left">
<%-- <c:choose> --%>
<%-- 		<c:when test="${empty contratosalario}"> --%>
<!-- 			<div class="msgInfo1" align="left">No existe salario para este contrato.</div> -->

<%-- 		</c:when> --%>
<%-- <c:otherwise> --%>


<div></div>

<form name="fEditarContratoSalario" id="fEditarContratoSalario" action="${ctx}/page/contrato" method="post">
<input type="hidden" name="action" value="contratosalario_editar"/>
<input type="hidden" name="idcontratosalario_editar" value="${contratosalario.idempleadosalario}"/>
<input type="hidden" name="idempleado_editar" value="${idempleado}"/>
<input type="hidden" name="idcontrato_editar" value="${idcontrato}"/>
<input type="hidden" name="valorSalario" value="${contratosalario.salario}"/>
<div>
	<button type="button" id="btnEditarCancelarContratoSalario" name="btnEditarCancelarContratoSalario" onclick="editarCancelarContratoSalario(${idempleado});">Cancelar</button>
	&nbsp;&nbsp;&nbsp;
	<button type="submit" id="btnEditarContratoSalario" name="btnEditarContratoSalario">Grabar</button>
</div>

<br/>


<!-- SALARIO DEL EMPLEADO -->
<fieldset>
	<legend class="e6">Salario</legend>
	
	<table border="0" width="100%" class="caja">
		<col style="width: 15%"/>
		<col/>
		<tr>
		
		<tr>
			<th nowrap="nowrap" style="text-align: right;">Tipo Moneda:</th>
			<td>
				<select name="idtipomoneda_editar">
				<option value=""></option>
				<c:forEach items="${tiposmoneda}" var="moneda" varStatus="loop">
					<option value="${moneda.idtipomoneda}">
						<c:out value="${moneda.simbolo} - ${moneda.nombretipomoneda} - ${moneda.codigoiso}"/>
					</option>
				</c:forEach>
				</select>
				<script type="text/javascript">
					$("#fEditarContratoSalario [name=idtipomoneda_editar]").val("${contratosalario.idtipomoneda}");
				</script>
			</td>
		</tr>
		
		<tr>
			<th nowrap="nowrap" style="text-align: right;">Sueldo actual:</th>
			<td>
				<input type="password" id="sueldoactualuno_editar" name="sueldoactualuno_editar" value="${contratosalario.salario}" style="width: 50%;" onpaste="return false" onkeyup="escribirSalario()"/>
			</td>
		</tr>
		
		<tr>
			<th nowrap="nowrap" style="text-align: right;">Confirme Sueldo:</th>
			<td>
				<input type="password" id="sueldoactualdos_editar" name="sueldoactualdos_editar" value="${contratosalario.salario}" style="width: 50%;" onpaste="return false" onkeyup="escribirSalario()"/>
			</td>
		</tr>
		<tr>
			<th nowrap="nowrap" style="text-align: right;">Confirme Sueldo:</th>
			<td>
				<input type="password" id="sueldoactualtres_editar" name="sueldoactualtres_editar" value="${contratosalario.salario}" style="width: 50%;" onpaste="return false" onkeyup="escribirSalario()"/>
			</td>
		</tr>
		<tr>
			<th nowrap="nowrap" style="text-align: right;">Sueldo Escrito:</th>
			<td>
				<p id="escrito"></p>
			</td>
		</tr>
	</table>
</fieldset>
<br/>
<br/>

<div>
<button type="button" id="btnEditarCancelarContratoSalario" name="btnEditarCancelarContratoSalario" onclick="editarCancelarContratoSalario(${idempleado});">Cancelar</button>&nbsp;&nbsp;&nbsp;
<button type="submit" id="btnEditarContratoSalario" name="btnEditarContratoSalario">Grabar</button></div>
</form>
<br/>

<br/>

<br/>
<%-- </c:otherwise> --%>
<%-- </c:choose> --%>
</div>
<div style="padding: 30px 0px;"></div>