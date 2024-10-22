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
					<th width="21%">이벤트명</th>
					<th width="25%">대상상품</th>
					<th width="10%">할인율</th>
					<th width="16%">업체명</th>
					<th width="10%">시작일</th>
					<th width="10%">종료일</th>
					<th width="8%"></th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td style="padding: 0px;border:none" colspan="7">
						<div>
							<table style="width: 100%" id="inner-table">
								<tbody>
									<tr v-for="vo in activeSale">
										<td style="padding: 8px" width="21%">{{vo.title}}</td>
										<td width="25%">{{vo.targetname}}</td>
										<td width="10%">{{vo.discount}}%</td>
										<td width="16%">{{vo.mvo.nickName}}</td>
										<td width="10%">{{vo.startDay}}</td>
										<td width="10%">{{vo.endDay}}</td>
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
					<th width="21%">이벤트명</th>
					<th width="25%">대상상품</th>
					<th width="10%">할인율</th>
					<th width="16%">업체명</th>
					<th width="10%">시작일</th>
					<th width="10%">종료일</th>
					<th width="8%"></th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td style="padding: 0px;border:none" colspan="7">
						<div>
							<table style="width: 100%" id="inner-table">
								<tbody>
									<tr v-for="avo in waitSale">
										<td style="padding: 8px" width="21%">{{avo.title}}</td>
										<td width="25%">{{avo.targetname}}</td>
										<td width="10%">{{avo.discount}}%</td>
										<td width="16%">{{avo.mvo.nickName}}</td>
										<td width="10%">{{avo.startDay}}</td>
										<td width="10%">{{avo.endDay}}</td>
										<td>
											<button class="btn btn-sm border-wine rounded-pill text-wine" type="button">X</button>
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
			<div class="modal-content tt">
				<span class="close" @click="changeModal(false)">&times;</span>
				<table class="table" style="margin-top: 10px;">
				<h4 class="text-center">프로모션 등록</h4>
					<tr>
						<th width="30%">프로모션 이름</th>
						<td width="70%"><input type="text" v-model="eventName" style="width: 100%" @keyup="checkBtn()"></td>
					</tr>
					<tr>
						<th width="30%">프로모션 대상</th>
						<td width="70%"><select style="width: 100%" v-model="option" @change="changeOption()">
								<option :value="1">전체</option>
								<option :value="2">카테고리별</option>
								<option :value="3">제품별</option>
						</select></td>
					</tr>
					<tr style="border: transparent;">
						<th width="30%"></th>
						<td width="70%" v-if="option===1"><input type="text" value="전체" readonly></td>
						<td width="70%" v-if="option===2"><select v-model="no">
								<option :value="1">레드</option>
								<option :value="2">화이트</option>
								<option :value="3">스파클링</option>
								<option :value="4">로제</option>
								<option :value="5">주정강화</option>
								<option :value="6">기타</option>
						</select></td>
						<td width="70%" v-if="option===3">
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
					<tr v-show="isDate">
						<th width="30%">할인율</th>
						<td width="70%"><input type="number" v-model="discount" @change="checkBtn()">%</td>
					</tr>
					<tr v-show="isDate">
						<th width="30%">시작일</th>
						<td width="70%"><input type="date" v-model="startDate" @change="checkBtn()"></td>
					</tr>
					<tr v-show="isDate">
						<th width="30%">종료일</th>
						<td width="70%"><input type="date" v-model="endDate" @change="checkBtn()"></td>
					</tr>
					<tr v-show="isBtn" style="text-align: right;">
						<td colspan="2">
							<button type="button" class="btn btn-sm btn-primary" @click="insertPromotion()">등록</button>
							<button type="button" class="btn btn-sm btn-warning" @click="changeModal(false)">취소</button>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<script>
	let id_='${sessionScope.id}'
	let app=Vue.createApp({
		data(){
			return{
				showModal:false,
				option:1,
				no:1,
				fd:'',
				list:[],
				activeSale:[],
				waitSale:[],
				isFind:false,
				isFd:false,
				isDate:true,
				isBtn:false,
				startDate:'',
				endDate:'',
				today:new Date(),
				discount:0,
				eventName:'',
				id:id_
			}
		},
		methods:{
			changeModal(check){
				if(check===false){
					this.option=1
					this.no=1
					this.fd=''
					this.list=[]
					this.isFind=false
					this.isFd=false
					this.isDate=true
					this.isBtn=false
					this.startDate=''
					this.endDate=''
					this.discount=0
					this.eventName=''
				}
				changeModal(this, check)
			},
			changeNo(no){
				this.no=this.list[no].wno
				this.isFd=true
				this.isFind=false
				this.fd=this.list[no].namekor
				this.isDate=true
			},
			findWine_(){
				findWine(this)
			},
			changeOption(){
				if(this.option===2){
					this.no=1
					this.fd=''
					this.isFd=false
					this.isFind=true
					this.isDate=true
				}
				else if(this.option===3){
					this.isDate=false
				}
				else{
					this.isDate=true
				}
				this.isBtn=false
			},
			checkBtn(){
				if(this.eventName===''){
					this.isBtn=false
					return
				}
				if(this.discount===0){
					this.isBtn=false
					return
				}
				if(this.startDate===''){
					return
				}
				if(this.endDate===''){
					return
				}
				this.isBtn=true
			},
			insertPromotion(){
				axios.post('../seller/vueSaleInsert.do', null, {
					params:{
						title:this.eventName,
						userid:this.id,
						discount:this.discount,
						type:this.option,
						target:this.no,
						startDay:this.startDate,
						endDay:this.endDate
					}
				}).then(response=>{
					alert('등록완료')
					this.changeModal(false)
					this.saleList()
				})
			},
			saleList(){
				axios.get('../seller/vueSaleList.do', null).then(response=>{
					this.activeSale=response.data.activeSale
					this.waitSale=response.data.waitSale
				})
			}
		},
		mounted(){
			this.saleList()
		}
	}).mount('#promotionTable')
	</script>
</body>
</html>