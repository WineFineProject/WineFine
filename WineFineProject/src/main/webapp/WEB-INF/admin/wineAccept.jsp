<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="row" id="adminItemApp">
		<table class="table">
			<tr>
				<th width="7%" class="text-center">번호</th>
				<th width="7%" class="text-center"></th>
				<th width="30%" class="text-center">이름</th>
				<th width="15%" class="text-center">판매자</th>
				<th width="15%" class="text-center">가격</th>
				<th width="15%" class="text-center">신청일</th>
				<th width="21%" class="text-center"></th>
			</tr>
			<template v-for="(vo, index) in list">
				<tr>
					<td width="7%" class="text-center">{{vo.wno}}</td>
					<td width="7%" class="text-center">
						<img :src="vo.poster">
					</td>
					<td width="30%" class="text-center">{{vo.namekor}}</td>
					<td width="15%" class="text-center">{{vo.mvo.nickName}}</td>
					<td width="15%" class="text-center">{{vo.price}}원</td>
					<td width="15%" class="text-center">{{vo.dbday}}</td>
					<td width="21%" class="text-center">
						<button>승인</button>
					</td>
				</tr>
				<tr v-show="isShow[index]">
					<td colspan="7" style="padding: 0px;">
						<table class="table"></table>
					</td>
				</tr>
			</template>
		</table>
	</div>
	<script>
	let adminItemApp=Vue.createApp({
		data(){
			return{
				list:[],
				curPage:1,
				totalPage:0,
				isShow:Array(10).fill(false)
			}
		}
	})
	</script>
</body>
</html>