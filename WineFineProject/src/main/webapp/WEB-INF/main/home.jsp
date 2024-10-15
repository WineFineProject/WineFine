<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.swiper-slide{
height: 300px !important;
opacity: 0.4;
margin-top: 20px;
}
.swiper-slide-active{
height: 330px !important;
opacity: 1 !important;
margin-top: 10px !important;
}
.swiper-slide-active>div{
box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.3);
}
.swiper-slide-prev, .swiper-slide-next{
opacity: 0.7 !important;
}
</style>
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css">
</head>
<body>
	<div id="mainApp">
		<div class="container-fluid fruite py-5" id="fruite">
			<div class="row text-center" style="margin: 0px auto; width: 1320px;">
				<div class="position-relative mx-auto">
					<input class="form-control border-2 border-wine w-75 py-3 px-4 rounded-pill" type="number" placeholder="Search" style="margin: 0px auto;">
					<button type="submit" class="btn btn-default border-2 border-wine py-3 px-4 position-absolute rounded-pill text-wine h-100" style="top: 0; right: 13%;">Submit Now</button>
				</div>
			</div>
		</div>
		<div class="container-fluid vesitable">
			<div class="py-5" style="margin-left: 20%; margin-right: 20%">
				<h1 class="mb-0" style="text-align: center;">추천 와인</h1>
				<!-- Swiper 시작 -->
				<div class="swiper">
					<div class="swiper-wrapper" style="height: 370px;">
						<div class="swiper-slide" v-for="vo in list">
							<div class="border border-wine rounded position-relative vesitable-item text-center">
								<div class="vesitable-img" style="margin-top: 10px;">
									<img :src="vo.wvo.poster" class="rounded-top" style="width: 50%; margin: auto;" alt="">
								</div>
								<div class="text-white bg-wine px-3 py-1 rounded position-absolute" style="top: 10px; right: 10px;">{{vo.wvo.type}}</div>
								<div class="p-4 rounded-bottom">
									<span><b>{{vo.wvo.namekor}}</b></span>
									<p>{{vo.mvo.nickName}}</p>
									<div class="d-flex justify-content-between flex-lg-wrap">
										<p class="text-dark fs-5 fw-bold mb-0" style="text-align: right;">{{vo.wvo.price}}</p>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- Add Pagination -->
					<!-- Add Navigation -->
					<!-- <div class="swiper-button-next"></div>
					<div class="swiper-button-prev"></div> -->
					<div class="swiper-pagination"></div>
				</div>
				<!-- Swiper 끝 -->
			</div>
		</div>
	</div>
	<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
	<script>
	let mainApp=Vue.createApp({
		data(){
			return{
				list:[]
			}
		},
		mounted(){
			axios.get('../main/vueMain.do').then(response=>{
				console.log(response.data)
				this.list=response.data
				this.$nextTick(()=>{
					const swiper = new Swiper('.swiper', {
						// Optional parameters
						slidesPerView: 5,
						spaceBetween: 40,
						loop:true,
						centeredSlides:true,
						pagination: {
							el: '.swiper-pagination',
							clickable: true,
						},
						autoplay: {
							delay: 5000,
							disableOnInteraction: false,
						},
					})
				})
				
			})
		}
	}).mount('#mainApp')
	</script>
</body>
</html>