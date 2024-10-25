<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="row" id="itemListApp">
		<table class="table mp">
		<tr>
		<td colspan="8">
			<label><input type="checkbox" :value="1" name="filter" v-model="filter" @change="showInfo()">판매중</label>
			<label><input type="checkbox" :value="2" name="filter" v-model="filter" @change="showInfo()">품절</label>
			<label><input type="checkbox" :value="3" name="filter" v-model="filter" @change="showInfo()">판매중단</label>
			<label><input type="checkbox" :value="7" name="filter" v-model="filter" @change="showInfo()">판매제한</label>
		</td>
		</tr>
			<tr>
				<th width="5%" class="text-center">번호</th>
				<th width="5%" class="text-center"></th>
				<th width="30%" class="text-center">제품명</th>
				<th width="5%" class="text-center">제고</th>
				<th width="10%" class="text-center">판매액</th>
				<th width="15%" class="text-center">상태</th>
				<th width="20%" class="text-center">상품등록일</th>
				<th width="10%" class="text-center"></th>
			</tr>
			<template v-for="(vo, index) in list">
				<tr @click="moreInfo(index)">
					<td width="5%" class="text-center">{{vo.wno}}</td>
					<td width="5%" class="text-center">
						<img :src="vo.poster" style="width: 35px; height: 58px">
					</td>
					<td width="30%" class="text-center scrollable-text">
						<p>{{vo.namekor}}</p>
					</td>
					<td width="5%" class="text-center">{{vo.stack}}</td>
					<td width="10%" class="text-center">{{vo.price}}</td>
					<td width="15%" class="text-center">{{vo.state===1?'판매중':vo.state===2?'품절':vo.state===3?'판매중단':'판매제한'}}</td>
					<td width="20%" class="text-center">{{vo.dbday}}</td>
					<td width="10%" class="text-center">
						<button class="btn btn-sm border-wine" v-if="vo.state!=7" @click="wineCancel(index)">판매제한</button>
					</td>
				</tr>
				<tr v-if="isShow[index]">
					<td colspan="8" style="padding: 0px;">
						<table class="table mp">
							<tr>
								<th width="8%" class="text-center">타입</th>
								<th width="20%" class="text-center">판매자</th>
								<th width="24%" class="text-center">주요품종</th>
								<th width="24%" class="text-center">생산지</th>
								<th width="24%" class="text-center">생산자</th>
							</tr>
							<tr style="vertical-align: middle;">
								<td width="8%" class="text-center">{{vo.type}}</td>
								<td width="20%" class="text-center">{{vo.mvo.nickName}}</td>
								<td width="24%" class="text-center scrollable-text">
									<p>{{vo.grape}}</p>
								</td>
								<td width="24%" class="text-center scrollable-text">
									<p>{{vo.nation}}</p>
								</td>
								<td width="24%" class="text-center">{{vo.maker}}</td>
							</tr>
						</table>
					</td>
				</tr>
			</template>
		</table>
		<div class="modal" :class="{ show: showModal }">
			<div class="modal-content" style="height: 200px;">
				<h3 class="text-center">사유 작성</h3>
				<input type="text" v-model="message" ref="message" @keyup.enter="sendMessage()">
			</div>
		</div>
	</div>
	<script>
let itemListApp=Vue.createApp({
	data(){
		return{
			list:[],
			curPage:1,
			totalPage:1,
			startPage:0,
			endPage:0,
			count:0,
			filter:[],
			isShow:Array(10).fill(false),
			message:'',
			showModal:false,
			sel:{}
		}
	},
	methods:{
		moreInfo(index){
			if(this.isShow[index]===true){
				this.isShow[index]=false
			}
			else{
				this.isShow=Array(10).fill(false)
				this.isShow[index]=true
			}
		},
		wineCancel(index){
			this.sel=this.list[index]
			this.changeModal(true)
		},
		changeModal(check){
			if(check===false){
				this.sel={}
				this.message=''
			}
			this.showModal=check
		},
		sendMessage(){
			if(this.message===''){
				this.$refs.message.focus()
				return
			}
			this.wineDelete()
		},
		wineDelete(){
			axios.get('../admin/reportWineUpdate.do', {
				params:{
					wno:this.sel.wno
				}
			}).then(response=>{
				axios.post('../notice/vueAdminNoticeSend.do',null,{
					params:{
						recvid:this.sel.seller,
						subject:encodeURIComponent(this.sel.mvo.nickName+'님 ['+this.sel.namekor+'] 제품 판매 제한 안내'),
						content:encodeURIComponent(this.message)
					}
				}).then(response=>{
					this.changeModal(false)
					this.iList(1)
				})
			})
		},
		showInfo(){
			this.iList(1)
		},
		iList(page){
			this.isShow=Array(10).fill(false)
			let filterStr='전체'
			if(this.filter.length!==0)
				filterStr=this.filter.join(',')
			axios.get('../admin/allWineList.do', {
				params:{
					page:page,
					filter:filterStr
				}
			}).then(response=>{
				console.log(response.data)
				this.list=response.data.list
				this.curPage=response.data.curPage
				this.totalPage=response.data.totalPage
				this.startPage=response.data.startPage
				this.endPage=response.data.endPage
				this.count=response.data.count
			})
		}
	},
	mounted(){
		this.iList(1)
	}
}).mount('#itemListApp')
</script>
</body>
</html>