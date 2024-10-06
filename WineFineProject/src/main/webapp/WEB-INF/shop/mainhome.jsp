<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.sear {
	width: 1000px !important;
	margin: 0 auto !important; /* 가운데 정렬 */
	border-color: #881824 !important;
	color: #881824 !important;
}

.searBtn {
    background-color: #881824;
    border-color: #881824 !important;
}

.text-ellipsis {
    white-space: nowrap;  
    overflow: hidden;       
    text-overflow: ellipsis;
}
.fon-cor-gr {
	color: gray;
}
.small-text {
    font-size: 0.8rem; /* 원하는 크기로 조정 */
    line-height: 1.2; /* 줄 간격 */
}
</style>
</head>
<body>

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
						<input type="search" class="form-control p-3" placeholder="keywords" aria-describedby="search-icon-1"> <span id="search-icon-1"
							class="input-group-text p-3"><i class="fa fa-search"></i></span>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Modal Search End -->


	<!-- Hero Start -->
	<div class="container-fluid py-5 mb-5 hero-header">
		<div class="container py-5">
			<div class="row g-5 align-items-center">
				<div class="col-md-12 col-lg-7">
					<h1 class="mb-5 display-3 text-wine">배너이벤트 공간</h1>

				</div>
				<div class="col-md-12 col-lg-5">
					<div id="carouselId" class="carousel slide position-relative" data-bs-ride="carousel">
						<div class="carousel-inner" role="listbox">
							<div class="carousel-item active rounded">
								<img src="#" class="img-fluid w-100 h-100 bg-secondary rounded" alt="First slide">
								<a href="#" class="btn px-4 py-2 text-white rounded">Fruites</a>
							</div>
							<div class="carousel-item rounded">
								<img src="#" class="img-fluid w-100 h-100 rounded" alt="Second slide">
								<a href="#" class="btn px-4 py-2 text-white rounded">Vesitables</a>
							</div>
						</div>
						<button class="carousel-control-prev" type="button" data-bs-target="#carouselId" data-bs-slide="prev">
							<span class="carousel-control-prev-icon" aria-hidden="true"></span> <span class="visually-hidden">Previous</span>
						</button>
						<button class="carousel-control-next" type="button" data-bs-target="#carouselId" data-bs-slide="next">
							<span class="carousel-control-next-icon" aria-hidden="true"></span> <span class="visually-hidden">Next</span>
						</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Hero End -->
					<div class="position-relative mx-auto text-center">
						<input class="form-control border-2 border-secondary w-75 py-3 px-4 rounded-pill sear" type="number" placeholder="Search">
						<button type="submit" class="btn btn-primary border-2 border-secondary py-3 px-4 position-absolute rounded-pill text-white h-100 searBtn"
							style="top: 0; right: 28%;">Submit Now</button>
					</div>

	<!-- Featurs Section Start -->
	<div class="container-fluid featurs py-5 text-center">
		<div class="container py-5">
		<h3>시음회 마감 기한 짧은순 4</h3>
			<div class="row g-4">
				<div class="col-md-6 col-lg-3">
					<div class="featurs-item text-center rounded bg-light p-4">
						<div class="featurs-icon btn-square rounded-circle bg-secondary mb-5 mx-auto">
							<i class="fas fa-car-side fa-3x text-white"></i>
						</div>
						<div class="featurs-content text-center">
							<h5>Free Shipping</h5>
							<p class="mb-0">Free on order over $300</p>
						</div>
					</div>
				</div>
				<div class="col-md-6 col-lg-3">
					<div class="featurs-item text-center rounded bg-light p-4">
						<div class="featurs-icon btn-square rounded-circle bg-secondary mb-5 mx-auto">
							<i class="fas fa-user-shield fa-3x text-white"></i>
						</div>
						<div class="featurs-content text-center">
							<h5>Security Payment</h5>
							<p class="mb-0">100% security payment</p>
						</div>
					</div>
				</div>
				<div class="col-md-6 col-lg-3">
					<div class="featurs-item text-center rounded bg-light p-4">
						<div class="featurs-icon btn-square rounded-circle bg-secondary mb-5 mx-auto">
							<i class="fas fa-exchange-alt fa-3x text-white"></i>
						</div>
						<div class="featurs-content text-center">
							<h5>30 Day Return</h5>
							<p class="mb-0">30 day money guarantee</p>
						</div>
					</div>
				</div>
				<div class="col-md-6 col-lg-3">
					<div class="featurs-item text-center rounded bg-light p-4">
						<div class="featurs-icon btn-square rounded-circle bg-secondary mb-5 mx-auto">
							<i class="fa fa-phone-alt fa-3x text-white"></i>
						</div>
						<div class="featurs-content text-center">
							<h5>24/7 Support</h5>
							<p class="mb-0">Support every time fast</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Featurs Section End -->
	<!-- Vesitable Shop Start-->
	<div class="container-fluid vesitable py-5">
		<div class="container py-5">
			<h1 class="mb-0">추천와인</h1>
			<div class="owl-carousel vegetable-carousel justify-content-center">
				<div class="border border-primary rounded position-relative vesitable-item ">
					<div class="vesitable-img">
						<img src="#" class="img-fluid w-100 rounded-top" alt="">
					</div>
					<div class="text-white bg-wine px-3 py-1 rounded position-absolute" style="top: 10px; right: 10px;">vo.type</div>
					<div class="p-4 rounded-bottom">
						<h6 class="text-ellipsis">vo.namekor</h6>
						<h6 class="text-ellipsis fon-cor-gr">vo.nameeng</h6>
						<div class="d-flex justify-content-between flex-lg-wrap">
							<p class="text-dark fs-5 fw-bold mb-0 small-text">vo.price (vo.vol)</p>
							<a href="#" class="btn border border-secondary rounded-pill px-3 text-wine small-text"><i class="fa fa-shopping-bag me-2 text-wine"></i> Add to cart</a>
						</div>
					</div>
				</div>

			</div>
		</div>
	</div>
	<!-- Vesitable Shop End -->


	<!-- Fruits Shop Start-->
	<div class="container-fluid fruite py-5">
		<div class="container py-5">
			<div class="tab-class text-center">
				<div class="row g-4">
					<div class="col-lg-4 text-start">
						<h1>와인찾기</h1>
					</div>
					<div class="col-lg-8 text-end">
						<ul class="nav nav-pills d-inline-flex text-center mb-5">
							<li class="nav-item">
								<a class="d-flex m-2 py-2 bg-light rounded-pill active" data-bs-toggle="pill" href="#tab-1"> <span class="text-dark" style="width: 130px;">All
										Products</span>
								</a>
							</li>
							<li class="nav-item">
								<a class="d-flex py-2 m-2 bg-light rounded-pill" data-bs-toggle="pill" href="#tab-2"> <span class="text-dark" style="width: 130px;">Vegetables</span>
								</a>
							</li>
							<li class="nav-item">
								<a class="d-flex m-2 py-2 bg-light rounded-pill" data-bs-toggle="pill" href="#tab-3"> <span class="text-dark" style="width: 130px;">Fruits</span>
								</a>
							</li>
							<li class="nav-item">
								<a class="d-flex m-2 py-2 bg-light rounded-pill" data-bs-toggle="pill" href="#tab-4"> <span class="text-dark" style="width: 130px;">Bread</span>
								</a>
							</li>
							<li class="nav-item">
								<a class="d-flex m-2 py-2 bg-light rounded-pill" data-bs-toggle="pill" href="#tab-5"> <span class="text-dark" style="width: 130px;">Meat</span>
								</a>
							</li>
						</ul>
					</div>
				</div>
				<div class="tab-content">
					<div id="tab-1" class="tab-pane fade show p-0 active">
						<div class="row g-4">
							<div class="col-lg-12">
								<div class="row g-4">

									<div class="col-md-6 col-lg-4 col-xl-3">
										<div class="rounded position-relative fruite-item">
											<div class="fruite-img">
												<img src="#" class="img-fluid w-100 rounded-top" alt="">
											</div>
											<div class="text-white bg-secondary px-3 py-1 rounded position-absolute" style="top: 10px; left: 10px;">Fruits</div>
											<div class="p-4 border border-secondary border-top-0 rounded-bottom">
												<h4>Banana</h4>
												<p>Lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod te incididunt</p>
												<div class="d-flex justify-content-between flex-lg-wrap">
													<p class="text-dark fs-5 fw-bold mb-0">$4.99 / kg</p>
													<a href="#" class="btn border border-secondary rounded-pill px-3 text-wine"><i class="fa fa-shopping-bag me-2 text-wine"></i> Add to
														cart</a>
												</div>
											</div>
										</div>
									</div>
									<div class="col-md-6 col-lg-4 col-xl-3">
										<div class="rounded position-relative fruite-item">
											<div class="fruite-img">
												<img src="#" class="img-fluid w-100 rounded-top" alt="">
											</div>
											<div class="text-white bg-secondary px-3 py-1 rounded position-absolute" style="top: 10px; left: 10px;">Fruits</div>
											<div class="p-4 border border-secondary border-top-0 rounded-bottom">
												<h4>Oranges</h4>
												<p>Lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod te incididunt</p>
												<div class="d-flex justify-content-between flex-lg-wrap">
													<p class="text-dark fs-5 fw-bold mb-0">$4.99 / kg</p>
													<a href="#" class="btn border border-secondary rounded-pill px-3 text-wine"><i class="fa fa-shopping-bag me-2 text-wine"></i> Add to
														cart</a>
												</div>
											</div>
										</div>
									</div>
									<div class="col-md-6 col-lg-4 col-xl-3">
										<div class="rounded position-relative fruite-item">
											<div class="fruite-img">
												<img src="#" class="img-fluid w-100 rounded-top" alt="">
											</div>
											<div class="text-white bg-secondary px-3 py-1 rounded position-absolute" style="top: 10px; left: 10px;">Fruits</div>
											<div class="p-4 border border-secondary border-top-0 rounded-bottom">
												<h4>Raspberries</h4>
												<p>Lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod te incididunt</p>
												<div class="d-flex justify-content-between flex-lg-wrap">
													<p class="text-dark fs-5 fw-bold mb-0">$4.99 / kg</p>
													<a href="#" class="btn border border-secondary rounded-pill px-3 text-wine"><i class="fa fa-shopping-bag me-2 text-wine"></i> Add to
														cart</a>
												</div>
											</div>
										</div>
									</div>
									<div class="col-md-6 col-lg-4 col-xl-3">
										<div class="rounded position-relative fruite-item">
											<div class="fruite-img">
												<img src="#" class="img-fluid w-100 rounded-top" alt="">
											</div>
											<div class="text-white bg-secondary px-3 py-1 rounded position-absolute" style="top: 10px; left: 10px;">Fruits</div>
											<div class="p-4 border border-secondary border-top-0 rounded-bottom">
												<h4>Grapes</h4>
												<p>Lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod te incididunt</p>
												<div class="d-flex justify-content-between flex-lg-wrap">
													<p class="text-dark fs-5 fw-bold mb-0">$4.99 / kg</p>
													<a href="#" class="btn border border-secondary rounded-pill px-3 text-wine"><i class="fa fa-shopping-bag me-2 text-wine"></i> Add to
														cart</a>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>

				</div>
			</div>
		</div>
	</div>
	<!-- Fruits Shop End-->


	<!-- Featurs Start -->
	<div class="container-fluid service py-5">
		<h3 class="text-center">할인쿠폰?</h3>
		<div class="container py-5">
			<div class="row g-4 justify-content-center">
				<div class="col-md-6 col-lg-4">
					<a href="#">
						<div class="service-item bg-secondary rounded border border-secondary">
							<img src="#" class="img-fluid rounded-top w-100" alt="">
							<div class="px-4 rounded-bottom">
								<div class="service-content bg-wine text-center p-4 rounded">
									<h5 class="text-white">Fresh Apples</h5>
									<h3 class="mb-0">20% OFF</h3>
								</div>
							</div>
						</div>
					</a>
				</div>
				<div class="col-md-6 col-lg-4">
					<a href="#">
						<div class="service-item bg-dark rounded border border-dark">
							<img src="#" class="img-fluid rounded-top w-100" alt="">
							<div class="px-4 rounded-bottom">
								<div class="service-content bg-light text-center p-4 rounded">
									<h5 class="text-wine">Tasty Fruits</h5>
									<h3 class="mb-0">Free delivery</h3>
								</div>
							</div>
						</div>
					</a>
				</div>
				<div class="col-md-6 col-lg-4">
					<a href="#">
						<div class="service-item bg-wine rounded border border-primary">
							<img src="img/featur-3.jpg" class="img-fluid rounded-top w-100" alt="">
							<div class="px-4 rounded-bottom">
								<div class="service-content bg-secondary text-center p-4 rounded">
									<h5 class="text-white">Exotic Vegitable</h5>
									<h3 class="mb-0">Discount 30$</h3>
								</div>
							</div>
						</div>
					</a>
				</div>
			</div>
		</div>
	</div>
	<!-- Featurs End -->



	<!-- Tastimonial Start -->
	<div class="container-fluid testimonial py-5">
		<div class="container py-5">
			<div class="testimonial-header text-center">
				<h1 class="display-5 mb-5 text-dark">인기 게시글</h1>
			</div>
			<div class="owl-carousel testimonial-carousel">
				<div class="testimonial-item img-border-radius bg-light rounded p-4">
					<div class="position-relative">
						<i class="fa fa-quote-right fa-2x text-wine position-absolute" style="bottom: 30px; right: 0;"></i>
						<div class="mb-4 pb-4 border-bottom border-secondary">
							<p class="mb-0">Lorem Ipsum is simply dummy text of the printing Ipsum has been the industry's standard dummy text ever since the 1500s,</p>
						</div>
						<div class="d-flex align-items-center flex-nowrap">
							<div class="bg-secondary rounded">
								<img src="#" class="img-fluid rounded" style="width: 100px; height: 100px;" alt="">
							</div>
							<div class="ms-4 d-block">
								<h4 class="text-dark">Client Name</h4>
								<p class="m-0 pb-3">Profession</p>
								<div class="d-flex pe-5">
									<i class="fas fa-star text-wine"></i> <i class="fas fa-star text-wine"></i> <i class="fas fa-star text-wine"></i> <i
										class="fas fa-star text-wine"></i> <i class="fas fa-star"></i>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="testimonial-item img-border-radius bg-light rounded p-4">
					<div class="position-relative">
						<i class="fa fa-quote-right fa-2x text-wine position-absolute" style="bottom: 30px; right: 0;"></i>
						<div class="mb-4 pb-4 border-bottom border-secondary">
							<p class="mb-0">Lorem Ipsum is simply dummy text of the printing Ipsum has been the industry's standard dummy text ever since the 1500s,</p>
						</div>
						<div class="d-flex align-items-center flex-nowrap">
							<div class="bg-secondary rounded">
								<img src="#" class="img-fluid rounded" style="width: 100px; height: 100px;" alt="">
							</div>
							<div class="ms-4 d-block">
								<h4 class="text-dark">Client Name</h4>
								<p class="m-0 pb-3">Profession</p>
								<div class="d-flex pe-5">
									<i class="fas fa-star text-wine"></i> <i class="fas fa-star text-wine"></i> <i class="fas fa-star text-wine"></i> <i
										class="fas fa-star text-wine"></i> <i class="fas fa-star text-wine"></i>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="testimonial-item img-border-radius bg-light rounded p-4">
					<div class="position-relative">
						<i class="fa fa-quote-right fa-2x text-wine position-absolute" style="bottom: 30px; right: 0;"></i>
						<div class="mb-4 pb-4 border-bottom border-secondary">
							<p class="mb-0">Lorem Ipsum is simply dummy text of the printing Ipsum has been the industry's standard dummy text ever since the 1500s,</p>
						</div>
						<div class="d-flex align-items-center flex-nowrap">
							<div class="bg-secondary rounded">
								<img src="#" class="img-fluid rounded" style="width: 100px; height: 100px;" alt="">
							</div>
							<div class="ms-4 d-block">
								<h4 class="text-dark">Client Name</h4>
								<p class="m-0 pb-3">Profession</p>
								<div class="d-flex pe-5">
									<i class="fas fa-star text-wine"></i> <i class="fas fa-star text-wine"></i> <i class="fas fa-star text-wine"></i> <i
										class="fas fa-star text-wine"></i> <i class="fas fa-star text-wine"></i>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Tastimonial End -->

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
	<!-- Copyright End -->



	<!-- Back to Top -->
	<a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i class="fa fa-arrow-up"></i></a>

</body>
</html>