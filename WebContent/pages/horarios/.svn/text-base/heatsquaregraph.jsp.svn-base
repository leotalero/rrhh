<%@ include file="/taglibs.jsp"%>

<script src="${ctx}/js/graft/themes/heatmap.js"></script>
		<script type="text/javascript">
		var reportePatronGraficaHeat;
		$(document).ready(function() {
			var fechastem= $("#fechas").val();
			 $('#reportePatronGraficaHeat').highcharts({
				 chart: {
			            type: 'heatmap',
			            marginTop: 40,
			            marginBottom: 80
			        },


			        title: {
			            text: 'Sales per employee per weekday'
			        },

			        xAxis: {
			            categories: ['Alexander', 'Marie', 'Maximilian']
			        },

			        yAxis: {
			            categories: ['Monday', 'Tuesday', 'Wednesday'],
			            title: null
			        },

			       

			        legend: {
			            align: 'right',
			            layout: 'vertical',
			            margin: 0,
			            verticalAlign: 'top',
			            y: 25,
			            symbolHeight: 280
			        },

			        tooltip: {
			            formatter: function () {
			                return '<b>' + this.series.xAxis.categories[this.point.x] + '</b> sold <br><b>' +
			                    this.point.value + '</b> items on <br><b>' + this.series.yAxis.categories[this.point.y] + '</b>';
			            }
			        },

			        series: [{
			            name: 'Sales per employee',
			            borderWidth: 1,
			            data: [[0, 0, 10], [0, 1, 19], [0, 2, 8], [0, 3, 24], [0, 4, 67], [1, 0, 92], [1, 1, 58], [1, 2, 78], [1, 3, 117]],
			            dataLabels: {
			                enabled: true,
			                color: '#000000'
			            }
			        }]
			    });
		
	});
		</script>
	

<input type="hidden" name="reporteaasistencia" value="${reporteaasistencia}"/>
<input type="hidden" name="fechas" id="fechas" value="${fechas}"/>

<div id="reportePatronGraficaHeat" ></div>







