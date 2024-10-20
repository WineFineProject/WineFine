<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
#myReserveApp table tr th {
	background: lightgray;
	color: white;
}

#myReserveApp table tr td table {
	margin-bottom: 0px;
}
</style>
</head>
<body>
	<div class="row" id="myReserveApp">
		<table class="table">
			<tr>
				<th width="5%" class="text-center">번호</th>
				<th width="5%" class="text-center"></th>
				<th width="30%" class="text-center">제품명</th>
				<th width="5%" class="text-center">개수</th>
				<th width="10%" class="text-center">결제금</th>
				<th width="15%" class="text-center">상태</th>
				<th width="20%" class="text-center">구매일</th>
				<th width="10%" class="text-center"></th>
			</tr>
			<template v-for="(vo, index) in list">
			<tr @click="moreInfo(index)">
				<td width="5%" class="text-center">{{vo.wpno}}</td>
				<td width="5%" class="text-center"><img :src="vo.wvo.poster" width="100%"></td>
				<td width="30%" class="text-center">{{vo.wvo.namekor}}</td>
				<td width="5%" class="text-center">{{vo.account}}</td>
				<td width="10%" class="text-center">{{vo.payment}}</td>
				<td width="15%" class="text-center">{{vo.state===0?'결제완료':vo.state===1?'배송준비중':vo.state===2?'배송중':vo.state===3?'배송완료':vo.state===9?'반품':'결제취소'}}</td>
				<td width="20%" class="text-center">{{vo.dbday}}</td>
				<td width="10%" class="text-center"><button class="btn btn-sm border-wine" v-if="vo.state<2">취소</button></td>
			</tr>
			<tr v-if="isShow[index]">
			<!-- 
			wdno, mcno, psno, type, name, post, addr1, addr2, msg, ctitle, cdiscount, stitle, sdiscount
			 -->
				<td colspan="7" style="padding: 0px;">
					<table class="table">
						<tr>
						<th width="6%" class="text-center">타입</th>
						<th width="22%" class="text-center">판매자</th>
						<th width="24%" class="text-center">주요품종</th>
						<th width="24%" class="text-center">생산지</th>
						<th width="24%" class="text-center">생산자</th>
						</tr>
						<tr>
						<td width="6%" class="text-center">{{vo.wvo.type}}</td>
						<td width="22%" class="text-center">{{vo.wvo.mvo.nickName}}</td>
						<td width="24%" class="text-center">{{vo.wvo.grape}}</td>
						<td width="24%" class="text-center">{{vo.wvo.nation}}</td>
						<td width="24%" class="text-center">{{vo.wvo.maker}}</td>
						</tr>
					</table>
					<table class="table">
						<tr>
						<th width="20%" class="text-center">판매가</th>
						<th width="20%" class="text-center">사용적립금</th>
						<th width="20%" class="text-center">{{vo.mcno!==0?'적용쿠폰':'적용할인'}}</th>
						<th width="20%" class="text-center">할인율</th>
						<th width="20%" class="text-center">적립된금액</th>
						</tr>
						<tr>
						<td width="20%" class="text-center">{{vo.wvo.price}}</td>
						<td width="20%" class="text-center">{{vo.mipoint}}</td>
						<td width="20%" class="text-center">{{vo.mcno!==0?vo.mcvo.title:vo.psno!==0?vo.svo.title:'할인적용 안함'}}</td>
						<td width="20%" class="text-center">{{vo.mcno!==0?vo.mcvo.discount+'%':vo.psno!==0?vo.svo.discount+'%':'할인적용 안함'}}</td>
						<td width="20%" class="text-center">{{grade===1?vo.payment*0:grade===2?Math.trunc(vo.payment*0.005):Math.trunc(vo.payment*0.015)}}</td>
						</tr>
					</table>
					<table class="table">
						<tr>
						<th width="15%" class="text-center">배송지명</th>
						<th width="10%" class="text-center">우편번호</th>
						<th width="40%" class="text-center">주소</th>
						<th width="35%" class="text-center">메세지</th>
						</tr>
						<tr>
						<td width="15%" class="text-center">{{vo.dvo.name}}</td>
						<td width="10%" class="text-center">{{vo.dvo.post}}</td>
						<td width="40%" class="text-center">{{vo.dvo.addr1+' '+vo.dvo.addr2}}</td>
						<td width="35%" class="text-center">{{vo.dvo.msg}}</td>
						</tr>
					</table>
				</td>
			</tr>
			</template>
		</table>
		<div style="height: 10px;"></div>
		<div class="text-center">
			<button class="btn btn-sm btn-wine" @click="pList(curPage>1?curPage-1:curPage)">이전</button>
			{{curPage}}page/{{totalPage}}page
			<button class="btn btn-sm btn-wine" @click="pList(curPage<totalPage?curPage+1:curPage)">다음</button>
		</div>
	</div>
	<script>
	let myReserveApp=Vue.createApp({
		data(){
			return{
				list:[],
				curPage:0,
				totalPage:0,
				grade:0,
				isShow:Array(10).fill(false)
			}
		},
		methods:{
			pList(page){
				axios.get('../mypage/vueMyPaymentList.do', {
					params:{
						page:page
					}
				}).then(response=>{
					console.log(response.data)
					this.list=response.data.list
					this.curPage=response.data.curPage
					this.totalPage=response.data.totalPage
					this.grade=response.data.grade
				})
			},
			moreInfo(index){
				if(this.isShow[index]===true){
					this.isShow[index]=false
				}
				else{
					this.isShow=Array(10).fill(false)
					this.isShow[index]=true
				}
			}
		},
		mounted(){
			this.pList(1)
		}
	}).mount('#myReserveApp')
	</script>
</body>
</html>