<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://unpkg.com/vue@3"></script>
<script src="http://unpkg.com/axios/dist/axios.min.js"></script>
</head>
<body>
<!-- Cart Header start -->
        <div class="container-fluid page-header py-5">
            <h1 class="text-center text-white display-6">장바구니</h1>
            <ol class="breadcrumb justify-content-center mb-0">
            </ol>
        </div>
        <!-- Cart Header End -->


        <!-- Cart Area -->
        <div class="container-fluid py-5">
            <div class="container py-5">        
            <div class="row">
            	<div class="col-lg-9">
                <div class="table-responsive" id="cartListTable">
                    <table class="table">
                        <thead>
                          <tr>
                            <th scope="col"></th>
                            <th scope="col"></th>
                            <th scope="col"></th>
                            <th scope="col"></th>
                            <th scope="col"></th>
                            <th scope="col"></th>
                          </tr>
                        </thead>
                        
                        <tbody> 
                            <tr v-for="wine in wines" :key="wine.wno">
                                <th scope="row">
                                    <div class="d-flex align-items-center">
                                        <img :src="wine.poster" class="img-fluid me-5 rounded-circle" style="width: 80px; height: 80px;">
                                    </div>
                                </th>
                                <td>
                                    <p class="mb-0 mt-4"><b style="font-size: 1.2em">{{wine.namekor}}</b></p><br>
                                    <p class="mb-0 mt-4">{{wine.seller}}</p>
                                </td>
                                <td>
                                    <p class="mb-0 mt-4">{{wine.price}}</p>
                                </td>
                                <td>
                                    <div class="input-group quantity mt-4" style="width: 100px;">
                                        <div class="input-group-btn">
                                            <button @click="minus(wine)" class="btn btn-sm btn-minus rounded-circle bg-light border" >
                         	                   <i class="fa fa-minus"></i>
                                            </button>
                                        </div>
                                        <input type="text" class="form-control form-control-sm text-center border-0" v-model="count">
                                        <div class="input-group-btn">
                                            <button @click="plus(wine)" class="btn btn-sm btn-plus rounded-circle bg-light border">
                                                <i class="fa fa-plus"></i>
                                            </button>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <p class="mb-0 mt-4">{{onePrice(wine)}}</p>
                                </td>
                                <td>
                                    <button @:click="drop()"class="btn btn-md rounded-circle bg-light border mt-4" >
                                        <i class="fa fa-times text-danger"></i>
                                    </button>
                                </td>
                            </tr>
                        </tbody>  
                    </table>
                </div>
				</div>
				
				<div class="col-lg-3">
                        <div class="bg-light rounded">
                            <div class="p-4">
                                <h1 class="display-6 mb-4">Cart <span class="fw-normal">Total</span></h1>
                                <div class="d-flex justify-content-between mb-4">
                                    <h5 class="mb-0 me-4">상품 가격</h5>
                                    <p class="mb-0">{{totalPrice()}}</p>
                                </div>
                                <div class="d-flex justify-content-between">
                                    <h5 class="mb-0 me-4">Shipping</h5>
                                    <div class="">
                                        <p class="mb-0">Flat rate: $3.00</p>
                                    </div>
                                </div>
                                <p class="mb-0 text-end">Shipping to Ukraine.</p>
                            </div>
                            <div class="py-4 mb-4 border-top border-bottom d-flex justify-content-between">
                                <h5 class="mb-0 ps-4 me-4">Total</h5>
                                <p class="mb-0 pe-4">$99.00</p>
                            </div>
                            <button class="btn border-secondary rounded-pill px-4 py-3 text-primary text-uppercase mb-4 ms-4" type="button">결제하기</button>
                        </div>
                    </div>
                    
                    </div>                    
                </div>
            </div>
    
        <!-- Cart Area End -->
</body>
<script>
	let cartListApp=Vue.createApp({
		data(){
			return {
				wines:[],
				cno:''
			}
		},
		mounted(){
			this.dataRecv()
		},	
		computed:{
			totalPrice(){
				return this.wines.reduce((total,wine)=>{
					return total + (wine.price * wine.count)
				},0)
			}
		},
		methods:{
			plus(wine){
				wine.count++;
				this.updateCart(wine)
			},
			minus(wine){
				if(wine.count>1){
				wine.count--;
				this.updateCart(wine)
				}
			},
			/* drop(){
				axios.get("../inMyCartDrop_vue.do", {
			        params: { 
			        	cno: this.cno 
			        	}
			      }).then(() => {
			        console.log("장바구니에서 삭제되었습니다");
			        
			      }).catch(error => {
			        console.error("error-Drop", error);
			      })
				},		 */			
			/* updateCart(wine){
				axios.post("../updateCart_vue.do", {
			        wno: wine.wno,
			        count: wine.count
			      }).then(() => {
			        console.log("수량 변경 완료");
			      }).catch(error => {
			        console.error("수량변경 오류", error);
			      })
			}, */
			onePrice(wine){
				return wine.count * wine.price
			},
			dataRecv(){
				axios.get("../cart/inMyCart_vue.do"
				).then(response => {
					console.log(response.data)
					this.wines=response.data.cartListData
					//this.cno=response.data.cno
				}).catch(error => {
					console.error("error-dataRecv()",error)
				})				
			}
		}			
	}).mount('#cartListTable')
</script>
</html>