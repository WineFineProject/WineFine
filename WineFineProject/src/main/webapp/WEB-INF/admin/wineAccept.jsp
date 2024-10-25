<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../tem/css/payment.css">
</head>
<body>
	<div class="row" id="adminItemApp">
	 <h3 class="table-title">상품 등록/수정 대기</h3>
		<table class="table mp">
			<tr>
				<th width="7%" class="text-center">품번</th>
				<th width="7%" class="text-center"></th>
				<th width="30%" class="text-center">이름</th>
				<th width="15%" class="text-center">판매자</th>
				<th width="10%" class="text-center">타입</th>
				<th width="10%" class="text-center">가격</th>
				<th width="10%" class="text-center">신청일</th>
				<th width="21%" class="text-center">승인/반려</th>
			</tr>
			<template v-for="(vo, index) in list">
				<tr @click="checkInfo(index)">
					<td width="7%" class="text-center">{{vo.wno}}</td>
					<td width="7%" class="text-center">
						<img :src="vo.poster" width="35px" style="max-height: 55px;">
					</td>
					<td width="30%" class="text-center">{{vo.namekor}}</td>
					<td width="15%" class="text-center">{{vo.mvo.nickName}}</td>
					<td width="10%" class="text-center">{{vo.type}}</td>
					<td width="10%" class="text-center">{{vo.price}}</td>
					<td width="10%" class="text-center">{{vo.dbday}}</td>
					<td width="21%" class="text-center">
						<button class="btn abtn abtn1" @click="wineAccept(vo.wno)"><i class="fa-solid fa-square-check fa-lg"></i></button>
						<button class="btn abtn abtn2" @click="wineRejection(vo.wno)"><i class="fa-solid fa-square-xmark fa-lg"></i></button>
					</td>
				</tr>
				<tr v-if="isShow[index]">
					<td colspan="7" style="padding: 0px;">
						<table class="table mp" style="margin-bottom: 0;">
							<tr>
								<th width="30%" class="text-center">영문명</th>
								<th width="7%" class="text-center">용량</th>
								<th width="7%" class="text-center">도수</th>
								<th width="21%" class="text-center">주요품종</th>
								<th width="21%" class="text-center">생산지</th>
								<th width="14%" class="text-center">생산자</th>
							</tr>
							<tr>
								<td width="30%" class="text-center">{{vo.nameeng}}</td>
								<td width="7%" class="text-center">{{vo.vol}}</td>
								<td width="7%" class="text-center">{{vo.alcohol}}</td>
								<td width="21%" class="text-center">{{vo.grape}}</td>
								<td width="21%" class="text-center">{{vo.nation}}</td>
								<td width="14%" class="text-center">{{vo.maker}}</td>
							</tr>
						</table>
						<table class="table mp" style="margin-bottom: 0;">
							<tr>
								<th width="26%" class="text-center">향</th>
								<th width="26%" class="text-center">음식매칭</th>
								<th width="12%" class="text-center">당도</th>
								<th width="12%" class="text-center">산도</th>
								<th width="12%" class="text-center">바디</th>
								<th width="12%" class="text-center">탄닌</th>
							</tr>
							<tr>
								<td width="26%" class="text-center">{{vo.aroma}}</td>
								<td width="26%" class="text-center">{{vo.food}}</td>
								<td width="12%" class="text-center">{{vo.sugar}}</td>
								<td width="12%" class="text-center">{{vo.acid}}</td>
								<td width="12%" class="text-center">{{vo.body}}</td>
								<td width="12%" class="text-center">{{vo.tannin}}</td>
							</tr>
						</table>
					</td>
					<td>
						<a class="btn btn-sm border-wine" :href="'../shop/detail.do?wno='+vo.wno" target="_blank">미리보기</a>
					</td>
				</tr>
			</template>
		</table>
		<div style="height: 15px;"></div>
		<div class="text-center">
			<button class="btn btn-sm btn-wine" @click="wList(curPage>1?curPage-1:curPage)">이전</button>
			{{curPage}}page/{{totalPage}}page
			<button class="btn btn-sm btn-wine" @click="wList(curPage<totalPage?curPage+1:curPage)">다음</button>
		</div>
	</div>
	<script>
	let adminItemApp=Vue.createApp({
		data(){
			return{
				list:[],
				curPage:1,
				totalPage:0,
				isShow:Array(10).fill(false),
			}
		},
		methods:{
			wList(page){
				this.isShow=Array(10).fill(false)
				axios.get('../admin/vueWineList.do', {
					params:{
						page:page
					}
				}).then(response=>{
					this.list=response.data.list
					this.curPage=response.data.curPage
					this.totalPage=response.data.totalPage
				})
			},
			checkInfo(index){
				if(this.isShow[index]===false){
					this.isShow=Array(10).fill(false)
					this.isShow[index]=true
				}
				else{
					this.isShow[index]=false
				}
			},
			wineAccept(wno){
				axios.get('../admin/vueWineAccept.do', {
					params:{
						wno:wno
					}
				}).then(response=>{
					this.wList(1)
				})
			},
			wineRejection(wno){
				axios.get('../admin/vueWineRejection.do', {
					params:{
						wno:wno
					}
				}).then(response=>{
					this.wList(1)
				})
			}
		},
		mounted(){
			this.wList(1)
		}
	}).mount('#adminItemApp')
	</script>
</body>
</html>