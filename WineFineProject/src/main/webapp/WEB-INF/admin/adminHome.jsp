<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<link rel="stylesheet" href="../tem/css/graph.css">
</head>
<body>
	<div class="row" id="myHomeApp">
		<table class="table t">
			<tr>
				<th width="40%" class="text-center">금일 결제</th>
				<td width="40%" class="text-center">{{nonePayment}}건</td>
			</tr>
			<tr>
				<th width="40%" class="text-center">승인 안한 상품등록</th>
				<td width="40%" class="text-center">{{noneItem}}건</td>
			</tr>
			<tr>
				<th width="40%" class="text-center">승인 안한 쿠폰신청</th>
				<td width="40%" class="text-center">{{noneCoupon}}건</td>
			</tr>
			<tr>
				<th width="40%" class="text-center">승인 안한 배너신청</th>
				<td width="40%" class="text-center">{{noneBanner}}건</td>
			</tr>
			<tr>
				<th width="40%" class="text-center">승인 안한 할인신청</th>
				<td width="40%" class="text-center">{{noneSale}}건</td>
			</tr>
			<tr>
				<th width="40%" class="text-center">답변 안한 문의</th>
				<td width="40%" class="text-center">{{noneAnswer}}건</td>
			</tr>
		</table>
		<div class="wrap border-wine" style="border: 1px solid;">
			<h2>7일간 방문자 수</h2>
			<div class="row" style="height: 350px; margin: 0px auto;">
				<div style="width: 8%;"></div>
				<div style="width: 12%; margin-top: auto;" class="text-center" v-for="date in dates">
					<div class="graph-bar" :data-value="date.visitCount"></div>
					<div class="graph-legend" style="margin: 0px auto;">{{date.visitDay}}</div>
				</div>
			</div>
			<div style="width: 8%;"></div>
		</div>
	</div>
	<script>
	let myHomeApp=Vue.createApp({
		data(){
			return{
				dates:[],
				maxVisit:0,
				noneCoupon:0,
				noneBanner:0,
				noneSale:0,
				noneItem:0,
				nonePayment:0,
				noneAnswer:0
			}
		},
		mounted(){
			axios.get('../admin/vueHomeInfo.do').then(response=>{
				this.dates=response.data.dates
				this.maxVisit=response.data.maxVisit
				this.noneCoupon=response.data.noneCoupon
				this.noneBanner=response.data.noneBanner
				this.noneSale=response.data.noneSale
				this.noneItem=response.data.noneItem
				this.nonePayment=response.data.nonePayment
				this.noneAnswer=response.data.noneAnswer
				$(document).ready(function() {
					let max=_this.maxVisit
					  $('.graph-bar').each(function() {
					     var dataWidth = $(this).data('value');
					     $(this).css("height", dataWidth/max*350 + "px");
					  });
				})
			})
			_this=this
		}
	}).mount('#myHomeApp')
	</script>
</body>
</html>