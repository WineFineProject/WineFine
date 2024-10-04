<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.promotion_table {
	width: 1500px;
}
</style>
</head>
<body>
	<div id="promotionTable">
		<div class="promotion_table">
			<table class="table">
				<tr>
					<td colspan="6" class="text-left">
						<button @click="changeModal(true)" type="button">프로모션 등록</button>
					</td>
				</tr>
			</table>
			<h3>진행중인 프로모션</h3>
			<table class="table" style="height: 400px;">
				<thead>
					<tr>
						<th width="23%">이벤트명</th>
						<th width="27%">대상상품</th>
						<th width="12%">남은노출횟수</th>
						<th width="18%">업체명</th>
						<th width="12%">시작일</th>
						<th width="8%"></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td colspan="7">
							<div>
								<table style="width: 100%">
									<tbody>
										<tr v-for="vo in activeBanner">
											<td width="23%">{{vo.title}}</td>
											<td width="27%">{{vo.wvo.namekor}}</td>
											<td width="12%">{{vo.stack}}회</td>
											<td width="18%">{{vo.userid}}</td>
											<td width="12%">{{vo.startDay}}</td>
											<td width="8%"></td>
										</tr>
									</tbody>
								</table>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
			<h3>승인 대기 프로모션</h3>
			<table class="table" style="height: 400px;">
				<thead>
					<tr>
						<th width="31%">이벤트명</th>
						<th width="35%">대상상품</th>
						<th width="10%">신청 횟수</th>
						<th width="16%">업체명</th>
						<th width="8%"></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td colspan="7">
							<div>
								<table style="width: 100%">
									<tbody>
										<tr v-for="avo in waitBanner">
											<td width="31%">{{avo.title}}</td>
											<td width="35%">{{avo.wvo.namekor}}</td>
											<td width="10%">{{avo.stack}}회</td>
											<td width="16%">{{avo.userid}}</td>
											<td width="8%">
												<button class="btn btn-sm border-wine text-wine" type="button" @click="couponApproval(avo.pcno)">승인</button>
												<button class="btn btn-sm border-wine text-wine" type="button" @click="couponRejection(avo.pcno)">거절</button>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="modal" :class="{ show: showModal }" @click.self="changeModal(false)">
			<div class="modal-content" style="height: 485px;">
				<span class="close" @click="changeModal(false)">&times;</span>
			</div>
		</div>
	</div>
	<script>
	let bannerApp=Vue.createApp({
		data(){
			return{
				showModal:false,
				list:[],
				no:0,
				fd:'',
				count:0,
				isFd:false,
				isBtn:false,
				startDate:'',
				eventName:'',
				option:1,
				isFind:false,
				activeBanner:[],
				waitBanner:[]
			}
		},
		mounted(){
			this.promotionList()
		},
		methods:{
			changeModal(check){
				if(check===false){
					this.no=0
					this.fd=''
					this.count=0
					this.isFd=false
					this.isBtn=false
					this.startDate=''
					this.eventName=''
					this.option=1
					this.isFind=false
					this.list=[]
				}
				changeModal(this, check)
			},
			changeNo(index){
				this.no=this.list[index].wno
				this.isFd=true
				this.isFind=false
				this.fd=this.list[index].namekor
			},
			checkBtn(){
				if(this.eventName===''){
					this.isBtn=false
					return
				}
				if(this.count===0){
					this.isBtn=false
					return
				}
				this.isBtn=true
			},
			findWine_(){
				findWine(this)
			},
			insertPromotion(){
				axios.post('../seller/vueBannerInsert.do', null, {
					params:{
						title:this.eventName,
						stack:this.count,
						wno:this.no,
						type:this.option
					}
				}).then(response=>{
					alert('등록 완료')
					this.changeModal(false)
					this.promotionList()
				})
			},
			promotionList(){
				axios.get('../seller/vueBannerList.do', null).then(response=>{
					this.activeBanner=response.data.activeBanner
					this.waitBanner=response.data.waitBanner
				})
			}
		}
	}).mount('#promotionTable')
	</script>
</body>
</html>