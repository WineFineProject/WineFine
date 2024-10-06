<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="row" style="width: 1200px;" id="noticeList">
		<h3 class="text-center">공지사항</h3>
		<table class="table">
			<tr>
				<td class="text-right"><a href="../seller/noticeInsert.do" class="btn btn-sm" style="background-color: #FCD500;">글쓰기</a></td>
			</tr>
		</table>
		<table class="table table-hover">
			<tr>
				<th width=10% class="text-center">번호</th>
				<th width=35% class="text-center">제목</th>
				<th width=15% class="text-center">이름</th>
				<th width=15% class="text-center">작성일</th>
				<th width=10% class="text-center">조회수</th>
			</tr>
			<tr v-for="(vo, index) in list">
				<td width=10% class="text-center">{{count-index}}</td>
				<td width=35%><a :href="'../seller/detail.do?nbno='+vo.nbno">{{vo.subject}}</a></td>
				<td width=15% class="text-center">{{vo.nickname}}</td>
				<td width=15% class="text-center">{{vo.dbday}}</td>
				<td width=10% class="text-center">{{vo.hit}}</td>
			</tr>
		</table>
		<table class="table">
			<tr>
				<td class="text-center"><a href="#" class="btn btn-sm btn-danger">이전</a> ${curPage } page / ${totalPage } page <a href="#" class="btn btn-sm btn-danger">다음</a></td>
			</tr>
		</table>
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