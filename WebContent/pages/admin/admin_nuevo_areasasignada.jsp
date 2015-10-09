<%@ include file="/taglibs.jsp"%>


<script type="text/javascript">

	
$(document).ready(function() {
	
		
		$("#dmMensajeArea").dialog({   				
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
		
		
	
		$("#dmMensajeHorario").dialog({   				
			width: 400,
			height: 200,   				
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
		
		
		
		$("[name=btnCrear]").button();	
		
		$("[name=btnNuevo]").button();

	
		
		$("#fAdmininNuevo").validate({
			//errorLabelContainer: "#msnBuscarCargue",
			errorClass: "invalid",
			rules: {
				idareaAsignadaNuevo: {
					required: true,
					min:1
				},
				idcargoAsociadoNuevo: {
					required: true,
					min:1
				},
			},
			messages: {
				
				idareaAsignadaNuevo: {
					required: "Seleccione un Area",
					
					
				},
				idcargoAsociadoNuevo: {
					required: "Seleccione un cargo ",
					
				}
			},
			submitHandler: function(form) {
		
				crearAreaAsociada(form);
				
				
			}
			
			
		});

	

		
	
		$("#fAdmininNuevo [name=idcargoAsociadoNuevo]").multiselect({
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
		    multiple: false,
		    position: {},
		    appendTo: "body",
		   


		}).multiselectfilter({                         
		     label: 'Filtro:&nbsp;',               
		  placeholder: '',
		  autoReset: false
		});

		
		$("#fAdmininNuevo [name=idareaAsignadaNuevo]").multiselect({
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
		    multiple: false,
		    position: {},
		    appendTo: "body",
		   


		}).multiselectfilter({                         
		     label: 'Filtro:&nbsp;',               
		  placeholder: '',
		  autoReset: false
		});
		
		

		$("#fAdmininNuevo [name=idareaMostrarNuevo]").multiselect({
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
	
	
	
</script>
<div align="left">

<div>
</div>

<form name="fAdmininNuevo" id="fAdmininNuevo" action="${ctx}/page/administracion" method="post">
<input type="hidden" name="action" value="grabar_areas_asociadas"/>
<fieldset><legend class="e6">Administración de áreas asociadas</legend>

	<table border="0" width="100%" class="caja">
	<col style="width:30%"/>
	<col/>
	
	
	
	<tr>
	<th>Cargo:</th>
	<th>Area asignada:</th>
	<th>Area mostrar:</th>

	<th>Grabar</th>

	
	</tr>
	<tbody>
	<tr>
	<td>
	<select name="idcargoAsociadoNuevo"  id="idcargoAsociadoNuevo"   multiple="multiple" size="5">
			
			<c:forEach items="${cargos}" var="cargo" varStatus="loop">
			<option  value="${cargo.idcargo}"><c:out value="${cargo.nombrecargo}"/></option>
			</c:forEach>
			</select>
			
	</td>
	<td>
	<select name="idareaAsignadaNuevo"  id="idareaAsignadaNuevo"   multiple="multiple" size="5">
			
			<c:forEach items="${areas}" var="area" varStatus="loop">
			<option  value="${area.idarea}"><c:out value="${area.nombrearea}"/></option>
			</c:forEach>
			</select>
			
	</td>
	
	<td>
	<select name="idareaMostrarNuevo"  id="idareaMostrarNuevo"   multiple="multiple" size="5">
			
			<c:forEach items="${areas}" var="area" varStatus="loop">
			<option  value="${area.idarea}"><c:out value="${area.nombrearea}"/></option>
			</c:forEach>
			</select>
			
	</td>	
	<td align="center"><button type="submit"  id="btnCrear" name="btnCrear">Grabar</button> </td>
	</tbody>
	
	
	
	
	</table>
	</form>

</div>
<div style="padding: 30px 0px;"></div>