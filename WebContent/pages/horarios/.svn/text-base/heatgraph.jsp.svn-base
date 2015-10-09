<%@ include file="/taglibs.jsp"%>

<script src="${ctx}/js/graft/themes/grid.js"></script>
		<script type="text/javascript">
		var reportePatronGrafica;
		$(document).ready(function() {
			var fechastem= $("#fechas").val();
			 $('#reportePatronGrafica').highcharts({
				 chart: {
			            
					 zoomType: 'xy',
			            panning: true,
			            panKey: 'shift'
			        },

	            	tooltip: {
	                    shared: true,
	                    useHTML: true
	            		
	                },
	                plotOptions: {
			            pie: {
			                allowPointSelect: true,
			                cursor: 'pointer',
			                dataLabels: {
			                    enabled: true,
			                    format: '<b>{point.name}</b>: {point.percentage:.1f} %',
			                    style: {
			                        color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
			                    }
			                }
			            },
			            column: {
			            	stacking: 'normal',
			                dataLabels: {
			                    enabled: true,
			                    color: (Highcharts.theme && Highcharts.theme.dataLabelsColor) || 'white'
			                    
			                }
			            }
			        },
				  credits: {
			            enabled: false
			        },
				 exporting: {
			            enabled: false
			        },
			        title: {
			            text: 'Asistencias',
			            x: -20 //center
			        },
			        subtitle: {
			            text: 'Tendencias',
			            x: -20
			        },
			        xAxis: {
			        	labels: {
			        		
			        		rotation: -60
			            },
			            categories: [${fechas}]
				        
			        },
			        yAxis: {
			        	 layout: 'vertical',
			            title: {
			                text: 'Número empleados (#)'
			            },
			            stackLabels: {
			                enabled: true,
			                style: {
			                    fontWeight: 'bold',
			                    color: (Highcharts.theme && Highcharts.theme.textColor) || 'gray'
			                }
			            }
			        },
			       
			       
			        legend: {
			            layout: 'vertical',
			            align: 'right',
			            verticalAlign: 'middle',
			            borderWidth: 0
			        },
			       
			        series: 
						[${series}]
			        
			    });
		
	});
		</script>
	

<input type="hidden" name="reporteaasistencia" value="${reporteaasistencia}"/>
<input type="hidden" name="fechas" id="fechas" value="${fechas}"/>

<div id="reportePatronGrafica" ></div>







