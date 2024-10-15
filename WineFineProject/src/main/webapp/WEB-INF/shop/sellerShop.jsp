<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.sinfo{
	display:inline-block;
	color:white;
}
.lrectangle{
	padding-top: 25px;
	padding-left: 15px;
	margin-top:30px;
	width: 600px; 
	height: 150px;
	background-color: rgb(166,70,90);
	border-radius: 10px;
}
.nrectangle{
    margin-top:15px;
    border: solid 2px;
    float: right;
}
#infologo{
	width:150px;
	height:100px;
	margin-right:80px;
}
.snoticeheader{
	position: sticky;
	margin-top:5px;
	margin-bottom:5px;
	text-align: center;
	font-weight: bold;
}
.snoticesub{
	height: 160px;
	overflow-y: auto;
	text-decoration: underline;
	margin-left:10px;
	font-size: 17px;
	line-height: 1.8 !important;
	cursor: pointer;
}
</style>
</head>
<body>
	<div class="container" id="sellerShop">
		<div class="row mb-4">
			<div class="col-lg-7">
				<div class="lrectangle" style="">
					<img :src=photo class="sinfo" id="infologo"/><h4 class="sinfo">{{username}}</h4>
				</div>
			</div>
			<div class="col-lg-5">
				<div class="nrectangle" style="width: 400px; height: 200px;">
				  <div class="snoticeheader">
					<span>판매자 공지</span>
				  </div>
				   <div class="snoticesub">
					 <div v-for="vo in nList" :key="vo.nbno">
						<span @click="openModal(vo)">{{vo.subject}}</span>
					 </div>
					</div>
				</div>
			</div>
			<div class="modal fade" id="noticeModal" tabindex="-1"
				aria-labelledby="noticeModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="noticeModalLabel">{{selectedNotice.subject }}</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<div v-if="selectedNotice.type === 1">
								<p> &#128312; 전체 공지</p>
								<p>{{ selectedNotice.content }}</p>
							</div>
							<div v-else-if="selectedNotice.type === 2">
								<p> &#128312; [{{ getTargetName(selectedNotice.target) }}] 공지 </p>
								<p>{{ selectedNotice.content }}</p>
							</div>
							<div v-else-if="selectedNotice.type === 3">
								<p>&#128312; 특정 와인 공지</p>
								<p>{{ selectedNotice.content }}</p>
							</div>
							<div v-else>
								<p>알 수 없는 공지 유형입니다.</p>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">닫기</button>
						</div>
					</div>
				</div>
			</div>
	</div>
			<div class="col-lg-12">
			<div class="row g-4 justify-content-center">
				<div class="col-lg-3" style="margin-bottom: 10px; margin-top:10px;"
					v-for="wvo in wList">
					<div class="rounded position-relative fruite-item">
						<div class="fruite-img text-center" style="border: 1px solid darkred; border-radius: 10px 10px 0 0; over-flow:hidden; border-bottom:none;">
							<img :src="wvo.poster" class="img-fluid rounded-top"
								style="width:150px;height:220px;object-fit: contain;">
						</div>
						<div
							class="text-white bg-wine px-3 py-1 rounded position-absolute"
							style="top: 10px; left: 10px;">{{wvo.type}}</div>
						<div class="p-3 border border-wine border-top-0 rounded-bottom">
							<h6>
								{{wvo.namekor}}
							</h6>
							<p class="text-hidden">
								<small>{{wvo.nameeng}}</small>
							</p>
							<div class="d-flex justify-content-between flex-lg-wrap">
								<p class="text-dark fw-bold mb-0 fs-6">{{wvo.price}}</p>
								<a href="#"
									class="btn border border-wine rounded-pill px-3 text-wine"><i
									class="fa fa-shopping-bag me-2 text-wine"></i> Add to cart</a>
							</div>
						</div>
					</div>
				</div>
				<div class="text-center">
					<button type="button"
						class="btn border border-wine rounded-pill px-3 text-wine"
						@click="moreInfo()">더보기</button>
				</div>
			</div>
		</div>
  </div>
<script>
let sellershopApp=Vue.createApp({
	data(){
		return {
			nList:[],
			wList:[],
			username:'',
			photo:'',
			id:'',
			selectedNotice: {} 
		}
	},  
	mounted(){
		this.getIdFromUrl()
		this.sellerInfo()
		this.sellerNotice()
		this.sellerWineList()
	},
	methods:{
	   getIdFromUrl() {
		        const url = window.location.href
		        const urlParams = new URL(url).searchParams
	            this.id = urlParams.get('id')
	    },
		sellerInfo()
		{
			axios.get('../seller/info_vue.do', {
				params:{ id:this.id}
			}).then(response=>{
				this.username=response.data.userName
				this.photo = response.data.photo
			}).catch(error => {
			    console.log(error.response)
			})
		},
		sellerNotice()
		{
			axios.get('../seller/snotice_vue.do', {
				params:{ id:this.id}
			}).then(response=>{
				this.nList=response.data
				console.log(response.data)
			}).catch(error => {
			    console.log(error.response)
			})
		},
		openModal(notice) {
            this.selectedNotice = notice; // 선택된 공지 저장
            const modal = new bootstrap.Modal(document.getElementById('noticeModal'));
            modal.show(); // 모달 열기
        },
        getTargetName(target) {
            switch (target) {
                case 1: return '레드'
                case 2: return '화이트'
                case 3: return '스파클링'
                case 4: return '로제'
                case 5: return '주정강화'
                case 6: return '기타'
            }
        },
        sellerWineList()
		{
			axios.get('../seller/swineList_vue.do', {
				params:{ id:this.id}
			}).then(response=>{
				this.wList=response.data
				console.log(response.data)
			}).catch(error => {
			    console.log(error.response)
			})
		},
	}
 }).mount('#sellerShop')
</script>
</body>
</html>