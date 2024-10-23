<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<style>
#accountingList{
	width: 1120px;
	margin-left: 10px;
}
#table222{
	 text-align: center;
	 display: inline;
}
.acctopbtn{
	border:none;
	color:darkred;
}
#atlistth{
    background-color: #f8f8f8;
    color: #333;
}
.acccheck{
	border-left: hidden;
	border-right: hidden;
	border-top: hidden;
	border-bottom:2px solid #E66E5B !important;
	text-align: center;
	padding-top:10px;
	padding-bottom:10px;
}
.accchecktd{
	border-bottom:2px solid #E66E5B !important;
	text-align: center;
	padding-top: 10px;
	padding-bottom:10px;
	color:black;
}
.acheckbtn{
	display: inline;
	width: 200px;
	height:40px;
	vertical-align: bottom;
	margin-top: 70px;
}
</style>
</head>
<body>
	<div class="container" id="accountingList">
		<div class="row">
			<h4 class="text-center table-title">정산 관리</h4>
			<div class="row">
			<table class="table" id="table222" style="width:50%;">
			<tr id="atlistth">
				<th class="acccheck">정산 신청일</th>
				<th class="acccheck">정산 신청가능금액</th>
				<th class="acccheck">정산 신청</th>
				<th class="acccheck">정산 정보</th>
			</tr>
			<tr>
			<td class="accchecktd">{{today}}</td>
			<td class="accchecktd">{{formatPoint(point)}}</td>
			<td class="accchecktd">
			<button class="btn-lg acctopbtn" @click="accSubmit()"><i class="fa-duotone fa-solid fa-wallet"></i></button>
			</td>
			<td class="accchecktd">
			<button class="btn-lg acctopbtn"><i class="fa-solid fa-circle-info"></i></button>
			</td>
			</tr>
			</table>
			<span style="width:40%;">&nbsp;</span>
			<button class="btn-sm acheckbtn" @click="dataRecv()" style="width:10%;">정산내역 조회</button>
			</div>
			<table class="table" id="coupon-table" width="60%">
				<tr id="atlistth">
					<th width="15%">정산번호</th>
					<th width="15%">정산신청일</th>
					<th width="15%">정산완료일</th>
					<th width="10%">정산상태</th>
					<th width="15%">정산금</th>
					<th width="15%">수수료</th>
					<th width="10%">VAT</th>
				</tr>
				<tr v-for="vo in aList" :key="vo.acno" id="inner-table">
				  <td width="15%">{{vo.acno}}</td>
				  <td width="15%">{{vo.rdbday}}</td>
				  <td width="15%">{{vo.edbday}}</td>
				  <td width="10%">{{vo.state}}</td>
				  <td width="15%">{{vo.amount}}</td>
				  <td width="15%">{{vo.fee}}</td>
				  <td width="10%">{{vo.vat}}</td>
				</tr>
			</table>
		</div>
	</div>
<script>
let accountinglistApp=Vue.createApp({
	data(){
		return {
			aList:[],
			pList:[],
			grade:0,
			point:0,
			today:'',
			fee:0,
			vat:0,
			finalpoint:0,
			nickname:'${sessionScope.nickName}',
			id:'${sessionScope.userId}'
		}
	},  
	mounted(){
		this.getinfo()
		this.getToday()
	},
	methods:{
		dataRecv(){
			axios.get('../seller/accList_vue.do',{
				params:{
					id:this.id,
				}
			}).then(response=>{
			     this.aList = response.data		
			}).catch(error=>{
				console.log(error.response)
			})
		},  
		getinfo(){
				axios.get('../seller/getinfo_vue.do', {
					params: { userid:this.id }
				}).then(response => {
					this.grade = response.data.grade
					this.point = response.data.point
					
				}).catch(error => {
					console.error(error)
				})
		},
		getToday(){
			axios.get('../seller/today_vue.do')
		    .then(response => {
		        this.today=response.data
		    })
		    .catch(error => {
		        console.error(error)
		    })
		},
		calculateFees(){
			const grade=this.grade
			const point=this.point
			let commissionRate
			
			switch (grade) {
            case 1:
                commissionRate = 0.07
                break;
            case 2:
                commissionRate = 0.05
                break;
            case 3:
                commissionRate = 0.03
                break;
            default:
                commissionRate = 0.0
                break;
             }
			const fee = Math.floor(point * commissionRate)
			const vat = Math.floor(fee * 0.10)
			const finalpoint = point - fee - vat
			
		        this.fee = fee
		        this.vat = vat
		        this.finalpoint = finalpoint
		     
		},
		accSubmit(){
			 axios.post('../seller/accSubmit_vue.do', null, {
                 params: { userid: this.id,
                	 	   grade: this.grade,
                	 	   amount: this.finalpoint,
                	 	   fee: this.fee,
                	 	   vat: this.vat} 
             }).then(response => {
            	 if (response.data === "yes") {
            		 this.acnoUpdate()            	 
            	 }
             }).catch(error => {
            	 console.error(error)
             })
		},
		acnoUpdate(){
			axios.post('../seller/acnoUpdate_vue.do', null, {
				params: {}
            }).then(response => {
           	 if (response.data === "yes") {          	 
                    alert("정산이 요청되었습니다.")
                  	 this.dataRecv()
           	 }
            }).catch(error => {
           	 console.error(error)
            })
		},
        formatPoint(point) {
                const numericValue = point.toString().replace(/[^0-9]/g, '')
                const formattedValue = numericValue.replace(/\B(?=(\d{3})+(?!\d))/g, ',') + (numericValue ? '원' : '')
                return formattedValue
          }
	}
 }).mount('#accountingList')
</script>
</body>
</html>