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
		<div class="wrap">
			<h2>7일간 방문자 통계</h2>
			<div class="barGraph">
				<ul class="graph">
					<li style="margin-bottom:10px;text-align: left;" v-for="date in dates"><span class="graph-legend">{{date.visitDay}}</span><span class="graph-bar" style="display: inline-block;" :data-value="date.visitCount"></span></li>
				</ul>
			</div>
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
			axios.get('../seller/vueSellerHomeInfo.do').then(response=>{
				this.dates=response.data.dates
				this.maxVisit=response.data.maxVisit
				$(document).ready(function() {
					let max=_this.maxVisit
				  $('.graph-bar').each(function() {
				     var dataWidth = $(this).data('value');
				     $(this).css("width", dataWidth/max*80 + "%");
				  });
				})
			})
			_this=this
		}
	}).mount('#myHomeApp')
	</script>
</body>
</html>