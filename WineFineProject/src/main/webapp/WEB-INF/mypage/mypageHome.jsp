<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang='en'>
  <head>
    <meta charset='utf-8' />
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js'></script>
    <script>

      document.addEventListener('DOMContentLoaded', function() {
        var calendarEl = document.getElementById('calendar');
        var calendar = new FullCalendar.Calendar(calendarEl, {
          headerToolbar:{
        	  left:'prev,next today',
        	  center:'title',
        	  right:'dayGridMonth,dayGridWeek,dayGridDay'
          },
          editable:true,
          events: [
              
              {
                  title : 'libft 과제이해',
                  start: '2024-10-26',
              },
              {
                  title : 'libft 코딩',
                  start: '2024-10-27'
              },
              {
                  title : 'libft 평가',
                  start: '2024-10-29'
              },
          ]
          
        });
        calendar.render();
      });

    </script>
  </head>
  <body>
    <div id='calendar' style="width:700px; height: 700px"></div>
  </body>
</html>
