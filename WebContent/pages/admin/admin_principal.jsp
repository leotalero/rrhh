<%@ include file="/taglibs.jsp"%>


<script type="text/javascript">


	$(document).ready(function() {
	
		//Buttons
		$("[name=btnBuscar]").button();
		$("[name=btnBuscarFaltas]").button();
		$("[name=btnNuevo]").button();
		$("[name=btnNuevaFalta]").button();
		$("[name=btnNuevaSancion]").button();
		$("[name=btnBuscarFormatos]").button();
		$("[name=btnNuevoFormato]").button();
		
		$("#dmMensajeArea").dialog({   				
			width: 400,
			height: 200,   				
			modal: true,
			autoOpen: false,
			resizable: true
		});
		
		$("#dmMensajeFalta").dialog({   				
			width: 400,
			height: 200,   				
			modal: true,
			autoOpen: false,
			resizable: true
		});
		
		$("#dmMensajeSancion").dialog({   				
			width: 400,
			height: 200,   				
			modal: true,
			autoOpen: false,
			resizable: true
		});
		
		$("#dmMensajeFormatoFalta").dialog({   				
			width: 400,
			height: 200,   				
			modal: true,
			autoOpen: false,
			resizable: true
		});
		
		$("#dmNuevo").dialog({   				
			width: 800,
			height: 400,   				
			modal: true,
			autoOpen: false,
			resizable: true
		});
		
		$("#dmNuevoTipoFalta").dialog({   				
			width: 400,
			height: 250,   				
			modal: true,
			autoOpen: false,
			resizable: true
		});
		
		$("#dmNuevaFalta").dialog({   				
			width: 800,
			height: 650,   				
			modal: true,
			autoOpen: false,
			resizable: true
		});
		
		$("#dmNuevaSancion").dialog({   				
			width: 800,
			height: 580,   				
			modal: true,
			autoOpen: false,
			resizable: true
		});
		
	
		$("#dmMensajeHorario").dialog({   				
			width: 400,
			height: 200,   				
			modal: true,
			autoOpen: false,
			resizable: true
		});
		
		
		//Ventanas
		$("#dmNuevoFormatoFalta").dialog({   				
			width: 700,
			height: 320,   				
			modal: true,
			autoOpen: false,
			resizable: true
		});
		
		$("#btnNuevo").click(function(){
			$("#dmNuevo").dialog("open");
			$("#dmNuevo").html(getHTMLLoaging30());
			$.ajax({
				cache: false,
				contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
	            type: 'POST',	            
	            url: "${ctx}/page/administracion?action=nuevo_asociacion",
	            dataType: "text",
	            error: function(jqXHR, textStatus, errorThrown) {
	                alert(jqXHR.statusText);
		        },
	            success: function(data) {		                    	                    	
	               	$("#dmNuevo").html(data);     
	            }
	        });
		});
		
		// Crear una nueva falta
		$("#btnNuevaFalta").click(function(){
			$("#dmNuevaFalta").dialog("open");
			$("#dmNuevaFalta").html(getHTMLLoaging30());
			$.ajax({
				cache: false,
				contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
	            type: 'POST',	            
	            url: "${ctx}/page/administracion?action=nuevaFalta",
	            dataType: "text",
	            error: function(jqXHR, textStatus, errorThrown) {
	                alert(jqXHR.statusText);
		        },
	            success: function(data) {		                    	                    	
	               	$("#dmNuevaFalta").html(data);     
	            }
	        });
		});
		
		// Crear una nueva Sanción
		$("#btnNuevaSancion").click(function(){
			$("#dmNuevaSancion").dialog("open");
			$("#dmNuevaSancion").html(getHTMLLoaging30());
			$.ajax({
				cache: false,
				contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
	            type: 'POST',	            
	            url: "${ctx}/page/administracion?action=nuevaSancion",
	            dataType: "text",
	            error: function(jqXHR, textStatus, errorThrown) {
	                alert(jqXHR.statusText);
		        },
	            success: function(data) {		                    	                    	
	               	$("#dmNuevaSancion").html(data);     
	            }
	        });
		});
		
		// Crear un nuevo formato
		$("#btnNuevoFormato").click(function(){
			$("#dmNuevoFormatoFalta").dialog("open");
			$("#dmNuevoFormatoFalta").html(getHTMLLoaging30());
			$.ajax({
				cache: false,
				contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
	            type: 'POST',	            
	            url: "${ctx}/page/administracion?action=nuevoFormato",
	            dataType: "text",
	            error: function(jqXHR, textStatus, errorThrown) {
	                alert(jqXHR.statusText);
		        },
	            success: function(data) {		                    	                    	
	               	$("#dmNuevoFormatoFalta").html(data);     
	            }
	        });
		});
		
		
		$("#fAdmininPrincipal").validate({
			//errorLabelContainer: "#msnBuscarCargue",
			errorClass: "invalid",
			rules: {
				idareaAsignada: {
					required: true,
					min:1
				},
				idcargoAsociado: {
					required: true,
					min:1
				},
			},
			messages: {
				
				idareaAsignada: {
					required: "Seleccione un Area",
					
					
				},
				idcargoAsociado: {
					required: "Seleccione un cargo ",
					
				}
			},
			submitHandler: function(form) {
		
				busquedaAreas(form);
			}
			
			
		});

		//Validar Formulario de busqueda de faltas.
		$("#fAdminFaltas").validate({
			errorClass: "invalid",
			rules: {
				idTiposFalta: {
					required: true,
					min:1
				}
			},
			messages: {
				idTiposFalta: {
					required: "Seleccione un tipo de Falta.",
				}
			},
			submitHandler: function(form) {
				
				var tiposFaltaSeleccionados = $('#idTiposFalta').val();
				if(tiposFaltaSeleccionados!=null){
					buscarFaltas(form);	
				}else{
					alert('Para buscar, Seleccione al menos un tipo de falta.');
				}
				
			}
			
			
		});
		
		//Validar y enviar formulario de formatos.
		$("#fAdminFormatos").validate({
			errorClass: "invalid",
			rules: {
				idTiposFormatos: {
					required: true,
					min:1
				}
			},
			messages: {
				idTiposFormatos: {
					required: "Seleccione al menos un (1) formato.",
				}
			},
			submitHandler: function(form) {
				var formatosSeleccionados = $('#idTiposFormatos').val();
				if(formatosSeleccionados!=null){
					buscarFormatos(form);	
				}else{
					alert('Para buscar, Seleccione al menos un (1) formato.');
				}
			}
		});
	
		
		$("#fAdmininPrincipal [name=idcargoAsociado]").multiselect({
		    /*header: true,*/
		    height: 175,
		    minWidth: 225,
		    //classes: '',
		    checkAllText: 'Marcar todos',
		   uncheckAllText: 'Desmarcar todos',
		    noneSelectedText: 'Seleccionar Cargo',
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

		//Configuración de la lista de los tipos de falta.
		$("#fAdminFaltas [name=idTiposFalta]").multiselect({
		    /*header: true,*/
		    height: 175,
		    minWidth: 225,
		    //classes: '',
		    checkAllText: 'Marcar todos',
		   	uncheckAllText: 'Desmarcar todos',
		    noneSelectedText: 'Seleccionar Tipo de Falta',
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
		
		
		//Configuración de la lista de formatos.
		$("#fAdminFormatos [name=idTiposFormatos]").multiselect({
		    /*header: true,*/
		    height: 175,
		    minWidth: 225,
		    //classes: '',
		    checkAllText: 'Marcar todos',
		   	uncheckAllText: 'Desmarcar todos',
		    noneSelectedText: 'Seleccionar Formato',
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
		
		
		$("#fAdmininPrincipal [name=idareaAsignada]").multiselect({
		    /*header: true,*/
		    height: 175,
		    minWidth: 225,
		   // classes: '',
		    checkAllText: 'Marcar todos',
		    uncheckAllText: 'Desmarcar todos',
		    noneSelectedText: 'Seleccionar Area',
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
		
		
		
	});
	
	
	
	function busquedaAreas(form) {
		
		$("#dmBusquedaListadoAreas").dialog("open");  
		$("#dmBusquedaListadoAreas").html(getHTMLLoaging16('Buscando'));
		$.ajax({
			cache: false,
			contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
            type: $(form).attr('method'),            
            url: $(form).attr('action'),
            data: $(form).serialize(),
            dataType: "text",
            error: function(jqXHR, textStatus, errorThrown) {
            	 alert(jqXHR.statusText);
	        },
            success: function(data) {    
           		$("#dmBusquedaListadoAreas").html(data);
             }
        });
	}

/*
 * Método para hacer la petición de buscar las faltas.
 */
function buscarFaltas(form) {
		$("#dmBusquedaListadoAreas").dialog("open");  
		$("#dmBusquedaListadoAreas").html(getHTMLLoaging16('Buscando Faltas...'));
		$.ajax({
			cache: false,
			contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
            type: $(form).attr('method'),            
            url: $(form).attr('action'),
            data: $(form).serialize(),
            dataType: "text",
            error: function(jqXHR, textStatus, errorThrown) {
            	 alert(jqXHR.statusText);
	        },
            success: function(data) {    
           		$("#dmBusquedaListadoAreas").html(data);
             }
        });
}

/*
 * Método para solicitar la busqueda de Formatos.
 */
function buscarFormatos(form) {
		$("#dmBusquedaListadoAreas").dialog("open");  
		$("#dmBusquedaListadoAreas").html(getHTMLLoaging16('Buscando Formatos...'));
		$.ajax({
			cache: false,
			contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
            type: $(form).attr('method'),            
            url: $(form).attr('action'),
            data: $(form).serialize(),
            dataType: "text",
            error: function(jqXHR, textStatus, errorThrown) {
            	 alert(jqXHR.statusText);
	        },
            success: function(data) {    
           		$("#dmBusquedaListadoAreas").html(data);
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
	
function deshabilitarArea(idcargo,idareaasignada,idarea) {		
		
		if(idcargo=='' || idarea=='' ){
			
		}else{
			
			if(confirm('¿Esta seguro de deshabilitar el area asociada ?')){
				
				$("#dmMensajeArea").dialog("open");
				$("#dmMensajeArea").html(getHTMLLoaging16(' Eliminando'));
				$.ajax({
					cache: false,
					contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
		            type: 'post',            
		            url: "${ctx}/page/administracion?action=area_deshabilitar&idcargo="+idcargo+"&idareaasignada="+idareaasignada+"&idarea="+idarea,
		            data: '',
		            dataType: "text",
		            error: function(jqXHR, textStatus, errorThrown) {
		            	      		
		                $("#dmMensajeArea").html(jqXHR.statusText);
			        },
		            success: function(data) {
		            	if(validarEntero(data)){
		            	
		                	$("#dmMensajeArea").dialog("close");
		                	busquedaAreas("#fAdmininPrincipal");
		                } else {
		                	
		                    $("#dmMensajeArea").html('Error desconocido');					
		                }
		            }
		        });	 
			}
		}
	}	

// deshabilitarFalta
function deshabilitarFalta(idsancion,idFalta) {	
		if(idsancion==''){
		}else{
			
			if(confirm('¿ Está seguro de deshabilitar la falta seleccionada ?')){
				
				$("#dmMensajeFalta").dialog("open");
				$("#dmMensajeFalta").html(getHTMLLoaging16(' Eliminando '));
				$.ajax({
					cache: false,
					contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
		            type: 'post',            
		            url: "${ctx}/page/administracion?action=deshabilitarSancion&idSancion="+idsancion+"&idFalta="+idFalta,
		            data: '',
		            dataType: "text",
		            error: function(jqXHR, textStatus, errorThrown) {
		                $("#dmMensajeFalta").html(jqXHR.statusText);
			        },
		            success: function(data) {
		            	if(validarEntero(data)){
		                	$("#dmMensajeFalta").dialog("close");
		                	buscarFaltas("#fAdminFaltas");
		                } else {
		                    $("#dmMensajeFalta").html('Error desconocido');					
		                }
		            }
		        });	 
			}
		}
}	


/**
 * Método para deshabilitar un Formato.
 */
function deshabilitarFormato(idFormato) {	
		if(idFormato==''){
		}else{
			
			if(confirm('¿ Está seguro de deshabilitar el formato seleccionado ?')){
				
				$("#dmMensajeFormatoFalta").dialog("open");
				$("#dmMensajeFormatoFalta").html(getHTMLLoaging16(' Eliminando '));
				$.ajax({
					cache: false,
					contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
		            type: 'post',            
		            url: "${ctx}/page/administracion?action=deshabilitarFormato&idFormato="+idFormato,
		            data: '',
		            dataType: "text",
		            error: function(jqXHR, textStatus, errorThrown) {
		                $("#dmMensajeFormatoFalta").html(jqXHR.statusText);
			        },
		            success: function(data) {
		            	if(validarEntero(data)){
		                	$("#dmMensajeFormatoFalta").dialog("close");
		                	buscarFormatos("#fAdminFormatos");
		                } else {
		                    $("#dmMensajeFormatoFalta").html('Error desconocido');					
		                }
		            }
		        });	 
			}
		}
}	


/**
 * Método para habilitar un Formato.
 */
function habilitarFormato(idFormato) {	
		if(idFormato==''){
		}else{
			
			if(confirm('¿ Está seguro de habilitar el formato seleccionado ?')){
				
				$("#dmMensajeFormatoFalta").dialog("open");
				$("#dmMensajeFormatoFalta").html(getHTMLLoaging16(' Eliminando '));
				$.ajax({
					cache: false,
					contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
		            type: 'post',            
		            url: "${ctx}/page/administracion?action=habilitarFormato&idFormato="+idFormato,
		            data: '',
		            dataType: "text",
		            error: function(jqXHR, textStatus, errorThrown) {
		                $("#dmMensajeFormatoFalta").html(jqXHR.statusText);
			        },
		            success: function(data) {
		            	if(validarEntero(data)){
		                	$("#dmMensajeFormatoFalta").dialog("close");
		                	buscarFormatos("#fAdminFormatos");
		                } else {
		                    $("#dmMensajeFormatoFalta").html('Error desconocido');					
		                }
		            }
		        });	 
			}
		}
}


//habilitarFalta
function habilitarFalta(idsancion,idFalta) {	
		if(idsancion==''){
		}else{
			
			if(confirm('¿ Está seguro de habilitar la falta seleccionada ?')){
				
				$("#dmMensajeFalta").dialog("open");
				$("#dmMensajeFalta").html(getHTMLLoaging16(' Activando '));
				$.ajax({
					cache: false,
					contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
		            type: 'post',            
		            url: "${ctx}/page/administracion?action=habilitarSancion&idSancion="+idsancion+"&idFalta="+idFalta,
		            data: '',
		            dataType: "text",
		            error: function(jqXHR, textStatus, errorThrown) {
		                $("#dmMensajeFalta").html(jqXHR.statusText);
			        },
		            success: function(data) {
		            	if(validarEntero(data)){
		                	$("#dmMensajeFalta").dialog("close");
		                	buscarFaltas("#fAdminFaltas");
		                } else {
		                    $("#dmMensajeFalta").html('Error desconocido');					
		                }
		            }
		        });	 
			}
		}
}	

	
	function crearAreaAsociada(form) {
		//alert("va");
		$("[name=btnCrear]").attr('disabled',true);;
		
		$("#dmMensajeArea").dialog("open");
		$("#dmMensajeArea").html(getHTMLLoaging16(' Creando'));
		$.ajax({
			cache: false,
			contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
	        type: $(form).attr('method'),            
	        url: $(form).attr('action'),
	        data: $(form).serialize(),
	        dataType: "text",
	        error: function(jqXHR, textStatus, errorThrown) {
	        	$("[name=btnCrearEmpleado]").attr('disabled',false);
	    		$("[name=btnCrearCancelarEmpleado]").attr('disabled',false);
	            $("#dmMensajeArea").html(jqXHR.statusText);
	        },
	        success: function(data) {  
	        	//alert("regresa");
	        	if(validarEntero(data)){
	        		$("#dmMensajeArea").dialog("close");
	            	$("#dmNuevo").dialog("close");
	            	busquedaAreas('#fAdmininPrincipal');
	            } else {
	            	$("[name=btnCrear]").attr('disabled',false);
	        		
	                $("#dmMensajeArea").html('Error desconocido');					
	            }            		 
	        }
	    });
	}
	
	
	/**
	 * Este método actualiza la pestaña de administración.
	 */
	function actualizarVentanaAdministracion(){
		$("#dmAdmin").html(getHTMLLoaging30());
		$.ajax({
			cache: false,
			contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
	        type: 'POST',
	        url: "${ctx}/page/administracion?action=administracion_principal",
	        dataType: "text",
	        error: function(jqXHR, textStatus, errorThrown) {
	            alert(jqXHR.statusText);
	        },
	        success: function(data) {
	        	$("#dmAdmin").html(data);
	        }
	    });
		
	}
	
</script>
<div align="left" id="dmAdmin">

<input type="hidden" name="idempleado" value="${empleado.idempleado}"/>
<input type="hidden" name="idcontrato" value="${contrato.idcontrato}"/>
<input type="hidden" name="idhorarioasignado" value="${horarioasignado.idhorarioasignado}"/>

<br/>
<table cellspacing="2"  width="100%" border="0" cellpadding="2">
	<col />
	<col style="width: 5px;"/>
	<col style="width: 200px;"/>
<tr  valign="middle">
	<td class="td3">
	
<form name="fAdmininPrincipal" id="fAdmininPrincipal" action="${ctx}/page/administracion" method="post">
<input type="hidden" name="action" value="buscar_areas_asociadas"/>

<fieldset>
<legend class="e6">Administración de áreas asociadas</legend>

	<table border="0" width="100%" class="caja">
	<col style="width:30%"/>
	<col/>
	
	
	
	<tr>
	<th>Cargo:</th>
	<th>Area Asignada:</th>

	<th>Buscar</th>

	
	</tr>
	<tbody>
	<tr>
	<td>
			<select name="idcargoAsociado"  id="idcargoAsociado"   multiple="multiple" size="5">
				<c:forEach items="${cargos}" var="cargo" varStatus="loop">
				<option  value="${cargo.idcargo}"><c:out value="${cargo.nombrecargo}"/></option>
				</c:forEach>
			</select>
	</td>
	<td>
			<select name="idareaAsignada"  id="idareaAsignada"   multiple="multiple" size="5">
				<c:forEach items="${areas}" var="area" varStatus="loop">
				<option  value="${area.idarea}"><c:out value="${area.nombrearea}"/></option>
				</c:forEach>
			</select>
			
	</td>
	
		
	<td align="center"><button type="submit"  id="btnBuscar" name="btnBuscar">Buscar</button> </td>
	</tbody>
	
	
	
	
	</table>
	</form>
	
	</td>
       <td></td>
		<td valign="middle" align="center" class="td3">
		 	<button type="submit"  id="btnNuevo" name="btnNuevo">Nuevo</button>
		</td>
	<td align="center"></td>
	</tr>
	
		

	</table>
	
</fieldset>

<!------------------------------------------------------------------>
<!-- ADMINISTRACIÓN DE FALTAS Y SANCIONES (PROCESO DISCIPLINARIO) -->
<!------------------------------------------------------------------>
<c:if test="${sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 1}">
<br/>
<table cellspacing="2"  width="100%" border="0" cellpadding="2">
	<col />
	<col style="width: 5px;"/>
	<col style="width: 200px;"/>
<tr  valign="middle">
	<td class="td3">
	
<form name="fAdminFaltas" id="fAdminFaltas" action="${ctx}/page/administracion" method="post">
<input type="hidden" name="action" value="buscarFaltas"/>

<fieldset>
<legend class="e6">Administración de Faltas</legend>

	<table border="0" width="100%" class="caja">
	<col style="width:30%"/>
	<col/>
	
	<tr> 
		<th>Tipo de Falta:</th>
		<th>Buscar</th>
	</tr>
	
	<tbody>
		<tr>
		<td>
			<select name="idTiposFalta"  id="idTiposFalta"   multiple="multiple" size="5">
					<c:forEach items="${listaTiposFalta}" var="faltaTipo" varStatus="loop">
						<option  value="${faltaTipo.idfaltatipo}"><c:out value="${faltaTipo.nombrefaltatipo}"/></option>
					</c:forEach>
			</select>
		</td>
		
		<td align="center"><button type="submit"  id="btnBuscarFaltas" name="btnBuscarFaltas">Buscar</button> </td>
	</tbody>
	
	</table>
	</form>
	
	</td>
       <td></td>
		<td valign="middle" align="center" class="td3">
		 	<button type="submit"  id="btnNuevaFalta" name="btnNuevaFalta">Nueva Falta</button>&nbsp;
		 	<button type="submit"  id="btnNuevaSancion" name="btnNuevaSancion">Nueva Sanción</button>
		</td>
	<td align="center"></td>
	</tr>
	
		

	</table>
	
</fieldset>

<!-------------------------------------------->
<!--  	ADMINISTRACIÓN DE FORMATOS          -->
<!--------------------------------------------> 
<br/>
<table cellspacing="2"  width="100%" border="0" cellpadding="2">
	<col />
	<col style="width: 5px;"/>
	<col style="width: 200px;"/>
<tr  valign="middle">
	<td class="td3">
	
<form name="fAdminFormatos" id="fAdminFormatos" action="${ctx}/page/administracion" method="post">
<input type="hidden" name="action" value="buscarFormatos"/>

<fieldset>
<legend class="e6">Administración de Formatos</legend>

	<table border="0" width="100%" class="caja">
	<col style="width:30%"/>
	<col/>
	
	<tr>
		<th>Lista de Formatos</th>
		<th>Buscar</th>
	</tr>
	
	<tbody>
		<tr>
		<td>
			<select name="idTiposFormatos"  id="idTiposFormatos"   multiple="multiple" size="5">
					<c:forEach items="${listaFormatos}" var="formato" varStatus="loop">
						<option  value="${formato.idformato}"><c:out value="${formato.nombreformato}"/></option>
					</c:forEach>
			</select>
		</td>
		
		<td align="center">
			<button type="submit"  id="btnBuscarFormatos" name="btnBuscarFormatos">Buscar</button> 
		</td>
	</tbody>
	
	</table>
	</form>
	
	</td>
       <td></td>
		<td valign="middle" align="center" class="td3">
		 	<button type="submit"  id="btnNuevoFormato" name="btnNuevoFormato">Nuevo</button>
		</td>
	<td align="center"></td>
	</tr>
	
	</table>
	
</fieldset>
</c:if>

<div id="dmBusquedaListadoAreas" title="Reporte"></div>
<div id="dmMensajeHorario" title="Mensaje"></div>
<div id="dmNuevo" title="Nueva asociación"></div>
<div id="dmNuevoTipoFalta" title="Nuevo Tipo Falta"></div>
<div id="dmNuevaFalta" title="Nueva Falta"></div>
<div id="dmNuevaSancion" title="Nueva Sanción"></div>
<div id="dmMensajeArea" title="Mensaje"></div>
<div id="dmMensajeFalta" title="Mensaje Falta"></div>
<div id="dmMensajeSancion" title="Mensaje Sanción"></div>
<div id="dmMensajeFormatoFalta" title="Mensaje"></div>
<div id="dmNuevoFormatoFalta" title="Nuevo Formato"></div>
<div style="padding: 30px 0px;"></div>

<br/>
<br/>



</div>