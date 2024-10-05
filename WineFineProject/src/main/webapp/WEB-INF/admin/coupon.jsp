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
	<div class="promotion_table">
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
					<td colspan="7">
						<div>
							<table style="width: 100%">
								<tbody>
									<tr v-for="vo in activeCoupon">
										<td width="21%">{{vo.title}}</td>
										<td width="25%">{{vo.targetname}}</td>
										<td width="10%">{{vo.discount}}%</td>
										<td width="16%">{{vo.mvo.nickname}}</td>
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
		<h3>대기 프로모션</h3>
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
					<td colspan="7">
						<div>
							<table style="width: 100%">
								<tbody>
									<tr v-for="(avo, index) in waitCoupon">
										<td width="21%">{{avo.title}}</td>
										<td width="25%">{{avo.targetname}}</td>
										<td width="10%">{{avo.discount}}%</td>
										<td width="16%">{{avo.mvo.nickname}}</td>
										<td width="10%">{{avo.startDay}}</td>
										<td width="10%">{{avo.endDay}}</td>
										<td width="8%">
											<button class="btn btn-sm border-wine text-wine" type="button" @click="couponApproval(index)">승인</button>
											<button class="btn btn-sm border-wine text-wine" type="button" @click="couponRejection(index)">거절</button>
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
						content:this.message,
						recvid:this.select.userid,
						subject:this.subject
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