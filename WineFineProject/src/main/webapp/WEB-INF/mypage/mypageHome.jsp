<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang='en'>
<head>
<link rel="stylesheet" href="../tem/css/calendarstyle.css">
<meta charset='utf-8' />
<script
	src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js'>
</script>
</head>
<body>
	<div class="MyCalendar">
		<div id='calendar' class="cal"></div>
		<div class="modal" :class="{show: showModal}">
			<div class="modal-content" style="width: 400px; height: 580px;margin-top: 7%;">
            <div class="modal-header">
                <h5 class="modal-title" id="addEventModalLabel">일정 추가</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" @click="changeModal(false)"></button>
            </div>
            <div class="modal-body">
                    <div class="mb-3">
                        <label for="subject" class="label">제목</label>
                        <input type="text" class="form-control" v-model="subject">
                    </div>
                    <div class="mb-3">
                        <label for="title" class="label">내용</label>
                        <input type="text" class="form-control" v-model="content">
                    </div>
                    <div class="mb-3">
                        <label for="start" class="label">시작 일자</label>
                        <input type="date" class="form-control" v-model="startday">
                    </div>
                    <div class="mb-3">
                        <label for="end" class="label">종료 일자</label>
                        <input type="date" class="form-control" v-model="endday">
                    </div>
                    <div class="mb-3">
                    <table style="width:100%">
                    <tr>
                    <td width="20%"></td>
                    <td width="30%">배경색</td>
                    <td width="30%">글자색</td>
                    <td width="20%"></td>
                    </tr>
                    <tr>
                    <td width="20%"></td>
                    <td width="30%"><input type="color" v-model="bcolor" required></td>
                    <td width="30%"><input type="color" v-model="fcolor" required></td>
                    <td width="20%"></td>
                    </tr>
                    </table>
                    </div>
                    <div>
                    <button type="submit" class="btn btn-warning" @click="submitBtn()">저장</button>
                    </div>
            </div>
			</div>
		</div>
		<div class="modal" :class="{show:sModal}">
			<div class="modal-content" style="width: 400px; height: 580px;margin-top: 7%;">
            <div class="modal-header">
                <h5 class="modal-title" id="addEventModalLabel">{{state==='1'?'예약보기':'일정보기'}}</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" @click="cModal(false)"></button>
            </div>
            <div class="modal-body" v-if="state==='2'">
                    <div class="mb-3">
                        <label for="subject" class="label">제목</label>
                        <span>{{vo.subject}}</span>
                    </div>
                    <div class="mb-3">
                        <label for="content" class="label">내용</label>
                        <span>{{vo.content}}</span>
                    </div>
                    <div class="mb-3">
                        <label for="start" class="label">시작 일자</label>
                        <span>{{vo.startday}}</span>
                    </div>
                    <div class="mb-3">
                        <label for="end" class="label">종료 일자</label>
                        <span>{{vo.endday}}</span>
                    </div>
                    <div>
                    <button type="submit" class="btn btn-wine" @click="deleteBtn()">삭제</button>
                    </div>
            </div>
            <div class="modal-body" v-if="state==='1'">
                    <div class="mb-3">
                        <label for="subject" class="label">제목</label>
                        <input type="text" class="form-control" v-model="subject">
                    </div>
                    <div class="mb-3">
                        <label for="title" class="label">내용</label>
                        <input type="text" class="form-control" v-model="content">
                    </div>
                    <div class="mb-3">
                        <label for="start" class="label">시작 일자</label>
                        <input type="date" class="form-control" v-model="startday">
                    </div>
                    <div class="mb-3">
                        <label for="end" class="label">종료 일자</label>
                        <input type="date" class="form-control" v-model="endday">
                    </div>
                    <div class="mb-3">
                    <table style="width:100%">
                    <tr>
                    <td width="20%"></td>
                    <td width="30%">배경색</td>
                    <td width="30%">글자색</td>
                    <td width="20%"></td>
                    </tr>
                    <tr>
                    <td width="20%"></td>
                    <td width="30%"><input type="color" v-model="bcolor" required></td>
                    <td width="30%"><input type="color" v-model="fcolor" required></td>
                    <td width="20%"></td>
                    </tr>
                    </table>
                    </div>
                    <div>
                    <button type="submit" class="btn btn-wine" @click="deleteBtn()">삭제</button>
                    </div>
            </div>
			</div>
		</div>
	</div>
	<script>
	
  let mypageApp=Vue.createApp({
	  data(){
		  return{
			  vo:{},
			  events:[],
			  memo:[],
			  event:[],
			  showModal:false,
			  sModal:false,
			  subject:'',
			  content:'',
			  startday:'',
			  endday:'',
			  bcolor:'#ffffff',
			  fcolor:'#000000',
			  state:''
		  }
	  },
	  methods:{
		  deleteBtn(){
			  axios.get('../mypage/memoDelete.do',{	
				 params:{
					 meno:this.vo.meno
				 }
		  }).then(response=>{
					 this.cList()
					 this.vo={}
					 this.cModal(false)
				 })
		  },
		  submitBtn(){
			  if(this.subject===''){
				  return
			  }
			  if(this.content===''){
				  return
			  }
			  if(this.startday===''){
				  return
			  }
			  if(this.endday===''){
				  return
			  }
			  axios.post('../mypage/memoInsert.do',null,{
				  params:{
					  subject:this.subject,
					  content:this.content,
					  startday:this.startday,
					  endday:this.endday,
					  bcolor:this.bcolor,
					  fcolor:this.fcolor
				  }
			  }).then(response=>{
				  this.changeModal(false)
				  this.cList()
			  }).catch(error=>{
				  console.log(error.response)
			  })
		  },
		  cList(){
			  axios.get('../mypage/getReserve.do')
			  .then(response=>{
				  this.events=response.data.events
				  this.memo=response.data.memo
				  this.initCalendar()
			  }).catch(error=>{
				  console.log(error.response)
			  })
		  },
		  loadEvents() {
			  console.log(this.events)
	            let event = []
	            for(let i of this.events){
	            	event.push({
	            		title: i.evo.title,
	                    start: i.evo.eday,
	                    color: '#92CAF0',
	                    id:i.rno+',1'
	            	})
	            }
	           for(let i of this.memo){
	            	event.push({
	            		title: i.subject,
	                    start: i.startday,
	                    end:i.endday===i.startday?null:i.endday+"T23:59",
	                    backgroundColor:i.bcolor,
	                    textColor:i.fcolor,
	                    id:i.meno+',2',
	                    borderColor:i.bcolor==='#ffffff'?'#000000':i.bcolor
	            	})
	            }
	            return event
	      },
	      initCalendar(){
	    	  _this=this
	    	  this.$nextTick(() => {
	    		  let event=this.loadEvents()
	  	        var calendarEl = document.getElementById('calendar');
	  	        var calendar = new FullCalendar.Calendar(calendarEl, {
	  	        	customButtons:{
	  	        		button:{
			  	      		text:'일정 추가',
			  	      		click:function(){
		  	      			_this.showModal=true
	  	      			}
	  	        	}
	  	        },
	  	          headerToolbar:{
	  	        	  left:'prev,next today button',
	  	        	  center:'title',
	  	        	  right:'dayGridMonth,dayGridWeek,dayGridDay'
	  	          },
	  	          selectable: true,
	  	          displayEventTime: false,
	  	          events: event,
	  	        eventClick: this.handleEventClick
	  	        });
	  	        calendar.render();
	  		});
	      },
	      handleEventClick(info){
	    	  let first=info.event.id.split(',')[0]
	    	  let second=info.event.id.split(',')[1]
	    	  this.state=second
	    	  if(second==='1'){
	    		  axios.get('../mypage/reserveDetail.do',{
	    			  params:{
	    				  rno:first
	    			  }
	    		  }).then(response=>{
	    			  console.log(response.data)
	    			  this.vo=response.data
	    		  }).catch(error=>{
	    			  
	    		  })
	    	  }
	    	  else{
	    		  axios.get('../mypage/memoDetail.do',{
	    			  params:{
	    				  meno:first
	    			  }
	    		  }).then(response=>{
	    			  console.log(response.data)
	    			  this.vo=response.data
	    		  }).catch(error=>{
	    			  
	    		  })
	    	  }
	    	  this.cModal(true)
	      },
	      cModal(check){
	    	this.sModal=check  
	      },
	      changeModal(check){
	    	  if(check===false){
	    		  this.subject=''
	    		  this.content=''
	    		  this.startday=''
	        	  this.endday=''
	    	      this.bcolor='#ffffff'
	    		  this.fcolor='#000000'
	    	  }
	    	  this.showModal=check
	      }
	  },
	  mounted(){
		  	this.cList()
			  
	  }
  }).mount('.MyCalendar')
</script>
</body>
</html>
