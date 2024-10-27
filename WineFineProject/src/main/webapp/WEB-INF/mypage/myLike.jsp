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
<div class="row" id="myLikeApp">
	<h3 class="table-title">좋아요</h3>
		<table class="table mp">
			<tr>
				<th width="5%" class="text-center">번호</th>
				<th width="5%" class="text-center"></th>
				<th width="35%" class="text-center">제품명</th>
				<th width="25%" class="text-center">업체명</th>
				<th width="10%" class="text-center">타입</th>
				<th width="10%" class="text-center">가격</th>
				<th width="10%" class="text-center"></th>
			</tr>
			<tr>
			<td v-show="list.length===0" colspan="7">좋아요를 누른 제품이 없습니다</td>
			</tr>
			<tr v-for="vo in list">
				<td width="5%" class="text-center">{{vo.lno}}</td>
				<td width="5%" class="text-center"><img :src="vo.wvo.poster" style="width:40px;height: 58px"></td>
				<td width="35%" class="text-center"><a :href="'../shop/detailBefore.do?wno='+vo.wno">{{vo.wvo.namekor}}</a></td>
				<td width="25%" class="text-center">{{vo.wvo.mvo.nickName}}</td>
				<td width="10%" class="text-center">{{vo.wvo.type}}</td>
				<td width="10%" class="text-center">{{vo.wvo.price}}</td>
				<td width="10%" class="text-center"><button class="btn btn-sm btn-border-wine" @click="deleteLike(vo.lno)">취소</button></td>
			</tr>
		</table>
		<div style="height: 10px;"></div>
		<div class="text-center">
			<button class="btn btn-sm btn-wine" @click="lList(curPage>1?curPage-1:curPage)">이전</button>
			{{curPage}}page/{{totalPage}}page
			<button class="btn btn-sm btn-wine" @click="lList(curPage<totalPage?curPage+1:curPage)">다음</button>
		</div>
	</div>
<script>
let myLikeApp=Vue.createApp({
	data(){
		return{
			list:[],
			curPage:1,
			totalPage:1
		}
	},
	methods:{
		lList(page){
			axios.get('../mypage/vueLikeList.do', {
				params:{
					page:page
				}
			}).then(response=>{
				this.list=response.data.list
				this.curPage=response.data.curPage
				this.totalPage=response.data.totalPage
			})
		},
		deleteLike(lno){
			axios.get('../mypage/vueLikeDelete.do', {
				params:{
					lno:lno
				}
			}).then(response=>{
				this.lList(1)
			})
		}
	},
	mounted(){
		this.lList(1)
	}
}).mount('#myLikeApp')
</script>
</body>
</html>