<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="container" id="approvalList">
		<div class="row">
			<table class="table">
			<tr>
				<td width="20%">
					승인 대기 : {{wCount}} 개
				</td>
				<td width="20%">
					승인 반려 : {{dCount}} 개
				</td>
				<td width="60%"></td>
			</tr>
			</table>
			<h4> 승인 대기 목록 </h4>
			<table class="table">
				<tr>
					<th width="15%">상품번호</th>
					<th width="15%">카테고리</th>
					<th width="25%">상품명</th>
					<th width="15%">생산자</th>
					<th width="10%">가격</th>
					<th width="10%">등록일</th>
					<th width="10%">&nbsp;</th>
				</tr>
				<tr v-for="vo in wList" :key="vo.wno">
				  <td width="15%">{{vo.wno}}</td>
				  <td width="15%">{{vo.type}}</td>
				  <td width="25%">{{vo.namekor}}</td>
				  <td width="15%">{{ getMakerName(vo.maker) }}</td>
				  <td width="10%">{{vo.price}}</td>
				  <td width="10%">{{vo.dbday}}</td>
				  <td width="10%">&nbsp;</td>
				</tr>
			</table>
		    <h4> 승인 반려 목록 </h4>
			<table class="table">
				<tr>
					<th width="15%">상품번호</th>
					<th width="15%">카테고리</th>
					<th width="25%">상품명</th>
					<th width="15%">생산자</th>
					<th width="10%">가격</th>
					<th width="10%">등록일</th>
					<th width="10%">삭제</th>
				</tr>
				<tr v-for="vo in dList" :key="vo.wno">
				  <td width="15%">{{vo.wno}}</td>
				  <td width="15%">{{vo.type}}</td>
				  <td width="25%">{{vo.namekor}}</td>
				  <td width="15%">{{ getMakerName(vo.maker) }}</td>
				  <td width="10%">{{vo.price}}</td>
				  <td width="10%">{{vo.dbday}}</td>
				  <td width="10%">
				  	<button type="button" @click="itemDelete(vo)">삭제</button>
				  </td>
				</tr>
			</table>
		</div>
	</div>
<script>
let sellershopApp=Vue.createApp({
	data(){
		return {
			wList:[],
			dList:[],
			wCount:0,
			dCount:0,
			state:0,
			maker:0,
			makerNames: {},
			id:'${sessionScope.userId}'
		}
	},  
	mounted(){
		this.sellerwait()
		this.sellerreturn()
	},
	methods:{
		loadmakername(maker) {
			if (this.makerNames[maker]) {
				return this.makerNames[maker];
			} else {
				axios.get('../seller/prevmaker_vue.do', {
					params: { maker: maker }
				}).then(response => {
					this.makerNames[maker] = response.data
				}).catch(error => {
					console.error(error)
					return 'Unknown'
				})
			}
			return 'Loading...'
		},
		getMakerName(maker) {
			return this.makerNames[maker] || this.loadmakername(maker)
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
 }).mount('#approvalList')
</script>
</body>
</html>