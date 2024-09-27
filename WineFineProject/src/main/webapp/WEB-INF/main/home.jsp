<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.text-hidden {
	white-space: nowrap;
	text-overflow: ellipsis;
	overflow: hidden;
}
.border-3px-dark{
border: 3px solid #45595b !important;
background-color: #45595b !important;    
}
.border-3px-wine{
border: 3px solid darkred !important;
background-color: darkred !important; 
}
</style>
</head>
<body>
	<div class="container-fluid fruite py-5" id="fruite">
		<div class="container py-5">
			<h1 class="mb-4">Fresh fruits shop</h1>
			<div class="row g-4">
				<div class="col-lg-12">
					<div class="row g-4">
						<div class="col-xl-3">
							<div class="input-group w-100 mx-auto d-flex">
								<input type="search" class="form-control p-3" placeholder="keywords" aria-describedby="search-icon-1"> <span id="search-icon-1"
									class="input-group-text p-3"><i class="fa fa-search"></i></span>
							</div>
						</div>
						<div class="col-6"></div>
						<div class="col-xl-3">
							<div class="bg-light ps-3 py-3 rounded d-flex justify-content-between mb-4">
								<label for="fruits">Default Sorting:</label>
								<select id="fruits" name="fruitlist" class="border-0 form-select-sm bg-light me-3" form="fruitform">
									<option value="volvo">Nothing</option>
									<option value="saab">Popularity</option>
									<option value="opel">Organic</option>
									<option value="audi">Fantastic</option>
								</select>
							</div>
						</div>
					</div>
					<div class="row g-4">
						<div class="col-lg-3">
							<div class="row g-4">
								<div class="col-lg-12">
									<div class="mb-3">
										<h4>Categories</h4>
										<ul class="list-unstyled fruite-categorie">
											<li>
												<div class="d-flex justify-content-between fruite-name">
													<label>
														<input @change="winelist(1)" name="type" type="checkbox" class="btn" v-model="types" style="display: none" value="레드"><span
															:class="{'border-3px-dark':!types.includes('레드'),'border-3px-wine':types.includes('레드') }"
															class="btn border  rounded-pill px-3 text-white">레드</span>
													</label>
													<label>
														<input @change="winelist(1)" name="type" type="checkbox" class="btn" v-model="types" style="display: none" value="화이트"><span
															:class="{'border-3px-dark':!types.includes('화이트'),'border-3px-wine':types.includes('화이트') }"
															class="btn border rounded-pill px-3 text-white">화이트</span>
													</label>
												</div>
											</li>
											<li>
												<div class="d-flex justify-content-between fruite-name">
													<label>
														<input @change="winelist(1)" name="type" type="checkbox" class="btn" v-model="types" style="display: none" value="스파클링"><span
															:class="{'border-3px-dark':!types.includes('스파클링'),'border-3px-wine':types.includes('스파클링') }"
															class="btn border rounded-pill px-3 text-white">스파클링</span>
													</label>
													<label>
														<input @change="winelist(1)" name="type" type="checkbox" class="btn" v-model="types" style="display: none" value="로제"><span
															:class="{'border-3px-dark':!types.includes('로제'),'border-3px-wine':types.includes('로제') }" class="btn border rounded-pill px-3 text-white border-3px">로제</span>
													</label>
												</div>
											</li>
											<li>
												<div class="d-flex justify-content-between fruite-name">
													<label>
														<input @change="winelist(1)" name="type" type="checkbox" class="btn" v-model="types" style="display: none" value="주정강화"><span
															:class="{'border-3px-dark':!types.includes('주정강화'),'border-3px-wine':types.includes('주정강화') }"
															class="btn border rounded-pill px-3 text-white border-3px">주정강화</span>
													</label>
													<label>
														<input @change="winelist(1)" name="type" type="checkbox" class="btn" v-model="types" style="display: none" value="기타"><span
															:class="{'border-3px-dark':!types.includes('기타'),'border-3px-wine':types.includes('기타') }"
															class="btn border rounded-pill px-3 text-white border-3px">기타</span>
													</label>
												</div>
											</li>
											<li>
												<div>{{types}}</div>
											</li>
										</ul>
									</div>
								</div>
								<div class="col-lg-12">
									<div class="mb-3">
										<h4 class="mb-2">Price</h4>
										<input @change="winelist(1)" type="range" class="form-range w-100" v-model="priceRange" name="rangeInput" min="0" max="200000" step="10000" value="0"> <span>{{priceRange>190000?'전체':priceRange}}</span>
									</div>
								</div>
								<div class="col-lg-12">
									<div class="mb-3">
										<h4>Taste</h4>
										<div class="mb-2">
											당도
											<label>
												<input @change="winelist(1)" type="radio" name="sugarStars" value="1" v-model="sugar" style="display: none;"><i :class="{'text-secondary':sugar>=1}"
													class="fa fa-circle"></i>
											</label>
											<label>
												<input @change="winelist(1)" type="radio" name="sugarStars" value="2" v-model="sugar" style="display: none;"><i :class="{'text-secondary':sugar>=2}"
													class="fa fa-circle"></i>
											</label>
											<label>
												<input @change="winelist(1)" type="radio" name="sugarStars" value="3" v-model="sugar" style="display: none;"><i :class="{'text-secondary':sugar>=3}"
													class="fa fa-circle"></i>
											</label>
											<label>
												<input @change="winelist(1)" type="radio" name="sugarStars" value="4" v-model="sugar" style="display: none;"><i :class="{'text-secondary':sugar>=4}"
													class="fa fa-circle"></i>
											</label>
											<label>
												<input @change="winelist(1)" type="radio" name="sugarStars" value="5" v-model="sugar" style="display: none;"><i :class="{'text-secondary':sugar>=5}"
													class="fa fa-circle"></i>
											</label>
										</div>
										<div class="mb-2">
											바디
											<label>
												<input @change="winelist(1)" type="radio" name="bodyStars" value="1" v-model="bodys" style="display: none;"><i :class="{'text-secondary':bodys>=1}"
													class="fa fa-circle"></i>
											</label>
											<label>
												<input @change="winelist(1)" type="radio" name="bodyStars" value="2" v-model="bodys" style="display: none;"><i :class="{'text-secondary':bodys>=2}"
													class="fa fa-circle"></i>
											</label>
											<label>
												<input @change="winelist(1)" type="radio" name="bodyStars" value="3" v-model="bodys" style="display: none;"><i :class="{'text-secondary':bodys>=3}"
													class="fa fa-circle"></i>
											</label>
											<label>
												<input @change="winelist(1)" type="radio" name="bodyStars" value="4" v-model="bodys" style="display: none;"><i :class="{'text-secondary':bodys>=4}"
													class="fa fa-circle"></i>
											</label>
											<label>
												<input @change="winelist(1)" type="radio" name="bodyStars" value="5" v-model="bodys" style="display: none;"><i :class="{'text-secondary':bodys>=5}"
													class="fa fa-circle"></i>
											</label>
										</div>
										<div class="mb-2">
											산도
											<label>
												<input @change="winelist(1)" type="radio" name="acidStars" value="1" v-model="acid" style="display: none;"><i :class="{'text-secondary':acid>=1}"
													class="fa fa-circle"></i>
											</label>
											<label>
												<input @change="winelist(1)" type="radio" name="acidStars" value="2" v-model="acid" style="display: none;"><i :class="{'text-secondary':acid>=2}"
													class="fa fa-circle"></i>
											</label>
											<label>
												<input @change="winelist(1)" type="radio" name="acidStars" value="3" v-model="acid" style="display: none;"><i :class="{'text-secondary':acid>=3}"
													class="fa fa-circle"></i>
											</label>
											<label>
												<input @change="winelist(1)" type="radio" name="acidStars" value="4" v-model="acid" style="display: none;"><i :class="{'text-secondary':acid>=4}"
													class="fa fa-circle"></i>
											</label>
											<label>
												<input @change="winelist(1)" type="radio" name="acidStars" value="5" v-model="acid" style="display: none;"><i :class="{'text-secondary':acid>=5}"
													class="fa fa-circle"></i>
											</label>
										</div>
										<div class="mb-2">
											탄닌
											<label>
												<input @change="winelist(1)" type="radio" name="tanninStars" value="1" v-model="tannin" style="display: none;"><i :class="{'text-secondary':tannin>=1}"
													class="fa fa-circle"></i>
											</label>
											<label>
												<input @change="winelist(1)" type="radio" name="tanninStars" value="2" v-model="tannin" style="display: none;"><i :class="{'text-secondary':tannin>=2}"
													class="fa fa-circle"></i>
											</label>
											<label>
												<input @change="winelist(1)" type="radio" name="tanninStars" value="3" v-model="tannin" style="display: none;"><i :class="{'text-secondary':tannin>=3}"
													class="fa fa-circle"></i>
											</label>
											<label>
												<input @change="winelist(1)" type="radio" name="tanninStars" value="4" v-model="tannin" style="display: none;"><i :class="{'text-secondary':tannin>=4}"
													class="fa fa-circle"></i>
											</label>
											<label>
												<input @change="winelist(1)" type="radio" name="tanninStars" value="5" v-model="tannin" style="display: none;"><i :class="{'text-secondary':tannin>=5}"
													class="fa fa-circle"></i>
											</label>
										</div>
									</div>
								</div>
								<div class="col-lg-12">
									<h4 class="mb-3">Featured products</h4>
									<div class="d-flex align-items-center justify-content-start">
										<div class="rounded me-4" style="width: 100px; height: 100px;">
											<img src="img/featur-1.jpg" class="img-fluid rounded" alt="">
										</div>
										<div>
											<h6 class="mb-2">Big Banana</h6>
											<div class="d-flex mb-2">
												<i class="fa fa-star text-secondary"></i> <i class="fa fa-star text-secondary"></i> <i class="fa fa-star text-secondary"></i> <i
													class="fa fa-star text-secondary"></i> <i class="fa fa-star"></i>
											</div>
											<div class="d-flex mb-2">
												<h5 class="fw-bold me-2">2.99 $</h5>
												<h5 class="text-danger text-decoration-line-through">4.11 $</h5>
											</div>
										</div>
									</div>
									<div class="d-flex align-items-center justify-content-start">
										<div class="rounded me-4" style="width: 100px; height: 100px;">
											<img src="img/featur-2.jpg" class="img-fluid rounded" alt="">
										</div>
										<div>
											<h6 class="mb-2">Big Banana</h6>
											<div class="d-flex mb-2">
												<i class="fa fa-star text-secondary"></i> <i class="fa fa-star text-secondary"></i> <i class="fa fa-star text-secondary"></i> <i
													class="fa fa-star text-secondary"></i> <i class="fa fa-star"></i>
											</div>
											<div class="d-flex mb-2">
												<h5 class="fw-bold me-2">2.99 $</h5>
												<h5 class="text-danger text-decoration-line-through">4.11 $</h5>
											</div>
										</div>
									</div>
									<div class="d-flex align-items-center justify-content-start">
										<div class="rounded me-4" style="width: 100px; height: 100px;">
											<img src="img/featur-3.jpg" class="img-fluid rounded" alt="">
										</div>
										<div>
											<h6 class="mb-2">Big Banana</h6>
											<div class="d-flex mb-2">
												<i class="fa fa-star text-secondary"></i> <i class="fa fa-star text-secondary"></i> <i class="fa fa-star text-secondary"></i> <i
													class="fa fa-star text-secondary"></i> <i class="fa fa-star"></i>
											</div>
											<div class="d-flex mb-2">
												<h5 class="fw-bold me-2">2.99 $</h5>
												<h5 class="text-danger text-decoration-line-through">4.11 $</h5>
											</div>
										</div>
									</div>
									<div class="d-flex justify-content-center my-4">
										<a href="#" class="btn border border-secondary px-4 py-3 rounded-pill text-primary w-100">Vew More</a>
									</div>
								</div>
								<div class="col-lg-12">
									<div class="position-relative">
										<img src="img/banner-fruits.jpg" class="img-fluid w-100 rounded" alt="">
										<div class="position-absolute" style="top: 50%; right: 10px; transform: translateY(-50%);">
											<h3 class="text-secondary fw-bold">
												Fresh <br> Fruits <br> Banner
											</h3>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="col-lg-9">
							<div class="row g-4 justify-content-center">
								<div class="col-md-6 col-lg-6 col-xl-4" style="margin-bottom: 10px;" v-for="vo in wine_list">
									<div class="rounded position-relative fruite-item">
										<div class="fruite-img text-center">
											<img :src="vo.poster" class="img-fluid w-75 h-75 rounded-top" alt="">
										</div>
										<div class="text-white bg-wine px-3 py-1 rounded position-absolute" style="top: 10px; left: 10px;">{{vo.type}}</div>
										<div class="p-3 border border-wine border-top-0 rounded-bottom">
											<h6>
												<p class="text-hidden">{{vo.namekor}}</p>
											</h6>
											<p class="text-hidden">
												<small>{{vo.nameeng}}</small>
											</p>
											<div class="d-flex justify-content-between flex-lg-wrap">
												<p class="text-dark fw-bold mb-0 fs-6">{{vo.price}}</p>
												<a href="#" class="btn border border-wine rounded-pill px-3 text-wine"><i class="fa fa-shopping-bag me-2 text-wine"></i> Add to cart</a>
											</div>
										</div>
									</div>
								</div>
								<div class="text-center">
								<button type="button" class="btn border border-wine rounded-pill px-3 text-wine" @click="moreInfo()">더보기</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script>
	let wine=Vue.createApp({
		data(){
			return{
				wine_list:[],
				priceRange:200000,
				types:[],
				sugar:0,
				bodys:0,
				acid:0,
				tannin:0,
				end:12
			}
		},
		methods:{
			winelist(page){
				let price_temp=String(this.priceRange)
				if(this.priceRange>190000)
					price_temp='전체'
				let typeStr='전체'
				if(this.types!='')
					typeStr=this.types.join(',')
				axios.get('../main/list.do', {
					params:{
					page:page,
					sugar:this.sugar,
					body:this.bodys,
					acid:this.acid,
					tannin:this.tannin,
					price:price_temp,
					types:typeStr,
					end:this.end
					}
				}).then(response=>{
					console.log(response.data.list)
					this.wine_list=response.data.list
				})
			},
			moreInfo(){
				this.end=this.end+6
				this.winelist(1)
			}
		},
		mounted() {
		    this.winelist(1);
		}
	}).mount('#fruite')
	</script>
</body>
</html>