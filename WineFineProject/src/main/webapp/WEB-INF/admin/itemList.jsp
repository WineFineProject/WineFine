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
	<div class="row" id="itemListApp">
	  <h3 class="table-title">상품 목록</h3>
		<div style="text-align: left;margin-bottom: 10px;padding: 0px">
			<input type="checkbox" :value="1" name="filter" v-model="filter" @change="showInfo()">
			<label style="margin: 0 10px 0 5px;">판매중</label> 
			<input type="checkbox" :value="2" name="filter" v-model="filter" @change="showInfo()">
			<label style="margin: 0 10px 0 5px;">품절</label> 
			<input type="checkbox" :value="3" name="filter" v-model="filter" @change="showInfo()">
			<label style="margin: 0 10px 0 5px;">판매중단</label> 
			<input type="checkbox" :value="7" name="filter" v-model="filter" @change="showInfo()">
			<label style="margin: 0 10px 0 5px;">판매제한</label> 
		</div>
		<table class="table mp">
			<tr>
				<th width="5%" class="text-center">품번</th>
				<th width="5%" class="text-center"></th>
				<th width="30%" class="text-center">제품명</th>
				<th width="5%" class="text-center">재고</th>
				<th width="10%" class="text-center">판매액</th>
				<th width="10%" class="text-center">타입</th>
				<th width="10%" class="text-center">상태</th>
				<th width="15%" class="text-center">상품등록일</th>
				<th width="10%" class="text-center"></th>
			</tr>
			<template v-for="(vo, index) in list">
				<tr @click="moreInfo(index)">
					<td width="5%" class="text-center">{{vo.wno}}</td>
					<td width="5%" class="text-center"><img :src="vo.poster"
						style="width: 35px; height: 55px"></td>
					<td width="30%" class="text-center scrollable-text">
						<p style="margin-bottom: 0px;">{{vo.namekor}}</p>
					</td>
					<td width="5%" class="text-center">{{vo.stack}}</td>
					<td width="10%" class="text-center">{{vo.price}}</td>
					<td width="10%" class="text-center">{{vo.type}}</td>
					<td width="10%" class="text-center">{{vo.state===1?'판매중':vo.state===2?'품절':vo.state===3?'판매중단':'판매제한'}}</td>
					<td width="15%" class="text-center">{{vo.dbday}}</td>
					<td width="10%" class="text-center">
						<button class="btn btn-sm btn-border-wine" v-if="vo.state!=7"
							@click="wineCancel(index)">판매제한</button>
					</td>
				</tr>
				<tr v-if="isShow[index]">
					<td colspan="9" style="padding: 0px;">
						<table class="table" style="margin-bottom: 0px;">
							<tr>
								<th width="20%" class="text-center">업체명</th>
								<th width="30%" class="text-center">영문명</th>
								<th width="10%" class="text-center">용량</th>
								<th width="10%" class="text-center">당도</th>
								<th width="10%" class="text-center">산도</th>
								<th width="10%" class="text-center">바디</th>
								<th width="10%" class="text-center">탄닌</th>
							</tr>
							<tr style="vertical-align: middle;">
								<td width="20%" class="text-center">{{vo.mvo.nickName}}</td>
								<td width="30%" class="text-center scrollable-text">
									<p style="margin-bottom: 0px;">{{vo.nameeng}}</p>
								</td>
								<td width="10%" class="text-center">{{vo.vol}}</td>
								<td width="10%" class="text-center">{{vo.sugar}}</td>
								<td width="10%" class="text-center">{{vo.acid}}</td>
								<td width="10%" class="text-center">{{vo.body}}</td>
								<td width="10%" class="text-center">{{vo.tannin}}</td>
							</tr>
						</table>
					</td>
				</tr>
			<tr v-if="isShow[index]">
				<td colspan="9" style="padding: 0px;">
					<table class="table" style="margin-bottom: 0px;">
						<tr>
							<th width="50%" class="text-center">음식매칭</th>
							<th width="50%" class="text-center">향</th>
						</tr>
						<tr style="vertical-align: middle;">
							<td width="50%" class="text-center">{{vo.food}}</td>
							<td width="50%" class="text-center">{{vo.aroma}}</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr v-if="isShow[index]">
				<td colspan="9" style="padding: 0px;">
					<table class="table" style="margin-bottom: 0px;">
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
								<p style="margin-bottom: 0px;">{{vo.grape}}</p>
							</td>
							<td width="24%" class="text-center scrollable-text">
								<p style="margin-bottom: 0px;">{{vo.nation}}</p>
							</td>
							<td width="24%" class="text-center">{{vo.maker}}</td>
						</tr>
					</table>
				</td>
			</tr>
			</template>
		</table>
		<div class="col-12 text-center">
			<div class="pagination-area d-sm-flex mt-15"
				style="justify-content: center">
				<nav aria-label="#">
					<ul class="pagination" style="display: flex;">
						<li class="page-item" v-if="startPage>1"><a class="page-link"
							@click="iList(startPage-1)"> <i
								class="fa fa-angle-double-left" aria-hidden="true"></i> 이전
						</a></li>
						<li
							:class="{'page-item active': i === curPage, 'page-item': i !== curPage}"
							v-for="i in pageRange"><a class="page-link"
							@click="iList(i)">{{ i }}</a></li>
						<li class="page-item" v-if="endPage<totalPage"><a
							class="page-link" @click="iList(endPage+1)"
							style="margin-left: 4px;"> 다음 <i
								class="fa fa-angle-double-right" aria-hidden="true"></i>
						</a></li>
					</ul>
				</nav>
			</div>
			<div class="modal" :class="{ show: showModal }">
				<div class="modal-content" style="height: 220px;">
					<div class="modal-header">
						<h4 class="modal-title">사유 작성</h4>
					</div>
					<div class="mb-3">
						<div style="margin-top: 10px;">
							<input type="text" v-model="message" ref="message"
								@keyup.enter="sendMessage()" class="r-boxs">
						</div>
					</div>
				</div>
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
			sel:{},
			pageRange:[]
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
		makeRange(){
			this.pageRange=[]
			for(let i=this.startPage;i<=this.endPage;i++){
				this.pageRange.push(i)
			}
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
				this.makeRange()
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