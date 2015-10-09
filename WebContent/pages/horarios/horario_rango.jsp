<%@ include file="/taglibs.jsp"%>
<script type="text/javascript">
$(document).ready(function() {
	
	var dates1 = $("#fechainicio, #txtTo")
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
				var option = this.id == "fechanacimiento" ? "minDate"
						: "maxDate", instance = $(this)
						.data("datepicker"), date = $.datepicker
						.parseDate(instance.settings.dateFormat || $.datepicker._defaults.dateFormat, selectedDate, instance.settings); 
				dates1.not(this).datepicker("option", option, date);
			}
		});
		
		var dates1 = $("#fechafin, #txtTo")
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
				var option = this.id == "fechanacimiento" ? "minDate"
						: "maxDate", instance = $(this)
						.data("datepicker"), date = $.datepicker
						.parseDate(instance.settings.dateFormat || $.datepicker._defaults.dateFormat, selectedDate, instance.settings); 
				dates1.not(this).datepicker("option", option, date);
			}
		});
		
});
</script>
<div align="left" >
<table border="0" width="100%" class="caja">
<col style="width: 15%"/>
<tr>
<th rowspan="2" nowrap="nowrap" style="text-align: right;">Rango:</th>
<td>fecha inicio:<input type="text" name="fechainicio" id="fechainicio" value="<fmt:formatDate value="${now}" pattern="dd/MM/yyyy" />" style="width: 50%;"/></td>
</tr>
<tr>
<td>fecha fin <input type="text" name="fechafin" id="fechafin" value="<fmt:formatDate value="${now}" pattern="dd/MM/yyyy" />" style="width: 50%;"/></td>
</tr>
<tr>
<th rowspan="2" nowrap="nowrap" style="text-align: right;">Frecuencia:</th>
<td>Frecuencia:
		<select name="idfrecuencia" >
		<option value=""></option>
		<c:forEach items="${frecuencias}" var="frecuencia" varStatus="loop">
		<option value="${frecuencia.idfrecuenciaasignacion}"><c:out value="${frecuencia.nombrefrecuencia}"/> </option>
		</c:forEach>
		</select>
		
	</td>
</tr>
</table>

</div>
