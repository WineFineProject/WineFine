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
									<tr v-for="vo in activeSale">
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
									<tr v-for="avo in waitSale">
										<td width="21%">{{avo.title}}</td>
										<td width="25%">{{avo.targetname}}</td>
										<td width="10%">{{avo.discount}}%</td>
										<td width="16%">{{avo.mvo.nickname}}</td>
										<td width="10%">{{avo.startDay}}</td>
										<td width="10%">{{avo.endDay}}</td>
										<td width="8%">
											<button class="btn btn-sm border-wine text-wine" type="button" @click="saleApproval(avo.psno)">승인</button>
											<button class="btn btn-sm border-wine text-wine" type="button" @click="saleRejection(avo.psno)">거절</button>
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
				activeSale:[],
				waitSale:[]
			}
		},
		methods:{
			saleList(){
				axios.get('../admin/vueSaleList.do', null).then(response=>{
					this.activeSale=response.data.activeSale
					this.waitSale=response.data.waitSale
				})
			},
			saleApproval(psno){
				axios.get('../admin/vueSaleApproval.do', {
					params:{
						psno:psno
					}
				}).then(response=>{
					alert('승인완료')
					this.saleList()
				})
			},
			saleRejection(psno){
				axios.get('../admin/vueSaleRejection.do', {
					params:{
						psno:psno
					}
				}).then(response=>{
					alert('거절완료')
					this.saleList()
				})
			}
		},
		mounted(){
			this.saleList()
		}
	}).mount('.promotion_table')
	</script>
</body>
</html>