<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../tem/css/coupon.css">
</head>
<body>
	<div class="promotion_table">
		<h3 class="table-title">진행중인 프로모션</h3>
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
							<tr v-show="activeCoupon.length===0">
										<td colspan="7">진행중인 프로모션이 없습니다</td>
									</tr>
								<tbody>
									<tr v-for="vo in activeCoupon">
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
		<h3 class="table-title">대기 프로모션</h3>
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
								<tr v-show="waitCoupon.length===0">
										<td colspan="7">승인대기중인 프로모션이 없습니다</td>
									</tr>
									<tr v-for="(avo, index) in waitCoupon">
										<td width="21%">{{avo.title}}</td>
										<td width="25%">{{avo.targetname}}</td>
										<td width="10%">{{avo.discount}}%</td>
										<td width="16%">{{avo.mvo.nickName}}</td>
										<td width="10%">{{avo.startDay}}</td>
										<td width="10%">{{avo.endDay}}</td>
										<td width="8%">
											<button class="btn btn-sm border-wine text-primary" type="button" @click="couponApproval(index)">승인</button>
											<button class="btn btn-sm border-wine text-warning" type="button" @click="couponRejection(index)">거절</button>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
		<div class="modal" :class="{ show: showModal }">
			<div class="modal-content" style="height: 200px;">
				<h3 class="text-center">사유 작성</h3>
				<input type="text" v-model="message" ref="message" @keyup.enter="sendMessage()">
			</div>
		</div>
	</div>
	<script>
	let adminCouponApp=Vue.createApp({
		data(){
			return{
				activeCoupon:[],
				waitCoupon:[],
				showModal:false,
				select:{},
				message:'',
				subject:''
			}
		},
		methods:{
			couponList(){
				axios.get('../admin/vueCouponList.do', null).then(response=>{
					this.activeCoupon=response.data.activeCoupon
					this.waitCoupon=response.data.waitCoupon
				})
			},
			couponApproval(index){
				this.select=this.waitCoupon[index]
				axios.get('../admin/vueCouponApproval.do', {
					params:{
						pcno:this.select.pcno
					}
				}).then(response=>{
					alert('승인완료')
					this.subject=this.select.userid+'님 '+this.select.title+' 쿠폰등록 신청이 승인되었습니다'
					this.message=this.select.title+' 쿠폰등록 신청이 승인되었습니다'
					this.sendMessage()
					this.couponList()
				})
			},
			couponRejection(index){
				this.select=this.waitCoupon[index]
				axios.get('../admin/vueCouponRejection.do', {
					params:{
						pcno:this.select.pcno
					}
				}).then(response=>{
					this.subject=this.select.userid+'님 '+this.select.title+' 쿠폰등록 신청이 반려되었습니다'
					this.showModal=true
				})
			},
			sendMessage(){
				if(this.message===''){
					this.$refs.message.focus()
					return
				}
				axios.post('../notice/vueAdminNoticeSend.do', null, {
					params:{
						content:encodeURIComponent(this.message),
						recvid:this.select.userid,
						subject:encodeURIComponent(this.subject)
					}
				}).then(response=>{
					this.showModal=false
					this.select={}
					this.message=''
					this.couponList()
				})
			}
		},
		mounted(){
			this.couponList()
		}
	}).mount('.promotion_table')
	</script>
</body>
</html>