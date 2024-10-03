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
			<h3>진행중인 프로모션</h3>
			<table class="table" style="height: 400px;">
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
						<td width="21%"></td>
						<td width="25%"></td>
						<td width="10%">%</td>
						<td width="16%"></td>
						<td width="10%"></td>
						<td width="10%"></td>
						<td width="8%"></td>
					</tr>
				</tbody>
			</table>
			<h3>승인 대기 프로모션</h3>
			<table class="table" style="height: 400px;">
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
						<td width="21%"></td>
						<td width="25%"></td>
						<td width="10%">%</td>
						<td width="16%"></td>
						<td width="10%"></td>
						<td width="10%"></td>
						<td>
							<button class="btn btn-sm border-wine rounded-pill text-wine" type="button">X</button>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
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
								<option :value="1" selected="selected">옵션 1 : 상단배너 (클릭횟수당 700원)</option>
								<option :value="2">옵션 2 : 하단배너 (클릭횟수당 500원)</option>
						</select></td>
					</tr>
					<tr>
						<th width="30%">노출횟수</th>
						<td width="70%"><input type="number" v-model="count" @change="checkBtn()">회</td>
					</tr>
					<tr>
						<th width="30%">결제액</th>
						<td width="70%">{{option===1?option*700*count:option*500*count}}원</td>
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
					<tr v-show="isDate">
						<th width="30%">시작일</th>
						<td width="70%"><input type="date" v-model="startDate" @change="checkBtn()"></td>
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
				isDate:false,
				isBtn:false,
				startDate:'',
				eventName:'',
				option:1,
				isFind:false
			}
		},
		mounted(){
			
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
					this.isDate=false
				}
				changeModal(this, check)
			},
			changeNo(index){
				this.no=this.list[index].wno
				this.isFd=true
				this.isFind=false
				this.fd=this.list[index].namekor
				this.isDate=true
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
				if(this.startDate===''){
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
						type:this.option,
						startDay:this.startDate,
					}
				}).then(response=>{
					alert('등록 완료')
				})
			}
		}
	}).mount('#promotionTable')
	</script>
</body>
</html>