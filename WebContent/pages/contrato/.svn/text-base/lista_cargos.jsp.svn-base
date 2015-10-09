<%@ include file="/taglibs.jsp"%>
<script type="text/javascript">
$(document).ready(function() {
	//$("#idcargo [value='${contrato.idcargo}']").attr("selected","selected");
	
$("[name=idcargo]").multiselect({
    /*header: true,*/
    height: 175,
    minWidth: 225,
    //classes: '',
  //  checkAllText: 'Marcar todos',
  //  uncheckAllText: 'Desmarcar todos',
    noneSelectedText: 'Seleccionar Cargo',
  //  selectedText: '# selecionado(s)',
    selectedList: 1,
  //  show: ["bounce", 500],
   // hide: ["explode", 400],
  	autoOpen: false,
    multiple: false,
    position: {},
  
    appendTo: "body"
}).multiselectfilter({                         
     label: 'Filtro:&nbsp;',               
  placeholder: '',
  autoReset: true
});

//$("#idcargo [value='${contrato.idcargo}']").attr("selected","selected");
//$("#idcargo").change();
});
</script>
<div align="left" >

<select name="idcargo"  style="width: 200px">
	<option value="" ></option>
	<c:forEach items="${cargos}" var="cargo">
		<option value="${cargo.idcargo}"><c:out value="${cargo.nombrecargo}" /> </option>
	</c:forEach>
</select>
<script type="text/javascript">$("[name=idcargo]").val("${contrato.idcargo}");

		</script>
</div>
