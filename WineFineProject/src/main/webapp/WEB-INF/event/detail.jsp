<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트 상세 페이지</title>
<style>
.namekor {
	font-size: 32px;
	font-weight: bold;
	color: black;
}

.nameeng {
	font-size: 20px;
	color: gray;
	margin-left: 10px;
}

table {
	border-collapse: collapse;
}

.item, .ti {
	border: 1px solid #ccc;
	padding: 10px 5px 10px 5px;
	text-align: center;
}

.item {
	color: black;
	background-color: #D9D9D9;
}

.listBtn {
	background-color: #96C4FF;
}

.reserveBtn {
    background-color: #DB3774;
}
.reserveBtn, .listBtn {
	cursor: pointer;
	margin-top: 20px;
	padding: 0px;
	width: 200px;
	height: 50px;
	align-content: center;
	font-weight:bold;
	border: none;
	border-radius: 20px;
	color: white;
	margin-left: 5px;
}

.header-line {
	border-top: 3px solid black;
	margin-top: 10px;
}

.button-container {
	text-align: center;
	margin-top: 20px;
}

#flavor {
	display: flex;
	display: flex;
	gap: 20px;
}

.left-align {
	text-align: left;
}

.fa-circle {
	color: lightgray;
}

.fa-circle.filled {
	color: #CF1D56;
}

.wine-type {
	display: inline-block;
	padding: 3px 8px; 
	border-radius: 10px; 
	font-weight: bold;
	font-size: 14px; 
}

.type-red {
	color: #fff;
	background-color: #bb2d3b;
	border: 1px solid #dc3545; 
}

.type-white {
	color: #000000;
	background-color: #ffffff;
	border: 1px solid #000000;
}

</style>
</head>
<body>
<div class="container" id="eventDetail" style="margin-top: 50px">
		<div class="row">
			<div class="col-sm-12">
				<div class="row" style="width:1000px;margin: auto">
		            <div style="padding: 0px !important">
		                <span class="namekor">{{vo.title}}</span>
		                <div style="height: 10px"></div>
		                <div>📆&nbsp;{{vo.eday}}</div>
		                <div class="header-line"></div>
		            </div>
		            <table>
							<tbody>
								<tr v-if="vo.address!==null">
									<th class="item" style="width: 20%">장소</th>
									<td class="left-align ti">&nbsp;{{vo.address}}</td>
								</tr>
								<tr v-show="vo.maxperson!==null">
									<th class="item">총 예약 가능 인원</th>
									<td class="left-align ti">&nbsp;{{vo.maxperson}}명</td>
								</tr>
							</tbody>
						</table>
		            <div style="margin-top: 50px;" class="text-center">
		                <img :src="img" v-for="img in pList" style="width: 80%">
		            </div>
				 <div class="button-container" style="margin-bottom: 500px"> 
		           <input type="button" class="reserveBtn" @click="isLoggedIn ? changeModal(true) : showAlert('로그인 후 예약할 수 있습니다.')" value="예약하기">
		           <input type="button" class="listBtn" @click="List" value="목록">
		         </div>
		         <div class="modal" :class="{ show: showModal }" @click.self="changeModal(false)">
					<div class="modal-content" style="width: 650px; height: 400px;">
						<h3 class="text-center">예약 신청</h3>
						<table class="table">
						<br>
						   <tr>
							  <th class="item" style="width: 20%">이벤트명</th>
							  <td class="left-align ti">&nbsp;{{vo.title}}</td>
							</tr>
							<tr>
							  <th class="item" style="width: 20%">장소</th>
							  <td class="left-align ti">&nbsp;{{vo.address}}</td>
							</tr>
							<tr>
							  <th class="item" style="width: 20%">날짜</th>
							  <td class="left-align ti">&nbsp;{{vo.eday}}</td>
							</tr>
							<tr>
							 <th class="item" style="width: 20%">예약 인원</th>
							  <td class="left-align ti"><input type="number" size=20 v-model="person" min="1" max="30">&nbsp;명</td>
							</tr>
						</table>
						<div  style="display: flex; justify-content: flex-end;">
						<button type="button" class="btn btn-lg btn-reserve" @click="reserveInsert(vo.weno)">예약</button>
						</div>
					</div>
				</div>
              </div>
	       </div>
		</div>
	</div>
    <script>
        let eventDetailApp = Vue.createApp({
        	 data() {
                 return {
                	 vo: {},
                	 pList:[],
                	 weno:${weno},
                	 showModal:false,
                	 person:1,
                	 isLoggedIn: <%= session.getAttribute("isLoggedIn") != null ? "true" : "false" %>
                 }
             },
             mounted() {
                 this.dataRecv()
             },
             methods: {
            	 showAlert(message) {
            	        alert(message)
            	    },
                 dataRecv() {
                     axios.get('../event/detailVue.do',{
                    	 params:{
             				weno:this.weno
             			}
                     }).then(response=>{
                    	 console.log(response.data)
                             this.vo=response.data.vo
                             this.pList=response.data.pList
                         }).catch(error=>{
                             console.error(error)
                         })
                 },
                 List() {
                     window.location.href='../event/list.do'
                 },
                 changeModal(check){
                	 this.showModal=check
                 },
                 reserveInsert(weno){
                	 axios.get('../event/reservePerson.do', {
                		 params:{
                			 weno:weno
                		 }
                	 }).then(response=>{
                		 if(response.data+this.person<=this.vo.maxperson){
		                	 axios.post('../event/reserveInsert.do', null, {
		     					params:{
		                           weno:weno,
		                           person:this.person
		     					}
		     				}).then(response=>{
		     					this.showModal=false
		     					alert('예약이 완료되었습니다')
		     				})
                		 }
                		 else{
                			 alert('예약가능한 인원을 초과하였습니다')
                		 }
                	 })
                 }
             }
        }).mount('#eventDetail')
    </script>
</body>
</html>