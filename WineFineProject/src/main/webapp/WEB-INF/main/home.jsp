<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.swiper-slide {
	height: 300px !important;
	opacity: 0.4;
	margin-top: 20px;
}

.swiper-slide-active {
	height: 330px !important;
	opacity: 1 !important;
	margin-top: 10px !important;
}

.swiper-slide-active>div {
	box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.3);
}

.swiper-slide-prev, .swiper-slide-next {
	opacity: 0.7 !important;
}

.filter {
	display: flex; /* Flexbox 활성화 */
	flex-wrap: wrap; /* 공간이 부족하면 다음 줄로 넘김 */
	justify-content: space-between; /* 항목 사이에 여백 분배 */
	margin-top: 20px; /* 위쪽 여백 추가 */
}

.filter-item {
	width: 20%;
	text-align: center;
}

.filter-box {
	list-style: none;
	padding: 0px;
	margin-top: 10px;
}

.filter-box li {
	color: darkred;
	margin: 4px 0px;;
	padding: 0px 5px;
}

.filter-box li label {
	padding: 3px 6px;
	width: 120px;
	display: inline-block;
	cursor: pointer;
}

.filter-box:last-child li {
	color: gray;
}

.filter-icons {
	font-size: 36px;
	color: white;
	padding: 10px;
}

.filter-img {
	background: darkred;
	border-right: 1px solid gray;
}

.filter-img:last-child {
	background: darkred;
	border: none;
}

.item-wine {
	border: 1px solid darkred;
	border-radius: 150px;
	color: darkred;
}

.filter-box li label.no-style {
	padding: 0;
	color: inherit;
	width: 16px;
}
</style>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css">
</head>
<body>
	<div id="mainApp">
		<div class="container-fluid fruite py-5" id="fruite">
			<div class="row text-center" style="margin: 0px auto; width: 1320px;">
				<div class="position-relative mx-auto">
					<form method="get" action="../main/find.do">
						<input class="form-control border-2 border-wine w-75 py-3 px-4 rounded-pill" type="text" name="fd" placeholder="Search" style="margin: 0px auto;">
						<button type="submit" class="btn btn-default border-2 border-wine py-3 px-4 position-absolute rounded-pill text-wine h-100" style="top: 0; right: 13%;">Submit Now</button>
					</form>
				</div>
			</div>
		</div>
		<div class="container-fluid vesitable">
			<div class="py-5" style="margin-left: 20%; margin-right: 20%">
				<h2 class="mb-0" style="text-align: center;">추천 와인</h2>
				<!-- Swiper 시작 -->
				<div class="swiper" style="margin-top: 30px">
					<div class="swiper-wrapper" style="height: 370px;">
						<div class="swiper-slide" v-for="(vo, index) in bList" @click="promotionDetail(index)">
							<div class="border border-wine rounded position-relative vesitable-item text-center">
								<div class="vesitable-img" style="marging-top: 10px;">
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
		<div class="container" style="margin-top:50px">
			<div class="row">
				<div class="col-sm-8">
					<iframe width="100%" height="100%" src="https://www.youtube.com/embed/EnO0yzn91YA?si=3y6-2TgiwlCtEdxR" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
				</div>
				<div class="col-sm-4">
					<h3 class="text-center">와인 뉴스</h3>
					<table class="table">
						<tr v-for="nvo in nList">
							<td style="overflow: hidden; white-space: nowrap;">
								<a :href="nvo.link" v-html="nvo.title" target="_blank"></a>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<div style="height: 50px;margin-top:50px"></div>
		<div class="container">
			<h2 class="text-center">와인 찾기</h2>
			<form action="../shop/list.do" method="post">
				<div class="filter" style="border-radius: 15px 15px 0px 0px;">
					<div class="filter-item">
						<div class="filter-img">
							<i class="fa-solid fa-glass-cheers filter-icons"></i>
						</div>
						<ul class="filter-box">
							<li>
								<label :class="{'item-wine':types.includes('레드') }"><input name="type" type="checkbox" v-model="types" style="display: none" value="레드">레드</label>
							</li>
							<li>
								<label :class="{'item-wine':types.includes('화이트') }"><input name="type" type="checkbox" v-model="types" style="display: none" value="화이트"> 화이트</label>
							</li>
							<li>
								<label :class="{'item-wine':types.includes('로제') }"><input name="type" type="checkbox" v-model="types" style="display: none" value="로제"> 로제</label>
							</li>
							<li>
								<label :class="{'item-wine':types.includes('스파클링') }"><input name="type" type="checkbox" v-model="types" style="display: none" value="스파클링"> 스파클링</label>
							</li>
							<li>
								<label :class="{'item-wine':types.includes('주정강화') }"><input name="type" type="checkbox" v-model="types" style="display: none" value="주정강화"> 주정강화</label>
							</li>
							<li>
								<label :class="{'item-wine':types.includes('기타') }"><input name="type" type="checkbox" v-model="types" style="display: none" value="기타"> 기타</label>
							</li>
						</ul>
					</div>
					<div class="filter-item">
						<div class="filter-img">
							<i class="fa-solid fa-coins filter-icons"></i>
						</div>
						<ul class="filter-box">
							<li>
								<label :class="{'item-wine':price==='3'}"><input name="price" type="radio" v-model="price" style="display: none" value="3">~3만원</label>
							</li>
							<li>
								<label :class="{'item-wine':price==='5'}"><input name="price" type="radio" v-model="price" style="display: none" value="5">~5만원</label>
							</li>
							<li>
								<label :class="{'item-wine':price==='7'}"><input name="price" type="radio" v-model="price" style="display: none" value="7">~7만원</label>
							</li>
							<li>
								<label :class="{'item-wine':price==='10'}"><input name="price" type="radio" v-model="price" style="display: none" value="10">~10만원</label>
							</li>
							<li>
								<label :class="{'item-wine':price==='20'}"><input name="price" type="radio" v-model="price" style="display: none" value="20">~20만원</label>
							</li>
							<li>
								<label :class="{'item-wine':price==='99999'}"><input name="price" type="radio" v-model="price" style="display: none" value="99999">20만원 이상</label>
							</li>
						</ul>
					</div>
					<div class="filter-item">
						<div class="filter-img">
							<i class="fa-solid fa-spray-can-sparkles filter-icons"></i>
						</div>
						<ul class="filter-box">
							<li v-for="aroma in aromaList">
								<label :class="{'item-wine':aromas.includes(aroma) }"><input name="aroma" type="checkbox" v-model="aromas" style="display: none" :value="aroma">{{aroma}}</label>
							</li>
						</ul>
					</div>
					<div class="filter-item">
						<div class="filter-img">
							<i class="fa-solid fa-utensils filter-icons"></i>
						</div>
						<ul class="filter-box">
							<li v-for="food in foodList">
								<label :class="{'item-wine':foods.includes(food) }"><input name="food" type="checkbox" v-model="foods" style="display: none" :value="food">{{food}}</label>
							</li>
						</ul>
					</div>
					<div class="filter-item">
						<div class="filter-img">
							<i class="fa-regular fa-face-grin-tongue filter-icons"></i>
						</div>
						<ul class="filter-box">
							<li>
								당도 <label v-for="ss in 5" class="no-style" style="cursor: pointer;"> <input type="radio" name="sugarStars" :value="ss" v-model="sugar" style="display: none;"><i :class="{'text-wine':sugar>=ss}" style="margin-right: 2px;" class="fa fa-circle"></i>
								</label>
							</li>
							<li>
								산도 <label v-for="as in 5" class="no-style" style="cursor: pointer;"> <input type="radio" name="acidStars" :value="as" v-model="acid" style="display: none;"><i :class="{'text-wine':acid>=as}" style="margin-right: 2px;" class="fa fa-circle"></i>
								</label>
							</li>
							<li>
								바디 <label v-for="bs in 5" class="no-style" style="cursor: pointer;"> <input type="radio" name="bodyStars" :value="bs" v-model="body" style="display: none;"><i :class="{'text-wine':body>=bs}" style="margin-right: 2px;" class="fa fa-circle"></i>
								</label>
							</li>
							<li>
								탄닌 <label v-for="ts in 5" class="no-style" style="cursor: pointer;"> <input type="radio" name="tanninStars" :value="ts" v-model="tannin" style="display: none;"><i :class="{'text-wine':tannin>=ts}" style="margin-right: 2px;" class="fa fa-circle"></i>
								</label>
							</li>
						</ul>
					</div>
				</div>
				<div style="text-align: right">
					<button class="btn btn-sm btn-wine2" type="button" @click="resetSelect()" style="margin-right: 10px;">초기화</button>
					<button class="btn btn-sm btn-wine2" type="submit">검색</button>
				</div>
			</form>
		</div>
	</div>
	<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
	<script>
	let mainApp=Vue.createApp({
		data(){
			return{
				bList:[],
				nList:[],
				sugar:0,
				acid:0,
				body:0,
				tannin:0,
				types:[],
				price:'',
				aromaList:['꽃','돌','레몬','말린과일','베리','사과','숙성','시나몬','아몬드','오크통','크로와상','파인애플',	'파프리카','허브'],
				foodList:['소','돼지','치킨','건육','생선','가리비','샐러드',	'튀김','치즈','과일','케이크',	'피자','아시아',	'비빔밥',	'누들','샴페인'],
				aromas:[],
				foods:[],
			}
		},
		mounted(){
			axios.get('../main/vueMain.do').then(response=>{
				console.log(response.data)
				this.bList=response.data.bList
				this.nList=response.data.nList
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
		},
		methods:{
			colorC(){
				console.log(this.color)
			},
			promotionDetail(index){
				axios.get('../main/vuePromotion.do', {
					params:{
						pbno:this.bList[index].pbno
					}
				}).then(response=>{
					location.href="../shop/detailBefore.do?wno="+this.bList[index].wno
				})
			},
			resetSelect(){
				this.sugar=0
				this.acid=0
				this.body=0
				this.tannin=0
				this.foods=[]
				this.aromas=[]
				this.types=[]
				this.price=''
			}
		}
	}).mount('#mainApp')
	</script>
</body>
</html>