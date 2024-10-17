<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang='en'>
<head>
<link rel="stylesheet" href="../tem/css/calendarstyle.css">
<meta charset='utf-8'/>
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
          selectable: true,
          editable:true
          
        });
        calendar.render();
        
        function loadEvents(fetchInfo, successCallback, failureCallback) {
            db.collection("events").get().then((querySnapshot) => {
                let events = [];
                querySnapshot.forEach((doc) => {
                    const eventData = doc.data();
                    events.push({
                        title: eventData.subject,
                        start: eventData.start,
                        end: eventData.end
                    });
                });
                successCallback(events); // 가져온 이벤트 배열 전달
            })
            .catch(function(error) {
                console.error("일정 불러오기 오류:", error);
                failureCallback(error); // 오류 발생 시 실패 콜백 호출
            });
        }
      });

    </script>
  </head>
  <body>
    <div id='calendar' class="cal" ></div>
  </body>
</html>
