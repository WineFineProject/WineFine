<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../tem/css/coupon.css">
</head>
<body>
	<div class="promotion_table">
		<h3 class="table-title">진행중인 프로모션</h3>
		<table class="table" id="coupon-table" style="height: 400px;">
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
					<td style="padding: 0px; border: none" colspan="7">
						<div>
							<table style="width: 100%" id="inner-table">
								<tbody>
									<tr v-show="activeBanner.length===0">
										<td colspan="6">진행중인 프로모션이 없습니다</td>
									</tr>
									<tr v-for="vo in activeBanner">
										<td style="padding: 8px" width="23%">{{vo.title}}</td>
										<td width="27%">{{vo.wvo.namekor}}</td>
										<td width="12%">{{vo.stack}}회</td>
										<td width="18%">{{vo.mvo.nickName}}</td>
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
		<h3 class="table-title">대기 프로모션</h3>
		<table class="table" id="coupon-table" style="height: 400px;">
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
				<tr v-show="waitBanner.length===0">
					<td colspan="5">신청대기중인 프로모션이 없습니다</td>
				</tr>
				<tr>
					<td style="padding: 0px; border: none" colspan="7">
						<div>
							<table style="width: 100%" id="inner-table">
								<tbody>
									<tr v-for="(avo, index) in waitBanner">
										<td style="padding: 8px" width="31%">{{avo.title}}</td>
										<td width="35%">{{avo.wvo.namekor}}</td>
										<td width="10%">{{avo.stack}}회</td>
										<td width="16%">{{avo.mvo.nickName}}</td>
										<td width="8%">
											<button class="btn btn-sm border-wine text-wine" type="button" @click="couponApproval(index)">승인</button>
											<button class="btn btn-sm border-wine text-wine" type="button" @click="couponRejection(index)">거절</button>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
		<div class="modal" :class="{ show: showModal }">
			<div class="modal-content" style="height: 200px;">
				<h3 class="text-center">사유 작성</h3>
				<input type="text" v-model="message" ref="message" @keyup.enter="sendMessage()">
			</div>
		</div>
	</div>
	<script>
	let adminCouponApp=Vue.createApp({
		data(){
			return{
				activeBanner:[],
				waitBanner:[],
				showModal:false,
				select:{},
				message:''
			}
		},
		methods:{
			bannerList(){
				axios.get('../admin/vueBannerList.do', null).then(response=>{
					this.activeBanner=response.data.activeBanner
					this.waitBanner=response.data.waitBanner
				})
			},
			couponApproval(index){
				this.select=this.waitBanner[index]
				console.log(this.select)
				axios.get('../admin/vueBannerApproval.do', {
					params:{
						pbno:this.select.pbno
					}
				}).then(response=>{
					alert('승인완료')
					this.subject=this.select.userid+'님 '+this.select.title+' 배너등록 신청이 승인되었습니다'
					this.message=this.select.title+' 배너등록 신청이 승인되었습니다'
					this.sendMessage()
					this.bannerList()
				})
			},
			couponRejection(index){
				this.select=this.waitBanner[index]
				axios.get('../admin/vueBannerRejection.do', {
					params:{
						pbno:this.select.pbno
					}
				}).then(response=>{
					this.showModal=true
					this.subject=this.select.userid+'님 '+this.select.title+' 배너등록 신청이 반려되었습니다'
				})
			},
			sendMessage(){
				if(this.message===''){
					this.$refs.message.focus()
					return
				}
				axios.post('../notice/vueAdminNoticeSend.do', null, {
					params:{
						content:encodeURIComponent(this.message),
						recvid:this.select.userid,
						subject:encodeURIComponent(this.subject),
					}
				}).then(response=>{
					this.showModal=false
					this.select={}
					this.message=''
					this.bannerList()
				})
			}
		},
		mounted(){
			this.bannerList()
		}
	}).mount('.promotion_table')
	</script>
</body>
</html>