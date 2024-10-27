<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../tem/css/payment.css">
</head>
<body>
	<div class="row" id="myReserveApp">
	<h3 class="table-title">예약내역</h3>
		<table class="table mp">
			<tr>
				<th width="5%" class="text-center">번호</th>
				<th width="30%" class="text-center">이벤트명</th>
				<th width="5%" class="text-center">인원</th>
				<th width="10%" class="text-center">일시</th>
				<th width="20%" class="text-center">주소</th>
				<th width="20%" class="text-center">신청일</th>
				<th width="20%" class="text-center"></th>
			</tr>
			<tr v-if="list.length===0"><td colspan="7">예약내역이 없습니다</td></tr>
			<tr v-for="vo in list">
				<td width="5%" class="text-center">{{vo.rno}}</td>
				<td width="30%" class="text-center">{{vo.evo.title}}</td>
				<td width="5%" class="text-center">{{vo.person}}</td>
				<td width="10%" class="text-center">{{vo.evo.eday}}</td>
				<td width="20%" class="text-center">{{vo.evo.address}}</td>
				<td width="20%" class="text-center">{{vo.dbday}}</td>
				<td width="10%" class="text-center"><button class="btn btn-sm border-wine" @click="deleteReserve(vo.rno)">취소</button></td>
			</tr>
		</table>
		<div style="height: 10px;"></div>
		<div class="text-center">
			<button class="btn btn-sm btn-wine" @click="rList(curPage>1?curPage-1:curPage)">이전</button>
			{{curPage}}page/{{totalPage}}page
			<button class="btn btn-sm btn-wine" @click="rList(curPage<totalPage?curPage+1:curPage)">다음</button>
		</div>
	</div>
	<script>
	let myReserveApp=Vue.createApp({
		data(){
			return{
				list:[],
				curPage:0,
				totalPage:0,
				today:'${today}'
			}
		},
		methods:{
			rList(page){
				axios.get('../event/vueMyReserveList.do', {
					params:{
						page:page
					}
				}).then(response=>{
					this.list=response.data.list
					this.curPage=response.data.curPage
					this.totalPage=response.data.totalPage
				})
			},
			deleteReserve(rno){
				axios.get('../mypage/vueDeleteReserve.do', {
					params:{
						rno:rno
					}
				}).then(response=>{
					this.rList(1)
				})
			}
		},
		mounted(){
			this.rList(1)
		}
	}).mount('#myReserveApp')
	</script>
</body>
</html>