<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트 상세 페이지</title>
<link rel="stylesheet" href="../tem/css/event.css">
<style>
table {
	border-collapse: collapse;
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
		            <div style="height: 50px"></div>
			    <div class="row">
			      <div id="map" style="width:100%;height:500px;"></div>
			    </div>
			    <div style="height: 30px"></div>
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
                	 address:'',
                	 person:1,
                	 isLoggedIn: false,
                	 sessionId:'${sessionScope.userId}'
                 }
             },
             mounted() {
            	 if(this.sessionId!=='')
            		 this.isLoggedIn=true
            	this.dataRecv()
             },
             methods: {
            	 dataRecv() {
                     axios.get('../event/detailVue.do',{
                    	 params:{
             				weno:this.weno
             			}
                     }).then(response=>{
                    	 console.log(response.data)
                             this.vo=response.data.vo
                             this.pList=response.data.pList
                             this.address = response.data.vo.address
                             if(window.kakao && window.kakao.map)
              			   {
              				   console.log("initMap")
              	   			   this.initMap()
              			   }
              			   else
              			   {
              				   console.log("addScript")
              	   			   this.addScript()
              			   }
                         }).catch(error=>{
                             console.error(error)
                         })
                 },
            	 showAlert(message) {
            	        alert(message)
            	    },
                 
                 List() {
                     window.location.href='../event/list.do'
                 },
                 changeModal(check){
                	 this.showModal=check
                 },
                 reserveInsert(weno){
                	 let today = new Date(); 
                	 let eventDate = new Date(this.vo.eday);
                	 
                	 if (eventDate < today) {
                	        alert('이미 종료된 이벤트입니다');
                	        this.showModal=false
                	        return;
                	    }
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
                 },
                 addScript(){
      			   const script=document.createElement("script") // <script>
      			   /* globel kakao */
      			   script.onload=()=>kakao.maps.load(this.initMap)
      			   script.src="https://dapi.kakao.com/v2/maps/sdk.js?autoload=false&appkey=81b614544bac2d13f8e340a9007323f8&libraries=services"
      			   document.head.appendChild(script)
      		   },
      		   initMap(){
      			 if (!this.address) {
      		        console.error("주소가 유효하지 않습니다:", this.address);
      		        return; // 주소가 유효하지 않으면 메소드 종료
      		    }
      			   var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
      			    mapOption = {
      			        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
      			        level: 3 // 지도의 확대 레벨
      			    };  

      			// 지도를 생성합니다    
      			var map = new kakao.maps.Map(mapContainer, mapOption); 

      			// 주소-좌표 변환 객체를 생성합니다
      			var geocoder = new kakao.maps.services.Geocoder();

      			// 주소로 좌표를 검색합니다
      			geocoder.addressSearch(this.address, function(result, status) {

      			    // 정상적으로 검색이 완료됐으면 
      			     if (status === kakao.maps.services.Status.OK) {

      			        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

      			        // 결과값으로 받은 위치를 마커로 표시합니다
      			        var marker = new kakao.maps.Marker({
      			            map: map,
      			            position: coords
      			        });

      			        // 인포윈도우로 장소에 대한 설명을 표시합니다
      			        var infowindow = new kakao.maps.InfoWindow({
      			            content: '<div style="width:150px;text-align:center;padding:6px 0;">'+'시음회 장소'+'</div>'
      			        });
      			        infowindow.open(map, marker);

      			        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
      			        map.setCenter(coords);
      			    } 
      			}); 
      			
      		   }
             }
        }).mount('#eventDetail')
    </script>
</body>
</html>