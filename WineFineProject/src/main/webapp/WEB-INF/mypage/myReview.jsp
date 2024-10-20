<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="row" id="myReviewApp">
		<table class="table">
			<tr>
				<th width="5%" class="text-center">번호</th>
				<th width="7%" class="text-center"></th>
				<th width="30%" class="text-center">제품명</th>
				<th width="30%" class="text-center">리뷰내용</th>
				<th width="5%" class="text-center">평점</th>
				<th width="13%" class="text-center">작성일</th>
				<th width="10%" class="text-center"></th>
			</tr>
			<tr v-for="vo in list">
				<td width="5%" class="text-center">{{vo.wrvno}}</td>
				<td width="7%" class="text-center"><img :src="vo.wvo.poster" width="100%"></td>
				<td width="30%">{{vo.wvo.namekor}}</td>
				<td width="30%">{{vo.content}}</td>
				<td width="5%" class="text-center">{{vo.srating}}</td>
				<td width="13%" class="text-center">{{vo.dbday}}</td>
				<td width="10%" class="text-center"><button class="btn btn-sm border-wine" @click="deleteReview(vo.wrvno, vo.wno)">삭제</button></td>
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
				totalPage:0
			}
		},
		methods:{
			rList(page){
				axios.get('../mypage/myReviewList.do', {
					params:{
						page:page
					}
				}).then(response=>{
					this.list=response.data.list
					this.curPage=response.data.curPage
					this.totalPage=response.data.totalPage
				})
			},
			deleteReview(wrvno, wno){
				axios.get('../mypage/myReviewDelete.do', {
					params:{
						wrvno:wrvno,
						wno:wno
					}
				}).then(response=>{
					this.rList(1)
				})
			}
		},
		mounted(){
			this.rList(1)
		}
	}).mount('#myReviewApp')
	</script>
</body>
</html>