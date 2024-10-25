<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.sinfo {
	display: inline-block;
	color: white;
}

.lrectangle {
	padding-top: 25px;
	padding-left: 15px;
	margin-top: 30px;
	width: 550px;
	height: 150px;
	background-color: rgb(166, 70, 90);
	border-radius: 10px;
}

.nrectangle {
	margin-top: 15px;
	border: solid 2px;
	float: right;
	width: 400px;
    height: 200px;
}

#infologo {
	width: 150px;
	height: 100px;
	margin-right: 80px;
}

.snoticeheader {
	position: sticky;
	margin-top: 5px;
	margin-bottom: 5px;
	text-align: center;
	font-weight: bold;
	color:darkred;
	font-size: 18px;
	
}

.snoticesub {
	height: 160px;
	overflow-y: auto;
	text-decoration: underline;
	margin-left: 10px;
	font-size: 17px;
	line-height: 1.8 !important;
	cursor: pointer;
}
.modal-header{
	display: inline-block;
	padding-bottom : 0px;
}
.snoticesub::-webkit-scrollbar {
    width: 6px;
}
.snoticesub::-webkit-scrollbar-thumb {
    background: darkred;
    border-radius: 10px;
}
#noticeModalLabel{
	display: inline-block;
}
.swinename{
	white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;	
}
.wine-type {
	display: inline-block;
	padding: 3px 8px; 
	border-radius: 10px; 
	font-weight: bold;
	font-size: 14px; 
}

.type-red {
	color: #fff;
	background-color: #bb2d3b;
	border: 1px solid #dc3545; 
}

.type-white {
	color: #000000;
	background-color: #ffffff;
	border: 1px solid #000000;
}

.type-spark {
	color: #000000;
	background-color: #b4c5fe;
	border: 1px solid #b4c5fe;
}

.type-rose {
	color: #000000;
	background-color: #ffc1e0;
	border: 1px solid #ffc1e0;
}

.type-alcohol {
	color: #000000;
	background-color: #8dc7c7;
	border: 1px solid #8dc7c7; 
}

.type-etc {
	color: #000000;
	background-color: #8dc7c7;
	border: 1px solid #8dc7c7; 
}
#sellerShop{
	width:1100px;
}
</style>
</head>
<body>
	<div class="container" id="sellerShop">
		<div class="row mb-4">
			<div class="col-lg-7">
				<div class="lrectangle" style="">
					<img :src=photo class="sinfo" id="infologo" />
					<h4 class="sinfo">{{username}}</h4>
				</div>
			</div>
			<div class="col-lg-5">
				<div class="nrectangle">
					<div class="snoticeheader">
						<span>판매자 공지</span>
					</div>
					<div class="snoticesub">
						<div v-for="vo in nList" :key="vo.nbno">
							<span @click="changeModal(true, vo)">{{vo.subject}}</span>
						</div>
					</div>
				</div>
			</div>
			
		</div>
		<div class="col-lg-12">
			<div class="row g-4 justify-content-center">
				<div class="col-lg-3" style="margin-bottom: 10px; margin-top: 10px;"
					v-for="wvo in wList">
					<a :href="'../shop/detailBefore.do?wno=' + wvo.wno">
					<div class="rounded position-relative fruite-item">
						<div class="fruite-img text-center"
							style="border: 1px solid darkred; border-radius: 10px 10px 0 0; over-flow: hidden; border-bottom: none;">
							<img :src="wvo.poster" class="img-fluid rounded-top"
								style="width: 150px; height: 200px; object-fit: contain; margin-top:8px;">
						</div>
						<div
							class="wine-type px-3 py-1 rounded position-absolute"
							:class="{'type-red': wvo.type === '레드','type-white': wvo.type === '화이트','type-spark': wvo.type === '스파클링','type-rose': wvo.type === '로제',
							'type-alcohol': wvo.type === '주정강화','type-etc': wvo.type === '기타', 'type-etc' : wvo.type === '고도주' }"
							style="top: 10px; left: 10px;">{{wvo.type}}</div>
						<div class="p-3 border border-wine border-top-0 rounded-bottom">
							<h6 class="swinename">{{wvo.namekor}}</h6>
							<p class="swinename text-hidden">
								<small>{{wvo.nameeng}}</small>
							</p>
							<div class="d-flex justify-content-between flex-lg-wrap">
								<p class="text-dark fw-bold mb-0 fs-6">{{wvo.price}}</p>
							</div>
						</div>
					</div>
				  </a>
				</div>
				<div class="text-center">
					<button type="button"
						class="btn border border-wine rounded-pill px-3 text-wine"
						@click="moreInfo()" style="margin-bottom:40px; margin-top:10px;">더보기</button>
				</div>
			</div>
		</div>
	<div class="modal" :class="{ show: showModal }"
		@click.self="changeModal(false)">
		<div class="modal-content" style="height: 485px; width: 800px;">
			<span class="close" @click="changeModal(false)">&times;</span>
			<div class="modal-header">
				 <div v-if="selectedNotice.type === 1">
					<p>&#128312; 전체 공지</p>
				  </div>
				  <div v-else-if="selectedNotice.type === 2">
					<p>&#128312; [ {{ getTargetName(selectedNotice.target) }} ] 카테고리 공지</p>
				  </div>
				  <div v-else-if="selectedNotice.type === 3">
					<p>&#128312; [ {{ wineName }} ] 공지</p>
				  </div>
				 <div>
				<h5 class="modal-title" id="noticeModalLabel">{{selectedNotice.subject}}</h5>
					<p style="text-align:right;font-size:14px;margin-bottom:10px;">{{selectedNotice.dbday}}</p>
				</div>
			</div>
			<div class="modal-body">
				<div>
					<p>{{ selectedNotice.content }}</p>
				</div>
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
			wineName:'',
			selectedNotice: {},
			end:8,
			showModal:false
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
				
			}).catch(error => {
			    console.log(error.response)
			})
		},
		changeModal(check, notice=null){
			this.showModal=check
			if (notice) {
		        this.selectedNotice = notice
		    }
			if (check && this.selectedNotice.type === 3) {
		        this.getWineName()
		    }
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
        getWineName()
        {
        	axios.get('../seller/swinename_vue.do', {
				params:{ target:this.selectedNotice.target}
        	}).then(response=>{
        		this.wineName = response.data
				
			}).catch(error => {
			    console.log(error.response)
			})
        },
        sellerWineList()
		{
			axios.get('../seller/swineList_vue.do', {
				params:{ id:this.id, end:this.end}
			}).then(response=>{
				this.wList=response.data
				
			}).catch(error => {
			    console.log(error.response)
			})
		},
		moreInfo(){
			this.end=this.end+8
			this.sellerWineList()
		}
	}
 }).mount('#sellerShop')
</script>
</body>
</html>