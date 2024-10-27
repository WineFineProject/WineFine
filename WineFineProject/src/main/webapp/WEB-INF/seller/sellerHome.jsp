<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<link rel="stylesheet" href="../tem/css/graph.css">
<link rel="stylesheet" href="../tem/css/payment.css">
</head>
<body>
	<div class="row" id="myHomeApp">
		<table>
			<tr>
				<td style="padding: 0px;">
					<h3 class="table-titlee text-center">판매현황</h3>
					<table class="table mp" style="margin-bottom: 0px;">
						<tr style="background: lightgray; color: white;">
							<th width="20%" class="text-center">판매중</th>
							<th width="20%" class="text-center">품절</th>
							<th width="20%" class="text-center">판매중단</th>
							<th width="20%" class="text-center">승인대기</th>
							<th width="20%" class="text-center">승인반려</th>
						</tr>
						<tr>
							<td width="20%" class="text-center">{{saleInfo.ACTIVE}}개</td>
							<td width="20%" class="text-center">{{saleInfo.SOLDOUT}}개</td>
							<td width="20%" class="text-center">{{saleInfo.SALESTOP}}개</td>
							<td width="20%" class="text-center">{{saleInfo.WAIT}}개</td>
							<td width="20%" class="text-center">{{saleInfo.REJECTION}}개</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td style="padding: 0px;">
					<table class="table mp">
						<tr style="background: lightgray; color: white;">
							<th width="17%" class="text-center">레드</th>
							<th width="17%" class="text-center">화이트</th>
							<th width="16%" class="text-center">스파클링</th>
							<th width="16%" class="text-center">로제</th>
							<th width="17%" class="text-center">주정강화</th>
							<th width="17%" class="text-center">기타</th>
						</tr>
						<tr>
							<td width="17%" class="text-center">{{typeInfo.RED}}개</td>
							<td width="17%" class="text-center">{{typeInfo.WHITE}}개</td>
							<td width="16%" class="text-center">{{typeInfo.SPARK}}개</td>
							<td width="16%" class="text-center">{{typeInfo.ROSE}}개</td>
							<td width="17%" class="text-center">{{typeInfo.ALCOHOL}}개</td>
							<td width="17%" class="text-center">{{typeInfo.ETC}}개</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td style="padding: 0px;">
					<h3 class="table-titlee text-center">주문현황</h3>
					<table class="table mp">
						<tr style="background: lightgray; color: white;">
							<th width="14%" class="text-center">결제 완료</th>
							<th width="14%" class="text-center">배송준비중</th>
							<th width="15%" class="text-center">배송중</th>
							<th width="14%" class="text-center">배송완료</th>
							<th width="15%" class="text-center">반품요청</th>
							<th width="14%" class="text-center">판매자 취소</th>
							<th width="14%" class="text-center">반품완료</th>
						</tr>
						<tr>
							<td width="14%" class="text-center">{{payInfo.PAYEND}}건</td>
							<td width="14%" class="text-center">{{payInfo.DELWAIT}}건</td>
							<td width="15%" class="text-center">{{payInfo.DELACTIVE}}건</td>
							<td width="14%" class="text-center">{{payInfo.DELEND}}건</td>
							<td width="15%" class="text-center">{{payInfo.RETURNREQUEST}}건</td>
							<td width="14%" class="text-center">{{payInfo.SELLERCANCEL}}건</td>
							<td width="14%" class="text-center">{{payInfo.RETURNEND}}건</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td style="padding: 0px;">
					<h3 class="table-titlee text-center">프로모션/문의</h3>
					<table class="table mp">
						<tr style="background: lightgray; color: white;">
							<th width="25%" class="text-center">할인</th>
							<th width="25%" class="text-center">쿠폰</th>
							<th width="25%" class="text-center">배너</th>
							<th width="25%" class="text-center">미응답문의</th>
						</tr>
						<tr>
							<td width="25%" class="text-center">{{etcInfo.SALE}}건</td>
							<td width="25%" class="text-center">{{etcInfo.COUPON}}건</td>
							<td width="25%" class="text-center">{{etcInfo.BANNER}}건</td>
							<td width="25%" class="text-center">{{etcInfo.NOANSWER}}건</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<div class="row" style="padding:0px">
			<span class="titlee">정산 가능 금액 : {{accPointFormat}}원</span>
		</div>
		<div class="wrap">
			<h2 class="text-center">7일간 방문자 수</h2>
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
				accPoint:0,
				noneAnswer:0,
				saleInfo:{},
				typeInfo:{},
				payInfo:{},
				etcInfo:{}
			}
		},
		computed:{
			accPointFormat(){
				return this.accPoint.toLocaleString()
			}
		},
		mounted(){
			axios.get('../seller/vueSellerHomeInfo.do').then(response=>{
				this.dates=response.data.dates
				this.maxVisit=response.data.maxVisit
				this.accPoint=response.data.accPoint
				$(document).ready(function() {
					let max=_this.maxVisit
				  $('.graph-bar').each(function() {
				     var dataWidth = $(this).data('value');
				     $(this).css("height", dataWidth/max*316 + "px");
				  });
				})
				axios.get('../seller/vueSellerSaleInfo.do').then(response=>{
					this.saleInfo=response.data.state
					this.typeInfo=response.data.type
					this.payInfo=response.data.pay
					this.etcInfo=response.data.etc
					console.log(response.data)
				})
			})
			_this=this
		}
	}).mount('#myHomeApp')
	</script>
</body>
</html>