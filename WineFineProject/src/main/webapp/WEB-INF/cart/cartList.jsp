<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../tem/css/cart.css">
</head>
<body>
	<div class="container-fluid page-header py-5">
		<h1 class="text-center text-white display-6">장바구니</h1>
		<ol class="breadcrumb justify-content-center mb-0">
		</ol>
	</div>
	<div class="container-fluid py-5">
		<div class="container py-5">
			<div class="row">
					<div class="table-responsive" id="cartListApp">
						<table class="table mp">
							<thead>
								<tr>
									<th width="5%" scope="col">번호</th>
									<th width="5%" scope="col"></th>
									<th width="35%" scope="col">제품명</th>
									<th width="20%" scope="col">업체명</th>
									<th width="10%" scope="col">가격</th>
									<th width="5%" scope="col">개수</th>
									<th width="10%" scope="col">추가일</th>
									<th width="10%" scope="col"></th>
								</tr>
							</thead>
							<tbody>
							<tr v-if="list.length===0"><td colspan="8">추가한 상품이 없습니다</td></tr>
								<tr v-for="vo in list">
									<td>
										<p class="mb-0 mt-4">{{vo.cno}}</p>
									</td>
									<td scope="row">
										<div class="d-flex align-items-center">
											<a :href="'../shop/detailBefore.do?wno='+vo.wno"><img :src="vo.wvo.poster" class="img-fluid me-5 rounded-circle" style="width: 80px; height: 80px;"></a>
										</div>
									</td>
									<td class="scrollable-text">
										<p class="mb-0 mt-4">
											<b style="font-size: 1.2em"><a :href="'../shop/detailBefore.do?wno='+vo.wno">{{vo.wvo.namekor}}</a></b>
										</p>
									</td>
									<td>
										<p class="mb-0 mt-4">{{vo.wvo.mvo.nickName}}</p>
									</td>
									<td>
										<p class="mb-0 mt-4">{{vo.wvo.price}}</p>
									</td>
									<td>
										<p class="mb-0 mt-4">{{vo.account}}</p>
									</td>
									<td>
										<p class="mb-0 mt-4">{{vo.dbday}}</p>
									</td>
									<td class="text-center">
										<button style="margin:0px !important" @:click="deleteCart(vo.cno)" class="btn btn-md rounded-circle bg-light border mt-4">
											<i class="fa fa-times text-danger"></i>
										</button>
										<a style="margin:0px !important" :href="'../shop/buy.do?wno='+vo.wno+'&account='+vo.account" class="btn btn-md rounded-circle bg-light border mt-4">
										<i class="fa fa-credit-card"></i>
										</a>
									</td>
								</tr>
							</tbody>
						</table>
						<div class="text-center">
						<button class="btn btn-sm btn-wine" @click="cList(curPage>1?curPage-1:curPage)">이전</button>
						{{curPage}}page/{{totalPage}}page
						<button class="btn btn-sm btn-wine" @click="cList(curPage<totalPage?curPage+1:curPage)">다음</button>
						</div>
					</div>
			</div>
		</div>
	</div>

	<script>
let cartListApp=Vue.createApp({
	data(){
		return{
			list:[],
			selected:{},
			curPage:1,
			totalPage:1
		}
	},
	methods:{
		cList(page){
			axios.get('../cart/vueMyCart.do', {
				params:{
					page:page
				}
			}).then(response=>{
				this.list=response.data.list
				curPage=response.data.curPage
				totalPage=response.data.totalPage
			})
		},
		deleteCart(cno){
			axios.get('../cart/vueCartDelete.do', {
				params:{
					cno:cno
				}
			}).then(response=>{
				this.cList(1)
			})
		}
	},
	mounted(){
		this.cList(1)
	}
}).mount('#cartListApp')
</script>
</body>
</html>