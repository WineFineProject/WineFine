<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../tem/css/replydetail.css">
</head>
<body>
	<div class="row" id="noticeList">
		<h3 class="table-title text-center">공지사항</h3>
		<div>
		  <a href="../seller/noticeInsert.do" class="btn btn-sm" style="background-color: #FCD500;margin-bottom: 10px">글쓰기</a>
		</div>
		<table class="table trb">
			<tr>
				<th width=10% class="text-center">번호</th>
				<th width=35% class="text-center">제목</th>
				<th width=15% class="text-center">이름</th>
				<th width=15% class="text-center">작성일</th>
				<th width=10% class="text-center">조회수</th>
			</tr>
			<tr v-for="(vo, index) in list">
				<td width=10% class="text-center">{{count-index}}</td>
				<td width=35%><a :href="'../seller/noticeDetail.do?nbno='+vo.nbno">{{vo.subject}}</a></td>
				<td width=15% class="text-center">{{vo.nickname}}</td>
				<td width=15% class="text-center">{{vo.dbday}}</td>
				<td width=10% class="text-center">{{vo.hit}}</td>
			</tr>
		</table>
		<div class="text-center">
					<button type="button" class="btn btn-sm btn-primary" @click="noticeList(curPage>1?curPage-1:curPage)">이전</button>
					{{curPage}} page / {{totalPage}} page
					<button type="button" class="btn btn-sm btn-primary" @click="noticeList(curPage<totalPage?curPage+1:curPage)">다음</button>
		</div>
	</div>
	<script>
	let noticeApp=Vue.createApp({
		data(){
			return{
				list:[],
				curPage:1,
				totalPage:0,
				count:0
			}
		},
		methods:{
			noticeList(page){
				axios.get('../seller/noticeList.do', {
					params:{
						page:page
					}
				}).then(response=>{
					console.log(response.data)
					this.list=response.data.list
					this.curPage=response.data.curPage
					this.totalPage=response.data.totalPage
					this.count=response.data.count
				})
			}
		},
		mounted(){
			this.noticeList(1)
		}
	}).mount('#noticeList')
	</script>
</body>
</html>