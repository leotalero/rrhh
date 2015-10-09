<%@ include file="/taglibs.jsp"%>


<link href='${ctx}/fullcalendar-2.2.6/fullcalendar.css' rel='stylesheet' />

<script src='${ctx}/fullcalendar-2.2.6/lib/moment.min.js'></script>
<script src='${ctx}/fullcalendar-2.2.6/fullcalendar.min.js'></script>
<script src='${ctx}/fullcalendar-2.2.6/lang-all.js'></script>
<script type="text/javascript">

	$(document).ready(function() {
		
		var idcontratotemp=document.getElementById("idcontrato").value;
		alert("idcontrato"+idcontratotemp);
		$('#calendar').fullCalendar({
			header: {
				left: 'prev,next today',
				center: 'title',
				right: 'month,agendaWeek,agendaDay'
			},
			
			editable: true,
			lang: 'es',
			selectable: true,
			selectHelper: true,
			select: function(start, end) {
				var title = prompt('Event Title:');
				var eventData;
				if (title) {
					eventData = {
						title: title,
						start: start,
						end: end
					};
					$('#calendar').fullCalendar('renderEvent', eventData, true); // stick? = true
				}
				$('#calendar').fullCalendar('unselect');
			},
			editable: true,
			eventLimit: true, // allow "more" link when too many events
			eventLimit: true, // allow "more" link when too many events
			 eventSources: [
			                {
			events: function(start, end, timezone, callback) {
		        $.ajax({
		        	cache: false,
				    url: "${ctx}/page/horarios?action=verhorarioencalendario",
		            data: {
		                // our hypothetical feed requires UNIX timestamps
		            	start: 'start',
                        end: 'end',
                        id: 'id',
                        title: 'title'
		            },
		            error: function(jqXHR, textStatus, errorThrown) {
		                alert(jqXHR.statusText);
			        },
		            success: function(doc) {
		            	
		            
		                var events = [];
		                $(doc).each(function() {
		                
		                    events.push({
		                        title: $(this).attr('title'),
		                        start: $(this).attr('start'), // will be parsed
		                        end: $(this).attr('end') // will be parsed
		                    });
		                });
		                callback(events);
		            }
		      
			
			
		        });
		    } ,
			//color: 'blue',   // an option!
           // textColor: 'black' // an option!
			
                   
			                }
			      ]
		});
		
	});

</script>

<style>

	body {
		margin: 40px 10px;
		padding: 0;
		font-family: "Lucida Grande",Helvetica,Arial,Verdana,sans-serif;
		font-size: 14px;
	}

	#calendar {
		max-width: 900px;
		margin: 0 auto;
	}

</style>


<body>
<div align="left">

<div>
</div>

<form name="fCalendario" id="fCalendario" action="${ctx}/page/horarios" method="post">
<input type="hidden" name="horariohoraentrada" id="horariohoraentrada" value="${horariohoraentrada}"/>
<input type="hidden" name="horariohorasalida" id="horariohorasalida" value="${horariohorasalida}"/>
<input type="hidden" name="idfrecuencia" id="idfrecuencia" value="${idfrecuencia}"/>
<input type="hidden" name="fechainicio" id="fechainicio" value="${fechainicio}"/>
<input type="hidden" name="fechafin" id="fechafin" value="${fechafin}"/>
<input type="hidden" name="fechasespecificas" id="fechasespecificas" value="${fechasespecificas}"/>
<input type="hidden" name="nombrehorario" id="nombrehorario" value="${nombrehorario}"/>


	<div id='calendar'></div>
</form>
</div>

</body>

<div style="padding: 30px 0px;"></div>