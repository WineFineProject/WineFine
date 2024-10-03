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
									<tr v-for="avo in waitCoupon">
										<td width="21%">{{avo.title}}</td>
										<td width="25%">{{avo.targetname}}</td>
										<td width="10%">{{avo.discount}}%</td>
										<td width="16%">{{avo.mvo.nickname}}</td>
										<td width="10%">{{avo.startDay}}</td>
										<td width="10%">{{avo.endDay}}</td>
										<td width="8%">
											<button class="btn btn-sm border-wine text-wine" type="button" @click="couponApproval(avo.pcno)">승인</button>
											<button class="btn btn-sm border-wine text-wine" type="button" @click="couponRejection(avo.pcno)">거절</button>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<script>
	let adminCouponApp=Vue.createApp({
		data(){
			return{
				activeCoupon:[],
				waitCoupon:[]
			}
		},
		methods:{
			couponList(){
				axios.get('../admin/vueCouponList.do', null).then(response=>{
					this.activeCoupon=response.data.activeCoupon
					this.waitCoupon=response.data.waitCoupon
				})
			},
			couponApproval(pcno){
				axios.get('../admin/vueCouponApproval.do', {
					params:{
						pcno:pcno
					}
				}).then(response=>{
					alert('승인완료')
					this.couponList()
				})
			},
			couponRejection(pcno){
				axios.get('../admin/vueCouponRejection.do', {
					params:{
						pcno:pcno
					}
				}).then(response=>{
					alert('거절완료')
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