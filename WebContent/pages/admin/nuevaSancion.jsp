<%@ include file="/taglibs.jsp"%>
<script type="text/javascript">
	
$(document).ready(function() {
	//Definción botones.
	$("[name=btnCrearCancelarSancion]").button();
	$("[name=btnCrearSancion]").button();
	
	
	//Configuración de la lista de los tipos de falta.
	$("#fCrearSancion [name=nameFormatosSeleccionadosSancion]").multiselect({
	    /*header: true,*/
	    height: 175,
	    minWidth: 300,
	    //classes: '',
	    checkAllText: 'Marcar todos',
	   	uncheckAllText: 'Desmarcar todos',
	    noneSelectedText: 'Seleccionar Formato(s) Asociado(s)',
	    selectedText: '# selecionado(s)',
	    selectedList: 1,
	    show: null,
	    hide: null,
	    autoOpen: false,
	    multiple: true,
	    position: {},
	    appendTo: "body",
	}).multiselectfilter({                         
	     label: 'Filtro:&nbsp;',               
	  placeholder: '',
	  autoReset: false
	});
	
	
	//Validaciones del formulario y submit.
	$("#fCrearSancion").validate({
		errorClass: "invalid",
		rules: {
			idTipoFaltaSeleccionadaSancion: {
				required: true,
				min:1
			},
			idFaltaAsignadaEnSancion: {
				required: true,
				min: 1
			},
			idSancionDeFalta:{
				required: true,
				maxlength: 2000
			},
			idProcedimientoDeFalta:{
				required: true,
				maxlength: 2000
			},
			responsableSeleccionadoSancion:{
				required: true
			},
			nameFormatosSeleccionadosSancion:{
				 required: true,
	             minlength: 1
			}
		},
		
		messages: {
			
			idTipoFaltaSeleccionadaSancion:{
				required: "Seleccione una opción para el tipo de falta.",	
			},
			idFaltaAsignadaEnSancion: {
				required: "Seleccione una opción para la falta."
			},
			idSancionDeFalta:{
				required: "Ingrese una sanción para la falta.",
				maxlength: "No puede ingresar mas de 2000 caráteres.",
			},
			idProcedimientoDeFalta:{
				required: "Ingrese un procedimiento para la falta.",
			},
			responsableSeleccionadoSancion:{
				required: "Seleccione (1) un responsable."
			},
			nameFormatosSeleccionadosSancion:{
				 required: "Seleccione al menos un formato."
			}
		},
		submitHandler: function(form) {
			var formatosSeleccionadosSancion = $('#idFormatosSeleccionadosSancion').val();
			if(formatosSeleccionadosSancion!=null){
				crearSancion(form);
			}else{
				alert('Debe seleccionar al menos un (1) formato.');
			}
		}
	}); 
	
	
});
	
/**
 * Método para cargar la lista de faltas por tipo de falta.
 */
function cargarFaltasPorTipo(idFaltaTipo){
	if(idFaltaTipo!=''){
		$("#divFaltasPorTipo").html(getHTMLLoaging30());
		$.ajax({
			cache: false,
			contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
	        type: 'POST',
	        dataType : 'text',
	        url: "${ctx}/page/administracion?action=cargarFaltasPorTipoDeFalta&idFaltaTipo="+idFaltaTipo,
	        error: function(jqXHR, textStatus, errorThrown) {
	            alert(jqXHR.statusText);
	        },
	        success: function(data) {
	           	$("#divFaltasPorTipo").html(data);     
	        }
	    });
	}else{
		alert('Seleccione un tipo de falta.');
	}
	
}
	
//Crear  Nueva Sanción
function crearSancion(form) {
	
		$("[name=btnCrearSancion]").attr('disabled',true);
		$("[name=btnCrearCancelarSancion]").attr('disabled',true);
		
		$("#dmMensajeSancion").dialog("open");
		$("#dmMensajeSancion").html(getHTMLLoaging16('Creando'));
		
		$.ajax({
			cache: false,
			contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
            type: $(form).attr('method'),            
            url: $(form).attr('action'),
            data: $(form).serialize(),
            dataType: "text",
            error: function(jqXHR, textStatus, errorThrown) {
            	$("[name=btnCrearSancion]").attr('disabled',false);
        		$("[name=btnCrearCancelarSancion]").attr('disabled',false);
                $("#dmMensajeSancion").html(jqXHR.statusText);
	        },
            success: function(data) {    
            	if(validarEntero(data)){
            		$("#dmMensajeSancion").dialog("close");
            		alert("Se ha creado la Sanción correctamente.");
                	$("#dmNuevaSancion").dialog("close");
					actualizarVentanaAdministracion();
                } else {
                	$("[name=btnCrearSancion]").attr('disabled',false);
            		$("[name=btnCrearCancelarSancion]").attr('disabled',false);
                    $("#dmMensajeSancion").html('Error desconocido.');					
                }            		 
            }
        });
}
	
</script>

<!-- Formulario nueva sancion -->

<div align="left">
<div>
</div>

<form name="fCrearSancion" id="fCrearSancion" action="${ctx}/page/administracion" method="post">

<input type="hidden" name="action" value="insertarSancion"/>
<input type="hidden" name="tiposFaltaSancion" value="${tiposFaltaSancion}"/>
<input type="hidden" name="faltasSancion" value="${faltasSancion}"/>


<div>
	<button type="button" id="btnCrearCancelarSancion" name="btnCrearCancelarSancion" onclick="$('#dmNuevaSancion').dialog('close');">Cancelar</button>
	&nbsp;&nbsp;&nbsp;
	<button type="submit" id="btnCrearSancion" name="btnCrearSancion">Registrar Sanción</button>
</div>
<br/>
<!-- Para datos de la sanción -->
<fieldset>
	<legend class="e6">Nueva Sanción</legend>
	
	<!-- Tabla del formulario -->
	<table border="0" width="100%" class="caja">
	<col style="width: 15%"/>
	<col/>
		<tr>
		
		<!-- Listado de Tipos de Faltas. -->
		<tr>
			<th nowrap="nowrap" style="text-align: right;">Tipo de Falta:</th>
			<td>
				<select name="idTipoFaltaSeleccionadaSancion" style="width: 99%" onchange="cargarFaltasPorTipo(this.value)">
					<option value=""></option>
					<c:forEach items="${tiposFaltaSancion}" var="tipoFalta" varStatus="loop">
						<option  value="${tipoFalta.idfaltatipo}">
							<c:out value="${tipoFalta.nombrefaltatipo}"/>
						</option>
					</c:forEach>
				</select>
			</td>
		</tr>
		
		<!-- Listado de faltas -->
		<tr>
			<th nowrap="nowrap" style="text-align: right;">Falta :</th>
			<td>
				<div id="divFaltasPorTipo">
					<select name="idFaltaAsignadaEnSancion">
						<option value=""></option>
					</select>
				</div>
			</td>
		</tr>
		
		<!-- Recurrencia  -->
		<tr>
		<th nowrap="nowrap" style="text-align: right;">Recurrencia:</th>
			<td>
				<div id="divNumeroRecurrencia">
				</div>
			</td>
		</tr>
		
		<!-- Sanción  -->
		<tr>
		<th nowrap="nowrap" style="text-align: right;">Sanción:</th>
			<td>
				<textarea id="idSancionDeFalta" name="idSancionDeFalta" rows="5" cols="99%"></textarea>
			</td>
		</tr>
		
		<!-- Procedimiento  -->
		<tr>
		<th nowrap="nowrap" style="text-align: right;">Procedimiento:</th>
			<td>
				<textarea id="idProcedimientoDeFalta" name="idProcedimientoDeFalta" rows="5" cols="99%"></textarea>
			</td>
		</tr>
		
		<!-- Responsable  -->
		<tr>
			<th nowrap="nowrap" style="text-align: right;">Responsable:</th>
			<td>
				<select name="responsableSeleccionadoSancion">
				  <option value=""></option> 
				  <option value="Director de Talento Humano">Director de Talento Humano</option>
				  <option value="Gerente de area y/o Director">Gerente de area y/o Director</option>
				  <option value="Lider y/o Coordinador">Lider y/o Coordinador</option>
				</select>
			</td>
		</tr>
		
		<!-- Formatos asociados a esta falta. -->
		<tr>
			<th nowrap="nowrap" style="text-align: right;">Asociar a formato(s):</th>
			<td>
				<select name="nameFormatosSeleccionadosSancion"  id="idFormatosSeleccionadosSancion"   multiple="multiple" size="5">
					<c:forEach items="${formatos}" var="formato" varStatus="loop">
						<option  value="${formato.idformato}">
							<c:out value="${formato.nombreformato}"/>
						</option>
					</c:forEach>
				</select>
			</td>
		</tr>
		
	</table>
</fieldset>

<br/>


<div>
<button type="button" id="btnCrearCancelarSancion" name="btnCrearCancelarSancion" onclick="$('#dmNuevaSancion').dialog('close');">Cancelar</button>
&nbsp;&nbsp;&nbsp;
<button type="submit" id="btnCrearSancion" name="btnCrearSancion">Registrar Sanción</button></div>
</form>

</div>
<div style="padding: 30px 0px;"></div>