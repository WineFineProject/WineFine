<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://unpkg.com/vue@3"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<style type="text/css">
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

.pagination {
	cursor: pointer;
}

.winecor {
	background-color: #881824 !important;
	color: white !important;
}

.whitecor {
	background-color: white !important;
	color: #881824 !important;
	border: solid 1px #881824 !important;
}

.page-link {
	position: relative;
	display: block;
	color: #881824 !important;
	background-color: #fff;
	border: 1px solid #881824 !important;
	transition: color .15s ease-in-out, background-color .15s ease-in-out,
		border-color .15s ease-in-out, box-shadow .15s ease-in-out;
}

.border-secondary {
	border-color: #881824 !important;
}

.label.no-style {
	padding: 0;
	color: inherit;
	width: 16px;
}

.filter-box {
	list-style: none;
	padding: 0px;
	margin-top: 10px;
}

.item-wine {
	border: 1px solid darkred;
	border-radius: 150px;
	color: #881824;
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


		<!-- Single Page Header start -->
		<div class="container-fluid page-header py-5">
			<h1 class="text-center text-white display-6">Shop</h1>
		</div>
		<!-- Single Page Header End -->


		<!-- Fruits Shop Start-->
		<div class="container-fluid fruite py-5">
			<div class="container py-5">

				<div class="row g-4">
					<div class="col-lg-12">
						<div class="row g-4" style="margin-bottom: 15px;">
							<div class="col-xl-3">
								<h3 class="mb-4">와인 필터</h3>
							</div>
							<div class="col-1" style="width: 32px;"></div>
							<div class="col-6" style="padding-top: 20px;">
								<div class="input-group w-100 mx-auto d-flex">
									<input type="search" class="form-control "
										placeholder="keywords" aria-describedby="search-icon-1">
									<span id="search-icon-1" class="input-group-text "><i
										class="fa fa-search"></i></span>
								</div>
							</div>
							<!-- 							<div class="col-xl-1"></div>							 -->
							<div class="col-2">
								<!-- 								<div
									class="py-3 rounded d-flex justify-content-between mb-4">
									<label for="fruits">Default Sorting:</label> 
									<select id="fruits" name="fruitlist"
										class="border-0 form-select-sm bg-light me-3" form="fruitform">
										<option value="volvo">최신등록순</option>
										<option value="saab">가격낮은순</option>
										<option value="opel">가격높은순</option>
										<option value="audi">평점순</option>
									</select>
								</div> -->
								<div style="padding: 30px 0px 0px 0px; text-align: left;">
									<h5 style="text-align: right;">전체 와인
										({{this.wineTcount.toLocaleString()}})</h5>
								</div>
							</div>
						</div>
						<div class="row g-4">
							<div class="col-lg-3">
								<div class="row g-4">

									<div class="col-lg-12">
										<div class="mb-3">
											<h4>종류</h4>
											<div class="mb-2">
												<ul class="filter-box">
													<li><label
														:class="{'item-wine':wtypes.includes('레드') }"><input
															name="type" type="checkbox" v-model="wtypes"
															style="display: none" value="레드">레드</label></li>
													<li><label
														:class="{'item-wine':wtypes.includes('화이트') }"><input
															name="type" type="checkbox" v-model="wtypes"
															style="display: none" value="화이트"> 화이트</label></li>
													<li><label
														:class="{'item-wine':wtypes.includes('로제') }"><input
															name="type" type="checkbox" v-model="wtypes"
															style="display: none" value="로제"> 로제</label></li>
													<li><label
														:class="{'item-wine':wtypes.includes('스파클링') }"><input
															name="type" type="checkbox" v-model="wtypes"
															style="display: none" value="스파클링"> 스파클링</label></li>
													<li><label
														:class="{'item-wine':wtypes.includes('주정강화') }"><input
															name="type" type="checkbox" v-model="wtypes"
															style="display: none" value="주정강화"> 주정강화</label></li>
													<li><label
														:class="{'item-wine':wtypes.includes('기타') }"><input
															name="type" type="checkbox" v-model="wtypes"
															style="display: none" value="기타"> 기타</label></li>
												</ul>
											</div>
										</div>
									</div>

									<div class="col-lg-12">
										<div class="mb-3">
											<h4 class="mb-2">가격</h4>
											<input type="range" class="form-range w-100" id="rangeInput"
												name="rangeInput" min="0" max="300000" value="0"
												oninput="amount.value=rangeInput.value">
											<output id="amount" name="amount" min-velue="0"
												max-value="500" for="rangeInput">0</output>
										</div>
									</div>
									<div class="col-lg-12">
										<div class="mb-3">
											<h4>음식매칭</h4>
											<div class="mb-2">
												<ul class="filter-box">
													<li v-for="food in foods"><label
														:class="{'item-wine':selectFoods.includes(food) }"><input
															name="food" type="checkbox" v-model="selectFoods"
															style="display: none" :value="food">{{food}}</label></li>
												</ul>
											</div>
										</div>
									</div>
									<div class="col-lg-12">
										<div class="mb-3">
											<h4>맛</h4>
											<ul class="list-unstyled fruite-categorie">
												<li>
													<div class="d-flex justify-content-between fruite-name">
														당도 : <label v-for="ss in 5" class="no-style"
															style="cursor: pointer;"> <input type="radio"
															name="sugarStars" :value="ss" v-model="sugar"
															style="display: none;"> <i
															:class="{'text-wine':srating>=ss}"
															style="margin-right: 2px;" class="fa fa-star"></i>
														</label>
													</div>
												</li>
												<li>
													<div class="d-flex justify-content-between fruite-name">
														바디 : <label v-for="bs in 5" class="no-style"
															style="cursor: pointer;"> <input type="radio"
															name="bodyStars" :value="bs" v-model="body"
															style="display: none;"> <i
															:class="{'text-wine':srating>=bs}"
															style="margin-right: 2px;" class="fa fa-star"></i>
														</label>
													</div>
												</li>
												<li>
													<div class="d-flex justify-content-between fruite-name">
														산도 : <label v-for="as in 5" class="no-style"
															style="cursor: pointer;"> <input type="radio"
															name="acidStars" :value="as" v-model="acid"
															style="display: none;"> <i
															:class="{'text-wine':srating>=as}"
															style="margin-right: 2px;" class="fa fa-star"></i>
														</label>
													</div>
												</li>
												<li>
													<div class="d-flex justify-content-between fruite-name">
														탄닌 : <label v-for="ts in 5" class="no-style"
															style="cursor: pointer;"> <input type="radio"
															name="tanninStars" :value="ts" v-model="tannin"
															style="display: none;"> <i
															:class="{'text-wine':srating>=ts}"
															style="margin-right: 2px;" class="fa fa-star"></i>
														</label>
													</div>
												</li>
											</ul>
										</div>
									</div>

									<div class="col-lg-12">
										<div class="mb-3">
											<h4>아로마</h4>
											<div class="mb-2">
												<ul class="filter-box">
													<li v-for="ar in aroma"><label
														:class="{'item-wine':selectAroma.includes(ar) }"><input
															name="ar" type="checkbox" v-model="selectAroma"
															style="display: none" :value="ar">{{ar}}</label></li>
												</ul>
											</div>
										</div>
									</div>

									<div class="col-lg-12">
										<div class="position-relative">
											<img src="#" class="img-fluid w-100 rounded" alt="">
											<div class="position-absolute"
												style="top: 50%; right: 10px; transform: translateY(-50%);">
											</div>
										</div>
									</div>

								</div>
							</div>

							<div class="col-lg-9">
								<div class="row g-4 justify-content-center">

									<!-- 상품 list -->
									<div class="col-md-6 col-lg-6 col-xl-4" v-for="vo in list"
										style="margin-bottom: 20px; width: 300px;">
										<a :href="'../shop/detail.do?wno=' + vo.wno">
											<div class="rounded position-relative fruite-item"
												style="width: 270px;">
												<div class="fruite-img text-center" style="width: 270px;">
													<img :src="vo.poster"
														class="img-fluid w-75 h-75 rounded-top" alt=""
														style="width: 180px !important;">
												</div>
												<div class="text-white px-3 py-1 rounded position-absolute"
													:class="vo.type === '화이트' ? 'whitecor' : 'winecor'"
													style="top: 10px; left: 10px;">{{vo.type}}</div>
												<div
													class="p-4 border border-secondary border-top-0 rounded-bottom"
													style="width: 270px; height: 134px;">
													<h6 class="text-ellipsis">{{ vo.namekor }}</h6>
													<h6 class="text-ellipsis fon-cor-gr">{{ vo.nameeng }}</h6>
													<div
														class="d-flex justify-content-between flex-lg-wrap text-center"
														v-if="vo.price!=null">
														<p class="text-dark fs-5 fw-bold mb-0">
															{{vo.price}}<br>
														</p>
														<a href="#"
															class="btn border border-secondary rounded-pill px-3 text-primary small-text"><i
															class="fa fa-shopping-bag me-2 text-primary"></i> Add to
															cart</a>
													</div>
													<div
														class="d-flex justify-content-between flex-lg-wrap text-center"
														v-if="vo.price===null">
														<p class="text-dark fs-5 fw-bold mb-0">
															가격문의<br>
														</p>
														<a href="#"
															class="btn border border-secondary rounded-pill px-3 text-primary small-text"><i
															class="fa fa-shopping-bag me-2 text-primary"></i> Add to
															cart</a>
													</div>
												</div>
											</div>
										</a>
									</div>
									<!-- 상품 list end -->

									<div class="col-12 text-center">
										<div class="pagination-area d-sm-flex mt-15"
											style="margin-left: 65px;">
											<nav aria-label="#">
												<ul class="pagination" style="display: flex;">
													<li class="page-item"><a class="page-link"
														@click="prev()"> <i class="fa fa-angle-double-left"
															aria-hidden="true"></i>
													</a></li>

													<li :class="i===curpage?'page-item active':''"
														v-for="i in range(startPage, endPage)"
														style="display: inline;"><a class="page-link"
														@click="pageChange(i)">{{i}}</a></li>

													<li class="page-item" v-if="endPage<totalpage"><a
														class="page-link" @click="next()"> <i
															class="fa fa-angle-double-right" aria-hidden="true"></i>
													</a></li>
												</ul>
											</nav>
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



		<!-- Back to Top -->
		<a href="#"
			class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i
			class="fa fa-arrow-up"></i></a>
	</div>
	<script>
    	let listApp=Vue.createApp({
    		data(){
    			return{
    				wineTcount: 0,
    				list: [],
        			curpage: 1,
        			totalpage: 0,
        			startPage: 0,
        			endPage: 0,
        			sugar: 0,
    				acid: 0,
    				body: 0,
    				tannin: 0,
    				srating: 0,
    				wtypes: [],
    				foods: [],
    				selectFoods: '${search.food}',
    				aroma:[],
    				selectAroma: '${search.aroma}'
    			}
    		},
    		mounted(){
    			console.log(this.selectAroma)
				this.dataRecv()
        	},
    		methods:{
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
    			    
    			    // 현재 페이지에서 총 페이지를 넘지 않도록 다음 페이지 계산
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
        		dataRecv(){
        			axios.get('../shop/list_vue.do',{
        				params:{
        					page:this.curpage
        				}
        			}).then(response=>{
        				console.log(response.data)
        				this.list=response.data.list
        				this.curpage=response.data.curpage
        				this.totalpage=response.data.totalpage
        				this.startPage=response.data.startPage
        				this.endPage=response.data.endPage
        				this.wineTcount = response.data.wineTcount
        				this.wtypes = response.data.wtypes
        				console.log('wtypes : ' + this.wtypes)
        				this.foods = response.data.foods
        				console.log('foods : ' + this.foods)
        				console.log('selectFoods : ' + this.selectFoods)
        				this.aroma = response.data.aroma
        				console.log('aroma : ' + this.aroma)
        				console.log('selectAroma : ' + this.selectAroma)
        			}).catch(error=>{
        				console.log(error.response)
        			})
        		}
    		}
    	}).mount('.shopcontainer')
    </script>
</body>
</html>