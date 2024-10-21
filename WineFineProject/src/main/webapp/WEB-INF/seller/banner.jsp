<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../tem/css/coupon.css">
</head>
<body>
	<div class="promotion_table" id="promotionTable">
		<table>
			<tr>
				<td colspan="6" class="text-left">
					<button @click="changeModal(true)" type="button" class="btn btn-wine">프로모션 등록</button>
				</td>
			</tr>
		</table>
		<h3 class="text-center table-title">진행중인 프로모션</h3>
		<table class="table" id="coupon-table" style="height: 400px;">
			<thead>
				<tr>
					<th width="23%">이벤트명</th>
					<th width="27%">대상상품</th>
					<th width="12%">남은노출횟수</th>
					<th width="18%">업체명</th>
					<th width="12%">시작일</th>
					<th width="8%"></th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td style="padding: 0px;border:none" colspan="7">
						<div>
							<table style="width: 100%" id="inner-table">
								<tbody>
									<tr v-for="vo in activeBanner">
										<td style="padding: 8px" width="23%">{{vo.title}}</td>
										<td width="27%">{{vo.wvo.namekor}}</td>
										<td width="12%">{{vo.stack}}회</td>
										<td width="18%">{{vo.mvo.nickName}}</td>
										<td width="12%">{{vo.startDay}}</td>
										<td width="8%"></td>
									</tr>
								</tbody>
							</table>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
		<h3 class="text-center table-title">승인 대기 프로모션</h3>
		<table class="table" id="coupon-table" style="height: 400px;">
			<thead>
				<tr>
					<th width="31%">이벤트명</th>
					<th width="35%">대상상품</th>
					<th width="10%">신청 횟수</th>
					<th width="16%">업체명</th>
					<th width="8%"></th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td style="padding: 0px;border:none" colspan="7">
						<div>
							<table style="width: 100%" id="inner-table">
								<tbody>
									<tr v-for="avo in waitBanner">
										<td style="padding: 8px" width="31%">{{avo.title}}</td>
										<td width="35%">{{avo.wvo.namekor}}</td>
										<td width="10%">{{avo.stack}}회</td>
										<td width="16%">{{avo.mvo.nickName}}</td>
										<td width="8%">
											<button class="btn btn-sm border-wine text-warning" type="button" @click="couponRejection(avo.pcno)">X</button>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</td>
				</tr>
			</tbody>
		</table>

		<div class="modal" :class="{ show: showModal }" @click.self="changeModal(false)">
			<div class="modal-content" style="height: 485px;">
				<span class="close" @click="changeModal(false)">&times;</span>
				<table class="table" style="margin-top: 50px;">
					<tr>
						<th width="30%">프로모션 이름</th>
						<td width="70%"><input type="text" v-model="eventName" style="width: 100%" @keyup="checkBtn()"></td>
					</tr>
					<tr>
						<th width="30%">배너위치</th>
						<td width="70%"><select v-model="option" style="width: 100%;">
								<option :value="1" selected="selected">옵션 1 : 메인페이지 추천 와인 노출 (클릭횟수당 700원)</option>
								<option :value="2">옵션 2 : 상품페이지 배너 (클릭횟수당 500원)</option>
						</select></td>
					</tr>
					<tr>
						<th width="30%">노출횟수</th>
						<td width="70%"><input type="number" v-model="count" @change="checkBtn()" min="0" max="9999"> 회</td>
					</tr>
					<tr>
						<th width="30%">결제액</th>
						<td width="70%">{{option===1?700*count:500*count}}원</td>
					</tr>
					<tr>
						<th width="30%">프로모션 대상</th>
						<td width="70%">
							<table style="width: 100%">
								<tr>
									<td><input type="text" v-model="fd" style="width: 100%" @keyup.enter="findWine_()" ref="fd" :disabled="isFd"></td>
								</tr>
								<tr v-show="isFind">
									<td>
										<div style="height: 180px; overflow-y: auto;">
											<table class="table">
												<tr v-for="(vo, index) in list">
													<td @click="changeNo(index)">{{vo.namekor}}</td>
												</tr>
											</table>
										</div>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
				<div v-show="isBtn" style="margin-top: auto;">
					<button type="button" class="btn btn-sm btn-wine" @click="insertPromotion()">등록</button>
					<button type="button" class="btn btn-sm btn-wine" @click="changeModal(false)">취소</button>
				</div>
			</div>
		</div>
	</div>
	<script>
	let bannerApp=Vue.createApp({
		data(){
			return{
				showModal:false,
				list:[],
				no:0,
				fd:'',
				count:0,
				isFd:false,
				isBtn:false,
				startDate:'',
				eventName:'',
				option:1,
				isFind:false,
				activeBanner:[],
				waitBanner:[]
			}
		},
		mounted(){
			this.promotionList()
		},
		methods:{
			changeModal(check){
				if(check===false){
					this.no=0
					this.fd=''
					this.count=0
					this.isFd=false
					this.isBtn=false
					this.startDate=''
					this.eventName=''
					this.option=1
					this.isFind=false
					this.list=[]
				}
				changeModal(this, check)
			},
			changeNo(index){
				this.no=this.list[index].wno
				this.isFd=true
				this.isFind=false
				this.fd=this.list[index].namekor
				this.checkBtn()
			},
			checkBtn(){
				if(this.eventName===''){
					this.isBtn=false
					return
				}
				if(this.count===0){
					this.isBtn=false
					return
				}
				if(this.isFd===false){
					this.isBtn=false
					return
				}
				this.isBtn=true
			},
			findWine_(){
				findWine(this)
			},
			insertPromotion(){
				axios.post('../seller/vueBannerInsert.do', null, {
					params:{
						title:this.eventName,
						stack:this.count,
						wno:this.no,
						type:this.option
					}
				}).then(response=>{
					alert('등록 완료')
					this.changeModal(false)
					this.promotionList()
				})
			},
			promotionList(){
				axios.get('../seller/vueBannerList.do', null).then(response=>{
					this.activeBanner=response.data.activeBanner
					this.waitBanner=response.data.waitBanner
				})
			}
		}
	}).mount('#promotionTable')
	</script>
</body>
</html>