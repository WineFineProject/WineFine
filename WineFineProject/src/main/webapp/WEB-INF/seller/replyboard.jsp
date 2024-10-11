<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="row" style="width: 1200px;" id="replyBoardList">
		<h3 class="text-center">공지사항</h3>
		<table class="table">
			<tr>
				<td class="text-right">
					<a href="../seller/noticeInsert.do" class="btn btn-sm" style="background-color: #FCD500;">글쓰기</a>
				</td>
			</tr>
		</table>
		<table class="table table-hover">
			<tr>
				<th width=10% class="text-center">번호</th>
				<th width=35% class="text-center">제목</th>
				<th width=12% class="text-center">이름</th>
				<th width=10% class="text-center">작성일</th>
				<th width=7% class="text-center">조회수</th>
				<th width=10% class="text-center">상태</th>
			</tr>
			<tr v-for="(vo, index) in list">
				<td width=10% class="text-center">{{count-index}}</td>
				<td width=35%>{{vo.subject}}</td>
				<td width=12% class="text-center">{{vo.nickname}}</td>
				<td width=10% class="text-center">{{vo.dbday}}</td>
				<td width=7% class="text-center">{{vo.hit}}</td>
				<td width=10% class="text-center">{{vo.hit}}</td>
			</tr>
		</table>
		<table class="table">
			<tr>
				<td class="text-center">
					<a href="#" class="btn btn-sm btn-danger">이전</a>
					${curPage } page / ${totalPage } page
					<a href="#" class="btn btn-sm btn-danger">다음</a>
				</td>
			</tr>
		</table>
	</div>
	<script>
		
	</script>
</body>
</html>