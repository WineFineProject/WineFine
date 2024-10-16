<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://unpkg.com/vue@3"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>


<style type="text/css">
.info-list {
	list-style-type: none;
	padding: 0;
	margin: 0;
}

.info-list li {
	display: flex;
	justify-content: flex-start;
	margin-bottom: 10px;
}

.info-list .title {
	width: 150px; /* 제목의 고정 너비 설정 */
	font-weight: bold;
}

.info-list .content {
	flex-grow: 1; /* 내용이 유동적으로 확장되도록 설정 */
}

.custom-nav-link {
	border: 1px solid #dee2e6 !important; /* 모든 테두리 유지 */
	border-top: 3px solid #881824 !important;
	border-bottom: none !important; /* 아래쪽 테두리 제거 */
	color: black !important;
}

.winecor {
	background-color: #881824;
	color: white;
}

.whitecor {
	background-color: white;
	color: #881824 !important;
	border: solid 1px #881824;
}

.image-margin {
	width: 15px;
	height: 15px;
}

.font-style {
	margin-right: 10px;
	font-size: 17px;
}

.img-size {
	width: 20px;
	margin-right: 4px;
}

.img-margin {
	margin-left: auto;
}

.img-text {
	color: black;
	margin-left: 3px;
	margin-right: 6px;
}

.a-color {
	color: gray;
}

.img-hover {
	cursor: pointer;
}

.report {
	padding: -0.75rem 0.5rem;
	font-size: 0.875rem;
}

.otherWine {
	overflow: hidden;
	width: 202px; 
	text-overflow: ellipsis; 
}

.vegetable-carousel {
	display: flex !important; /* 가로로 배치 */
	overflow-x: hidden;
}

.vesitable-item {
	flex: 0 0 auto; /* 아이템이 고정 크기를 유지하도록 설정 */
	margin-right: 10px; /* 아이템 사이 간격 */
}
</style>
</head>
<body>
	<!-- Modal Search Start -->
	<!--         <div class="modal fade" id="searchModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-fullscreen">
                <div class="modal-content rounded-0">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Search by keyword</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body d-flex align-items-center">
                        <div class="input-group w-75 mx-auto d-flex">
                            <input type="search" class="form-control p-3" placeholder="keywords" aria-describedby="search-icon-1">
                            <span id="search-icon-1" class="input-group-text p-3"><i class="fa fa-search"></i></span>
                        </div>
                    </div>
                </div>
            </div>
        </div> -->
	<!-- Modal Search End -->


	<!-- Single Page Header start -->
	<div class="container-fluid page-header py-5">
		<h1 class="text-center text-white display-6">Shop Detail</h1>
	</div>
	<!-- Single Page Header End -->


	<!-- Single Product Start -->
	<div class="container-fluid py-5 mt-5 shopcontainer" v-for="vo in list">
		<div class="container py-5">
			<div class="row g-4 mb-5" style="width: 1600px;">
				<div class="col-xl-10">
					<div class="row g-4">
						<div class="col-lg-5">
							<div class="border rounded" style="width: 400px;">
								<a href="#"> <img :src="vo.poster" class="img-fluid rounded"
									alt="Image">
								</a>
							</div>
						</div>

						<div class="col-lg-7">
							<h4 class="fw-bold mb-3"></h4>
							<p class="mb-3 d-flex align-items-center">
								<span :class="vo.type === '화이트' ? 'whitecor' : 'winecor'">{{vo.type}}
									</span> | <span v-for="(nvo,index) in nname">{{index === 0
									?'':'&nbsp;|&nbsp;'}}<a>{{nvo}}</a>
								</span> <span class="img-margin"> <span> <img
										src="../img/like_off.png" class="img-size img-hover"> <span
										class="img-text"><b>0</b></span>
								</span> <img src="../img/eye.png" class="img-size "> <span
									class="img-text"><b>{{vo.hit}}</b></span> <span
									@click="copyLink()" class="img-hover"> <img
										src="../img/share.png" class="img-size "> <span>
									</span>
								</span>
								</span>
							</p>
							<h4 class="fw-bold mb-3">{{vo.namekor}}</h4>
							<p>
								<b>{{vo.nameeng}}</b>
							</p>
							<h5 class="fw-bold mb-3">{{vo.price}}({{vo.vol}})</h5>
							<div class="d-flex mb-4">
								<i class="fa fa-star text-secondary"></i> <i
									class="fa fa-star text-secondary"></i> <i
									class="fa fa-star text-secondary"></i> <i
									class="fa fa-star text-secondary"></i> <i class="fa fa-star"></i>
							</div>
							<div class="d-flex mb-4">
								<p>
									<b class="font-style">당도</b> <span v-if="vo.sugar === 0">
										<img class="image-margin" src="../img/0.png"> <img
										class="image-margin" src="../img/0.png"> <img
										class="image-margin" src="../img/0.png"> <img
										class="image-margin" src="../img/0.png"> <img
										class="image-margin" src="../img/0.png">
									</span> <span v-if="vo.sugar === 1"> <img class="image-margin"
										src="../img/1.png"> <img class="image-margin"
										src="../img/0.png"> <img class="image-margin"
										src="../img/0.png"> <img class="image-margin"
										src="../img/0.png"> <img class="image-margin"
										src="../img/0.png">
									</span> <span v-if="vo.sugar === 2"> <img class="image-margin"
										src="../img/1.png"> <img class="image-margin"
										src="../img/2.png"> <img class="image-margin"
										src="../img/0.png"> <img class="image-margin"
										src="../img/0.png"> <img class="image-margin"
										src="../img/0.png">
									</span> <span v-if="vo.sugar === 3"> <img class="image-margin"
										src="../img/1.png"> <img class="image-margin"
										src="../img/2.png"> <img class="image-margin"
										src="../img/3.png"> <img class="image-margin"
										src="../img/0.png"> <img class="image-margin"
										src="../img/0.png">
									</span> <span v-if="vo.sugar === 4"> <img class="image-margin"
										src="../img/1.png"> <img class="image-margin"
										src="../img/2.png"> <img class="image-margin"
										src="../img/3.png"> <img class="image-margin"
										src="../img/4.png"> <img class="image-margin"
										src="../img/0.png">
									</span> <span v-if="vo.sugar === 5"> <img class="image-margin"
										src="../img/1.png"> <img class="image-margin"
										src="../img/2.png"> <img class="image-margin"
										src="../img/3.png"> <img class="image-margin"
										src="../img/4.png"> <img class="image-margin"
										src="../img/5.png">
									</span> <b class="font-style">산도</b> <span v-if="vo.acid === 0">
										<img class="image-margin" src="../img/0.png"> <img
										class="image-margin" src="../img/0.png"> <img
										class="image-margin" src="../img/0.png"> <img
										class="image-margin" src="../img/0.png"> <img
										class="image-margin" src="../img/0.png">
									</span> <span v-if="vo.acid === 1"> <img class="image-margin"
										src="../img/1.png"> <img class="image-margin"
										src="../img/0.png"> <img class="image-margin"
										src="../img/0.png"> <img class="image-margin"
										src="../img/0.png"> <img class="image-margin"
										src="../img/0.png">
									</span> <span v-if="vo.acid === 2"> <img class="image-margin"
										src="../img/1.png"> <img class="image-margin"
										src="../img/2.png"> <img class="image-margin"
										src="../img/0.png"> <img class="image-margin"
										src="../img/0.png"> <img class="image-margin"
										src="../img/0.png">
									</span> <span v-if="vo.acid === 3"> <img class="image-margin"
										src="../img/1.png"> <img class="image-margin"
										src="../img/2.png"> <img class="image-margin"
										src="../img/3.png"> <img class="image-margin"
										src="../img/0.png"> <img class="image-margin"
										src="../img/0.png">
									</span> <span v-if="vo.acid === 4"> <img class="image-margin"
										src="../img/1.png"> <img class="image-margin"
										src="../img/2.png"> <img class="image-margin"
										src="../img/3.png"> <img class="image-margin"
										src="../img/4.png"> <img class="image-margin"
										src="../img/0.png">
									</span> <span v-if="vo.acid === 5"> <img class="image-margin"
										src="../img/1.png"> <img class="image-margin"
										src="../img/2.png"> <img class="image-margin"
										src="../img/3.png"> <img class="image-margin"
										src="../img/4.png"> <img class="image-margin"
										src="../img/5.png">
									</span> <b class="font-style">바디</b> <span v-if="vo.body === 0">
										<img class="image-margin" src="../img/0.png"> <img
										class="image-margin" src="../img/0.png"> <img
										class="image-margin" src="../img/0.png"> <img
										class="image-margin" src="../img/0.png"> <img
										class="image-margin" src="../img/0.png">
									</span> <span v-if="vo.body === 1"> <img class="image-margin"
										src="../img/1.png"> <img class="image-margin"
										src="../img/0.png"> <img class="image-margin"
										src="../img/0.png"> <img class="image-margin"
										src="../img/0.png"> <img class="image-margin"
										src="../img/0.png">
									</span> <span v-if="vo.body === 2"> <img class="image-margin"
										src="../img/1.png"> <img class="image-margin"
										src="../img/2.png"> <img class="image-margin"
										src="../img/0.png"> <img class="image-margin"
										src="../img/0.png"> <img class="image-margin"
										src="../img/0.png">
									</span> <span v-if="vo.body === 3"> <img class="image-margin"
										src="../img/1.png"> <img class="image-margin"
										src="../img/2.png"> <img class="image-margin"
										src="../img/3.png"> <img class="image-margin"
										src="../img/0.png"> <img class="image-margin"
										src="../img/0.png">
									</span> <span v-if="vo.body === 4"> <img class="image-margin"
										src="../img/1.png"> <img class="image-margin"
										src="../img/2.png"> <img class="image-margin"
										src="../img/3.png"> <img class="image-margin"
										src="../img/4.png"> <img class="image-margin"
										src="../img/0.png">
									</span> <span v-if="vo.body === 5"> <img class="image-margin"
										src="../img/1.png"> <img class="image-margin"
										src="../img/2.png"> <img class="image-margin"
										src="../img/3.png"> <img class="image-margin"
										src="../img/4.png"> <img class="image-margin"
										src="../img/5.png">
									</span> <b class="font-style">타닌</b> <span v-if="vo.tannin === 0">
										<img class="image-margin" src="../img/0.png"> <img
										class="image-margin" src="../img/0.png"> <img
										class="image-margin" src="../img/0.png"> <img
										class="image-margin" src="../img/0.png"> <img
										class="image-margin" src="../img/0.png">
									</span> <span v-if="vo.tannin === 1"> <img class="image-margin"
										src="../img/1.png"> <img class="image-margin"
										src="../img/0.png"> <img class="image-margin"
										src="../img/0.png"> <img class="image-margin"
										src="../img/0.png"> <img class="image-margin"
										src="../img/0.png">
									</span> <span v-if="vo.tannin === 2"> <img class="image-margin"
										src="../img/1.png"> <img class="image-margin"
										src="../img/2.png"> <img class="image-margin"
										src="../img/0.png"> <img class="image-margin"
										src="../img/0.png"> <img class="image-margin"
										src="../img/0.png">
									</span> <span v-if="vo.tannin === 3"> <img class="image-margin"
										src="../img/1.png"> <img class="image-margin"
										src="../img/2.png"> <img class="image-margin"
										src="../img/3.png"> <img class="image-margin"
										src="../img/0.png"> <img class="image-margin"
										src="../img/0.png">
									</span> <span v-if="vo.tannin === 4"> <img class="image-margin"
										src="../img/1.png"> <img class="image-margin"
										src="../img/2.png"> <img class="image-margin"
										src="../img/3.png"> <img class="image-margin"
										src="../img/4.png"> <img class="image-margin"
										src="../img/0.png">
									</span> <span v-if="vo.tannin === 5"> <img class="image-margin"
										src="../img/1.png"> <img class="image-margin"
										src="../img/2.png"> <img class="image-margin"
										src="../img/3.png"> <img class="image-margin"
										src="../img/4.png"> <img class="image-margin"
										src="../img/5.png">
									</span>
								</p>
							</div>
							<div>
								<span>아로마</span>
							</div>
							<div>
								<ul>
									<li>{{vo.aroma != null ? vo.aroma : '정보없음' }}</li>
								</ul>
							</div>
							<div>
								<span>음식매칭</span>
							</div>
							<div>
								<ul>
									<li>{{vo.food != null ? vo.food : '정보없음' }}</li>
								</ul>
							</div>

							<div class="d-flex align-items-center mb-5">
								<div class="input-group quantity" style="width: 100px;">
									<div class="input-group-btn">
										<button
											class="btn btn-sm btn-minus rounded-circle bg-light border">
											<i class="fa fa-minus"></i>
										</button>
									</div>
									<input type="text"
										class="form-control form-control-sm text-center border-0"
										value="1">
									<div class="input-group-btn">
										<button
											class="btn btn-sm btn-plus rounded-circle bg-light border">
											<i class="fa fa-plus"></i>
										</button>
									</div>
								</div>

								<a
									class="btn border border-secondary rounded-pill px-4 py-2 ms-3 text-primary"
									@click="handleAddToCart()"> <i
									class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart
								</a> <a
									class="btn border border-secondary rounded-pill px-4 py-2 ms-3 text-primary"
									@click="handleBuyNow()"> <i
									class="fa fa-shopping-bag me-2 text-primary"></i> Buy Now
								</a>
							</div>
							<div style="text-align: right;">
								<a href="../shop/list.do" class="btn btn-default winecor"
									style="width: 150px; color: white;">목록</a>
							</div>

						</div>
						<div style="margin: 20px;"></div>

						<div class="col-lg-12" style="border-bottom: solid 1px #80808036;">
							<nav>
								<div class="nav nav-tabs mb-3">
									<button class="nav-link active custom-nav-link" type="button"
										role="tab" id="nav-about-tab" data-bs-toggle="tab"
										data-bs-target="#nav-about" aria-controls="nav-about"
										aria-selected="true">상세정보</button>
									<button class="nav-link border-white custom-nav-link"
										type="button" role="tab" id="nav-mission-tab"
										data-bs-toggle="tab" data-bs-target="#nav-mission"
										aria-controls="nav-mission" aria-selected="false">판매처</button>
								</div>
							</nav>

							<div class="tab-content mb-5">
								<div class="tab-pane active" id="nav-about" role="tabpanel"
									aria-labelledby="nav-about-tab">
									<div class="px-2">
										<div class="row g-4">
											<div class="col-6">
												<ul class="info-list">
													<li><span class="title">· 생산자</span> <span><a
															:href="'../maker/detail.do?no='+vo.maker" class="a-color">{{
																vo.makerkor != null ? vo.makerkor : '정보없음' }} / {{
																vo.makereng != null ? vo.makereng : '' }}</a></span></li>
													<li><span class="title">· 국가/생산지역</span> <span
														v-for="(nvo,index) in nname">{{index === 0
															?'':'&nbsp;|&nbsp;'}}<a
															:href="'../nation/detail.do?no='+nnolink[index]"
															class="a-color">{{ nvo != null ? nvo : '정보없음' }}</a>
													</span></li>
													<li><span class="title">· 주요품종</span> <span
														v-for="(gvo,index) in gname">{{index === 0 ?
															'':'&nbsp;|&nbsp;'}}<a
															:href="'../grape/detail.do?no='+gnolink[index]"
															class="a-color">{{ gvo != null ? gvo : '정보없음' }}</a>
													</span></li>
													<li><span class="title">· 도수</span> <span
														class="content">{{ vo.alcohol != null ? vo.alcohol
															: '정보없음' }}</span></li>
													<li><span class="title">· 추천음식</span> <span
														class="content">{{ vo.food != null ? vo.food :
															'정보없음' }}</span></li>
												</ul>
											</div>
										</div>
									</div>
								</div>

								<div class="tab-pane" id="nav-mission" role="tabpanel"
									aria-labelledby="nav-mission-tab">
									<ul class="info-list">
										<li><span class="title">· 판매자 정보</span> <span
											class="content">{{vo.seller!=null ? vo.seller:'정보없음'}}</span></li>
										<li><span class="title">· 신고하기</span> WineFine 은 소비자의 보호와
											사이트의 안전거래를 위해 <br> 신고 센터를 운영하고 있습니다. 안전 거레를 저해하는 경우 신고하여
											주시기 바랍니다.</li>
										<li><span class="title"></span><input type="button"
											value="신고하기" class="report"></li>
									</ul>
								</div>
							</div>
						</div>


						<form action="#" style="margin-top: 40px;">
							<h4 class="mb-5 fw-bold">Leave a Reply</h4>
							<div class="row g-4">
								<div class="d-flex align-items-center">
									<p class="mb-0 me-3">Please rate:</p>
									<div class="d-flex align-items-center" style="font-size: 12px;">
										<i class="fa fa-star text-muted"></i> <i class="fa fa-star"></i>
										<i class="fa fa-star"></i> <i class="fa fa-star"></i> <i
											class="fa fa-star"></i>
									</div>
								</div>

								<div class="col-lg-12">
									<div class="border-bottom rounded my-4">
										<textarea name="" id="" class="form-control border-0"
											cols="30" rows="8" placeholder="Your Review *"
											spellcheck="false" style="resize: none;"></textarea>
									</div>
								</div>
								<div class="col-lg-12">
									<div class="d-flex py-3 mb-5">
										<a href="#"
											class="btn border border-secondary text-primary rounded-pill px-4 py-3">
											Post Comment</a>
									</div>
								</div>
							</div>
						</form>
					</div>
				</div>

			</div>

			<div class="col-lg-12" style="border-bottom: solid 1px #80808036;">
				<h3>관련와인</h3><br>
				<nav>
					<div class="nav nav-tabs mb-3">
						<button class="nav-link active custom-nav-link" type="button"
							role="tab" id="nav-tab1" data-bs-toggle="tab"
							data-bs-target="#tab1-content" aria-controls="tab1-content"
							aria-selected="true">생산자</button>
						<button class="nav-link border-white custom-nav-link"
							type="button" role="tab" id="nav-tab2" data-bs-toggle="tab"
							data-bs-target="#tab2-content" aria-controls="tab2-content"
							aria-selected="false">판매자</button>
					</div>
				</nav>

				<div class="tab-content mb-5">
					<!-- 1번탭 내용 -->
					<div class="tab-pane active" id="tab1-content" role="tabpanel"
						aria-labelledby="nav-tab1">
						<div class="px-2">
							<div class="vesitable">
								<h3 class="fw-bold mb-0">&nbsp; "{{vo.makerkor}}" 의 다른 상품</h3>
								<br>
								<div
									class="owl-carousel vegetable-carousel justify-content-center">
									<div
										class="border border-primary rounded position-relative vesitable-item otherWine"
										v-for="mk in otherMaker" :key="mk.wno" style="width: 250px;">
										<a :href="'../shop/detail.do?wno=' + mk.wno + '&page=' + 2">
											<div style="width: 250px; height: 250px;">
												<img :src="mk.poster" class="img-fluid rounded-top" alt=""
													style="width: 250px; height: 267px; padding: 24px 24px 0;">
											</div>
											<div class="px-3 py-1 rounded position-absolute"
												style="top: 10px; right: 10px;"
												:class="mk.type === '화이트' ? 'whitecor' : 'winecor'">{{mk.type}}</div>
											<div class="p-4 pb-0 rounded-bottom"
												style="width: 250px; height: 140px;">
												<h4
													style="display: -webkit-box; -webkit-box-orient: vertical; overflow: hidden; text-overflow: ellipsis; -webkit-line-clamp: 2; line-height: 1.2; max-height: 2.4em; width: 200px;">
													{{mk.namekor}}</h4>
												<div class="d-flex justify-content-between flex-lg-wrap">
													<p class="text-dark fs-5 fw-bold" v-if="mk.price != null">{{mk.price}}
														({{mk.vol}})</p>
													<p class="text-dark fs-5 fw-bold" v-if="mk.price === null">{{mk.price}}
														({{mk.vol}})</p>
												</div>
											</div>
										</a>
									</div>
								</div>
							</div>
						</div>
					</div>

					<!-- 2번탭 내용 -->
					<div class="tab-pane" id="tab2-content" role="tabpanel"
						aria-labelledby="nav-tab2">
						<div class="px-2">
							<div class="vesitable">
								<h3 class="fw-bold mb-0">&nbsp; "{{vo.seller}}" 의 Top 5</h3>
								<br>
								<div class="owl-carousel vegetable-carousel justify-content-center" style=" overflow-x: auto;">
									<div class="border border-primary rounded position-relative vesitable-item otherWine"
										v-for="sl in otherSeller" :key="sl.wno" style="width: 250px;">
										<a :href="'../shop/detail.do?wno=' + sl.wno + '&page=' + 2">
											<div style="width: 250px; height: 250px;">
												<img :src="sl.poster" class="img-fluid rounded-top" alt=""
													style="width: 250px; height: 267px; padding: 24px 24px 0;">
											</div>
											<div class="px-3 py-1 rounded position-absolute"
												style="top: 10px; right: 10px;"
												:class="sl.type === '화이트' ? 'whitecor' : 'winecor'">{{sl.type}}</div>
											<div class="p-4 pb-0 rounded-bottom"
												style="width: 250px; height: 140px;">
												<h4
													style="display: -webkit-box; -webkit-box-orient: vertical; overflow: hidden; text-overflow: ellipsis; -webkit-line-clamp: 2; line-height: 1.2; max-height: 2.4em; width: 200px;">
													{{sl.namekor}}</h4>
												<div class="d-flex justify-content-between flex-lg-wrap">
													<p class="text-dark fs-5 fw-bold" v-if="sl.price != null">{{sl.price}}
														({{sl.vol}})</p>
													<p class="text-dark fs-5 fw-bold" v-if="sl.price === null">가격문의
														({{sl.vol}})</p>
												</div>
											</div>
										</a>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>


		</div>
	</div>
	<!-- Single Product End -->


	<!-- Back to Top -->
	<a href="#"
		class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i
		class="fa fa-arrow-up"></i></a>
	<script>
	let detailApp = Vue.createApp({
	    data() {
	        return {
	            vo: {}, // 와인 상세 정보
	            wno: '${wno}', // 와인 번호 (문자열로 처리)
	            sessionId: '${session}', // 사용자 세션 ID (문자열로 처리)
	            list: [],
	            msg: '',
	            isUps: false,
	            gname: [],
	            nname: [],
	            gnolink: [],
	            nnolink: [],
	            mnolink: '',
	            otherMaker: null, // 초기화
	            otherSeller: null,
	            carousel: null, 
	            account: 1
	        }
	    },
	    mounted() {
	        // 초기 데이터 로드
	        axios.get('../shop/detail_vue.do', {
	            params: {
	                wno: this.wno
	            }
	        }).then(response => {
	            console.log(response.data)
	            this.vo = response.data.vo
	            this.gname = response.data.gname
	            this.nname = response.data.nname
	            this.mname = response.data.mname
	            this.gnolink = response.data.gnolink
	            this.nnolink = response.data.nnolink
	            this.mnolink = response.data.mnolink
	            this.otherMaker = response.data.otherMaker
				this.otherSeller = response.data.otherSeller
	            // Owl Carousel 초기화
	            this.$nextTick(() => {
	                this.carousel = $('.owl-carousel').owlCarousel({
	                    items: 1, // 한 번에 보여줄 아이템 수
	                    loop: true,
	                    margin: 10,
	                    nav: false,
	                    touchDrag: true, // 드래그 활성화
	                    mouseDrag: true, // 마우스 드래그 활성화
	                });
	            });
	        }).catch(error => {
	            console.error('데이터 로드 오류:', error.response)
	        });
	    },
	    methods: {
	        // 링크 복사 메서드
	        copyLink() {
	            const urlToCopy = window.location.href
	            navigator.clipboard.writeText(urlToCopy)
	                .then(() => {
	                    alert('링크가 복사되었습니다')
	                })
	                .catch(err => {
	                    console.error('링크 복사 실패:', err)
	                });
	        },
	        handleAddToCart() {
	            if (this.sessionId) {	                
	                this.addToCart()
	            } else {
	                alert('로그인 후 사용이 가능합니다.')
	                window.location.href = '../member/login.do'
	            }
	        },
	        addToCart(){
	        	axios.post('../shop/cart_insert.do',null,{
	        		params:{
	        			wno: this.wno,
	        			account: this.account
	        		}        		
	        	}).then(response=>{
	        		console.log(response.data)
	        		alert("장바구니에 추가되었습니다.")
	        	}).catch(error=>{
	        		console.log(error.response)
	        	})
	        },
	        handleBuyNow() {
	            if (this.sessionId) {
	                window.location.href = '../shop/buy.do?wno=' + this.vo.wno;
	            } else {
	                alert('로그인 후 사용이 가능합니다.');
	                window.location.href = '../member/login.do'; 
	            }
	        }
	    }
	}).mount('.shopcontainer');

</script>



</body>
</html>