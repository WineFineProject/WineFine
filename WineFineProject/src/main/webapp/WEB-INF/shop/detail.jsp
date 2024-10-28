<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Wine Detail</title>
<link rel="stylesheet" href="../tem/css/winedetail.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>

	<!-- Single Product Start -->
	<div class="container-fluid py-5 mt-5 shopcontainer" style="margin-top: 0px !important;padding-top: 0px !important;" v-for="vo in list">
	<div class="container-fluid page-header py-5">
		<h1 class="text-center text-white display-6">상품 정보</h1>
		<ol class="breadcrumb justify-content-center mb-0">
		</ol>
	</div>
		<div class="container py-5">
			<div class="row g-4 mb-5" style="width: 1600px;">
				<div class="col-xl-10">
					<div class="row g-4">
						<div class="col-lg-5">
							<div
								class=" rounded d-flex justify-content-center align-items-center"
								style="width: 400px; height: 600px;">
								<img :src="vo.poster" class="img-fluid rounded" alt="Image"
									style="max-width: 100%; max-height: 100%;">
							</div>
						</div>


						<div class="col-lg-7">
							<h4 class="fw-bold mb-3"></h4>
							<p class="mb-3 d-flex align-items-center">
								<span :class="wineClass(vo.type)">{{vo.type}} </span> | <span
									v-for="(nvo,index) in nname"> {{index === 0
									?'':'&nbsp;|&nbsp;'}} <a>{{nvo}}</a>
								</span> <span class="img-margin"> <span> <img
										src="../img/like_off.png" @click="likeOn()"
										class="img-size img-hover"
										v-if="Lcheck === 0 || sessionId ==='' "> <img
										src="../img/like_on.png" @click="likeOff()"
										class="img-size img-hover"
										v-if="Lcheck !== 0 && sessionId !=='' "> <span
										class="img-text"> <b>{{likeCount}}</b>
									</span>
								</span> <img src="../img/eye.png" class="img-size "> <span
									class="img-text"> <b>{{vo.hit}}</b>
								</span> <span @click="copyLink()" class="img-hover"> <img
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
								<b class="font-style">평점</b> <span v-for="as in 5"
									class="no-style"> <i
									:class="{'text-secondary-wine':vo.score>=as}"
									style="margin-right: 2px;" class="fa fa-star"></i>
								</span> &nbsp; <b class="font-style" style="color: orange">{{formattedValue}}</b>
							</div>
							<div class="d-flex mb-4">
								<p>
									<b class="font-style">당도</b> <span v-for="as in 5"
										class="no-style"> <i
										:class="{'text-wine':vo.sugar>=as}" style="margin-right: 2px;"
										class="fa fa-star"></i>
									</span> &nbsp; <b class="font-style">산도</b> <span v-for="as in 5"
										class="no-style"> <i :class="{'text-wine':vo.acid>=as}"
										style="margin-right: 2px;" class="fa fa-star"></i>
									</span> &nbsp; <b class="font-style">바디</b> <span v-for="as in 5"
										class="no-style"> <i :class="{'text-wine':vo.body>=as}"
										style="margin-right: 2px;" class="fa fa-star"></i>
									</span> &nbsp; <b class="font-style">탄닌</b> <span v-for="as in 5"
										class="no-style"> <i
										:class="{'text-wine':vo.tannin>=as}"
										style="margin-right: 2px;" class="fa fa-star"></i>
									</span> &nbsp;
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

								<a class="btn border rounded-pill px-4 py-2 ms-3 aorb"
									@click="handleAddToCart()"> <i
									class="fa-solid fa-cart-plus " style="color: #881824;"></i> Add
									to cart
								</a> <a class="btn border rounded-pill px-4 py-2 ms-3 aorb"
									@click="handleBuyNow()"> <i
									class="fa-solid fa-credit-card " style="color: #881824;"></i>
									Buy Now
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
									<button class="nav-link border-white custom-nav-link"
										type="button" role="tab" id="nav-mission-tab2"
										data-bs-toggle="tab" data-bs-target="#nav-mission2"
										aria-controls="nav-mission2" aria-selected="false">상품
										문의</button>
								</div>
							</nav>
							<div class="tab-content mb-5">
								<div class="tab-pane active" id="nav-about" role="tabpanel"
									aria-labelledby="nav-about-tab">
									<div class="px-2">
										<div class="row g-4">
											<div class="col-6">
												<ul class="info-list" style="width: 1230px;">
													<li><span class="title">· 생산자</span> <span> <a
															:href="'../maker/detail.do?no='+vo.maker" class="a-color">{{
																vo.makerkor != null ? vo.makerkor : '정보없음' }} / {{
																vo.makereng != null ? vo.makereng : '' }}</a>
													</span></li>
													<li><span class="title">· 국가/생산지역</span> <span
														v-for="(nvo,index) in nname"> {{index === 0
															?'':'&nbsp;|&nbsp;'}} <a
															:href="'../nation/detail.do?no='+nnolink[index]"
															class="a-color">{{ nvo != null ? nvo : '정보없음' }}</a>
													</span></li>
													<li><span class="title">· 주요품종</span> <span
														v-for="(gvo,index) in gname"> {{index === 0 ?
															'':'&nbsp;|&nbsp;'}} <a
															:href="'../grape/detail.do?no='+gnolink[index]"
															class="a-color">{{ gvo != null ? gvo : '정보없음' }}</a>
													</span></li>
													<li><span class="title">· 도수</span> <span
														class="content">{{ vo.alcohol != null ? vo.alcohol +' %'
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
									<div class="px-2">
										<div class="row g-4">
											<div class="col-6">
												<ul class="info-list" style="width: 1230px;">
													<li><span class="title">· 판매자 정보</span> 
													
													<span class="content" v-if="vo.seller === null">
														정보없음
													</span>
													
													<span class="content" v-if="vo.seller !== null">
														<a :href="'http://localhost:8080/controller/shop/sellerShop.do?id=' + vo.seller"> {{sellerName}}</a> 
													</span>
													
													</li>												
													<li><span class="title">· 신고하기</span> <span
														class="content"> WineFine 은 소비자의 보호와 사이트의 안전거래를 위해
															신고 센터를 운영하고 있습니다. <br> 안전 거레를 저해하는 경우 신고하여 주시기 바랍니다.
													</span></li>
													<li><span class="title"></span> <input type="button"
														value="신고하기" class="report" @click="changeModal(true)">
													</li>
												</ul>
											</div>
										</div>
									</div>
								</div>
								<div class="tab-pane" id="nav-mission2" role="tabpanel"
									aria-labelledby="nav-mission-tab2">
									<div class="px-2">
										<div class="row g-4">
											<div class="col-6">
												<ul class="info-list" style="width: 1230px;">
													<li><span class="title">· 문의 게시판</span> <span
														class="content"
														style="text-align: right; margin-right: 15px;"> <a
															:href="'../replyboard/insert3.do?wno=' + vo.wno + '&namekor=' + encodeURIComponent(vo.namekor) + '&seller=' + encodeURIComponent(sellerName) + '&sellerid=' + encodeURIComponent(vo.seller)">
																<b>글쓰기</b>
														</a>

													</span></li>
													<li>
														<table class="table">
															<thead style="background-color: #efefef;">
																<tr class="text-center">
																	<th width="10%">번호</th>
																	<th width="40%">제목</th>
																	<th width="13%">작성자</th>
																	<th width="17%">작성일</th>
																	<th width="10%">조회수</th>
																	<th width="10%">상태</th>
																</tr>
															</thead>
															<tr v-if="relist.length===0"><td colspan="6">문의내역이 없습니다.</td></tr>
															<tbody v-for="(re,index) in relist">
																<tr>
																	<td class="text-center">{{totalpage - index}}</td>
																	<td width=35%><span style="color: darkred"
																		v-if="sessionId!==re.userid&&re.secret===1&&re.group_step===0">
																			<i class="fa fa-lock" aria-hidden="true"></i>&nbsp;비밀글입니다
																	</span> <span style="color: darkred"
																		v-else-if="sessionId!==re.recvid&&re.secret===1&&re.group_step===1">
																			ㄴ&nbsp;<i class="fa fa-lock" aria-hidden="true"></i>&nbsp;비밀글입니다
																	</span> <a :href="'../replyboard/detail.do?wrno='+re.wrno"
																		v-else> <span v-if="re.group_step===1">ㄴ</span> <span
																			v-if="re.type===2">[{{cnos[re.cno]}}]&nbsp;</span> <span
																			v-if="vo.type===3">[{{cno[vo.cno]}}]&nbsp;</span>
																			{{re.subject}}
																	</a></td>
																	<td class="text-center">{{re.nickname}}</td>
																	<td class="text-center">{{re.dbday}}</td>
																	<td class="text-center">{{re.hit}}</td>
																	<td class="text-center"><span
																		v-if="re.group_step === 1" style="color: blue;">문의
																			답변</span> <span v-else-if="re.isreply === 0"
																		style="color: #881824;">답변대기</span> <span v-else
																		style="color: green;">답변완료</span></td>
																</tr>
															</tbody>
														</table>
													</li>
												</ul>
											</div>
											<div class="col-12 text-center"
												style="display: flex; place-content: center;">
												<div style="text-align: center;" v-if="bocount < totalpage">
													<button class="form-control"
														style="background-color: #57102F; color: white; width: 100px;"
														@click="viewMore2()">더보기</button>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div style="height: 15px;"></div>
					<h4 class="mb-5 fw-bold">리뷰( 총
						{{reviewCount.toLocaleString()}} 개)</h4>
					<div class="row g-4" style="align-items: center;">
						<div v-for="(vw,index) in reviewListData"
							style="display: flex; flex-direction: column; align-items: center; border-bottom: 1px solid lightgray; margin-bottom: 20px;">
                     <div style="align-self: self-start;"><span
										v-for="as in 5" class="no-style"> <i
											:class="{'text-secondary-wine':vw.srating>=as}"
											style="margin-bottom: 12px;" class="fa fa-star"></i>
									</span>
									</div>
							<table style="width: 100%">
								<tr>
									<td>
										<h5 style="display: inline-block;">
											<b>{{vw.nickname}}</b>
										</h5>
											&nbsp;&nbsp;|&nbsp;&nbsp;<small><b>{{vw.dbday}}</b></small>
									</td>
									<td style="width: 180px;" class="text-center">
									</td>
									<td style="text-align: right;">
										<button class="btn btn-md rounded-circle"
											@click="reviewDelete(vw.wrvno)"
											v-if="vw.userid === sessionId">
											<i class="fa fa-times text-danger"></i>
										</button> <img src="../img/Report.png" alt="Report"
										style="width: 30px; height: auto;" class="img-hover"
										@click="reportMemory(index)">
									</td>
								</tr>
							</table>
							<pre class="form-control"
								style="width: 100%; height: 110px; resize: none; margin-right: 10px;">{{vw.content}}</pre>
						</div>
						<div style="text-align: center;" v-if="count < reviewCount">
							<button @click="viewMore()"
								style="background-color: #57102F; color: white; width: 100px;">
								<h5>더보기</h5>
							</button>
						</div>
						<div v-if="sessionId == ''">
							<h4>로그인 후 작성이 가능합니다</h4>
						</div>
						<template v-if="sessionId != ''">
							<div class="d-flex align-items-center"
								style="margin-bottom: 10px; margin-left: 10px;">
								<table>
									<tr>
										<td style="width: 500px;"><b>{{nick}}&nbsp;&nbsp;</b> <label
											v-for="ss in 5" class="no-style" style="cursor: pointer;">
												<input type="radio" name="sugarStars" :value="ss"
												v-model="srating" style="display: none;"> <i
												:class="{'text-wine':srating>=ss}"
												style="margin-right: 2px;" class="fa fa-star"></i>
										</label></td>
									</tr>
								</table>
							</div>

							<div v-if="sessionId !== ''"
								style="display: flex; justify-content: center; align-items: center;">
								<textarea rows="4" cols="62" ref="review" v-model="review"
									class="form-control"
									style="width: 100%; resize: none; margin-right: 10px;" placeholder="리뷰를 입력해주세요"></textarea>
								<button class="form-control"
									style="background-color: #57102F; color: white; width: 100px; height: 110px;"
									@click="reviewInsert()">리뷰쓰기</button>
							</div>
						</template>
					</div>
				</div>
			</div>
			<div class="col-lg-12" style="border-bottom: solid 1px #80808036;">
				<h3>관련와인</h3>
				<br>
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
								<h3 class="fw-bold mb-0">&nbsp; {{vo.makerkor}}의 다른 상품</h3>
								<br>
								<div
									class="owl-carousel vegetable-carousel justify-content-center">
									<div
										class="border rounded position-relative vesitable-item otherWine"
										v-for="mk in otherMaker" :key="mk.wno"
										style="width: 250px; border-color: #881824 !important">
										<a :href="'../shop/detail.do?wno=' + mk.wno + '&page=' + 2">
											<div style="width: 250px; height: 250px;">
												<img :src="mk.poster" class="img-fluid rounded-top" alt=""
													style="width: 250px; height: 267px; padding: 24px 24px 0;">
											</div>
											<div class="px-3 py-1 rounded position-absolute"
												style="top: 10px; right: 10px;" :class="wineClass(mk.type)">{{mk.type}}</div>
											<div class="p-4 pb-0 rounded-bottom"
												style="width: 250px; height: 140px;">
												<h4
													style="display: -webkit-box; -webkit-box-orient: vertical; overflow: hidden; text-overflow: ellipsis; -webkit-line-clamp: 2; line-height: 1.2; max-height: 2.4em; width: 200px;">{{mk.namekor}}</h4>
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
								<h3 class="fw-bold mb-0">&nbsp; {{sellerName}}의 Top 5</h3>
								<br>
								<div
									class="owl-carousel vegetable-carousel justify-content-center"
									style="overflow-x: auto;">
									<div
										class="border rounded position-relative vesitable-item otherWine"
										v-for="sl in otherSeller" :key="sl.wno"
										style="width: 250px; border-color: #881824 !important">
										<a :href="'../shop/detail.do?wno=' + sl.wno + '&page=' + 2">
											<div style="width: 250px; height: 250px;">
												<img :src="sl.poster" class="img-fluid rounded-top" alt=""
													style="width: 250px; height: 267px; padding: 24px 24px 0;">
											</div>
											<div class="px-3 py-1 rounded position-absolute"
												style="top: 10px; right: 10px;" :class="wineClass(sl.type)">{{sl.type}}</div>
											<div class="p-4 pb-0 rounded-bottom"
												style="width: 250px; height: 140px;">
												<h4
													style="display: -webkit-box; -webkit-box-orient: vertical; overflow: hidden; text-overflow: ellipsis; -webkit-line-clamp: 2; line-height: 1.2; max-height: 2.4em; width: 200px;">{{sl.namekor}}</h4>
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

		<div class="modal" :class="{ show: showModal }"
			@click.self="changeModal(false)">
			<div class="modal-content" style="width: 650px; height: 400px;">
				<h3 class="text-center">신고하기</h3>
				<table class="table mp" style="margin-top: 20px;">
					<tr>
						<th width="20%" class="centered">신고대상 ID</th>
						<td width="20%" class="text-center" style="border: 1px solid #e1e1e1;vertical-align: middle"><b>{{sellerName}}</b>
						</td>
						<th width="20%" class="centered">상품명</th>
						<td width="40%" class="text-center" style="border: 1px solid #e1e1e1;vertical-align: middle"><b>{{vo.namekor}}</b>
						</td>
					</tr>
					<tr>
						<th width="20%" class="centered">카테고리</th>
						<td colspan="3" style="border: 1px solid #e1e1e1;vertical-align: middle"><select style="width: 175px;"
							v-model="category" @change="selectCategory($event)">
								<option value="상품관련">상품관련</option>
								<option value="배송관련">배송관련</option>
								<option value="기타신고">기타신고</option>
						</select></td>
					</tr>
					<tr>
						<th width="20%" class="text-center">신고 사유</th>
						<td colspan="3" style="border: 1px solid #e1e1e1;vertical-align: middle"><textarea rows="4" cols="30"
								style="width: 100%; resize: none;" v-model="content">
						</textarea></td>
					</tr>
					<tr>
						<td colspan="4" class="rmbtn"
							style="text-align: center; border-bottom: none;">
							<button type="button" class="rmbtn btn-sm btn-success"
								@click="sendReport()">접수</button> &nbsp;&nbsp;
							<button type="button" class="rmbtn btn-sm btn-danger"
								@click="changeModal(false)">취소</button>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div v-if="cookieCheck===0&&vo.nbno!==0" class="layer-popup"
			id="popup" :class="{active:popupVisible}">
			<div class="layer-popup-header">
			<h4 class="modal-title centered">판매자 공지</h4>
				<span class="layer-popup-close" style="text-align: right;"
					@click="popupClose()">X</span>
			</div>
			<table class="table mp" style="table-layout: fixed; margin-top: 10px;">
				<tr>
					<th width="20%" class="centered">제목</th>
					<td colspan="3" style="border: 1px solid #e1e1e1;vertical-align: middle">
						<p style="margin:0px">{{nvo.subject}}</p>
					</td>
				</tr>
				<tr>
					<th width="20%" class="centered">판매자</th>
					<td width="40%" class="centered">{{nvo.nickname}}</td>
					<th width="10%" class="centered">작성일</th>
					<td width="30%" class="centered" style="border: 1px solid #e1e1e1">{{nvo.dbday}}</td>
				</tr>
				<tr>
					<td colspan="4" class="round"><pre>{{nvo.content}}</pre>
					</td>
				</tr>
			</table>
			<p style="text-align: right; cursor: default;"
				@click="cookieClose(vo.wno)">□오늘 하루 보지 않음</p>
		</div>
		
		<div class="modal" v-if="showModal2" :class="{ show: showModal2 }"
			@click.self="changeModal2(false)">
			<div class="modal-content" style="width: 650px; height: 400px;">
				<h3 class="text-center">신고하기</h3>
				<table class="table mp" style="margin-top: 20px;">
					<tr>
						<th width="20%" class="centered">신고대상 ID</th>
						<td width="20%" class="text-center" class="text-center" style="border: 1px solid #e1e1e1;vertical-align: middle">
						<b>{{selReport.nickname}}</b>
						</td>
						<th width="20%" class="centered">상품명</th>
						<td width="40%" class="text-center" class="text-center" style="border: 1px solid #e1e1e1;vertical-align: middle"><b>{{vo.namekor}}</b>
						</td>
					</tr>
					<tr>
						<th width="20%" class="centered">카테고리</th>
						<td colspan="3" style="border: 1px solid #e1e1e1"><select style="width: 175px;"
							v-model="category2" @change="selectCategory2($event)">
								<option value="폭언/욕설">폭언/욕설</option>
								<option value="불법광고">불법광고</option>
								<option value="기타신고">기타신고</option>
						</select></td>
					</tr>
					<tr>
						<th width="20%" class="text-center">신고 사유</th>
						<td colspan="3" class="text-center" style="border: 1px solid #e1e1e1;vertical-align: middle"><textarea rows="4" cols="30"
								style="width: 100%; resize: none;" v-model="content">
						</textarea></td>
					</tr>
					<tr>
						<td colspan="4" class="rmbtn"
							style="text-align: center; border-bottom: none;">
							<button type="button" class="rmbtn btn-sm btn-warning"
								@click="sendReport2()">접수</button> &nbsp;&nbsp;
							<button type="button" class="rmbtn btn-sm btn-danger"
								@click="changeModal2(false)">취소</button>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<!-- Single Product End -->
	<script>
	let detailApp = Vue.createApp({
	    data() {
	        return {
	            vo: {}, // 와인 상세 정보
	            wno: '${wno}', 
	            sessionId: '${session}',
	            nick: '${nick}',
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
	            showModal2: false,	            
	            category: '배송관련',
	            category2: '폭언/욕설',
	            content: '',
	            review: '',
	            srating: 1,
	            reviewListData: [],
	            popupVisible:false,
	            count: 4,
	            bocount: 4,
	            isOn: false,
	            reviewCount: 0,
	            likeCount: 0,
	            Lcheck: 0,
	            reviewCheck: 0,
	            sellerName: '',
	            wrvno:0,
	            relist:[],
	            nvo:{},
	            cookieCheck:0,
    			curpage: 1,
    			totalpage: 0,
    			startPage: 0,
    			endPage: 0,
    			buyer: 0,
    			black: 0,
    			reviewIndex: 0,
    			selReport:{}
	        }
	    },
	    mounted() {	    	
	        this.dataRecv()
	    },
	    methods: {
			prev(){
				if(this.curpage === 1){
					alert('첫 페이지 입니다')
					return
				}
			        this.curpage = this.curpage - 10;
			        this.dataRecv();   			    
			},
			next() {
			    if (this.curpage >= this.totalpage) {
			        alert('마지막 페이지 입니다');
			        return;
			    }		    
			    let nextPage = this.curpage + 10;
			    this.curpage = nextPage <= this.totalpage ? nextPage : this.totalpage;
			    this.dataRecv();
			},
    		pageChange(page){
    			this.curpage=page
    			this.dataRecv()
    		},
    		range(start,end){
    			let arr=[]
    			let len=end-start
    			for(let i=0;i<=len;i++)
    			{
    				arr[i]=start
    				start++
    			}
    			return arr;
    		},
		    wineClass(type) {
    		      switch (type) {
    		        case '레드':
    		          return 'winecor'
    		        case '화이트':
    		          return 'whitecor'
    		        case '로제':
    		          return 'rose'
    		        case '스파클링':
    		          return 'sparkling'
    		        case '주정강화':
    		          return 'Fortified'
    		        default:
    		          return 'atherwine'
    		      }
    		    },
	    	likeOn(){
	    		if(this.sessionId == ''){
	    			alert('로그인 후 사용이 가능합니다')
	                window.location.href = '../member/login.do'
	    		}	    		
	    		axios.get('../shop/likeOn.do',{
	    			params:{
	    				wno: this.wno
	    			}	    			
	    		}).then(response => {
	    			console.log(response.data)	    			
		    		alert('좋아요 추가 완료!')
	    			this.Lcheck = response.data.Lcheck
	    			this.dataRecv()
	    		}).catch(error => {
	    			console.log(error.response)
	    		})	    		
	    	},
	    	popupClose(){
	    		this.popupVisible=false
	    	},
	    	likeOff(){
	    		if(this.sessionId == ''){
	    			alert('로그인 후 사용이 가능합니다')
	                window.location.href = '../member/login.do'
	    		}
	    		axios.get('../shop/likeOff.do', {
	    			params:{
	    				wno: this.wno
	    			}
	    		}).then(response => {
	    			console.log(response.data)
		    		alert('좋아요 취소')
	    			this.Lcheck = response.data.Lcheck
	    			this.dataRecv()
	    		}).catch(error => {
	    			console.log(error.response)
	    		})
	    	},
	    	selectCategory($event){
	    		console.log(this.category)
	    	},
	    	selectCategory2($event){
	    		console.log(this.category2)
	    	},
	    	sendReport() {
	    		axios.post('../shop/seller_report.do', null, {
					params:{		  
						userid: this.sessionId,
		    			type: 3,
		    			tno: this.wno,
		    			state: 0,
		    			rid: this.vo.seller,
		    			category: this.category,
		    			content: this.content	  	    			
					}
	    		}).then(response => {
	    			console.log(response.data)
	    			alert('신고가 접수되었습니다')
	    			this.content = ''
	    			this.changeModal(false)
	    			this.dataRecv()
	    		}).catch(error => {
	    			console.log(error.response)	    			
	    			alert('신고 접수 실패' + error)
	    			this.changeModal(false)
	    		})
	    	},
	    	sendReport2() {
	    		axios.post('../shop/seller_report.do', null, {
					params:{		  
						userid: this.sessionId,
		    			type: 4,
		    			tno: this.selReport.wrvno,
		    			state: 0,
		    			rid: this.selReport.nickname,
		    			category: this.category2,
		    			content: this.content	  	    			
					}
	    		}).then(response => {
	    			console.log(response.data)
	    			alert('신고가 접수되었습니다')
	    			this.changeModal2(false)
	    		}).catch(error => {
	    			console.log(error.response)	    			
	    			alert('신고 접수 실패' + error)
	    			this.changeModal2(false)
	    			this.wrvno=0
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
	    	changeModal2(check){
	    		if(this.sessionId){
		    		this.showModal2 = check	    			
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
	        cookieClose(wno){
	        	axios.get('../shop/cookieClose.do', {
	        		params:{
	        			wno:wno
	        		}
	        	}).then(response=>{
	        		this.popupVisible=false
	        	})
	        },
	        handleBuyNow() {
	            if (this.sessionId) {
	            	if(this.black !== 0){
	            		alert('구매하실 수 없습니다\n판매자에게 문의해 주세요 ')
	            		return
	            	}
	                window.location.href = '../shop/buy.do?wno=' + this.vo.wno;
	            } else {
	                alert('로그인 후 사용이 가능합니다.');
	                window.location.href = '../member/login.do'; 
	            }
	        },
	        reviewInsert(){
	        	if(this.buyer === 0){
	        		alert('상품을 구매한 사람만 작성 가능합니다')
	        		this.review = ''
	        		return
	        	}
    			if(this.reviewCheck !== 0){
    				alert('리뷰는 한 번만 작성 가능합니다')
    				this.review = ''
    				return
    			}
    			if(this.review === "")
    			{
    				alert('내용을 입력해주세요')
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
	   				 this.review = ''
	   				 alert('작성되었습니다')	   				 
	    			 this.dataRecv()
			   }).catch(error=>{
				     console.log(error.response)
			   })
	        },
	        reviewDelete(wrvno){
	        	axios.get('../shop/review_delete.do',{
	        		params:{
	        			wrvno : wrvno
	        		}
	        	}).then(response => {
	        		if(response.data === "yes"){
	        			alert('삭제 완료!')
	        		}else {
	        			alert('삭제 실패!')
	        			console.log(response.data)
	        		}
		        	this.dataRecv()
	        	}).catch(error => {
	        		console.log(error.response)
	        	})
	        },
	        viewMore(){
	        	this.count += 4
	        	this.dataRecv()
	        },
	        viewMore2(){
	        	this.bocount += 4
	        	this.dataRecv()
	        },
	        reportMemory(index){
	        	this.selReport=this.reviewListData[index]
	        	this.changeModal2(true)
	        },
   			 dataRecv(){
				axios.get('../replyboard/shoplist_vue.do',{
					params:{
						wno: this.wno,
						page: this.curpage,
						count: this.bocount
					}
				}).then(response => {
					console.log(response.data)
					this.relist = response.data.list
					this.recount = response.data.count
					this.totalpage = response.data.totalpage
					this.startpage = response.data.startpage
					this.endpage = response.data.endpage
					this.boTocount = response.data.boTocount
				}).catch(error => {
					console.log(error.response)
				})
    			
   				 axios.get('../shop/detail_vue.do',{
   					 params:{
						wno: this.wno,
						count: this.count
   					 }
   				 }).then(response=>{
 	 	          	 console.log(response.data)
		   	         this.vo = response.data.vo
		   	         this.nvo=response.data.nvo
		   	         this.cookieCheck=response.data.cookieCheck
		   	         if(this.cookieCheck!==1)
		   	        	 this.popupVisible=true
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
			          this.isOn = response.data.inOn
			          this.reviewCount = response.data.reviewCount
			          this.Lcheck = response.data.Lcheck
			          this.likeCount = response.data.likeCount
			          this.sellerName = response.data.sellerName
			          this.reviewCheck = response.data.reviewCheck
			          this.buyer = response.data.buyer
			          this.black = response.data.black
			          this.reviewIndex = response.data.reviewIndex	
			          
		        }).catch(error => {
		            console.error('데이터 로드 오류:', error.response)
		        })
   		 	}
	    },
	    computed:{
	    	formattedValue() {
	    	      return Number(this.vo.score).toFixed(1)
	    	 }
	    }
	}).mount('.shopcontainer');

</script>
</body>
</html>