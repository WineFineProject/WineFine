<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://unpkg.com/vue@3"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<style type="text/css">
.coupondiv {
	border: solid 1px;
	border-radius: 15px;
}

.use {
	cursor: pointer;
}

.winecor {
	background-color: #881824;
	color: white;
}
</style>
</head>
<body>
	<div class="shopcontainer">
		<!-- Modal Search Start -->
		<div class="modal fade" id="searchModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-fullscreen">
				<div class="modal-content rounded-0">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel">Search by keyword</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body d-flex align-items-center">
						<div class="input-group w-75 mx-auto d-flex">
							<input type="search" class="form-control p-3" placeholder="keywords" aria-describedby="search-icon-1"> <span id="search-icon-1" class="input-group-text p-3"><i class="fa fa-search"></i></span>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- Modal Search End -->


		<!-- Single Page Header start -->
		<div class="container-fluid page-header py-5">
			<h1 class="text-center text-white display-6">구매 확인</h1>
		</div>
		<!-- Single Page Header End -->


		<!-- Cart Page Start -->
		<div class="container-fluid py-5">
			<div class="container py-5">
			<div>판매자 &gt; <a href="#">{{vo.seller}}</a></div>
				<div class="table-responsive">
					<table class="table">
						<thead>
							<tr>
								<th scope="col"></th>
								<th scope="col">상품명</th>
								<th scope="col">가격</th>
								<th scope="col">수량</th>
								<th scope="col">총 금액</th>
								<th scope="col"></th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<th scope="row" class="align-middle"><img :src="vo.poster" class="img-fluid me-5 rounded-circle" style="width: 80px; height: 80px;" alt=""></th>
								<td class="align-middle">
									<p class="mb-0">{{ vo.namekor }}</p>
								</td>
								<td class="align-middle">
									<p class="mb-0">{{ vo.price }} 원</p>
								</td>
								<td class="align-middle">
									<div class="input-group quantity" style="width: 100px;">
										<!--                         <button class="btn btn-sm  rounded-circle bg-light border" @click="decreaseQuantity">
                            <i class="fa fa-minus"></i>
                        </button> -->
										<input type="number" class="form-control form-control-sm text-center border-0" v-model.number="quantity" min="1" />

										<!--                         <button class="btn btn-sm  rounded-circle bg-light border" @click="increaseQuantity">
                            <i class="fa fa-plus"></i>
                        </button> -->
									</div>
								</td>
								<td class="align-middle">
									<p class="mb-0">{{ (vo.price * quantity).toLocaleString() }} 원</p>
								</td>
								<td class="align-middle">
									<button class="btn btn-md rounded-circle bg-light border">
										<i class="fa fa-times text-danger"></i>
									</button>
								</td>
							</tr>
						</tbody>
					</table>
				</div>


				<div class="row g-4 justify-content-end">
					<div class="col-5">
						<h3>할인쿠폰 / 적립금</h3>
						<div class="table-responsive coupondiv">
							<table class="table">
								<thead>
									<tr>
										<th style="border-bottom: none;"></th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td><select v-model="selectedCoupon" style="width: 400px;" class="text-center">
												<option disabled value="">쿠폰을 선택하세요</option>
												<option v-for="coupon in cvo" :key="coupon.couponId" :value="coupon">{{ coupon.title }} ({{ coupon.discount }}%) {{coupon.endDay}} 까지</option>
										</select>
											<button class="btn btn-md rounded-circle bg-light border" style="margin-left: 30px;">
												<i class="fa fa-times text-danger"></i>
											</button></td>
									</tr>

									<tr>
										<td style="border-bottom: none;"><input type="text" value="0원" style="width: 400px;" class="text-center" onfocus="this.value=''" onblur="if(this.value === '') this.value='0원'">
											<button class="btn btn-md  bg-light  " style="margin-left: 5px;">전액사용</button></td>
									</tr>
									<tr>
										<td style="border-bottom: none;">잔여 적립금 [0] 원</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<div class="col-1"></div>
					<div class="col-6 ">
						<h3>총 결제 금액</h3>
						<div class="bg-light rounded">
							<div class="p-4" style="border: solid 1px; border-radius: 15px 15px 0px 0px; border-bottom: solid 1px gainsboro;">
								<div class="d-flex justify-content-between">
									<h5 class="mb-0 me-4">상품 목록</h5>
									<div class="">
										<p class="mb-0 ">{{vo.namekor}}</p>
									</div>
								</div>

								<p class="mb-0 text-end">수량 : {{quantity}} 개 &nbsp;&nbsp; {{totalPrice}} 원</p>
							</div>
							<div class="p-4" style="border: solid 1px; border-top: solid 1px gainsboro;">
								<div class="d-flex justify-content-between">
									<h5 class="mb-0 me-4">사용 쿠폰</h5>
									<div class="">
										<p class="mb-0">{{ selectedCoupon ? selectedCoupon.title +' ('+selectedCoupon.discount+'%'+')' : '적용안함' }}</p>
									</div>
								</div>
							</div>


							<div class="py-4 border-top  justify-content-between use" @click="payment" style="border: solid 1px; border-radius: 0px 0px 15px 15px; border-top: none !important;">
								<h5 class="mb-0 ps-4  text-center">[ {{totalPayment}} 원 ] 결제하기</h5>
							</div>

						</div>
					</div>
					<div style="text-align: center !important; margin-bottom: -40px; margin-top: 110px;">
						<button class="btn btn-default winecor" style="width: 150px; color: white;" onclick="history.back();">취소</button>
					</div>

				</div>

			</div>
		</div>
		<!-- Cart Page End -->

		<!-- Copyright Start -->
		<div class="container-fluid copyright bg-dark py-4">
			<div class="container">
				<div class="row">
					<div class="col-md-6 text-center text-md-start mb-3 mb-md-0">
						<span class="text-light"><a href="#"><i class="fas fa-copyright text-light me-2"></i>Your Site Name</a>, All right reserved.</span>
					</div>
					<div class="col-md-6 my-auto text-center text-md-end text-white">
						<!--/*** This template is free as long as you keep the below author’s credit link/attribution link/backlink. ***/-->
						<!--/*** If you'd like to use the template without the below author’s credit link/attribution link/backlink, ***/-->
						<!--/*** you can purchase the Credit Removal License from "https://htmlcodex.com/credit-removal". ***/-->
						Designed By <a class="border-bottom" href="https://htmlcodex.com">HTML Codex</a>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Copyright End -->



	<!-- Back to Top -->
	<a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i class="fa fa-arrow-up"></i></a>
	<script>
	let buyApp = Vue.createApp({
		data() {
			return {
				vo: {},
				wno: ${wno},
				cvo: [], 
				list: [],
				selectedCoupon: null,  // 선택된 쿠폰을 저장할 변수
				quantity: 1,
				sessionId:'${sessionId}'
			}
		},
		computed: {
		    totalPrice() {
		        return (this.vo.price * this.quantity).toLocaleString(); 
		    },
		    totalPayment() {
		        // coupon이 아닌 selectedCoupon을 사용해야 합니다.
		        return this.selectedCoupon 
		            ? (this.vo.price * this.quantity * (1 - this.selectedCoupon.discount / 100)).toLocaleString()
		            : this.totalPrice; // 쿠폰이 선택되지 않았을 때 totalPrice 반환
		    }
		},
		mounted() {
		    axios.get('../shop/buy_vue.do', {
		        params: {
		            wno: this.wno
		        }
		    }).then(response => {
		        console.log(response.data)
		        this.vo = response.data.vo
		        this.cvo = response.data.cvo
		        this.list = response.data.list 
		        this.cvo_list = this.cvo.couponList || []  
				this.calculateTotalPrice() 
		        this.quantity = response.data.quantity || 1; // 기본값 1 설정
		        console.log("수량 : "+this.quantity)		        
		    }).catch(error => {
		        console.log(error.response)
		    })
		},
		methods: {
			increaseQuantity() {
				this.quantity++;
				this.calculateTotalPrice();
			},
			decreaseQuantity() {
				if (this.quantity > 1) { // 수량이 1보다 작아지지 않도록 제한
					this.quantity--;
					this.calculateTotalPrice();
				}
			},
			calculateTotalPrice() {
				this.totalPrice = this.vo.price * this.quantity; // 총 금액 계산
				console.log("총 금액: ", this.totalPrice);
			},
			payment() {
				alert('결제 처리중');
			}
		}
	}).mount('.shopcontainer')
</script>

</body>
</html>