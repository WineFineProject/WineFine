<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../tem/css/delivery.css">
<script type="text/javascript" src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
</head>
<body>
	<div id="deliveryApp">
		<h3>배송지 관리</h3>
		<div style="text-align: right;">
			<button type="button" class="btn btn-sm btn-warning" @click="changeModal(true)" style="margin-bottom: 10px">등록</button>
		</div>
		<table class="table" style="height: 600px;">
			<tr v-for="vo in list">
				<td>
					<table class="table" id="tt">
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
							<span class="btn btn-sm btn-del" v-show="vo.state===1">기본배송지</span>
								<button type="button" class="btn btn-sm btn-del" @click="stateUpdate(vo.wdno)" v-show="vo.state===0">기본배송지로 설정</button>
								<button type="button" class="btn btn-sm btn-wine" @click="myDelete(vo.wdno)" v-show="vo.state===0">삭제</button>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<div class="modal" :class="{ show: showModal }" @click.self="changeModal(false)">
			<div class="modal-content" style="height: 600px;">
				<h4 class="text-center">배송지 등록</h4>
					<div class="mb-3" style="text-align: left;">
                        <label class="label">배송지명</label>
						<input type="text" v-model="name" ref="name" class="form-control">
                    </div>
                    <div class="mb-3" style="text-align: left;">    
                        <label class="label">우편번호</label><br>
						<input style="width: 30%; margin-right: 10px; display: inline-block;" type="text" v-model="post" ref="name" size="10" class="form-control" disabled><button type="button" class="btn btn-sm btn-warning" @click="postFind()">주소검색</button>
                    </div>
					<div class="mb-3" style="text-align: left;">
                        <label class="label">주소</label>
						<input style="width: 100%" type="text" v-model="addr1" class="form-control" disabled>
                    </div>
					<div class="mb-3" style="text-align: left;">
                        <label class="label">상세주소</label>
						<input style="width: 100%" type="text" v-model="addr2" class="form-control">
                    </div>
					<div class="mb-3" style="text-align: left;">
                        <label class="label">전달사항</label>
						<textarea style="width: 100%; resize: none;" rows="3" v-model="msg" class="form-control"></textarea>
                    </div>
					<div class="mb-3" style="text-align: left;">
						<label><input type="checkbox" v-model="isBase">기본 배송지로 설정</label>
                    </div>
				<div style="text-align: right;">
					<button class="btn btn-sm btn-del" @click="deliveryInsert()">등록</button>
					<button type="button" class="btn btn-sm btn-wine" @click="changeModal(false)">취소</button>
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
					addrEng:'',
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
							 _this.addrEng=data.sidoEnglish
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
							addrEng:this.addrEng,
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