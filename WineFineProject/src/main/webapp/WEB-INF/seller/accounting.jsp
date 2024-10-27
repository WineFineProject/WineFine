<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link rel="stylesheet" href="../tem/css/orderlist.css">
</head>
<body>
	<div class="container" id="accountingList">
		<div class="row">
			<h3 class="text-center table-title">정산 관리</h3>
			<div class="row" style="padding:0px">
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
			<button class="btn-lg acctopbtn" @click="changeModal(true)"><i class="fa-solid fa-circle-info"></i></button>
			</td>
			</tr>
			</table>
			<span style="width:40%;">&nbsp;</span>
			<!--  
			<button class="btn-sm acheckbtn" @click="dataRecv()" style="width:10%;">정산내역 조회</button>
			-->
			</div>
			<table class="table acctable" id="coupon-table" width="60%">
				<tr id="atlistth">
					<th width="15%">정산번호</th>
					<th width="15%">정산신청일</th>
					<th width="15%">정산완료일</th>
					<th width="10%">정산상태</th>
					<th width="15%">정산금</th>
					<th width="15%">수수료</th>
					<th width="10%">VAT</th>
				</tr>
				<tr v-if="aList.length===0"><td colspan="7">정산 목록이 없습니다</td></tr>
				<tr v-for="vo in aList" :key="vo.acno" id="inner-table">
				  <td width="15%">{{vo.acno}}</td>
				  <td width="15%">{{vo.rdbday}}</td>
				  <td width="15%">{{vo.edbday}}</td>
				  <td width="10%">
				  {{ vo.state === 0 ? '정산 신청' : vo.state === 1 ? '정산 완료' : vo.state === 2 ? '정산 반려' : ' ' }}</td>
				  <td width="15%">{{formatPoint(vo.amount)}}</td>
				  <td width="15%">{{formatPoint(vo.fee)}}</td>
				  <td width="10%">{{formatPoint(vo.vat)}}</td>
				</tr>
			</table>
		</div>
		<div class="modal" :class="{ show: showModal }" @click.self="changeModal(false)">
			<div class="modal-content">
				<span class="close" @click="changeModal(false)">&times;</span>
				<table class="table" style="margin-top: 50px; border: 1px solid lightgray;">
					<tr>
						<th width="30%">정산 신청 ID : </th>
						<td width="70%">{{id}}</td>
					</tr>
					<tr>
						<th width="30%">판매자등급 : </th>
						<td width="70%">{{grade}}</td>
					</tr>
					<tr>
						<th width="30%">수수료(%) : </th>
						<td width="70%">{{rate}}% </td>
					</tr>
					<tr>
						<th width="30%">예금주 : </th>
						<td width="70%">
						<input type="text" style="width: 300px; height:30px;" v-model="iholder">
						</td>
					</tr>
					<tr>
						<th width="30%">계좌번호:</th>
						
						<td width="70%">
						<input type="text" style="width: 300px; height:30px;" v-model="iaccountnum" placeholder="숫자만 입력해주세요">
					</tr>
					<tr>
						<td colspan="2" class="rmbtn">
							<button type="button" class="rmbtn btn-sm btn-danger" @click="accinfoinsert()" v-if="holder=='' && accountnum==''">추가</button>
							<button type="button" class="rmbtn btn-sm btn-danger" @click="accinfoupdate()" v-else>저장</button>
							<button type="button" class="rmbtn btn-sm btn-secondary" @click="changeModal(false)">취소</button>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
<script>
let accountinglistApp=Vue.createApp({
	data(){
		return {
			aList:[],
			acList:[],
			grade:0,
			point:0,
			today:'',
			fee:0,
			vat:0,
			finalpoint:0,
			iholder:'',
			holder:'',
			iaccountnum:'',
			accountnum:'',
			rate:0,
			prate:0,
			showModal:false,
			nickname:'${sessionScope.nickName}',
			id:'${sessionScope.userId}'
		}
	},  
	mounted(){
		this.getinfo()
		this.getToday()
		this.dataRecv()
	},
	methods:{
		dataRecv(){
			axios.get('../seller/accList_vue.do',{
				params:{
					userid:this.id,
				}
			}).then(response=>{
				if (!response.data || response.data.length === 0) {
		            return
		        }
		        this.aList = response.data	
			}).catch(error=>{
				console.log(error.response)
			})
		},  
		changeModal(check, order=null){
			this.showModal=check
			this.getaccinfo()
		},
		getinfo(){
				axios.get('../seller/getinfo_vue.do', {
					params: { userid:this.id }
				}).then(response => {
					this.grade = response.data.grade
					this.point = response.data.point
					this.getrate()
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
			const rate=this.rate
			
			const fee = Math.floor(point * rate * 0.01)
			const vat = Math.floor(fee * 0.10)
			const finalpoint = point - fee - vat
			
		    this.fee = fee
		    this.vat = vat
		    this.finalpoint = finalpoint
		},
		getrate()
		{
			const grade=this.grade
			let prate
			switch (grade) {
            case 1:
                prate = 7
                break;
            case 2:
                prate = 5
                break;
            case 3:
                prate = 3
                break;
            default:
                prate = 0
                break;
             }
				this.rate=prate
		},
		accSubmit(){
			  this.calculateFees()
			  if(this.point==0)
				  {
				  	alert("정산 신청이 불가능합니다.")
				  	return
				  }
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
                  	 this.getinfo()
           	 }
            }).catch(error => {
           	 console.error(error)
            })
		},
		getaccinfo(){
			axios.get('../seller/getaccinfo_vue.do', {
				params: { userid:this.id }
			}).then(response => {
				this.iholder=response.data.holder
				this.holder=response.data.holder
				this.iaccountnum=response.data.accountnum
				this.accountnum=response.data.accountnum
			}).catch(error => {
				console.error(error)
			})
		},
		accinfoinsert(){
			axios.post('../seller/accinfoinsert_vue.do', null, {
				params: {userid:this.id,
						 grade:this.grade,
						 holder:this.iholder,
						 accountnum:this.iaccountnum,
						 feerate:this.rate
				}
            }).then(response => {
           	 if (response.data === "yes") {          	 
                    alert("정산정보가 추가되었습니다.")
                  	 this.showModal=false
           	 }
            }).catch(error => {
           	 console.error(error)
            })
		},
		accinfoupdate(){
			axios.post('../seller/accinfoupdate_vue.do', null, {
				params: {userid:this.id,
						 grade:this.grade,
						 holder:this.iholder,
						 accountnum:this.iaccountnum,
						 feerate:this.rate
				}
            }).then(response => {
           	 if (response.data === "yes") {          	 
                    alert("정산정보가 저장되었습니다.")
                  	 this.showModal=false
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