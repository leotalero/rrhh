<%@ include file="/taglibs.jsp"%>

<script type="text/javascript">
	$(document).ready(function(){
		
		//Botones
		$("[name=btnCrearFalta]").button();
		$("[name=btnCrearCancelarFalta]").button();
		$("[name=btnCrearTipoFalta]").button();
		$("[name=btnNuevoFormatoFalta]").button();
		
		//Ventanas
		$("#dmNuevoFormatoFalta").dialog({   				
			width: 700,
			height: 320,   				
			modal: true,
			autoOpen: false,
			resizable: true
		});
		
		//Configuración de la lista de los tipos de falta.
		$("#fCrearFalta [name=nameFormatosSeleccionados]").multiselect({
		    /*header: true,*/
		    height: 175,
		    minWidth: 225,
		    //classes: '',
		    checkAllText: 'Marcar todos',
		   	uncheckAllText: 'Desmarcar todos',
		    noneSelectedText: 'Seleccionar Formatos Asociados',
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
		
		
		//Validaciones y submit
		$("#fCrearFalta").validate({
			errorClass: "invalid",
			rules: {
				idTipoFaltaSeleccionada: {
					required: true,
					min:1
				},
				falta: {
					required: true,
					maxlength: 2000
				},
				sancionDeFalta:{
					required: true,
					maxlength: 2000
				},
				recurrenciaSeleccionada:{
					required: true,
					min:1
				},
				procedimientoDeFalta:{
					required: true,
					maxlength: 2000
				},
				responsableSeleccionado:{
					required: true
				},
				nameFormatosSeleccionados:{
					 required: true,
		              minlength: 1
				}
			},
			
			messages: {
				
				idTipoFaltaSeleccionada:{
					required: "Seleccione una opción para el tipo de falta.",	
				},
				falta: {
					required: "Ingrese una falta.",
					maxlength: "No puede ingresar mas de 2000 caráteres.",
				},
				sancionDeFalta:{
					required: "Ingrese una sanción para la falta.",
					maxlength: "No puede ingresar mas de 2000 caráteres.",
				},
				recurrenciaSeleccionada:{
					required: "Seleccione una opción para la recurrencia.",
				},
				procedimientoDeFalta:{
					required: "Ingrese un procedimiento para la falta.",
					maxlength:"No puede ingresar mas de 2000 caráteres.",
				},
				responsableSeleccionado:{
					required: "Seleccione una opción para el responsable.",
				},
				nameFormatosSeleccionados:{
					 required: "Seleccione al menos un formato."
				}
// 				,
// 				idFormatosSeleccionados:{
// 					required: "Seleccione una opción para los formatos.",
// 				}
			},
			submitHandler: function(form) {
				var formatosSeleccionados = $('#idFormatosSeleccionados').val();
				if(formatosSeleccionados!=null){
					crearFalta(form);
				}else{
					alert('Debe seleccionar al menos un (1) formato.');
				}
			}
		}); 
		
	});
	
	
	
	//Crear la Falta.
	function crearFalta(form) {
		
			$("[name=btnCrearFalta]").attr('disabled',true);
			$("[name=btnCrearCancelarFalta]").attr('disabled',true);
			
			$("#dmMensajeFalta").dialog("open");
			$("#dmMensajeFalta").html(getHTMLLoaging16('Creando'));
			
			$.ajax({
				cache: false,
				contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
	            type: $(form).attr('method'),            
	            url: $(form).attr('action'),
	            data: $(form).serialize(),
	            dataType: "text",
	            error: function(jqXHR, textStatus, errorThrown) {
	            	$("[name=btnCrearFalta]").attr('disabled',false);
	        		$("[name=btnCrearCancelarFalta]").attr('disabled',false);
	                $("#dmMensajeFalta").html(jqXHR.statusText);
		        },
	            success: function(data) {    
	            	if(validarEntero(data)){
	            		$("#dmMensajeFalta").dialog("close");
	            		alert("Se ha creado la falta correctamente.");
	                	$("#dmNuevaFalta").dialog("close");
// 	                	actualizarEducacion(data);
						actualizarVentanaAdministracion();
	                } else {
	                	$("[name=btnCrearFalta]").attr('disabled',false);
	            		$("[name=btnCrearCancelarFalta]").attr('disabled',false);
	                    $("#dmMensajeFalta").html('Error desconocido.');					
	                }            		 
	            }
	        });
	}
	
	
	function crearTipoDeFalta(){
		$("#dmNuevoTipoFalta").dialog("close");
		visualizarCrearTipoFalta();
	}
		
	/**
	 * Permite visualizar la ventana para crear un tipo de falta. 
	 */
	function visualizarCrearTipoFalta(){
		$("#dmNuevoTipoFalta").dialog("open"); 
		$.ajax({
			cache: false,
			contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
	        type: 'POST',
	        url: "${ctx}/page/administracion?action=crearTipoDeFalta",
	        dataType: "text",
	        error: function(jqXHR, textStatus, errorThrown) {
	            alert(jqXHR.statusText);
	        },
	        success: function(data) {
	           	$("#dmNuevoTipoFalta").html(data);     
	        }
	    });
	}
	
	
	
	/**
	 * Ventana para subir un nuevo formato.
	 */
	function verCrearFormatoFalta(){
		
		$("#dmNuevoFormatoFalta").dialog("open");
		$("#dmNuevoFormatoFalta").html(getHTMLLoaging30());
		$.ajax({
			cache: false,
			contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
	        type: 'POST',
	        url: "${ctx}/page/administracion?action=verCargarNuevoFormato",
	        dataType: "text",
	        error: function(jqXHR, textStatus, errorThrown) {
	            alert(jqXHR.statusText);
	        },
	        success: function(data) {		                    	                    	
	           	$("#dmNuevoFormatoFalta").html(data);     
	        }
	    });
	}
	
	
	function validarEntero(valor){ 
    	valor = parseInt(valor);
     	if (isNaN(valor)) { 
           	 return false;
     	}else{
     		return true;
     	} 
	}
	
	
	
</script>


<div align="left">

<div>
</div>

<form name="fCrearFalta" id="fCrearFalta" action="${ctx}/page/administracion" method="post">

<input type="hidden" name="action" value="insertarFalta"/>
<input type="hidden" name="tiposFalta" value="${tiposFalta}"/>
<input type="hidden" name="faltas" value="${faltas}"/>

<div>
	<button type="button" id="btnCrearCancelarFalta" name="btnCrearCancelarFalta" onclick="$('#dmNuevaFalta').dialog('close');">Cancelar</button>
	&nbsp;&nbsp;&nbsp;
	<button type="submit" id="btnCrearFalta" name="btnCrearFalta">Registrar Falta</button>
</div>
<br/>
<!-- Para datos del proceso -->
<fieldset>
	<legend class="e6">Nueva Falta</legend>
	
	<!-- Tabla del formulario -->
	<table border="0" width="100%" class="caja">
	<col style="width: 15%"/>
	<col/>
		<tr>
		
		<!-- Listado de Tipos de Faltas. -->
		<tr>
			<th nowrap="nowrap" style="text-align: right;">Tipo de Falta:</th>
			<td>
				<select name="idTipoFaltaSeleccionada">
					<option value=""></option>
					<c:forEach items="${tiposFalta}" var="tipoFalta" varStatus="loop">
						<option  value="${tipoFalta.idfaltatipo}">
							<c:out value="${tipoFalta.nombrefaltatipo}"/>
						</option>
					</c:forEach>
				</select>
				&nbsp;
<!-- 				<form id="idformAgregarTipoDeFalta" name="idformAgregarTipoDeFalta"> -->
					<button type="button" id="btnCrearTipoFalta" name="btnCrearTipoFalta" onclick="crearTipoDeFalta();">Agregar tipo</button>
<!-- 				</form> -->
				
			</td>
		</tr>
		
		<!-- Falta -->
		<tr>
			<th nowrap="nowrap" style="text-align: right;">Falta :</th>
			<td>
				<textarea id="falta" name="falta" rows="5" cols="99%"></textarea>
			</td>
		</tr>
		
		<!-- Sanción  -->
		<tr>
			<th nowrap="nowrap" style="text-align: right;">Sanción:</th>
			<td>
				<textarea id="sancionDeFalta" name="sancionDeFalta" rows="5" cols="99%"></textarea>
			</td>
		</tr>
		
		<!-- Recurrencia:  -->
		<tr>
			<th nowrap="nowrap" style="text-align: right;">Recurrencia:</th>
			<td>
				<select name="recurrenciaSeleccionada">
				  <option value=""></option> 
				  <option value="1">Primera vez</option>
				  <option value="2">Segunda vez</option>
				  <option value="3">Tercera vez</option>
				  <option value="4">Cuarta vez</option>
				  <option value="5">Quinta vez</option>
				</select>
			</td>
		</tr>
		
		<!-- Procedimiento  -->
		<tr>
			<th nowrap="nowrap" style="text-align: right;">Procedimiento:</th>
			<td>
				<textarea id="procedimientoDeFalta" name="procedimientoDeFalta" rows="5" cols="99%"></textarea>
			</td>
		</tr>
		
		<!-- Responsable:  -->
		<tr>
			<th nowrap="nowrap" style="text-align: right;">Responsable:</th>
			<td>
				<select name="responsableSeleccionado">
				  <option value=""></option> 
				  <option value="Director de Talento Humano">Director de Talento Humano</option>
				  <option value="Gerente de area y/o Director">Gerente de area y/o Director</option>
				  <option value="Lider y/o Coordinador">Lider y/o Coordinador</option>
				</select>
			</td>
		</tr>
		
		<!-- Formatos asociados a esta falta. -->
		<tr>
			<th nowrap="nowrap" style="text-align: right;">Asociar a los formatos:</th>
			<td>
				<select name="nameFormatosSeleccionados"  id="idFormatosSeleccionados"   multiple="multiple" size="5">
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


<!-- <!-- Formatos Asociados --> 
<!-- <fieldset> -->
<!-- 	<legend class="e6">Formatos</legend> -->
<!-- 	<table border="0" width="100%" class="caja"> -->
<!-- 			<col style="width: 15%"/> -->
<!-- 			<col/> -->
<!-- 			<!-- Archivo(s) a subir --> 
<!-- 			<tr> -->
<!-- 			<tr> -->
<!-- 				<th nowrap="nowrap" style="text-align: right;">Archivo(s) : -->
<!-- 				<div class="texto1">Todo tipo de archivos tam max:20MB</div>  -->
<!-- 				</th> -->
<!-- 				<td> -->
<!-- 				Archivo Uno -->
<!-- 					<input type="file" name="formatoUno" id="formatoUno" style="max-width: 100%" onchange="validarArchivo(this.id);"/> -->
<!-- 					<select id="idtipoformatoUno" name="idtipoformatoUno"> -->
<!-- 						<option value=""></option> -->
<%-- 						<c:forEach items="${formatos}" var="tipoFormatoUno" varStatus="loop"> --%>
<%-- 							<option value="${tipoFormatoUno.iddisciplinaarchivotipo}"> --%>
<%-- 								<c:out value="${tipoFormatoUno.nombretipoarchivo}"/> --%>
<!-- 							</option> -->
<%-- 						</c:forEach> --%>
<!-- 					</select> -->
					
<!-- 					Archivo Dos -->
<!-- 					<input type="file" name="formatoDos" id="formatoDos" style="max-width: 100%" onchange="validarArchivo(this.id);"/> -->
<!-- 					<select id="idtipoformatoDos" name="idtipoformatoDos"> -->
<!-- 						<option value=""></option> -->
<%-- 						<c:forEach items="${formatos}" var="tipoFormatoDos" varStatus="loop"> --%>
<%-- 							<option value="${tipoFormatoDos.iddisciplinaarchivotipo}"> --%>
<%-- 								<c:out value="${tipoFormatoDos.nombretipoarchivo}"/> --%>
<!-- 							</option> -->
<%-- 						</c:forEach> --%>
<!-- 					</select> -->
					
<!-- 					Archivo Tres -->
<!-- 					<input type="file" name="formatoTres" id="formatoTres" style="max-width: 100%" onchange="validarArchivo(this.id);"/> -->
<!-- 					<select id="idtipoformatoTres" name="idtipoformatoTres"> -->
<!-- 						<option value=""></option> -->
<%-- 						<c:forEach items="${formatos}" var="tipoFormatoTres" varStatus="loop"> --%>
<%-- 							<option value="${tipoFormatoTres.iddisciplinaarchivotipo}"> --%>
<%-- 								<c:out value="${tipoFormatoTres.nombretipoarchivo}"/> --%>
<!-- 							</option> -->
<%-- 						</c:forEach> --%>
<!-- 					</select> -->
					
<!-- 					Archivo Cuatro -->
<!-- 					<input type="file" name="formatoCuatro" id="formatoCuatro" style="max-width: 100%" onchange="validarArchivo(this.id);"/> -->
<!-- 					<select id="idtipoformatoCuatro" name="idtipoformatoCuatro"> -->
<!-- 						<option value=""></option> -->
<%-- 						<c:forEach items="${formatos}" var="tipoFormatoCuatro" varStatus="loop"> --%>
<%-- 							<option value="${tipoFormatoCuatro.iddisciplinaarchivotipo}"> --%>
<%-- 								<c:out value="${tipoFormatoCuatro.nombretipoarchivo}"/> --%>
<!-- 							</option> -->
<%-- 						</c:forEach> --%>
<!-- 					</select> -->
					
<!-- 					Archivo Cinco -->
<!-- 					<input type="file" name="formatoCinco" id="formatoCinco" style="max-width: 100%" onchange="validarArchivo(this.id);"/> -->
<!-- 					<select id="idtipoformatoCinco" name="idtipoformatoCinco"> -->
<!-- 						<option value=""></option> -->
<%-- 						<c:forEach items="${formatos}" var="tipoFormatoCinco" varStatus="loop"> --%>
<%-- 							<option value="${tipoFormatoCinco.iddisciplinaarchivotipo}"> --%>
<%-- 								<c:out value="${tipoFormatoCinco.nombretipoarchivo}"/> --%>
<!-- 							</option> -->
<%-- 						</c:forEach> --%>
<!-- 					</select> -->
					
<!-- 				</td> -->
<!-- 			</tr> -->
		
<!-- 		</table> -->
<!-- </fieldset> -->

<div>
<button type="button" id="btnCrearCancelarFalta" name="btnCrearCancelarFalta" onclick="$('#dmNuevaFalta').dialog('close');">Cancelar</button>
&nbsp;&nbsp;&nbsp;
<button type="submit" id="btnCrearFalta" name="btnCrearFalta">Registrar Falta</button></div>
</form>

</div>
<div style="padding: 30px 0px;"></div>
<div id="dmMensajeFormatoFalta" title="Mensaje"></div>
<div id="dmNuevoFormatoFalta" title="Nuevo Formato"></div>