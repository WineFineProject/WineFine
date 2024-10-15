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

.cou {
	cursor: pointer;
}

.custom-nav-link {
	border: 1px solid #dee2e6 !important; /* 모든 테두리 유지 */
	border-top: 3px solid #881824 !important;
	border-bottom: none !important; /* 아래쪽 테두리 제거 */
	color: black !important;
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

				<div class="table-responsive justify-content-center">
					<table class="table col-11">
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

				<div class="row g-4 justify-content-center">
					
					<div class="col-3 " style="height: 385px; overflow: scroll; overflow-x: hidden;">
						<h3>배송지선택</h3>
						<br>
						<table v-for="(userDeli,index) in userDeli" class="coupondiv" style="width: 290px; height: 150px; margin-bottom: 10px;">
							<thead>
								<tr>
									<th style="border-bottom: none;"></th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>
										<div style="padding: 10px 10px 0px 10px;" class="form-check">
											<input class="form-check-input" type="radio" name="flexRadioDefault" id="'flexRadioDefault'+index" style="margin: 0px auto;" v-model="selectAddr" :value="index"> 
											<label class="form-check-label" for="flexRadioDefault"></label> 
											<b>{{userDeli.name}}</b>
											<p>{{userDeli.addr1}}</p>
											<p>{{userDeli.addr2}}</p>
										</div>
									</td>
								</tr>
							</tbody>
						</table>
					</div>




					<div class="col-4">
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
										<td>
											<div style="margin-top: 10px; width: 290px;">
												<label for="search"> 쿠폰 검색</label> <input type="text" class="form-control cou" :disabled="isFd" :placeholder="selectedCoupon ? selectedCoupon.title + ' ('+selectedCoupon.discount+'%'+')' : '쿠폰을 선택하세요'" @click="selectCou()" readonly>
												<div class="result-list cou" id="listCou" v-if="isVisible" v-for="sale in psvo">
													<li @click="selectProduct(none)">쿠폰 선택 안 함</li>
													<li v-for="coupon in cvo" class="result-item" @click="selectProduct(coupon)"><a>{{coupon.title }} ({{ coupon.discount }}%)</a></li>
												</div>
											</div>
										</td>

									</tr>

									<tr>
										<td style="border-bottom: none; display: flex;"><input type="number" style="width: 290px;" class="text-center form-control" @keyup="checkPoint()" v-model="point" min="0" :max="userPoint">

											<button class="btn btn-md  bg-light  " style="margin-left: 5px;" @click="allPoint()">전액사용</button></td>
									</tr>
									<tr>
										<td style="border-bottom: none;">잔여 적립금 [ {{userPoint}} ] 원</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>

					<div class="col-5 ">
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
									<h5 class="mb-0 me-4">진행중인 프로모션</h5>
									<div class="">
										<p class="mb-0" v-for="sale in psvo" v-if="selectedCoupon == null">{{sale.discount != 0 ? sale.title +' ('+sale.discount+'%'+')' : '적용안함' }}</p>
										<p class="mb-0" v-for="sale in psvo" v-if="selectedCoupon != null">적용안함</p>
									</div>
								</div>

								<br>

								<div class="d-flex justify-content-between">
									<h5 class="mb-0 me-4">사용 쿠폰</h5>
									<div class="">
										<p class="mb-0">{{ selectedCoupon ? selectedCoupon.title +' ('+selectedCoupon.discount+'%'+')' : '적용안함' }}</p>
									</div>
								</div>

								<br>

								<div class="d-flex justify-content-between">
									<h5 class="mb-0 me-4">사용 적립금</h5>
									<div class="">
										<p class="mb-0">{{ point != null ? point + ' 원' : '적용안함' }}</p>
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
            cvo: [], // 쿠폰 목록
            list: [],
            selectedCoupon: null,
            quantity: 1,
            psvo: [], // 프로모션 목록
            isVisible: false, 
            userPoint:0,
            point:0,
            userDeli:[],	//배송지
            selectAddr:{} // 선택한 주소 값 가져오기
        };
    },
    computed: {
        totalPrice() {
            return (this.vo.price * this.quantity).toLocaleString()
        },
        totalPayment() {
            const selectedCouponDiscount = this.selectedCoupon ? this.selectedCoupon.discount : 0
            const psvoDiscount = this.psvo.length > 0 ? this.psvo[0].discount : 0

            if (selectedCouponDiscount > psvoDiscount) {
                // 쿠폰이 선택되었고 쿠폰 할인이 더 클 경우
                return (this.vo.price * this.quantity * (1 - selectedCouponDiscount / 100) - this.point).toLocaleString()
            } else if (psvoDiscount > 0) {
                // 프로모션 할인만 있을 경우
                return (this.vo.price * this.quantity * (1 - psvoDiscount / 100) - this.point).toLocaleString()
            } else {
                // 아무것도 선택되지 않았을 때
                return this.totalPrice - this.point  // 기본 가격 반환
            }
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
            this.psvo = response.data.psvo
            this.calculateTotalPrice()
            this.quantity = response.data.quantity || 1
            console.log("수량 : " + this.quantity)
            this.userPoint = response.data.userPoint
            this.userDeli = response.data.userDeli
            this.selectAddr = response.data.selectAddr
            console.log(this.selectAddr)
        }).catch(error => {
            console.log(error.response)
        });
    },
    methods: {
        getSelectedDelivery() {
            console.log(this.selectAddr) // 선택된 배송지의 인덱스를 출력
            if (this.selectAddr !== null) {
                const selectedDeli = this.userDeli[this.selectAddr]
                console.log(selectedDeli) // 선택된 배송지의 정보 출력
            }
        },
        increaseQuantity() {
            this.quantity++;
            this.calculateTotalPrice()
        },
        decreaseQuantity() {
            if (this.quantity > 1) {
                this.quantity--;
                this.calculateTotalPrice()
            }
        },
        calculateTotalPrice() {
            this.totalPrice = this.vo.price * this.quantity // 총 금액 계산
            console.log("총 금액: ", this.totalPrice)
        },
        payment() {
            alert('결제 처리중')
        },
        selectCou() {
            this.isVisible = !this.isVisible;
        },
        selectProduct(coupon) {
            this.selectedCoupon = coupon // 선택한 쿠폰을 저장
            this.isVisible = false // 리스트 숨기기
            
            // 선택된 쿠폰에 대한 추가 로직을 여기에 추가할 수 있습니다.
            if (this.psvo.length > 0 && this.cvo.length > 0) { // 배열이 비어 있지 않은지 확인
                const psvoDiscount = this.psvo[0].discount // 첫 번째 프로모션 할인
                const cvoDiscount = this.selectedCoupon.discount // 선택한 쿠폰 할인

                if (psvoDiscount >= cvoDiscount) {
                    alert('프로모션 할인 가격이 더 높습니다')
                    this.selectedCoupon = null // 선택한 쿠폰을 저장
                    this.isVisible = false // 리스트 숨기기
                    return
                }
                
            }
			
        },
        checkPoint(){
        	if(this.point >= this.userPoint ){
        		this.point = this.userPoint
        	}
        },
        allPoint(){
       		this.point = this.userPoint
        }
    }
}).mount('.shopcontainer')
</script>


</body>
</html>