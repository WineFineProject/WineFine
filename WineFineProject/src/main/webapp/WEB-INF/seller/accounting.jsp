<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="container" id="accountingList">
		<div class="row">
			<h4 class="text-center table-title">정산 관리</h4>
			<table class="table" id="coupon-table">
				<tr>
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
			acList:[],
			pList:[],
			grade:0,
			nickname:'${sessionScope.nickName}',
			id:'${sessionScope.userId}'
		}
	},  
	mounted(){
		this.getgrade()
		
	},
	methods:{
		getgrade(){
				axios.get('../seller/getgrade_vue.do', {
					params: { userid:this.id }
				}).then(response => {
					this.grade = response.data
				}).catch(error => {
					console.error(error)
				})
		},
		sellerwait()
		{
			axios.get('../seller/approvalCheck_vue.do', {
				params:{ id:this.id, state:9}
			}).then(response=>{
				this.wList = response.data.list
				this.wCount = response.data.count
			}).catch(error => {
			    console.log(error.response)
			})
		},
		sellerreturn()
		{
			axios.get('../seller/approvalCheck_vue.do', {
				params:{ id:this.id, state:8}
			}).then(response=>{
				this.dList=response.data.list
				this.dCount = response.data.count
			}).catch(error => {
			    console.log(error.response)
			})
		},
		 itemDelete(vo) {
        	if (confirm("정말로 이 상품을 삭제하시겠습니까?")) {
                axios.post('../seller/itemdelete_vue.do', null, {
                    params: { wno: vo.wno } 
                }).then(response => {
                        if (response.data === "OK") {
                            this.dList = this.dList.filter(item => item.wno !== vo.wno)
                            this.dCount = this.dList.length
                            alert("상품이 삭제되었습니다.")
                        } else {
                            alert("삭제 중 오류가 발생했습니다.")
                        }
                    })
                    .catch(error => {
                        console.error(error);
                        alert("삭제 중 오류가 발생했습니다.")
                    })
            	}
            },
	}
 }).mount('#accountingList')
</script>
</body>
</html>