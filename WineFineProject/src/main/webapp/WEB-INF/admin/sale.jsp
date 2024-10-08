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
	<div class="promotion_table">
		<h3>진행중인 프로모션</h3>
		<table class="table" style="height: 400px;">
			<thead>
				<tr>
					<th width="21%">이벤트명</th>
					<th width="25%">대상상품</th>
					<th width="10%">할인율</th>
					<th width="16%">업체명</th>
					<th width="10%">시작일</th>
					<th width="10%">종료일</th>
					<th width="8%"></th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td colspan="7">
						<div>
							<table style="width: 100%">
								<tbody>
									<tr v-for="vo in activeSale">
										<td width="21%">{{vo.title}}</td>
										<td width="25%">{{vo.targetname}}</td>
										<td width="10%">{{vo.discount}}%</td>
										<td width="16%">{{vo.mvo.nickName}}</td>
										<td width="10%">{{vo.startDay}}</td>
										<td width="10%">{{vo.endDay}}</td>
										<td width="8%"></td>
									</tr>
								</tbody>
							</table>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
		<h3>대기 프로모션</h3>
		<table class="table" style="height: 400px;">
			<thead>
				<tr>
					<th width="21%">이벤트명</th>
					<th width="25%">대상상품</th>
					<th width="10%">할인율</th>
					<th width="16%">업체명</th>
					<th width="10%">시작일</th>
					<th width="10%">종료일</th>
					<th width="8%"></th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td colspan="7">
						<div>
							<table style="width: 100%">
								<tbody>
									<tr v-for="(avo, index) in waitSale">
										<td width="21%">{{avo.title}}</td>
										<td width="25%">{{avo.targetname}}</td>
										<td width="10%">{{avo.discount}}%</td>
										<td width="16%">{{avo.mvo.nickName}}</td>
										<td width="10%">{{avo.startDay}}</td>
										<td width="10%">{{avo.endDay}}</td>
										<td width="8%">
											<button class="btn btn-sm border-wine text-wine" type="button" @click="saleApproval(index)">승인</button>
											<button class="btn btn-sm border-wine text-wine" type="button" @click="saleRejection(index)">거절</button>
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
				activeSale:[],
				waitSale:[],
				showModal:false,
				select:{},
				message:''
			}
		},
		methods:{
			saleList(){
				axios.get('../admin/vueSaleList.do', null).then(response=>{
					this.activeSale=response.data.activeSale
					this.waitSale=response.data.waitSale
				})
			},
			saleApproval(index){
				this.select=this.waitSale[index]
				axios.get('../admin/vueSaleApproval.do', {
					params:{
						psno:this.select.psno
					}
				}).then(response=>{
					alert('승인완료')
					this.subject=this.select.userid+'님 '+this.select.title+' 할인 신청이 승인되었습니다'
					this.message=this.select.title+' 할인 신청이 승인되었습니다'
					this.sendMessage()
					this.saleList()
				})
			},
			saleRejection(index){
				this.select=this.waitSale[index]
				axios.get('../admin/vueSaleRejection.do', {
					params:{
						psno:this.select.psno
					}
				}).then(response=>{
					this.showModal=true
				})
			},
			sendMessage(){
				if(this.message===''){
					this.$refs.message.focus()
					return
				}
				axios.post('../notice/vueAdminNoticeSend.do', null, {
					params:{
						content:this.message,
						recvid:this.select.userid,
						subject:this.select.userid+'님 할인 신청이 반려되었습니다',
					}
				}).then(response=>{
					this.showModal=false
					this.select={}
					this.message=''
					this.saleList()
				})
			}
		},
		mounted(){
			this.saleList()
		}
	}).mount('.promotion_table')
	</script>
</body>
</html>