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
					<td colspan="7">
						<div>
							<table style="width: 100%">
								<tbody>
									<tr v-for="vo in activeBanner">
										<td width="23%">{{vo.title}}</td>
										<td width="27%">{{vo.wvo.namekor}}</td>
										<td width="12%">{{vo.stack}}회</td>
										<td width="18%">{{vo.userid}}</td>
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
		<h3>대기 프로모션</h3>
		<table class="table" style="height: 400px;">
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
					<td colspan="7">
						<div>
							<table style="width: 100%">
								<tbody>
									<tr v-for="avo in waitBanner">
										<td width="31%">{{avo.title}}</td>
										<td width="35%">{{avo.wvo.namekor}}</td>
										<td width="10%">{{avo.stack}}회</td>
										<td width="16%">{{avo.userid}}</td>
										<td width="8%">
											<button class="btn btn-sm border-wine text-wine" type="button" @click="couponApproval(avo.pbno)">승인</button>
											<button class="btn btn-sm border-wine text-wine" type="button" @click="couponRejection(avo.pbno)">거절</button>
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
				activeBanner:[],
				waitBanner:[]
			}
		},
		methods:{
			bannerList(){
				axios.get('../admin/vueBannerList.do', null).then(response=>{
					this.activeBanner=response.data.activeBanner
					this.waitBanner=response.data.waitBanner
				})
			},
			couponApproval(pbno){
				axios.get('../admin/vueBannerApproval.do', {
					params:{
						pbno:pbno
					}
				}).then(response=>{
					alert('승인완료')
					this.bannerList()
				})
			},
			couponRejection(pbno){
				axios.get('../admin/vueBannerRejection.do', {
					params:{
						pbno:pbno
					}
				}).then(response=>{
					alert('거절완료')
					this.bannerList()
				})
			}
		},
		mounted(){
			this.bannerList()
		}
	}).mount('.promotion_table')
	</script>
</body>
</html>