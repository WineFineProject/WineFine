<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Wine List</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

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
/* /////////////////////////////////////////////////////////// */
.winecor {
	background-color: #881824 !important;
	color: white !important;
}

.rose {
	background-color: #eb9ba6 !important;
	color: white !important;
}

.Fortified {
	background-color: #efb76f !important;
	color: white !important;
}

.sparkling {
	background-color: #cdd381 !important;
	color: white !important;
}

.atherwine {
	background-color: #75528b !important;
	color: white !important;
}

.whitecor {
	background-color: white !important;
	color: black !important;
	border: solid 1px black !important;
}
/* ///////////////////////////////////////////////////////////// */
.pagination .page-item.active .page-link {
    background-color: #881824; 
    color: white; 
    border: solid 1px #881824 !important;
}

.pagination .page-item .page-link {
    color: #881824; 
    border: solid 1px #881824 !important;
}

.pagination .page-item .page-link:hover {
    background-color: #f1f1f1; 
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

.thispointer {
	cursor: pointer !important;
}

.boxPointer {
	cursor: pointer !important;
	padding: 3px 6px;
	width: 120px;
	text-align: center;
	margin-bottom: 5px;
}

.ahover:hover {
	box-shadow: 0 4px 8px rgba(136, 24, 36, 0.5);
}

.typeSize {
	padding-top: .15rem !important;
	padding-bottom: .15rem !important;
	padding-right: 0.5rem !important;
	padding-left: 0.5rem !important;
}
.paginav{
	background-color: #881824 !important;
	color: white !important;
}
</style>
</head>
<body>
	<div class="shopcontainer">
		<!-- Fruits Shop Start-->
		<div class="container-fluid fruite py-5">
			<div class="container py-5">

				<div class="row g-4">
					<div class="col-lg-12">
						<div class="row g-4" style="margin-bottom: 15px;">
							<div class="col-xl-3" style="border-bottom: 1px solid;">
								<div class="filter-header" style="display: flex; justify-content: space-between; align-items: center;">
									<h3 class="mb-4">와인 필터</h3>
									<p style="cursor: pointer;" @click="resetSelect()" class="thispointer">
										<small>초기화&nbsp;<i class="fa-solid fa-rotate-right"></i></small>
									</p>
								</div>

								<b>TYPE :</b> <small>{{selectType}}</small><br> <b>FOOD :</b> <small>{{selectFoods}}</small><br> <b>AROMA :</b> <small>{{selectAroma}}</small><br> <b>PRICE :</b> <small>{{fprice == 1000000 ? '전체' : fprice + '원'}}</small>
							</div>
							<div class="col-1" style="width: 32px;"></div>
							<div class="col-6" style="padding-top: 20px;">
								<div class="input-group w-100 mx-auto d-flex">
									<input type="text" @keyup.enter="sfw()" class="form-control " placeholder="와인 검색" aria-describedby="search-icon-1 " v-model="searchWine"><span id="search-icon-1" class="input-group-text thispointer"><i class="fa fa-search" @click="sfw()"></i></span>
								</div>
							</div>
							<!-- 							<div class="col-xl-1"></div>							 -->
							<div class="col-2">
								<div style="padding: 30px 0px 0px 0px; text-align: left;">
									<h5 style="text-align: right;">전체 와인 ({{this.wineTcount.toLocaleString()}})</h5>
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
												<ul class="filter-box" style="display: flex; flex-wrap: wrap; list-style: none; padding: 0;">
													<li style="flex: 0 0 50%;"><label class="boxPointer" :class="{'item-wine':selectType.includes('레드') }"><input @change="filterChange()" name="type" type="checkbox" v-model="selectType" style="display: none" value="레드">레드</label></li>
													<li style="flex: 0 0 50%;"><label class="boxPointer" :class="{'item-wine':selectType.includes('화이트') }"><input @change="filterChange()" name="type" type="checkbox" v-model="selectType" style="display: none" value="화이트"> 화이트</label></li>
													<li style="flex: 0 0 50%;"><label class="boxPointer" :class="{'item-wine':selectType.includes('로제') }"><input @change="filterChange()" name="type" type="checkbox" v-model="selectType" style="display: none" value="로제"> 로제</label></li>
													<li style="flex: 0 0 50%;"><label class="boxPointer" :class="{'item-wine':selectType.includes('스파클링') }"><input @change="filterChange()" name="type" type="checkbox" v-model="selectType" style="display: none" value="스파클링"> 스파클링</label></li>
													<li style="flex: 0 0 50%;"><label class="boxPointer" :class="{'item-wine':selectType.includes('주정강화') }"><input @change="filterChange()" name="type" type="checkbox" v-model="selectType" style="display: none" value="주정강화"> 주정강화</label></li>
													<li style="flex: 0 0 50%;"><label class="boxPointer" :class="{'item-wine':selectType.includes('기타') }"><input @change="filterChange()" name="type" type="checkbox" v-model="selectType" style="display: none" value="기타"> 기타</label></li>
												</ul>
											</div>
										</div>
									</div>

									<div class="col-lg-12">
										<div class="mb-3">
											<h4 class="mb-2">가격</h4>
											<input @change="dataRecv()" type="range" class="form-range w-100" id="rangeInput" name="rangeInput" min="10000" max="1000000" value="0" step="30000" v-model="fprice"> <span>{{fprice == 1000000 ? '전체' : fprice}}</span>
										</div>
									</div>
									<div class="col-lg-12">
										<div class="mb-3">
											<h4>음식매칭</h4>
											<div class="mb-2">
												<ul class="filter-box" style="display: flex; flex-wrap: wrap; padding: 0; list-style-type: none;">
													<li v-for="food in foodList" style="flex: 0 0 50%; box-sizing: border-box;"><label class="boxPointer" :class="{'item-wine':selectFoods.includes(food) }"><input @change="filterChange()" name="food" type="checkbox" v-model="selectFoods" class="thispointer" style="display: none" :value="food">{{food}}</label></li>
												</ul>
											</div>
										</div>
									</div>
									<div class="col-lg-12">
										<div class="mb-3">
											<h4>맛</h4>
											<ul class="filter-box">
												<li style="text-align: center;">당도 &nbsp;<label v-for="ss in 5" class="no-style" style="cursor: pointer; margin-right: 5px;"> <input @change="filterChange()" type="radio" name="sugarStars" :value="ss" v-model="sugar" style="display: none;"><i :class="{'text-wine':sugar>=ss}" style="margin-right: 2px;" class="fa fa-circle"></i>
												</label>
												</li>
												<li style="text-align: center;">산도 &nbsp;<label v-for="as in 5" class="no-style" style="cursor: pointer; margin-right: 5px;"> <input @change="filterChange()" type="radio" name="acidStars" :value="as" v-model="acid" style="display: none;"><i :class="{'text-wine':acid>=as}" style="margin-right: 2px;" class="fa fa-circle"></i>
												</label>
												</li>
												<li style="text-align: center;">바디 &nbsp;<label v-for="bs in 5" class="no-style" style="cursor: pointer; margin-right: 5px;"> <input @change="filterChange()" type="radio" name="bodyStars" :value="bs" v-model="body" style="display: none;"><i :class="{'text-wine':body>=bs}" style="margin-right: 2px;" class="fa fa-circle"></i>
												</label>
												</li>
												<li style="text-align: center;">탄닌 &nbsp;<label v-for="ts in 5" class="no-style" style="cursor: pointer; margin-right: 5px;"> <input @change="filterChange()" type="radio" name="tanninStars" :value="ts" v-model="tannin" style="display: none;"><i :class="{'text-wine':tannin>=ts}" style="margin-right: 2px;" class="fa fa-circle"></i>
												</label>
												</li>
											</ul>
										</div>
									</div>

									<div class="col-lg-12">
										<div class="mb-3">
											<h4>아로마</h4>
											<div class="mb-2">
												<ul class="filter-box" style="display: flex; flex-wrap: wrap; padding: 0; list-style-type: none;">
													<li v-for="ar in aromaList" style="flex: 0 0 50%; box-sizing: border-box;"><label class="boxPointer" :class="{'item-wine':selectAroma.includes(ar) }"><input @change="filterChange()" name="ar" type="checkbox" v-model="selectAroma" style="display: none" :value="ar">{{ar}}</label></li>
												</ul>
											</div>
										</div>
									</div>

								</div>
							</div>

							<div class="col-lg-9">
								<div class="row g-4 justify-content-center">

									<!-- 상품 list -->
									<div class="col-md-6 col-lg-6 col-xl-3" v-for="(vo,index) in list" style="margin-bottom: 20px; width: 25%;">
										<a :href="'../shop/detailBefore.do?wno=' + vo.wno">
											<div class="rounded position-relative fruite-item">
												<div class="text-center" style="height: 180px; display: flex; justify-content: center; align-items: center;">
													<img :src="vo.poster" class="img-fluid w-75" style="width: 60% !important; margin-top: 3px;">
												</div>

												<div class="text-white typeSize rounded position-absolute" :class="wineClass(vo.type)" style="top: 10px; left: 10px;">{{vo.type}}</div>
												<div class="p-4 border-top-0 rounded-bottom" style="height: 134px;">
													<h6 class="text-ellipsis" style="margin-bottom: 0px;">{{ vo.namekor }}</h6>
													<h6 class="text-ellipsis fon-cor-gr" style="margin-bottom: 0px;">{{ vo.nameeng }}</h6>
													<div class="d-flex justify-content-between flex-lg-wrap text-center" v-if="vo.price!=null">
														<p class="text-dark fs-5 fw-bold mb-0">
															{{vo.price}}<br>
														</p>
														<div style="display: inline-flex;">
															<a class="btn border border-secondary rounded-pill px-3 small-text ahover" style="width: 60px; display: flex; justify-content: center; align-items: center; margin-right: 10px; margin-left: 10px;" @click="handleAddToCart(index)"> <i class="fa-solid fa-cart-plus " style="color: #881824;"></i>
															</a> <a class="btn border border-secondary rounded-pill px-3 small-text ahover" style="width: 60px; display: flex; justify-content: center; align-items: center;" @click="handleBuyNow(index)"> <i class="fa-solid fa-credit-card " style="color: #881824;"></i>
															</a>
														</div>
													</div>
												</div>
											</div>
										</a>
									</div>
									<!-- 상품 list end -->
									<div class="col-12 text-center" >
							        <div class="pagination-area d-sm-flex mt-15" style="justify-content: center">
							            <nav aria-label="#">
							               <ul class="pagination" style="display: flex;">
							                   <li class="page-item" v-if="startPage>1">
							                     <a class="page-link" @click="prev()"><i class="fa fa-angle-double-left" aria-hidden="true"></i> 이전</a>
							                    </li>
							                     <li :class="{'page-item active': i === curpage, 'page-item': i !== curpage}"
								                    v-for="i in range(startPage, endPage)">
								                    <a class="page-link" @click="pageChange(i)">{{ i }}</a>
								                </li>
							                     <li class="page-item" v-if="endPage<totalpage">
							                      <a class="page-link" @click="next()" style="margin-left: 4px;">다음 <i class="fa fa-angle-double-right" aria-hidden="true"></i></a>
							                     </li>
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
	</div>
	<script>
    	let listApp=Vue.createApp({
    		data(){
    			return{
    				wineTcount: 0,
    				list: [],
    				srating: 0,
        			curpage: 1,
        			totalpage: 0,
        			startPage: 0,
        			endPage: 0,
        			sugar: ${search.sugarStars},
        			acid: ${search.acidStars},
        			body: ${search.bodyStars},
        			tannin: ${search.tanninStars},
    				wtypeList: [],
    				selectType: [],
    				foodList: [],
    				selectFoods: [],
    				aromaList:[],
    				selectAroma: [],
    				fprice: 1000000,
    				selectPrice: '${search.price}',
    				searchWine: '',
    				fd:'',
    				sessionId: '${sessionid}'
    			}
    		},
    		mounted(){
    			let selectPrice = '${search.price}'
    			if(selectPrice !== ''){
   				    this.fprice = parseInt(selectPrice.replace(/,/g, ''), 10) * 10000 
    			}
    			let typeStr='${search.type}'    
       			if(typeStr!==''){
	    			typeStr=typeStr.slice(1, typeStr.length-1)
	    			for(s of typeStr.split(',')){
	    				this.selectType.push(s.trim())       				
       				}
    			}
    			let foodStr='${search.food}'
    			if(foodStr!==''){
	    			foodStr=foodStr.slice(1, foodStr.length-1)
	    			for(s of foodStr.split(',')){
	    				this.selectFoods.push(s.trim())
	    			}
    			}
    			let aromaStr='${search.aroma}'
    			if(aromaStr!==''){
	    			aromaStr=aromaStr.slice(1, aromaStr.length-1)
	    			for(s of aromaStr.split(',')){
	    				this.selectAroma.push(s.trim())
	    			}    				
    			}
				this.dataRecv()
        	},
    		methods:{
    	        handleBuyNow(SelectIndex) {
    	        	let wno = this.list[SelectIndex].wno
    	            if (this.sessionId) {
    	                window.location.href = '../shop/buy.do?wno=' + wno;
    	            } else {
    	                alert('로그인 후 사용이 가능합니다.');
    	                window.location.href = '../member/login.do'; 
    	            }
    	        },
    	        handleAddToCart(SelectIndex) {
    	            if (this.sessionId) {	                
    	                this.addToCart(SelectIndex)
    	            } else {
    	                alert('로그인 후 사용이 가능합니다.')
    	                window.location.href = '../member/login.do'
    	            }
    	        },
    	        addToCart(SelectIndex){
    	        	let wno = this.list[SelectIndex].wno
    	        	axios.post('../shop/cart_insert.do',null,{
    	        		params:{
    	        			wno: wno,
    	        			account: 1
    	        		}        		
    	        	}).then(response=>{
    	        		console.log(response.data)
    	        		alert("장바구니에 추가되었습니다.")
    	        	}).catch(error=>{
    	        		console.log(error.response)
    	        	})
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
    			sfw(){
    				this.fd=this.searchWine
    				this.searchWine = ''
    				this.dataRecv()
    			},
    			resetSelect(){
    				this.sugar = 0
    				this.acid = 0
    				this.body = 0
    				this.tannin = 0
    				this.selectFoods = []
    				this.selectAroma = []
    				this.selectType = []
    				this.fprice = 1000000
    				this.searchWine = ''
    				this.dataRecv()
    			},
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
        		filterChange(){
        			this.curpage=1
        			this.dataRecv()
        		},
        		dataRecv(){
        			let typeStr='전체'
        			if(this.selectType.length!==0)
        				typeStr=this.selectType.join(',')
        				
        			let foodStr='전체'
        			if(this.selectFoods.length!==0)
	        			foodStr=this.selectFoods.join(',')
	        			
        			let aromaStr='전체'
        			if(this.selectAroma.length!==0)
	        			aromaStr=this.selectAroma.join(',')
	        		
	        		let fprice_temp = String(this.fprice)
					if(this.fprice > 990000)
					fprice_temp='전체'
					
        			axios.get('../shop/list_vue.do',{
        				params:{
        					page:this.curpage,
        					type : typeStr,
         					food : foodStr,
         					aroma : aromaStr,
                			sugar: this.sugar,
                			acid: this.acid,
                			body: this.body,
                			tannin: this.tannin,
                			price: fprice_temp,
                			fd:this.fd
        				}
        			}).then(response=>{        				
  	     				console.log(response.data)
        				this.list=response.data.list
        				this.curpage=response.data.curpage
        				this.totalpage=response.data.totalpage
        				this.startPage=response.data.startPage
        				this.endPage=response.data.endPage
        				this.wineTcount = response.data.wineTcount       				
        				this.aromaList = response.data.aromaList
        				this.foodList = response.data.foodList
        				this.selectPrice = response.data.selectPrice
            			console.log('검색값 : ' + this.searchWine)
        			}).catch(error=>{
        				console.log(error.response)
        			})
        		}
    		}
    	}).mount('.shopcontainer')
    </script>
</body>
</html>