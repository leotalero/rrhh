<%@ include file="/taglibs.jsp"%>
<script type="text/javascript">
	
	
	$(document).ready(function() {
		$("#btnBuscarCertificado").button();
		
		$("#dmMensajeCertificado").dialog({   				
			width: 400,
			height: 200,   				
			modal: true,
			autoOpen: false,
			resizable: true
		});
		
		$("#fBuscarUsuarioC").validate({
			errorLabelContainer: "#msnBuscarEmpleadoC",
			errorClass: "invalid",
			rules: {
				tipobusqueda:{
					required: true
				},				
				from:{
					required: function(element){ return $("#tipobusquedausuario").val() == 1;} 
				},
				to:{
					required: function(element){ return $("#tipobusquedausuario").val() == 1;} 
				},
				nombreC:{
					required: function(element){ return $("#tipobusquedausuario").val() == 2;} 
				},
				numidentificacionC:{
					required: function(element){ return $("#tipobusquedausuario").val() == 3;}, 
					digits: function(element){ return $("#tipobusquedausuario").val() == 3;}
				},
				usuario:{
					required: function(element){ return $("#tipobusquedausuario").val() == 4;} 
				},
				codusuarioC:{
					required: function(element){ return $("#tipobusquedausuario").val() == 5;} 
				},
				idaplicacion:{
					required: function(element){ return $("#tipobusquedausuario").val() == 6;} 
				},
				idgrupo:{
					required: function(element){ return $("#tipobusquedausuario").val() == 7;} 
				},
				idcuenta:{
					required: function(element){ return $("#tipobusquedausuario").val() == 8;} 
				}
			},
			messages: {
				tipobusqueda: {
					required: "Selecione un tipo de búsqueda."
				},				
				from: {
					required: "Seleccione una fecha válida."
				},
				to: {
					required: "Seleccione una fecha válida."
				},
				nombreC:{
					required: "Ingrese un valor." 
				},
				numidentificacionC:{
					required: "Ingrese un valor.",
					digits: "Ingrese solo dígitos"
				},
				usuario:{
					required: "Ingrese un valor." 
				},
				codusuarioC:{
					required: "Ingrese un valor."
				},
				idaplicacion:{
					required: "Ingrese un valor." 
				},
				idgrupo:{
					required: "Ingrese un valor." 
				},
				idcuenta:{
					required: "Ingrese un valor." 
				}
				
			},
			submitHandler: function(form) {				
				actualizarBusquedaDeCertificado(form);
			}
		});

		var dates = $("#from_b_usuarioC, #to_b_usuarioC").datepicker({
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
						var option = this.id == "from_b_usuarioC" ? "minDate" : "maxDate",
							instance = $( this ).data( "datepicker" ),
							date = $.datepicker.parseDate(
								instance.settings.dateFormat ||
								$.datepicker._defaults.dateFormat,
								selectedDate, instance.settings );
						dates.not( this ).datepicker( "option", option, date );
			}
		});	
		
		
		
		$("#tipobusquedausuarioC").change( function() {
			var data =  $(this).val();
			$(".classtipobusquedausuario").hide();
			if(data==1){
				$("#tipobusquedausuario_creacionC").show();
			}else if(data==2){
				$("#tipobusquedausuario_nombreC").show();
			}else if(data==3){
				$("#tipobusquedausuario_numidentificacionC").show();
			}else if(data==4){
				$("#tipobusquedausuario_usuarioC").show();
			}else if(data==5){
				$("#tipobusquedausuario_codusuarioC").show();
			}else if(data==6){
				$("#tipobusquedausuario_idaplicacion").show();
			}else if(data==7){
				$("#tipobusquedausuario_idgrupo").show();
			}else if(data==8){
				$("#tipobusquedausuario_idcuenta").show();
			}
			else if(data==9){
				$("#tipobusquedausuario_numcertificadoC").show();
			}
			else if(data==10){
				$("#tipobusquedausuario_codigoverificacionC").show();
			}
			
			 
		});	
	});
	
	
	function actualizarBusquedaDeCertificado(form){
		$("#cajaBuscarUsuarioC").html(getHTMLLoaging30()); 
       	$("#btnBuscarCertificado").attr('disabled',true);;	 				
		$.ajax({
			cache: false,
			contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
            type: 'POST',
            url: $(form).attr('action'),
            data: $(form).serialize(),
            dataType: "text",
            error: function(jqXHR, textStatus, errorThrown) {
                alert(jqXHR.statusText);
	        },
            success: function(data) {
                $("#cajaBuscarUsuarioC").html(data);
                $("#btnBuscarCertificado").attr('disabled',false);	 
            }
        });
	}




	
</script>
<div align="left" >
<div  align="center">
	<table cellspacing="2"  width="100%" border="0" cellpadding="2">
	<col />
	<col style="width: 5px;"/>
	<col style="width: 200px;"/>	
	<tr  valign="middle">
	<td class="td3">
	<form name="fBuscarUsuarioC" id="fBuscarUsuarioC" action="${ctx}/page/certificado">
	<input type="hidden" name="action" value="buscar_certificado">
      <table width="100%" border="0">          
        <tr class="td3" valign="middle">
          <td height="33" align="right" valign="middle" width="300">
           	Buscar por: 
           	<select name="tipobusqueda" id="tipobusquedausuarioC">
           		<option value="2">Nombre</option>
           		<option value="3">Num. identificación</option>
           		<option value="9">Cod. Certificado</option>
           		<option value="10">Cod. Verificación</option>
				<option value="1">Fecha de creación</option>
				
				
           	</select>  
           	&nbsp;&nbsp; &nbsp;&nbsp;          
         </td>
         <td valign="middle" align="left" width="360">
         		<div id="tipobusquedausuario_usuarioC" class="classtipobusquedausuario" style="display: none;">   
	            	<input type="text" name="usuario">
	            </div>
         		<div id="tipobusquedausuario_numidentificacionC" class="classtipobusquedausuario" style="display: none;">   
	            	<input type="text" name="numidentificacion">
	            </div>	            
	            <div id="tipobusquedausuario_nombreC" class="classtipobusquedausuario" style="display: block;">   
	            	<input type="text" name="nombre" size="50">
	            </div>
	            <div id="tipobusquedausuario_codusuarioC" class="classtipobusquedausuario" style="display: none;">   
	            	<input type="text" name="codusuario">
	            </div>
	      	 <div id="tipobusquedausuario_numcertificadoC" class="classtipobusquedausuario" style="display: none;">   
	            	<input type="text" name="numerocertificado">
	            </div>
	             <div id="tipobusquedausuario_codigoverificacionC" class="classtipobusquedausuario" style="display: none;">   
	            	<input type="text" name="codigoverificacion" size="50">
	            </div>
	           
	            <div id="tipobusquedausuario_creacionC" class="classtipobusquedausuario" style="display: none;">   
	            	desde: <input type="text" name="from" 
					id="from_b_usuarioC" value="<fmt:formatDate value="${now}" pattern="dd/MM/yyyy" />" />
					&nbsp;&nbsp;hasta: <input type="text" name="to" id="to_b_usuarioC" 
					value="<fmt:formatDate value="${now}" pattern="dd/MM/yyyy" />" />
	            </div> 
            	
           </td>          
          <td valign="middle" align="left">                       
           <button type="submit" id="btnBuscarCertificado" name="btnBuscarCertificado">Buscar certificado</button>
          </td>
         </tr>
       </table>
       </form> 
       </td>
      
	</tr>
	</table>
	

<div  align="center" id="msnBuscarEmpleadoC" ></div>
</div> 
<div  align="center" id="cajaBuscarUsuarioC">
</div>
</div>

<div id="dmMensajeCertificado" title="Mensaje"></div>