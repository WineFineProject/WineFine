<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../tem/css/payment.css">
</head>
<body>
	<div class="container" id="accCheckList">
		<div class="row">
			<table class="table" style="margin-bottom: 30px">
			<tr>
				<td width="20%">
					승인 대기 : {{accCount}} 개
				</td>
				<td width="80%"></td>
			</tr>
			</table>
			<h4 class="text-center table-title">정산 승인 대기 목록</h4>
			<table class="table mp">
				<tr>
					<th width="10%">정산번호</th>
					<th width="10%">판매자 ID</th>
					<th width="15%">정산 신청일</th>
					<th width="10%">정산상태</th>
					<th width="15%">정산금</th>
					<th width="15%">수수료</th>
					<th width="10%">VAT</th>
					<th width="15%">승인/반려</th>
				</tr>
				<tr v-for="vo in aList" :key="vo.acno" class="mp">
				  <td width="10%">{{vo.acno}}</td>
				  <td width="10%">{{vo.userid}}</td>
				  <td width="15%">{{vo.rdbday}}</td>
				  <td width="10%"> 정산 신청 </td>
				  <td width="15%">{{formatPoint(vo.amount)}}</td>
				  <td width="15%">{{formatPoint(vo.fee)}}</td>
				  <td width="10%">{{formatPoint(vo.vat)}}</td>
				  <td width="15%">
				  <button class="btn abtn abtn1" @click="accUpdate(vo.acno, 1)"><i class="fa-solid fa-square-check fa-lg"></i></button>
				  <button class="btn abtn abtn2" @click="accUpdate(vo.acno, 2)"><i class="fa-solid fa-square-xmark fa-lg"></i></button>
				  </td>
				</tr>
			</table>
		</div>
	</div>
<script>
let accCheckApp=Vue.createApp({
	data(){
		return {
			aList:[],
			accCount:0,
			state:0,
			acno:0,
			id:'${sessionScope.userId}'
		}
	},  
	mounted(){
		this.dataRecv()
	},
	methods:{
		dataRecv(){
			axios.get('../admin/acclist_vue.do',{
				params:{
				}
			}).then(response=>{
		        this.aList = response.data	
		        this.accCount = response.data.length
			}).catch(error=>{
				console.log(error.response)
			})
		},  
		accUpdate(acno, state) {
	        axios.post('../admin/accUpdate_vue.do', null, {
	            params: { acno: acno, state: state }
	        })
	        .then(response => {
	            if (response.data === "yes") {
	                if(state === 1){
	            	alert("정산 승인했습니다.")
	                this.dataRecv()
	                }
	                if(state === 2){
	            	alert("정산 반려했습니다.")
	                this.dataRecv()
	                }
	            } else {
	                alert("정산 승인/반려에 실패했습니다.")
	            }
	        })
	        .catch(error => {
	            console.error(error)
	        })
	    },
		 formatPoint(point) {
            const numericValue = point.toString().replace(/[^0-9]/g, '')
            const formattedValue = numericValue.replace(/\B(?=(\d{3})+(?!\d))/g, ',') + (numericValue ? '원' : '')
            return formattedValue
     		 }
		}
 }).mount('#accCheckList')
</script>
</body>
</html>