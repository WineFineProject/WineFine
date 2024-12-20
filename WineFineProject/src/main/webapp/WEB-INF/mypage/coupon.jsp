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
		<h3 class="table-title">수령한 쿠폰</h3>
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
					<td colspan="7" id="tmp" style="border:none">
						<div>
							<table class="table" id="inner-table" style="width: 100%">
								<tbody>
								<tr>
								<td v-show="myCoupon.length===0" colspan="7">수령한 쿠폰이 없습니다</td>
								</tr>
									<tr v-for="vo in myCoupon">
										<td width="21%">{{vo.title}}</td>
										<td width="25%">{{vo.sellname}}</td>
										<td width="10%">{{vo.discount}}%</td>
										<td width="16%">{{vo.pvo.mvo.nickName}}</td>
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
		<h3 class="table-title">수령 가능 쿠폰</h3>
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
					<td colspan="7" id="tmp" style="border:none">
						<div>
							<table class="table" id="inner-table" style="width: 100%">
								<tbody>
								<tr>
								<td v-show="activeCoupon.length===0" colspan="7">수령가능한 쿠폰이 없습니다</td>
									</tr>
									<tr v-for="(avo, index) in activeCoupon">
										<td width="21%">{{avo.title}}</td>
										<td width="25%">{{avo.targetname}}</td>
										<td width="10%">{{avo.discount}}%</td>
										<td width="16%">{{avo.mvo.nickName}}</td>
										<td width="10%">{{avo.startDay}}</td>
										<td width="10%">{{avo.endDay}}</td>
										<td width="8%">
											<button class="btn btn-sm border-wine text-wine" type="button" @click="getCoupon(index)">받기</button>
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
		let couponApp=Vue.createApp({
			data(){
				return{
					myCoupon:[],
					activeCoupon:[]
				}
			},
			methods:{
				activeList(){
					axios.get('../mypage/vueCouponList.do', null).then(response=>{
						this.activeCoupon=response.data.activeCoupon
						this.myCoupon=response.data.myCoupon
					})
				},
				getCoupon(index){
					let vo=this.activeCoupon[index]
					console.log(vo)
					axios.post('../mypage/vueGetCoupon.do', null, {
						params:{
							title:vo.title,
							pcno:vo.pcno,
							discount:vo.discount,
							pcid:vo.userid,
							startDay:vo.startDay,
							endDay:vo.endDay
						}
					}).then(response=>{
						this.activeList()
					})
				}
			},
			mounted(){
				this.activeList()
			}
		}).mount('.promotion_table')
	</script>
</body>
</html>