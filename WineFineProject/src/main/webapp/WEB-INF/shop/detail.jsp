<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

.label.no-style {
	padding: 0;
	color: inherit;
	width: 16px;
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
								<img :src="vo.poster" class="img-fluid rounded" alt="Image">

							</div>
						</div>

						<div class="col-lg-7">
							<h4 class="fw-bold mb-3"></h4>
							<p class="mb-3 d-flex align-items-center">
								<span :class="vo.type === '화이트' ? 'whitecor' : 'winecor'">{{vo.type}} </span> | <span v-for="(nvo,index) in nname">{{index === 0 ?'':'&nbsp;|&nbsp;'}}<a>{{nvo}}</a>
								</span> <span class="img-margin"> <span> <img src="../img/like_off.png" class="img-size img-hover"> <span class="img-text"><b>0</b></span>
								</span> <img src="../img/eye.png" class="img-size "> <span class="img-text"><b>{{vo.hit}}</b></span> <span @click="copyLink()" class="img-hover"> <img src="../img/share.png" class="img-size "> <span> </span>
								</span>
								</span>
							</p>
							<h4 class="fw-bold mb-3">{{vo.namekor}}</h4>
							<p>
								<b>{{vo.nameeng}}</b>
							</p>
							<h5 class="fw-bold mb-3">{{vo.price}}({{vo.vol}})</h5>
							<div class="d-flex mb-4">
								<i class="fa fa-star text-secondary"></i> <i class="fa fa-star text-secondary"></i> <i class="fa fa-star text-secondary"></i> <i class="fa fa-star text-secondary"></i> <i class="fa fa-star"></i>
							</div>
							<div class="d-flex mb-4">
								<p>
									<b class="font-style">당도</b> <span v-if="vo.sugar === 0"> <img class="image-margin" src="../img/0.png"> <img class="image-margin" src="../img/0.png"> <img class="image-margin" src="../img/0.png"> <img class="image-margin" src="../img/0.png"> <img class="image-margin" src="../img/0.png">
									</span> <span v-if="vo.sugar === 1"> <img class="image-margin" src="../img/1.png"> <img class="image-margin" src="../img/0.png"> <img class="image-margin" src="../img/0.png"> <img class="image-margin" src="../img/0.png"> <img class="image-margin" src="../img/0.png">
									</span> <span v-if="vo.sugar === 2"> <img class="image-margin" src="../img/1.png"> <img class="image-margin" src="../img/2.png"> <img class="image-margin" src="../img/0.png"> <img class="image-margin" src="../img/0.png"> <img class="image-margin" src="../img/0.png">
									</span> <span v-if="vo.sugar === 3"> <img class="image-margin" src="../img/1.png"> <img class="image-margin" src="../img/2.png"> <img class="image-margin" src="../img/3.png"> <img class="image-margin" src="../img/0.png"> <img class="image-margin" src="../img/0.png">
									</span> <span v-if="vo.sugar === 4"> <img class="image-margin" src="../img/1.png"> <img class="image-margin" src="../img/2.png"> <img class="image-margin" src="../img/3.png"> <img class="image-margin" src="../img/4.png"> <img class="image-margin" src="../img/0.png">
									</span> <span v-if="vo.sugar === 5"> <img class="image-margin" src="../img/1.png"> <img class="image-margin" src="../img/2.png"> <img class="image-margin" src="../img/3.png"> <img class="image-margin" src="../img/4.png"> <img class="image-margin" src="../img/5.png">
									</span> <b class="font-style">산도</b> <span v-if="vo.acid === 0"> <img class="image-margin" src="../img/0.png"> <img class="image-margin" src="../img/0.png"> <img class="image-margin" src="../img/0.png"> <img class="image-margin" src="../img/0.png"> <img class="image-margin" src="../img/0.png">
									</span> <span v-if="vo.acid === 1"> <img class="image-margin" src="../img/1.png"> <img class="image-margin" src="../img/0.png"> <img class="image-margin" src="../img/0.png"> <img class="image-margin" src="../img/0.png"> <img class="image-margin" src="../img/0.png">
									</span> <span v-if="vo.acid === 2"> <img class="image-margin" src="../img/1.png"> <img class="image-margin" src="../img/2.png"> <img class="image-margin" src="../img/0.png"> <img class="image-margin" src="../img/0.png"> <img class="image-margin" src="../img/0.png">
									</span> <span v-if="vo.acid === 3"> <img class="image-margin" src="../img/1.png"> <img class="image-margin" src="../img/2.png"> <img class="image-margin" src="../img/3.png"> <img class="image-margin" src="../img/0.png"> <img class="image-margin" src="../img/0.png">
									</span> <span v-if="vo.acid === 4"> <img class="image-margin" src="../img/1.png"> <img class="image-margin" src="../img/2.png"> <img class="image-margin" src="../img/3.png"> <img class="image-margin" src="../img/4.png"> <img class="image-margin" src="../img/0.png">
									</span> <span v-if="vo.acid === 5"> <img class="image-margin" src="../img/1.png"> <img class="image-margin" src="../img/2.png"> <img class="image-margin" src="../img/3.png"> <img class="image-margin" src="../img/4.png"> <img class="image-margin" src="../img/5.png">
									</span> <b class="font-style">바디</b> <span v-if="vo.body === 0"> <img class="image-margin" src="../img/0.png"> <img class="image-margin" src="../img/0.png"> <img class="image-margin" src="../img/0.png"> <img class="image-margin" src="../img/0.png"> <img class="image-margin" src="../img/0.png">
									</span> <span v-if="vo.body === 1"> <img class="image-margin" src="../img/1.png"> <img class="image-margin" src="../img/0.png"> <img class="image-margin" src="../img/0.png"> <img class="image-margin" src="../img/0.png"> <img class="image-margin" src="../img/0.png">
									</span> <span v-if="vo.body === 2"> <img class="image-margin" src="../img/1.png"> <img class="image-margin" src="../img/2.png"> <img class="image-margin" src="../img/0.png"> <img class="image-margin" src="../img/0.png"> <img class="image-margin" src="../img/0.png">
									</span> <span v-if="vo.body === 3"> <img class="image-margin" src="../img/1.png"> <img class="image-margin" src="../img/2.png"> <img class="image-margin" src="../img/3.png"> <img class="image-margin" src="../img/0.png"> <img class="image-margin" src="../img/0.png">
									</span> <span v-if="vo.body === 4"> <img class="image-margin" src="../img/1.png"> <img class="image-margin" src="../img/2.png"> <img class="image-margin" src="../img/3.png"> <img class="image-margin" src="../img/4.png"> <img class="image-margin" src="../img/0.png">
									</span> <span v-if="vo.body === 5"> <img class="image-margin" src="../img/1.png"> <img class="image-margin" src="../img/2.png"> <img class="image-margin" src="../img/3.png"> <img class="image-margin" src="../img/4.png"> <img class="image-margin" src="../img/5.png">
									</span> <b class="font-style">타닌</b> <span v-if="vo.tannin === 0"> <img class="image-margin" src="../img/0.png"> <img class="image-margin" src="../img/0.png"> <img class="image-margin" src="../img/0.png"> <img class="image-margin" src="../img/0.png"> <img class="image-margin" src="../img/0.png">
									</span> <span v-if="vo.tannin === 1"> <img class="image-margin" src="../img/1.png"> <img class="image-margin" src="../img/0.png"> <img class="image-margin" src="../img/0.png"> <img class="image-margin" src="../img/0.png"> <img class="image-margin" src="../img/0.png">
									</span> <span v-if="vo.tannin === 2"> <img class="image-margin" src="../img/1.png"> <img class="image-margin" src="../img/2.png"> <img class="image-margin" src="../img/0.png"> <img class="image-margin" src="../img/0.png"> <img class="image-margin" src="../img/0.png">
									</span> <span v-if="vo.tannin === 3"> <img class="image-margin" src="../img/1.png"> <img class="image-margin" src="../img/2.png"> <img class="image-margin" src="../img/3.png"> <img class="image-margin" src="../img/0.png"> <img class="image-margin" src="../img/0.png">
									</span> <span v-if="vo.tannin === 4"> <img class="image-margin" src="../img/1.png"> <img class="image-margin" src="../img/2.png"> <img class="image-margin" src="../img/3.png"> <img class="image-margin" src="../img/4.png"> <img class="image-margin" src="../img/0.png">
									</span> <span v-if="vo.tannin === 5"> <img class="image-margin" src="../img/1.png"> <img class="image-margin" src="../img/2.png"> <img class="image-margin" src="../img/3.png"> <img class="image-margin" src="../img/4.png"> <img class="image-margin" src="../img/5.png">
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
										<button class="btn btn-sm btn-minus rounded-circle bg-light border">
											<i class="fa fa-minus"></i>
										</button>
									</div>
									<input type="text" class="form-control form-control-sm text-center border-0" value="1">
									<div class="input-group-btn">
										<button class="btn btn-sm btn-plus rounded-circle bg-light border">
											<i class="fa fa-plus"></i>
										</button>
									</div>
								</div>

								<a class="btn border border-secondary rounded-pill px-4 py-2 ms-3 text-primary" @click="handleAddToCart()"> <i class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart
								</a> <a class="btn border border-secondary rounded-pill px-4 py-2 ms-3 text-primary" @click="handleBuyNow()"> <i class="fa fa-shopping-bag me-2 text-primary"></i> Buy Now
								</a>
							</div>
							<div style="text-align: right;">
								<a href="../shop/list.do" class="btn btn-default winecor" style="width: 150px; color: white;">목록</a>
							</div>

						</div>
						<div style="margin: 20px;"></div>

						<div class="col-lg-12" style="border-bottom: solid 1px #80808036;">
							<nav>
								<div class="nav nav-tabs mb-3">
									<button class="nav-link active custom-nav-link" type="button" role="tab" id="nav-about-tab" data-bs-toggle="tab" data-bs-target="#nav-about" aria-controls="nav-about" aria-selected="true">상세정보</button>
									<button class="nav-link border-white custom-nav-link" type="button" role="tab" id="nav-mission-tab" data-bs-toggle="tab" data-bs-target="#nav-mission" aria-controls="nav-mission" aria-selected="false">판매처</button>
									<button class="nav-link border-white custom-nav-link" type="button" role="tab" id="nav-mission-tab2" data-bs-toggle="tab" data-bs-target="#nav-mission2" aria-controls="nav-mission2" aria-selected="false">상품 문의</button>
								</div>
							</nav>

							<div class="tab-content mb-5">
								<div class="tab-pane active" id="nav-about" role="tabpanel" aria-labelledby="nav-about-tab">
									<div class="px-2">
										<div class="row g-4">
											<div class="col-6">
												<ul class="info-list" style="width: 1230px;">
													<li><span class="title">· 생산자</span> <span><a :href="'../maker/detail.do?no='+vo.maker" class="a-color">{{ vo.makerkor != null ? vo.makerkor : '정보없음' }} / {{ vo.makereng != null ? vo.makereng : '' }}</a></span></li>
													<li><span class="title">· 국가/생산지역</span> <span v-for="(nvo,index) in nname">{{index === 0 ?'':'&nbsp;|&nbsp;'}}<a :href="'../nation/detail.do?no='+nnolink[index]" class="a-color">{{ nvo != null ? nvo : '정보없음' }}</a>
													</span></li>
													<li><span class="title">· 주요품종</span> <span v-for="(gvo,index) in gname">{{index === 0 ? '':'&nbsp;|&nbsp;'}}<a :href="'../grape/detail.do?no='+gnolink[index]" class="a-color">{{ gvo != null ? gvo : '정보없음' }}</a>
													</span></li>
													<li><span class="title">· 도수</span> <span class="content">{{ vo.alcohol != null ? vo.alcohol : '정보없음' }}</span></li>
													<li><span class="title">· 추천음식</span> <span class="content">{{ vo.food != null ? vo.food : '정보없음' }}</span></li>
												</ul>
											</div>
										</div>
									</div>
								</div>

								<div class="tab-pane" id="nav-mission" role="tabpanel" aria-labelledby="nav-mission-tab">
									<div class="px-2">
										<div class="row g-4">
											<div class="col-6">
												<ul class="info-list" style="width: 1230px;">
													<li><span class="title">· 판매자 정보</span> <span class="content">{{vo.seller!=null ? vo.seller:'정보없음'}}</span></li>
													<li><span class="title">· 신고하기</span> <span class="content">WineFine 은 소비자의 보호와 사이트의 안전거래를 위해 신고 센터를 운영하고 있습니다. <br> 안전 거레를 저해하는 경우 신고하여 주시기 바랍니다.
													</span></li>
													<li><span class="title"></span><input type="button" value="신고하기" class="report" @click="changeModal(true)"></li>
												</ul>
											</div>
										</div>
									</div>
								</div>

								<div class="tab-pane" id="nav-mission2" role="tabpanel" aria-labelledby="nav-mission-tab2">
									<div class="px-2">
										<div class="row g-4">
											<div class="col-6">
												<ul class="info-list" style="width: 1230px;">
													<li><span class="title">· 문의 게시판</span> <span class="content"></span></li>
													<li><span class="title">· 신고하기</span> WineFine 은 소비자의 보호와 사이트의 안전거래를 위해 <br> 신고 센터를 운영하고 있습니다. 안전 거레를 저해하는 경우 신고하여 주시기 바랍니다.</li>
													<li><span class="title"></span><input type="button" value="신고하기" class="report"></li>
												</ul>

											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div style="height: 15px;"></div>

						<h4 class="mb-5 fw-bold">리뷰(갯수)</h4>
						<div class="row g-4" style="align-items: center;">

							<div v-for="vw in reviewListData">
								<table>
									<tr>
										<td style="width: 130px;" class="text-center">
											<h5>
												<b>{{vw.nickname}}</b>
											</h5>
										</td>
										<td style="width: 130px;" class="text-center">
											<h5>
												<b>{{vw.srating}}</b>
											</h5>
										</td>
										<td style="width: 130px;" class="text-center">
											<h5>
												<b>{{vw.dbday}}</b>
											</h5>
										</td>
										<td>
											<button class="btn btn-md rounded-circle bg-light border">
												<i class="fa fa-times text-danger"></i>
											</button>
										</td>

									</tr>
								</table>
								<pre class="form-control" style="width: 70%; height: 110px; resize: none; margin-right: 10px;">{{vw.content}}</pre>

								<div style="height: 15px;"></div>
							</div>

							<div v-if="sessionId == ''">
								<h4>로그인 후 작성이 가능합니다</h4>
							</div>
							<template v-if="sessionId != ''">
								<div class="d-flex align-items-center">
									<table>
										<tr>
											<th style="width: 130px;" class="text-center">
												<h5>
													<b>{{sessionId}}</b>
												</h5>
											</th>
											<td style="width: 150px;">별점 : <label v-for="ss in 5" class="no-style" style="cursor: pointer;"> <input type="radio" name="sugarStars" :value="ss" v-model="srating" style="display: none;"> <i :class="{'text-wine':srating>=ss}" style="margin-right: 2px;" class="fa fa-star"></i>
											</label>
											</td>
										</tr>
									</table>
								</div>

								<div v-if="sessionId !== ''" style="display: flex; justify-content: center; align-items: center;">
									<textarea rows="4" cols="62" ref="review" v-model="review" class="form-control" style="width: 70%; resize: none; margin-right: 10px;"></textarea>
									<button class="form-control" style="background-color: #57102F; color: white; width: 100px; height: 110px;" @click="reviewInsert()">리뷰쓰기</button>
								</div>

							</template>
						</div>

					</div>
				</div>

			</div>

			<div class="col-lg-12" style="border-bottom: solid 1px #80808036;">
				<h3>관련와인</h3>
				<br>
				<nav>
					<div class="nav nav-tabs mb-3">
						<button class="nav-link active custom-nav-link" type="button" role="tab" id="nav-tab1" data-bs-toggle="tab" data-bs-target="#tab1-content" aria-controls="tab1-content" aria-selected="true">생산자</button>
						<button class="nav-link border-white custom-nav-link" type="button" role="tab" id="nav-tab2" data-bs-toggle="tab" data-bs-target="#tab2-content" aria-controls="tab2-content" aria-selected="false">판매자</button>

					</div>
				</nav>

				<div class="tab-content mb-5">
					<!-- 1번탭 내용 -->
					<div class="tab-pane active" id="tab1-content" role="tabpanel" aria-labelledby="nav-tab1">
						<div class="px-2">
							<div class="vesitable">
								<h3 class="fw-bold mb-0">&nbsp; "{{vo.makerkor}}" 의 다른 상품</h3>
								<br>
								<div class="owl-carousel vegetable-carousel justify-content-center">
									<div class="border border-primary rounded position-relative vesitable-item otherWine" v-for="mk in otherMaker" :key="mk.wno" style="width: 250px;">
										<a :href="'../shop/detail.do?wno=' + mk.wno + '&page=' + 2">
											<div style="width: 250px; height: 250px;">
												<img :src="mk.poster" class="img-fluid rounded-top" alt="" style="width: 250px; height: 267px; padding: 24px 24px 0;">
											</div>
											<div class="px-3 py-1 rounded position-absolute" style="top: 10px; right: 10px;" :class="mk.type === '화이트' ? 'whitecor' : 'winecor'">{{mk.type}}</div>
											<div class="p-4 pb-0 rounded-bottom" style="width: 250px; height: 140px;">
												<h4 style="display: -webkit-box; -webkit-box-orient: vertical; overflow: hidden; text-overflow: ellipsis; -webkit-line-clamp: 2; line-height: 1.2; max-height: 2.4em; width: 200px;">{{mk.namekor}}</h4>
												<div class="d-flex justify-content-between flex-lg-wrap">
													<p class="text-dark fs-5 fw-bold" v-if="mk.price != null">{{mk.price}} ({{mk.vol}})</p>
													<p class="text-dark fs-5 fw-bold" v-if="mk.price === null">{{mk.price}} ({{mk.vol}})</p>
												</div>
											</div>
										</a>
									</div>
								</div>
							</div>
						</div>
					</div>

					<!-- 2번탭 내용 -->
					<div class="tab-pane" id="tab2-content" role="tabpanel" aria-labelledby="nav-tab2">
						<div class="px-2">
							<div class="vesitable">
								<h3 class="fw-bold mb-0">&nbsp; "{{vo.seller}}" 의 Top 5</h3>
								<br>
								<div class="owl-carousel vegetable-carousel justify-content-center" style="overflow-x: auto;">
									<div class="border border-primary rounded position-relative vesitable-item otherWine" v-for="sl in otherSeller" :key="sl.wno" style="width: 250px;">
										<a :href="'../shop/detail.do?wno=' + sl.wno + '&page=' + 2">
											<div style="width: 250px; height: 250px;">
												<img :src="sl.poster" class="img-fluid rounded-top" alt="" style="width: 250px; height: 267px; padding: 24px 24px 0;">
											</div>
											<div class="px-3 py-1 rounded position-absolute" style="top: 10px; right: 10px;" :class="sl.type === '화이트' ? 'whitecor' : 'winecor'">{{sl.type}}</div>
											<div class="p-4 pb-0 rounded-bottom" style="width: 250px; height: 140px;">
												<h4 style="display: -webkit-box; -webkit-box-orient: vertical; overflow: hidden; text-overflow: ellipsis; -webkit-line-clamp: 2; line-height: 1.2; max-height: 2.4em; width: 200px;">{{sl.namekor}}</h4>
												<div class="d-flex justify-content-between flex-lg-wrap">
													<p class="text-dark fs-5 fw-bold" v-if="sl.price != null">{{sl.price}} ({{sl.vol}})</p>
													<p class="text-dark fs-5 fw-bold" v-if="sl.price === null">가격문의 ({{sl.vol}})</p>
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

			<div class="modal" :class="{ show: showModal }" @click.self="changeModal(false)">
				<div class="modal-content" style="width: 650px; height: 400px;">
					<h3 class="text-center">신고하기</h3>
					<table class="table" style="margin-top: 50px;">
						<tr>
							<th width="20%" class="text-center">신고대상 ID :</th>
							<td width="20%" class="text-center">{{vo.seller}}</td>
							<th width="20%" class="text-center">상품명 :</th>
							<td width="40%" class="text-center">{{vo.namekor}}</td>
						</tr>
						<tr>
							<th width="20%" class="text-center">카테고리 :</th>
							<td colspan="3"><select style="width: 175px;" v-model="category" @change="selectCategory($event)">
									<option value="상품관련">상품관련</option>
									<option value="배송관련">배송관련</option>
									<option value="기타신고">기타신고</option>
							</select></td>
						</tr>
						<tr>
							<th width="20%" class="text-center">신고 사유:</th>
							<td colspan="3"><textarea rows="4" cols="30" style="width: 100%; resize: none;" v-model="content">
						</textarea></td>
						</tr>
						<tr>
							<td colspan="4" class="rmbtn" style="text-align: center; border-bottom: none;">
								<button type="button" class="rmbtn btn-sm btn-success" @click="sendReport()">접수</button>&nbsp;&nbsp;
								<button type="button" class="rmbtn btn-sm btn-danger" @click="changeModal(false)">취소</button>
							</td>
						</tr>
					</table>
				</div>
			</div>


		</div>
	</div>
	<!-- Single Product End -->


	<!-- Back to Top -->
	<a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i class="fa fa-arrow-up"></i></a>
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
	            account: 1,
	            showModal: false,
	            category: '배송관련',
	            content: '',
	            review: '',
	            srating: 0,
	            reviewListData: [],
	            count: 4
	        }
	    },
	    mounted() {
	        // 초기 데이터 로드
	        axios.get('../shop/detail_vue.do', {
	            params: {
	                wno: this.wno,
	                count: this.count
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
				this.reviewListData = response.data.reviewListData
				console.log('reviewListData : ' + this.reviewListData)
				this.count = response.data.count
	            console.log('count : ' + this.count)
	            // Owl Carousel 초기화
	            this.$nextTick(() => {
	                this.carousel = $('.owl-carousel').owlCarousel({
	                    items: 1, // 한 번에 보여줄 아이템 수
	                    loop: true,
	                    margin: 10,
	                    nav: false,
	                    touchDrag: true, // 드래그 활성화
	                    mouseDrag: true, // 마우스 드래그 활성화
	                })
	            })
	        }).catch(error => {
	            console.error('데이터 로드 오류:', error.response)
	        })
	    },
	    methods: {
	    	selectCategory($event){
	    		console.log(this.category)
	    	},
	    	sendReport() {
	    		axios.post('../shop/seller_report.do', null, {
					params:{		  
						userid: this.sessionId,
		    			type: 3,
		    			tno: this.wno,
		    			state: 1,
		    			rid: this.vo.seller,
		    			category: this.category,
		    			content: this.content	  	    			
					}
	    		}).then(response => {
	    			console.log(response.data)
	    			console.log('신고자 :' + this.sessionId)
	    			console.log('타입 :' + 3)
	    			console.log('상품번호 :' + this.wno)
	    			console.log('신고상태 :' + 1)
	    			console.log('피신고자 :' + this.vo.seller)
	    			console.log('카테고리 :' + this.category)
	    			console.log('내용 :' + this.content)
	    			alert('신고가 접수되었습니다')
	    			this.changeModal(false)
	    		}).catch(error => {
	    			console.log(error.response)	    			
	    			alert('신고 접수 실패' + error)
	    			this.changeModal(false)
	    		})
	    	},
	    	changeModal(check){
	    		if(this.sessionId){
		    		this.showModal = check	    			
	    		}else {
	                alert('로그인 후 사용이 가능합니다.')
	                window.location.href = '../member/login.do'
	    		}
	    		
	    	},
	        // 링크 복사 메서드
	        copyLink() {
	            const urlToCopy = window.location.href
	            navigator.clipboard.writeText(urlToCopy)
	                .then(() => {
	                    alert('링크가 복사되었습니다')
	                })
	                .catch(err => {
	                    console.error('링크 복사 실패:', err)
	                })
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
	        },
	        reviewInsert(){
    			if(this.review === "")
    			{
    				alert('내용을 입력 해 주세요')
    				this.$refs.review.focus()
    				return
    			}
    			axios.post('../shop/review_insert.do',null,{
    				params:{
						wno: this.wno,
						srating: this.srating,
						content: this.review
    				}
    			}).then(response=>{
	   				 console.log(response.data)
	   				 console.log('내용 : ' + this.review)	 
	   				 console.log('별점 : ' + this.srating)	 
	   				 this.review = ''
	   				 alert('작성되었습니다')
	   				 
			   }).catch(error=>{
				     console.log(error.response)
			   })
    			this.dataRecv()
	        },
	        reviewDelete(){
	        	this.count + 4
	        },
   			 dataRecv(){
   				 axios.get('../shop/detail_vue.do',{
   					 params:{
						wno: this.wno,
						count: this.count
   					 }
   				 }).then(response=>{
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
					 this.reviewListData = response.data.reviewListData
					 this.count = response.data.count
		           	 console.log('count : ' + this.count)
			         this.$nextTick(() => {
			             this.carousel = $('.owl-carousel').owlCarousel({
			         	    items: 1, // 한 번에 보여줄 아이템 수
			        	    loop: true,
			       		    margin: 10,
			        	    nav: false,
			       	     	touchDrag: true, // 드래그 활성화
			             	mouseDrag: true, // 마우스 드래그 활성화
			             })
			          })
		        }).catch(error => {
		            console.error('데이터 로드 오류:', error.response)
		        })
   		 	}
	    }
	}).mount('.shopcontainer');

</script>



</body>
</html>