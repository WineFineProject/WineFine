<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>

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

.selectAd.selected {
	background-color: #e0e0e0; /* 선택된 배경색 */
	border: 1px solid #881824; /* 선택된 경계선 색상 */
}

.selectAd:hover {
	background-color: #e0e0e0; /* hover 시 배경색 */
}

.noborder {
	border: none;
	border-bottom: 2px solid #881824;
}
</style>
</head>
<body>
	<div class="shopcontainer">
		<!-- Modal Search Start -->
		<div class="modal fade" id="searchModal" tabindex="-1"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-fullscreen">
				<div class="modal-content rounded-0">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel">Search by
							keyword</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body d-flex align-items-center">
						<div class="input-group w-75 mx-auto d-flex">
							<input type="search" class="form-control p-3"
								placeholder="keywords" aria-describedby="search-icon-1">
							<span id="search-icon-1" class="input-group-text p-3"><i
								class="fa fa-search"></i></span>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- Modal Search End -->
		<!-- Cart Page Start -->
		<div class="container-fluid py-5">
			<div class="container py-5">

				<div class="table-responsive justify-content-center">
					<table class="table col-11">
						<thead>
							<tr>
								<th width="7%" class="noborder"
									style="border-left: 1px solid; border-top: 1px solid;"></th>
								<th width="43%" class="noborder text-center"
									style="border-top: 1px solid;">주문상품</th>
								<th width="15%" class="noborder text-center"
									style="border-top: 1px solid;">가격</th>
								<th width="15%" class="noborder text-center"
									style="border-top: 1px solid;">수량</th>
								<th width="20%" class="noborder text-center"
									style="border-top: 1px solid; border-right: 1px solid;">총
									금액</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<th scope="row" class="align-middle" style="border-right: none;"><img
									:src="vo.poster" class="img-fluid me-5"
									style="width: 80px; height: 80px;" alt=""></th>
								<td class="align-middle text-center">
									<p class="mb-0">
										<b>{{ vo.namekor }}</b>
									</p>
								</td>
								<td class="align-middle text-center">
									<p class="mb-0">{{ vo.price }} 원</p>
								</td>
								<td class="align-middle text-center">
									<div class="input-group quantity"
										style="width: 100px; margin: 0 auto;">
										<input type="number"
											class="form-control form-control-sm text-center border-0"
											v-model.number="quantity" min="1" style="text-align: center;" />
									</div>
								</td>
								<td class="align-middle text-center"
									style="border-right: 1px solid lightgray;">
									<p class="mb-0">{{ (vo.price * quantity).toLocaleString()
										}} 원</p>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="row g-4 justify-content-center">
					<div class="col-3 "
						style="height: 385px; overflow: auto; overflow-x: hidden;">
						<h3>배송지선택</h3>
						<br>
						<table v-for="(user, index) in userDeli"
							:class="['coupondiv', 'selectAd', {'selected': selectAddr.wdno === user.wdno}]"
							style="width: 290px; height: 150px; margin-bottom: 10px; border-radius: 0px;">
							<tbody>
								<tr>
									<td>
										<div class="form-check "
											style="padding: 10px 10px 0px 10px; cursor: pointer;">
											<input class="form-check-input" type="radio"
												name="flexRadioDefault" :id="'flexRadioDefault'+index"
												style="display: none;"> <label
												class="form-check-label" :for="'flexRadioDefault'+index"
												@click="selectAddress(index)" style="cursor: pointer">
												<b>{{user.name}}</b>
												<p>{{user.addr1}}</p>
												<p>{{user.addr2}}</p>
											</label>
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
												<label for="search"> 쿠폰 검색</label> <input type="text"
													class="form-control cou" value='쿠폰을 선택하세요'
													@click="selectCou()" readonly>
												<div class="result-list cou" id="listCou" v-if="isVisible"
													v-for="sale in psvo">
													<li @click="selectProduct(99999)">쿠폰 선택 안 함</li>
													<li v-for="(coupon, index) in cvo" class="result-item"
														@click="selectProduct(index)"><a>{{coupon.title
															}} ({{ coupon.discount }}%)</a></li>
												</div>
											</div>
										</td>
									</tr>
									<tr>
										<td style="border-bottom: none; display: flex;"><input
											type="number" style="width: 290px;"
											class="text-center form-control" @keyup="checkPoint()"
											v-model="point" min="0" :max="vo.price">

											<button class="btn btn-md  bg-light  "
												style="margin-left: 5px;" @click="allPoint()">전액사용</button></td>
									</tr>
									<tr>
										<td style="border-bottom: none;">잔여 적립금 [ {{userPoint}} ]
											원</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<div class="col-5 ">
						<h3>총 결제 금액</h3>
						<div class="bg-light rounded">
							<div class="p-4"
								style="border: solid 1px; border-radius: 15px 15px 0px 0px; border-bottom: solid 1px gainsboro;">
								<div class="d-flex justify-content-between">
									<h5 class="mb-0 me-4">상품 목록</h5>
									<div class="">
										<p class="mb-0 ">{{vo.namekor}}</p>
									</div>
								</div>
								<p class="mb-0 text-end">수량 : {{quantity}} 개 &nbsp;&nbsp;
									{{totalPrice}} 원</p>
							</div>
							<div class="p-4"
								style="border: solid 1px; border-top: solid 1px gainsboro;">
								<div class="d-flex justify-content-between">
									<h5 class="mb-0 me-4">진행중인 프로모션</h5>
									<div class="">
										<p class="mb-0" v-if="promo === 0 ">없음</p>
										<p class="mb-0" v-for="sale in psvo" v-if="!isCoupon">{{sale.discount
											!= 0 ? sale.title +' ('+sale.discount+'%'+')' : '없음' }}</p>
										<p class="mb-0" v-for="sale in psvo" v-if="isCoupon">없음</p>
									</div>
								</div>
								<br>
								<div class="d-flex justify-content-between">
									<h5 class="mb-0 me-4">사용 쿠폰</h5>
									<div class="">
										<p class="mb-0">{{ isCoupon? selectedCoupon.title +'
											('+selectedCoupon.discount+'%'+')' : '적용안함' }}</p>
									</div>
								</div>
								<br>
								<div class="d-flex justify-content-between">
									<h5 class="mb-0 me-4">사용 적립금</h5>
									<div class="">
										<p class="mb-0">{{ point != null ? point + ' 원' : '적용안함'
											}}</p>
									</div>
								</div>
								<br>
								<div class="d-flex justify-content-between">
									<h5 class="mb-0 me-4">적립 예정 포인트</h5>
									<div class="">
										<p class="mb-0">{{plpoint()}} 원</p>
									</div>
								</div>
							</div>
							<div class="py-4 border-top  justify-content-between use"
								@click="payment"
								style="border: solid 1px; border-radius: 0px 0px 15px 15px; border-top: none !important;">
								<h5 class="mb-0 ps-4  text-center">[
									{{totalPayment.toLocaleString()}} 원 ] 결제하기</h5>
							</div>
						</div>
					</div>
					<div
						style="display: flex; justify-content: center; margin-top: 110px;">
						<button class="btn btn-default winecor"
							style="width: 150px; color: white; margin-right: 10px;"
							@click="payment">결제하기</button>
						<button class="btn btn-default winecor"
							style="width: 150px; color: white;" onclick="history.back();">취소</button>
					</div>
					<div>
						<button @click="requestPay()">test</button>
					</div>
				</div>
			</div>
			<!-- Cart Page End -->
			<!-- Copyright Start -->
			<div class="container-fluid copyright bg-dark py-4">
				<div class="container">
					<div class="row">
						<div class="col-md-6 text-center text-md-start mb-3 mb-md-0">
							<span class="text-light"><a href="#"><i
									class="fas fa-copyright text-light me-2"></i>Your Site Name</a>,
								All right reserved.</span>
						</div>
						<div class="col-md-6 my-auto text-center text-md-end text-white">
							Designed By <a class="border-bottom" href="https://htmlcodex.com">HTML
								Codex</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Copyright End -->
<script>
let buyApp = Vue.createApp({
    data() {
        return {
            vo: {},
            wno: ${wno},
            cvo: [],
            selectedCoupon: {},
            quantity: 1,
            psvo: [],
            isVisible: false,
            userPoint: 0,
            userGrade: 0,
            point: 0,
            userDeli: [], // 배송지
            selectAddr: {}, // 선택한 주소에 wdno 가져오기
            promo: 0,
            isCoupon: false,
            pay: 0,
            plus: 0
        }
    },
    computed: {
        totalPrice() {
            return (this.vo.price * this.quantity).toLocaleString()
        },
        totalPayment() {
            const selectedCouponDiscount = this.isCoupon ? this.selectedCoupon.discount : 0
            const psvoDiscount = this.promo != 0 ? this.psvo[0].discount : 0
            if (selectedCouponDiscount > psvoDiscount) {
                return (this.vo.price * this.quantity * (1 - selectedCouponDiscount / 100) - this.point)
            } else if (psvoDiscount > 0) {
                return (this.vo.price * this.quantity * (1 - psvoDiscount / 100) - this.point)
            } else {
                return this.vo.price * this.quantity - this.point // 기본 가격 반환
            }
        }
    },  
    mounted() {
        axios.get('../shop/buypage_vue.do', {
            params: {
                wno: this.wno
            }
        }).then(response => {
            console.log(response.data)
            this.vo = response.data.vo
            this.cvo = response.data.cvo
            this.psvo = response.data.psvo
            this.userPoint = response.data.userPoint
            this.userDeli = response.data.userDeli
            this.selectAddr = response.data.userDeli[0]
            this.userGrade = response.data.userGrade
            this.promo = response.data.promo
            console.log('tpam' + this.totalPayment)
            console.log('프로모션 유무 0 x 1 o : ' + this.promo)
            console.log('회원 등급:' + this.userGrade)
            console.log('총 결제 금액:' + this.totalPayment)
            console.log(typeof this.totalPayment)
        }).catch(error => {
            console.log(error.response)
        })
    },
    methods: {
        plpoint() {
            if (this.userGrade === '1') {
                return 0
            }
            if (this.userGrade === '2') {
                return Math.round(this.totalPayment * 0.005)
            }
            if (this.userGrade === '3') {
                return Math.round(this.totalPayment * 0.015)
            }
        },
        increaseQuantity() {
            this.quantity++
        },
        decreaseQuantity() {
            if (this.quantity > 1) {
                this.quantity--
            }
        },
        selectCou() {
            this.isVisible = !this.isVisible
        },
        selectProduct(index) {
            if (index !== 99999) {
                if (this.selectedCoupon.discount >= this.cvo[index].discount) {
                    alert('지금 선택중인 할인 가격이 더 높습니다')
                    return
                }
                this.isCoupon = true
                this.selectedCoupon = this.cvo[index] // 선택한 쿠폰을 저장
                this.isVisible = false // 리스트 숨기기
                if (this.psvo.length > 0) {
                    const psvoDiscount = this.psvo[0].discount
                    const cvoDiscount = this.selectedCoupon.discount
                    if (psvoDiscount >= cvoDiscount) {
                        alert('프로모션 할인 가격이 더 높습니다')
                        this.selectedCoupon = {}
                        this.isVisible = false
                        this.isCoupon = false
                        return
                    }
                }
            } else {
                this.selectedCoupon = {}
                this.isCoupon = false
                this.isVisible = false
            }
        },
        checkPoint() {
            if (this.point >= this.userPoint) {
                this.point = this.userPoint
                if (this.point > parseInt(this.vo.price)) {
                    this.point = this.vo.price
                }
            }
        },
        allPoint() {
            console.log('test' + this.vo.price)
            if (this.userPoint > parseInt(this.vo.price)) {
                this.point = this.vo.price
            } else {
                console.log('typeof point :' + typeof this.point)
                console.log('typeof userPoint :' + typeof this.userPoint)
                console.log('typeof vo.price :' + typeof this.vo.price)
                this.point = this.userPoint
            }
        },
        selectAddress(index) {
            this.selectAddr = this.userDeli[index] // 선택한 배송지 정보를 selectAddr에 저장
            console.log('선택한 주소 wdno:', this.selectAddr.wdno) // wdno 출력
        },
        payment() {
            alert('결제 처리중')
            let selCoupon = !this.isCoupon ? 0 : this.selectedCoupon.mcno
            pay = this.totalPayment
            plus = this.plpoint
            axios.post('../shop/payment_vue.do', null, {
                params: { // 실제 전달하는 데이터
                    wno: this.wno,
                    wdno: this.selectAddr.wdno,
                    psno: this.promo !== 0
                        ? (this.isCoupon ? 0 : this.psvo[0].psno)
                        : 0,
                    account: this.quantity,
                    mcno: selCoupon,
                    mipoint: this.point,
                    plpoint: this.plpoint(),
                    payment: this.totalPayment
                }
            }).then(response => {
                console.log(response.data)
                if (response.data === "yes") {
                    alert("구매 성공!")
                    window.location.href = '../main/main.do'
                } else {
                    alert("구매 실패\n" + response.data)
                    return
                }
            }).catch(error => {
                console.log(error.response)
            })
        },
        isEmpty(object) {
            for (i in object) {
                return false
            }
            return true
        }
    }
}).mount('.shopcontainer')
</script>
</body>
</html>