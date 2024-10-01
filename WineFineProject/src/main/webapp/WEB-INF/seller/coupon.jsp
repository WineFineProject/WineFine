<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.promotion_table {
	width: 1500px;
}

.modal {
	display: none; /* 기본적으로 모달은 숨김 */
	position: fixed;
	z-index: 9999;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.5);
	opacity: 0; /* 초기 투명도 */
	transition: opacity 0.3s ease; /* 투명도 변화 애니메이션 */
}

/* 모달이 활성화되었을 때 */
.modal.show {
	display: block; /* 블록으로 표시 */
	opacity: 1; /* 완전 불투명 */
}

/* 모달 컨텐츠 스타일 */
.modal-content {
	position: relative;
	background-color: #fff;
	margin: 15% auto;
	padding: 20px;
	border: 1px solid #888;
	width: 500px;
	height: 400px; border-radius : 10px;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
	transform: translateY(-50px); /* 시작 위치 */
	transition: transform 0.3s ease, opacity 0.3s ease;
	/* 이동 및 투명도 애니메이션 */
	opacity: 0;
	border-radius: 10px /* 초기 투명도 */
}

/* 모달이 활성화되었을 때 모달 컨텐츠 애니메이션 */
.modal.show .modal-content {
	transform: translateY(0); /* 원래 위치로 돌아옴 */
	opacity: 1; /* 완전 불투명 */
}

/* 닫기 버튼 스타일 */
.close {
	position: absolute;
	right: 10px;
	top: 10px;
	color: #aaa;
	font-size: 24px;
	font-weight: bold;
	cursor: pointer;
}

.close:hover, .close:focus {
	color: #000;
	text-decoration: none;
	cursor: pointer;
}
</style>

</head>
<body>
	<div id="promotionTable">
		<div class="promotion_table">
			<table class="table">
				<tr>
					<td colspan="6" class="text-left">
						<button @click="changeModal(true)" type="button">프로모션 등록</button>
					</td>
				</tr>
			</table>
			<table class="table" style="height: 400px;">
				<thead>
					<tr>
						<th width="21%">이벤트명</th>
						<th width="8%"></th>
						<th width="25%">대상상품</th>
						<th width="10%">할인율</th>
						<th width="16%">시작일</th>
						<th width="16%">종료일</th>
						<th width="4%"></th>
					</tr>
				</thead>
				<tbody>
					<tr v-for="vo in currentPromotion">
						<td>{{vo.title}}</td>
						<td><img :src="vo.wvo.poster" class="img-fluid me-5 rounded-circle" style="width: 30px; height: 30px;" alt=""></td>
						<td></td>
						<td>{{vo.discount}}%</td>
						<td>{{vo.startday}}</td>
						<td>{{vo.endday}}</td>
						<td></td>
					</tr>
				</tbody>
			</table>
			<table class="table" style="height: 400px;">
				<thead>
					<tr>
						<th width="21%">이벤트명</th>
						<th width="8%"></th>
						<th width="25%">대상상품</th>
						<th width="10%">할인율</th>
						<th width="16%">시작일</th>
						<th width="16%">종료일</th>
						<th width="4%"></th>
					</tr>
				</thead>
				<tbody>
					<tr v-for="vo in upcommingPromotion">
						<td>{{vo.title}}</td>
						<td><img :src="vo.wvo.poster" class="img-fluid me-5 rounded-circle" style="width: 30px; height: 30px;" alt=""></td>
						<td></td>
						<td>{{vo.discount}}%</td>
						<td>{{vo.startday}}%</td>
						<td>{{vo.endday}}%</td>
						<td>
							<button class="btn btn-sm border-wine rounded-pill text-wine" type="button">X</button>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="modal" :class="{ show: showModal }" @click.self="changeModal(false)">
			<div class="modal-content">
				<span class="close" @click="changeModal(false)">&times;</span>
				<table class="table" style="margin-top: 50px;">
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
									<td><input type="text" v-model="fd" style="width: 100%" @keyup="findWine()" ref="fd" :disabled="isFd"></td>
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
					<tr v-show="isBtn">
						<td colspan="2">
							<button type="button" class="btn btn-sm btn-wine" @click="insertPromotion()">등록</button>
							<button type="button" class="btn btn-sm btn-wine" @click="changeModal(false)">취소</button>
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
				this.showModal=check
			},
			findWine(){
				if(this.fd===''){
					this.isFind=false
				}
				else{
					this.isFind=true
				}
				axios.get('../seller/findWine.do', {
					params:{
						fd:this.fd
					}
				}).then(response=>{
					console.log(this.fd)
					this.list=response.data
				})
			},
			changeNo(no){
				this.no=this.list[no].wno
				this.isFd=true
				this.isFind=false
				this.fd=this.list[no].namekor
				this.isDate=true
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
				console.log(this.startDate)
				console.log(this.endDate)
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
			axios.post('../seller/couponInsert.do', null, {
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
			})
		}
		}
	}).mount('#promotionTable')
	</script>
</body>
</html>