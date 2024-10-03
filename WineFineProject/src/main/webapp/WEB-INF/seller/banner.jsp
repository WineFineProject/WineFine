<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
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
<script src="../tem/js/test.js"></script>
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
					<tr v-for="avo in waitCoupon">
						<td width="21%">{{avo.title}}</td>
						<td width="25%">{{avo.targetname}}</td>
						<td width="10%">{{avo.discount}}%</td>
						<td width="16%">{{avo.mvo.nickname}}</td>
						<td width="10%">{{avo.startDay}}</td>
						<td width="10%">{{avo.endDay}}</td>
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
				</table>
			</div>
		</div>
	</div>
	<script>
	let bannerApp=Vue.createApp({
		data(){
			return{
				showModal:false
			}
		},
		mounted(){
			
		},
		methods:{
			changeModal(check){
				changeModal(this, check)
			}
		}
	}).mount('#promotion_table')
	</script>
</body>
</html>