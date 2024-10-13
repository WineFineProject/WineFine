<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 목록</title>
<link rel="stylesheet" href="../tem/css/memberlist.css">
</head>
<body>
	<div id="list" class="row">
		<h3 class="text-center" style="width: 80%">회원 관리</h3>
		<table class="table" style="margin-top: 20px">
			<thead class="text-center">
				<tr>
					<th>번호</th>
					<th>아이디</th>
					<th>닉네임</th>
					<th>이름</th>
					<th>이메일</th>
					<th>성별</th>
					<th>휴대폰번호</th>
					<th>등급</th>
					<th>가입일</th>
					<th>관리</th>
				</tr>
			</thead>
			<tbody class="text-center">
				<tr v-for="(vo, index) in members" :key="vo.userId" style="vertical-align: middle;">
					<td>{{index+1}}</td>
					<td>{{vo.userId}}</td>
					<td>{{vo.nickName}}</td>
					<td>{{vo.userName}}</td>
					<td>{{vo.email}}</td>
					<td>{{vo.sex}}</td>
					<td>{{vo.phone}}</td>
					<td>{{vo.grade}}</td>
					<td>{{vo.regday}}</td>
					<td>
						<button type="button" class="btn btn-sm btn-danger" id="blackListBtn" @click="blackListInsert(vo.userId)">블랙리스트</button>
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
        let memberListApp=Vue.createApp({
            data() {
                return {
                    members:[],
                    tmp:'',
                    showModal:false,
                    message:''
                }
            },
            mounted() {
                this.mList()
            },
            methods: {
            	sendMessage(){
            		if(this.message===''){
    					this.$refs.message.focus()
    					return
    				}
            		console.log(this.tmp)
    				axios.post('../seller/blackListInsert.do', null, {
    					params:{
    						content:this.message,
    						recvid:this.tmp
    					}
    				}).then(response=>{
    					this.showModal=false
    				})
    				axios.post('../notice/vueSellerNoticeSend.do',null,{
    					params:{
    						content:this.message,
    						recvid:this.tmp,
    						subject:'블랙리스트 등록 안내 공지'
    					}
    				}).then(response=>{
    					this.message=''
    					this.tmp=''
    					this.showModal=false
    				})
            	},
                mList(){
                    axios.get('../seller/memberListVue.do') 
                        .then(response=>{
                            this.members=response.data.members
                        })
                        .catch(error=>{
                            alert(error.response)
                            console.log(error.response)
                        })
                },
                blackListInsert(id){
                	this.tmp=id
                	this.showModal=true
                }
            }
        }).mount('#list')
    </script>
</body>
</html>