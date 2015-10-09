<%@ include file="/taglibs.jsp"%>
<script type="text/javascript">

	$(document).ready(function() {
		
		$("#btnBuscarUsuarioTestigo").button();
		
		$("#fBuscarUsuarioTestigo").validate({
			errorLabelContainer: "#msnBuscarEmpleadoTestigo",
			errorClass: "invalid",
			rules: {
				tipobusqueda:{
					required: true
				},				
				from:{
					required: function(element){ 
						return $("#tipobusquedausuario").val() == 1;
						} 
				},
				to:{
					required: function(element){ return $("#tipobusquedausuario").val() == 1;} 
				},
				nombre:{
					required: function(element){ return $("#tipobusquedausuario").val() == 2;} 
				},
				numidentificacion:{
					required: function(element){ return $("#tipobusquedausuario").val() == 3;}, 
					digits: function(element){ return $("#tipobusquedausuario").val() == 3;}
				},
				usuario:{
					required: function(element){ return $("#tipobusquedausuario").val() == 4;} 
				},
				codusuario:{
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
				nombre:{
					required: "Ingrese un valor." 
				},
				numidentificacion:{
					required: "Ingrese un valor.",
					digits: "Ingrese solo dígitos"
				},
				usuario:{
					required: "Ingrese un valor." 
				},
				codusuario:{
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
				actualizarBusquedaDeUsuarioTestigo(form);
			}
		});

		var dates = $("#from_b_usuario, #to_b_usuario").datepicker({
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
						var option = this.id == "from_b_usuario" ? "minDate" : "maxDate",
							instance = $( this ).data( "datepicker" ),
							date = $.datepicker.parseDate(
								instance.settings.dateFormat ||
								$.datepicker._defaults.dateFormat,
								selectedDate, instance.settings );
						dates.not( this ).datepicker( "option", option, date );
			}
		});	

		$("#fBuscarUsuarioTestigo [name=tipobusquedausuario]").change( function() {
			var data =  $(this).val();
			$(".classtipobusquedausuarioTestigo").hide();
			if(data==1){
				//alert('1');
				$("#tipobusquedausuario_creacionTestigo").show();
			}else if(data==2){
				//alert('2');
				$("#tipobusquedausuario_nombreempleadoTestigo").show();
			}else if(data==3){//alert('3');
				$("#tipobusquedausuario_numidentificacionTestigo").show();
			}else if(data==4){//alert('4');
				$("#tipobusquedausuario_usuarioTestigo").show();
			}else if(data==5){//alert('5');
				$("#tipobusquedausuario_codusuarioTestigo").show();
			}else if(data==6){//alert('6');
				$("#tipobusquedausuario_idaplicacionTestigo").show();
			}else if(data==7){//alert('7');
				$("#tipobusquedausuario_idgrupoTestigo").show();
			}else if(data==8){//alert('8');
				$("#tipobusquedausuario_idcuentaTestigo").show();
			}
		});
	
});
	
	function actualizarBusquedaDeUsuarioTestigo(form){
		//alert('iddisciplina en buscarTestigo: ${idDisciplinas},${idSancions},${idContratos},${idFaltas}');
		$("#cajaBuscarUsuarioTestigo").html(getHTMLLoaging30()); 
       	$("#btnBuscarUsuarioTestigo").attr('disabled',true);	 				
		$.ajax({
			cache: false,
			contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
            type: 'POST',
//             url: $(form).attr('action'),
			url :  '${ctx}/page/empleado?action=buscarTestigos&idDisciplina=${idDisciplinas}&idSancion=${idSancions}&idContrato=${idContratos}&idFalta=${idFaltas}',
            data: $(form).serialize(),
            dataType: "text",
            error: function(jqXHR, textStatus, errorThrown) {
                alert(jqXHR.statusText);
	        },
            success: function(data) {
                $("#cajaBuscarUsuarioTestigo").html(data);
                $("#btnBuscarUsuarioTestigo").attr('disabled',false);	 
            }
        });
	}
	
</script>


<body>
<div>
	<input type="hidden" name="idDisciplinas" value="${idDisciplinas}"/>
	<input type="hidden" name="idSancions" value="${idSancions}"/>
	<input type="hidden" name="idContratos" value="${idContratos}"/>
	<input type="hidden" name="idFaltas" value="${idFaltas}"/>
</div>

<div id="busquedaTestigos" align="center">
	<table cellspacing="2"  width="100%" border="0" cellpadding="2">
	<col />
	<col style="width: 5px;"/>
	<col style="width: 200px;"/>	
	<tr  valign="middle">
	<td class="td3">
	<form name="fBuscarUsuarioTestigo" id="fBuscarUsuarioTestigo" action="${ctx}/page/empleado">
<!-- 	<input type="hidden" name="action" value="buscarTestigos"> -->
      <table width="100%" border="0">          
        <tr class="td3" valign="middle">
          <td height="33" align="right" valign="middle" width="300">
           	Buscar por: 
           	<select name="tipobusquedausuario" id="tipobusquedausuario">
           		<option value="2">Nombre</option>
           		<option value="3">Num. identificación</option>
				<option value="1">Fecha de creación</option>
           	</select>  
           	&nbsp;&nbsp; &nbsp;&nbsp;          
         </td>
         <td valign="middle" align="left" width="360">
         		<div id="tipobusquedausuario_usuarioTestigo" class="classtipobusquedausuarioTestigo" style="display: none;">   
	            	<input type="text" name="usuario">
	            </div>
         		<div id="tipobusquedausuario_numidentificacionTestigo" class="classtipobusquedausuarioTestigo" style="display: none;">   
	            	<input type="text" name="numidentificacion">
	            </div>	            
	            <div id="tipobusquedausuario_nombreempleadoTestigo" class="classtipobusquedausuarioTestigo" style="display: block;">   
	            	<input type="text" name="nombre" size="50">
	            </div>
	            <div id="tipobusquedausuario_codusuarioTestigo" class="classtipobusquedausuarioTestigo" style="display: none;">   
	            	<input type="text" name="codusuario">
	            </div>
	       
	           
	            <div id="tipobusquedausuario_creacionTestigo" class="classtipobusquedausuarioTestigo" style="display: none;">   
	            	desde: <input type="text" name="from" 
					id="from_b_usuario" value="<fmt:formatDate value="${now}" pattern="dd/MM/yyyy" />" />
					&nbsp;&nbsp;hasta: <input type="text" name="to" id="to_b_usuario" 
					value="<fmt:formatDate value="${now}" pattern="dd/MM/yyyy" />" />
	            </div> 
            	
           </td>          
          <td valign="middle" align="left">                       
          	<button type="submit" id="btnBuscarUsuarioTestigo" name="btnBuscarUsuarioTestigo">Buscar empleado</button>
          </td>
         </tr>
       </table>
       </form> 
       </td>
       <td></td>
	</tr>
</table>
	

<div  align="center" id="msnBuscarEmpleadoTestigo" ></div>
</div> 
<div  align="center" id="cajaBuscarUsuarioTestigo">
</div>

</body>