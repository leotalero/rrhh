<%@ include file="/taglibs.jsp"%>
<script type="text/javascript">

	
	$(document).ready(function() {
		$("[name=btnCrearPropiedad]").button();	
		$("[name=btnCrearCancelarPropiedad]").button();

		$("#fArchivoPropiedad").validate({
			//errorLabelContainer: "#msnBuscarCargue",
			errorClass: "invalid",
			rules: {
				idprocesopropiedad: {
					required: true,
					digits: true,
					min:1
				},
				archivoR:{
					required: true,
					maxlength: 150
				},
				observacion:{
					
					maxlength: 2500
				}
				
				
				
				
				
			},
			messages: {
				
				idprocesopropiedad: {
					required: "Seleccione una opción para tipo de propiedad",
		
				},
				archivoR: {
					required: "Este valor es requerido.",
					maxlength: "El archivo debe tener un nombre menor a 150 caracteres"
				},
			observacion: {
					maxlength: "Ingresar menos de 2500 caracteres"
				}
				
			},
			submitHandler: function(form) {				
				crearPropiedad(form);
			
            
			}
		});


	});
		
	
	
	
  



/* function crearPropiedadajax(form) {
	alert("va ajax");
	$("#dmMensajeDesvinculacion").dialog("open");
	$("#dmMensajeDesvinculacion").html(getHTMLLoaging16(' Creando'));
	$( "#fArchivoPropiedad" ) .attr( "enctype", "multipart/form-data" )
    .attr( "encoding", "multipart/form-data" );
	$.ajax({
		cache: false,
		contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
        type: $(form).attr('method'), 
        contentType:attr( "enctype", "multipart/form-data" ),
        url: $(form).attr('action'),
        data: $(form).serialize(),
        dataType: "text",
        error: function(jqXHR, textStatus, errorThrown) {
        	
            $("#dmMensajeDesvinculacion").html(jqXHR.statusText);
        },
        success: function(data) {
        	alert("regresa");
        	if(validarEntero(data)){
        		$("#dmMensajeDesvinculacion").dialog("close");
            	$("#dmNuevaPropiedad").dialog("close");
            	actualizarPropiedadesProcesos('${contratoproceso.proceso.nombreproceso}','${contrato.idcontrato}','${contratoproceso.proceso.idproceso}');
             } else {
            	$("[name=btnCrearPropiedad]").attr('disabled',false);
        		$("[name=btnCrearCancelarPropiedad]").attr('disabled',false);
                $("#dmMensajeDesvinculacion").html('Error desconocido');					
            }            		 
        }
    });
} */

	
	
	function crearPropiedad(form) {
		
		$("[name=btnCrearPropiedad]").attr('disabled',true);;
		$("[name=btnCrearCancelarPropiedad]").attr('disabled',true);;
		$("#dmMensajeDesvinculacion").dialog("open");
		$("#dmMensajeDesvinculacion").html(getHTMLLoaging16(' Creando'));
		//alert("guardatemporal"+$(form).attr('action'));
		//alert("envia guardatemporal");
			//$("#dmMensajeCargueM").dialog("open");
			var date = new Date();
			var mensaje = $("#dmMensajeDesvinculacion"); 
		    var iframe_nombre = "upload_iframe_"+date.getTime();
		    var iframe_id = iframe_nombre;

		    var iframe = document.createElement("iframe");
		    iframe.setAttribute("id", iframe_nombre);
		    iframe.setAttribute("name", iframe_nombre);
		    iframe.setAttribute("width", "0");
		    iframe.setAttribute("height", "0");
		    iframe.setAttribute("border", "0");
		    iframe.setAttribute("style", "width: 0; height: 0; border: none;");
		    // Add to document...

		    form.parentNode.appendChild(iframe);

		    window.frames[iframe_nombre].name = iframe_nombre;

		    iframeId = document.getElementById(iframe_id);

		    // Add event...
		    var eventHandler = null;
		    eventHandler = function () {
		    
					if (iframeId.detachEvent){ 
						iframeId.detachEvent("onload", eventHandler);
					}else {
						iframeId.removeEventListener("load", eventHandler, false);		            	
		            }
		            
		            // Message from server...
		            if (iframeId.contentDocument) {
		                content = iframeId.contentDocument.body.innerHTML;
		            } else if (iframeId.contentWindow) {
		                content = iframeId.contentWindow.document.body.innerHTML;
		            } else if (iframeId.document) {
		                content = iframeId.document.body.innerHTML;
		            }
		            
		            
		            
		            
		            // Del the iframe...
		          
		            
		            //refresca todo el div de cargues por base
		          $("#dmMensajeDesvinculacion").dialog("close");
            	$("#dmNuevaPropiedad").dialog("close");
            	actualizarPropiedadesProcesos('${contratoproceso.proceso.nombreproceso}','${contrato.idcontrato}','${contratoproceso.proceso.idproceso}');
           
		           
		        //    $("#dmMensajeCargueM").html('<div>'+content+'</div>');
		            
		            setTimeout('iframeId.parentNode.removeChild(iframeId)', 30);
		         
		    };
		    if (iframeId.addEventListener) iframeId.addEventListener("load", eventHandler, true);
		    if (iframeId.attachEvent) iframeId.attachEvent("onload", eventHandler);
		    // Set properties of form...
		 form.setAttribute("target", iframe_nombre);
		   // form.setAttribute("target", "#divDocumento");

		    form.setAttribute("action","${ctx}/page/desvinculacion?action=archivos_guardar_propiedad");
		    form.setAttribute("method", "post");
		  form.setAttribute("enctype", "multipart/form-data");
		    //form.setAttribute("encoding", "iso-8859-1");

		    // Submit the form...
		    form.submit();
		 
		    mensaje.html(getHTMLLoaging16("Cargando ... ")); 
		    
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
	

	
	function Checkfiles(idelement){
	  
	    var fileName = document.getElementById(idelement).value;
	    var ext = fileName.substring(fileName.lastIndexOf('.') + 1);
	
		if(ext !="exe" || ext!="EXE"){
			return true;
		}
		else{
			alert("Solo documentos en pdf");
			document.getElementById(idelement).value="";
			return false;
		}
	}

	
	/*
	* Método para validar el tamaño y la extension del archivo.
	* Tamaño máximo : 20MB (20971520 bytes)
	* Extensión no permitida: .exe
	*/
	$('#archivoR').bind('change', function() {
		var nombreArchivo = $('#archivoR').val();
		var extension = nombreArchivo.substring(nombreArchivo.lastIndexOf('.'));
		
		if(this.files[0].size>20971520){
			alert('El tamaño del archivo no debe superar los 20MB.');
			$("#archivoR").val('');
		}
		if(extension=='.exe' || extension=='exe' || extension=='.EXE' || extension=='EXE'){
			alert('Archivo no valido.');
			$("#archivoR").val('');
		}
	});
	
	
</script>
<div align="left">

<div>
</div>

<form name="fArchivoPropiedad" id="fArchivoPropiedad"  enctype="multipart/form-data" action="${ctx}/page/desvinculacion" method="post">

<input type="hidden" name="action" value="archivos_guardar_propiedad"/>
<input type="hidden" name="idempleado" value="${empleado.idempleado}"/>
<input type="hidden" name="idcontrato" value="${contrato.idcontrato}"/>
<input type="hidden" name="nombreproceso" value="${contratoproceso.proceso.nombreproceso}"/>
<input type="hidden" name="idproceso" value="${contratoproceso.proceso.idproceso}"/>

<div>
	<button type="button" id="btnCrearCancelarPropiedad" name="btnCrearCancelarPropiedad" onclick="$('#dmNuevaPropiedad').dialog('close');">Cancelar</button>&nbsp;&nbsp;&nbsp;<button type="submit" id="btnCrearPropiedad" name="btnCrearPropiedad">Crear</button>
</div>
<br/>

<fieldset>
<legend class="e6">${contratoproceso.proceso.nombreproceso}</legend>


<table border="0" width="100%" class="caja">

<col style="width: 15%"/>
<col/>
<tr>
<th nowrap="nowrap" style="text-align: right;">${contratoproceso.proceso.nombreproceso}:</th>
<td>
		<select name="idprocesopropiedad">
			<option value=""></option>
			<c:forEach items="${procesopropiedades}" var="propiedad" varStatus="loop">
				<option value="${propiedad.idprocesopropiedad}"><c:out value="${propiedad.nombrepropiedad}"/></option>
			</c:forEach>
		</select>
		
		<script type="text/javascript">$("#fArchivoPropiedad [name=idprocesopropiedad]").val("${procesopropiedad.idprocesopropiedad}");</script>
</td>
</tr>
<tr>
<tr>
	<th nowrap="nowrap" style="text-align: right;">Detalle <div class="texto1">Todo tipo de archivos tam max:20MB</div> 
	</th>
	<td>
		<input type="file" name="archivoR" id="archivoR" style="max-width: 100%"   onchange="javascript:Checkfiles(this.id)">
	</td>
</tr>
<tr>
	<th nowrap="nowrap" style="text-align: right;">Observacion:</th>
	<td>
		<textarea  name="observacion" cols=70 rows=5 maxlength="3950" spellcheck="true" ></textarea>
	</td>
</tr>





</table>
</fieldset>
<br/>


<div><button type="button" id="btnCrearCancelarPropiedad" name="btnCrearCancelarPropiedad" onclick="$('#dmNuevaPropiedad').dialog('close');">Cancelar</button>&nbsp;&nbsp;&nbsp;<button type="submit" id="btnCrearPropiedad" name="btnCrearPropiedad">Crear</button></div>
</form>

</div>
<div style="padding: 30px 0px;"></div>