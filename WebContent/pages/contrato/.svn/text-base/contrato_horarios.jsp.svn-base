<%@ include file="/taglibs.jsp"%>
<script type="text/javascript">
	jQuery.validator.addMethod("loginregex", function(value, element) {
	    return this.optional(element) || /^[a-zA-Z0-9\_]+$/.test(value);
	});
	
	$(document).ready(function() {	
	
		
		$("#idarea [value='${contrato.idarea}']").attr("selected","selected");
		
		
		$("#idcargo [value='${contrato.idcargo}']").attr("selected","selected");
		
		$("#tabsHorariosAsignacionn").tabs({
			cache: true,
			spinner: ' '+getHTMLLoaging14(''),			
			ajaxOptions: {
				cache: true,
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
				}
				
			},
			submitHandler: function(form) {
				f(form);
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
                	visualizarEditarHorario(data);
                } else {
                	$("[name=btnCrearUsuarioHorario]").attr('disabled',false);
                    $("#dmMensajeContrato").html('Error desconocido');					
                }            		 
            }
        });
	}

	
	function editarCancelarContrato(idempleado) {
		$('#dmEditarHorario').dialog('close');
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

	
	function VereditarHorarioAsignado(idhorarioasignado,idcontrato){
		$("#dmEditarHorarioAsignado").dialog("open");
		$("#dmEditarHorarioAsignado").html(getHTMLLoaging30());
		$.ajax({
			cache: false,
			contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
	        type: 'POST',
	        url: "${ctx}/page/horarios?action=empleado_vereditarhorarioasignado&idhorarioasignado="+idhorarioasignado+"&idcontrato="+idcontrato,
	        dataType: "text",
	        error: function(jqXHR, textStatus, errorThrown) {
	            alert(jqXHR.statusText);
	        },
	        success: function(data) {		                    	                    	
	           	$("#dmEditarHorarioAsignado").html(data);     
	        }
	    });
	}


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

<br/>
<div>
<button type="button" id="btnEditarCancelarContrato" name="btnEditarCancelarContrato" onclick="editarCancelarContrato(${contrato.idempleado});">Cancelar</button>&nbsp;&nbsp;&nbsp;
</div>
</form>
<br/>

<div id="tabsHorariosAsignacionn">
	<ul>		
		<li><a href="#idTabsContratosHorarios">&nbsp;Horarios<span>&nbsp;</span></a></li>
		<li><a href="${ctx}/page/horarios?action=mostrar_calendario&idcontrato=${contrato.idcontrato}">&nbsp;Calendario<span>&nbsp;</span></a></li>

	</ul>
	
	
	<div id="idTabsContratosHorarios">
	
<fieldset><legend class="e6">Horarios asociados</legend>
<br/>
<div>
<form name="fCrearContratoHorario" id="fCrearContratoHorario" action="${ctx}/page/horarios" method="post">
<input type="hidden" name="action" value="asignar_horario"/>
<input type="hidden" name="idempleado" value="${empleado.idempleado}"/>
<input type="hidden" name="idcontrato" value="${contrato.idcontrato}"/>
<table border="0" width="100%" class="caja">
<col style="width: 30%"/>

<tr>
<th>Horario asigando </th>
<th>Fecha validez inicio</th>
<th>Fecha validez final</th>
<th>Observaciones</th>

<th></th>
</tr>
<tbody>
<tr>
<td valign="middle">
<select name="idhorario">
<option value=""></option>
<c:forEach items="${horarios}" var="horario" varStatus="loop">
<option value="${horario.idhorario}"><c:out value="${horario.nombrehorario} "/> [ <c:out value="${horario.horaentrada} "/> - <c:out value="${horario.horasalida} "/>] - [frecuencia:<c:out value="${horario.frecuenciaasignacion.nombrefrecuencia} "/>]</option>
</c:forEach>
</select>
</td>
<td>
<input type="text" name="validezinicio" id="validezinicio" value="<fmt:formatDate value="${ultimohorariovalido.validezfin}" pattern="dd/MM/yyyy" />" style="width: 95%;"/>


</td>
<td>
<input type="text" name="validezfin" id="validezfin" value="<fmt:formatDate value="${ultimohorariovalido.validezfin}" pattern="dd/MM/yyyy" />" style="width: 95%;"/>
</td>
<td><input type="text" name="observaciones" value="" style="width:95%;"/></td>
		<td>
		<c:if test="${sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 1 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 214 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 215 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 216}">
	
		<button type="submit" id="btnCrearUsuarioHorario" name="btnCrearUsuarioHorario">Asociar horario</button>
		</c:if>
		</td>
	
</tr>
</tbody>
</table>
</form>
</div>
<br/>
<c:choose>
	<c:when test="${fn:length(horariosasignados) eq 0}">
		<div class="msgInfo1" align="left">No tiene asignado ningun horario.</div>
	</c:when>		
	<c:otherwise>
	<table border="0" width="95%" class="tExcel tRowSelect">
	<col style="width:200px"/>
	
	
	<tr>
		<th>Nombre</th>
		<th>Horario entrada</th>
		<th>Horario salida</th>
		<th>Desde</th>
		<th>Hasta</th>
		<th>Frecuencia asignacion</th>
		<th>Observaciones</th>
		<th>User crea</th>
		<th>Fecha crea</th>
		<th>User mod</th>
		<th>Fecha mod</th>	
		<th>Estado</th>	
		<th>Acción</th>	
	</tr>
	<tbody>
	
	<c:forEach items="${horariosasignados}" var="horarioasignado" varStatus="loop">
	<tr style="color: ${horarioasignado.estado==2?'':'red'};">
	<td><c:out value="${horarioasignado.horario.nombrehorario} "/> [ <c:out value="${horarioasignado.horario.horaentrada} "/> - <c:out value="${horarioasignado.horario.horasalida} "/>]-[frecuencia:<c:out value="${horarioasignado.frecuenciaasignacion.nombrefrecuencia} "/>]</td>
	<td><c:out value="${horarioasignado.horario.horaentrada}"/></td>
	<td><c:out value="${horarioasignado.horario.horasalida}"/></td>
	<td><fmt:formatDate value="${horarioasignado.validezinicio}" pattern="dd/MM/yyyy"/></td>
	<td><fmt:formatDate value="${horarioasignado.validezfin}" pattern="dd/MM/yyyy "/></td>
	<td><c:out value="${horarioasignado.frecuenciaasignacion.nombrefrecuencia}"/></td>
	<td><c:out value="${horarioasignado.causahorario}"/></td>
	<td><c:out value="${horarioasignado.idusuariocrea}"/></td>
	<td><fmt:formatDate value="${horarioasignado.fechacrea}" pattern="dd/MM/yyyy H:mm"/></td>
	<td><c:out value="${horarioasignado.idusuariomod}"/></td>
	<td><fmt:formatDate value="${horarioasignado.fechamod}" pattern="dd/MM/yyyy H:mm"/></td>
	<td>
	<c:if test="${horarioasignado.estado==2}">
	<c:out value="Activo"/>
	</c:if>
	<c:if test="${horarioasignado.estado==3}">
	<c:out value="Desactivado"/>
	</c:if>
	
	</td>
	
	<td>
	<c:if test="${sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 1 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 214 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 215 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 216}">
					
		<c:if test="${horarioasignado.estado==2}">
	
		<span class="enlace" onclick="deshabilitarHorarioAsignado(${horarioasignado.idhorarioasignado});" title="Deshabilitar"><img alt="Deshabilitar" src="${ctx}/imagen/control_deshabilitar.gif"></span>
		<span class="enlace" onclick="VereditarHorarioAsignado(${horarioasignado.idhorarioasignado},${contrato.idcontrato});" title="Editar"><img alt="Editar" src="${ctx}/imagen/control_editar.gif"></span>
							
		</c:if> 
		<c:if test="${horarioasignado.estado==3}">
		<span class="enlace" onclick="habilitarHorarioAsignado(${horarioasignado.idhorarioasignado});" title="Activar"><img alt="Activar" src="${ctx}/imagen/control_habilitar.gif"></span>
		</c:if>
	</c:if>
	
	</tr>
	</c:forEach>			  
	</tbody>
	</table>
	</c:otherwise>
</c:choose>

</fieldset>
	
	</div>
</div>

<br/>


<br/>
</c:otherwise>
</c:choose>
</div>
<div style="padding: 30px 0px;"></div>

