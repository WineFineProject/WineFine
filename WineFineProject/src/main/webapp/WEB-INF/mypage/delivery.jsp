<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
</head>
<body>
	<div id="deliveryApp">
		<h3>배송지 관리</h3>
		<div style="text-align: right;">
			<button type="button" @click="changeModal(true)">등록</button>
		</div>
		<table class="table" style="height: 600px;">
			<tr v-for="vo in list">
				<td>
					<table class="table">
						<tr>
						<th width="20%">배송지명</th>
							<td width="80%" style="text-align: left;">{{vo.name}}</td>
						</tr>
						<tr>
						<th width="20%">우편번호</th>
							<td width="80%" style="text-align: left;">{{vo.post}}</td>
						</tr>
						<tr>
						<th width="20%">주소</th>
							<td width="80%" style="text-align: left;">{{vo.addr1}}</td>
						</tr>
						<tr>
						<th width="20%">상세주소</th>
							<td width="80%" style="text-align: left;">{{vo.addr2}}</td>
						</tr>
						<tr>
						<th width="20%">전달사항</th>
							<td width="80%" style="text-align: left;">{{vo.msg}}</td>
						</tr>
						<tr>
							<td colspan="2" style="text-align: right;">
							<span class="btn btn-sm btn-success" v-show="vo.state===1">기본배송지</span>
								<button type="button" class="btn btn-sm btn-success" @click="stateUpdate(vo.wdno)" v-show="vo.state===0">기본배송지로 설정</button>
								<button type="button" class="btn btn-sm btn-primary" @click="myDelete(vo.wdno)" v-show="vo.state===0">삭제</button>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<div class="modal" :class="{ show: showModal }" @click.self="changeModal(false)">
			<div class="modal-content" style="height: 470px;">
				<h3 class="text-center">배송지 등록</h3>
				<table class="table">
					<tr>
						<td style="text-align: left;"><input type="text" v-model="name" ref="name" placeholder="배송지명"></td>
					</tr>
					<tr>
						<td style="text-align: left;"><input style="width: 30%; margin-right: 10px;" type="text" v-model="post" ref="name" size="10" placeholder="우편번호" disabled>
							<button type="button" class="btn btn-sm btn-info" @click="postFind()">주소검색</button></td>
					</tr>
					<tr>
						<td style="text-align: left;"><input style="width: 100%" type="text" v-model="addr1" placeholder="주소" disabled></td>
					</tr>
					<tr>
						<td style="text-align: left;"><input style="width: 100%" type="text" v-model="addr2" placeholder="상세주소"></td>
					</tr>
					<tr>
						<td style="text-align: left;"><textarea style="width: 100%; resize: none;" rows="3" placeholder="전달사항" v-model="msg"></textarea></td>
					</tr>
					<tr>
						<td style="text-align: left;"><label><input type="checkbox" v-model="isBase">기본 배송지로 설정</label></td>
					</tr>
				</table>
				<div style="text-align: right;">
					<button class="btn btn-sm btn-success" @click="deliveryInsert()">등록</button>
					<button type="button" class="btn btn-sm btn-primary" @click="changeModal(false)">취소</button>
				</div>
			</div>
		</div>
	</div>
	<script>
		let myDeliveryApp=Vue.createApp({
			data(){
				return{
					list:[],
					name:'',
					post:'',
					addr1:'',
					addr2:'',
					msg:'',
					isBase:false,
					showModal:false
				}
			},
			methods:{
				postFind(){
					let _this=this
					new daum.Postcode({
						oncomplete:function(data){
							 _this.post=data.zonecode
							 _this.addr1=data.address
						}
					}).open()
				},
				deliveryList(){
					axios.get('../delivery/vueDeliveryList.do').then(response=>{
						this.list=response.data
					})
				},
				stateUpdate(wdno){
					axios.get('../delivery/vueDeliveryStateUpdate.do', {
						params:{
							wdno:wdno
						}
					}).then(response=>{
						this.deliveryList()
					})
				},
				myDelete(wdno){
					axios.get('../delivery/vueDeliveryDelete.do', {
						params:{
							wdno:wdno
						}
					}).then(response=>{
						this.deliveryList()
					})
				},
				changeModal(check){
					if(check===false){
						this.msg=''
						this.name=''
						this.post=''
						this.addr1=''
						this.addr2=''
						this.isBase=false
					}
					changeModal(this, check)
				},
				deliveryInsert(){
					if(this.name===''){
						alter('배송지명을 입력하세요')
						return
					}
					if(this.post===''){
						alter('배송주소를 입력하세요')
						return
					}
					let state=this.isBase?1:0
					console.log(state)
					axios.post('../delivery/vueDeliveryInsert.do', null, {
						params:{
							name:this.name,
							post:this.post,
							addr1:this.addr1,
							addr2:this.addr2,
							msg:this.msg,
							state:state
						}
					}).then(response=>{
						this.deliveryList()
					})
				}
			},
			mounted(){
				this.deliveryList()
			}
		}).mount('#deliveryApp')
	</script>
</body>
</html>