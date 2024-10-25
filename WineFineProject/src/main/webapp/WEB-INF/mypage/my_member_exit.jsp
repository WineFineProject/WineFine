<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../tem/css/payment.css">
<style>
.exitcontent{
    width: 90%;
    margin-left: 60px;
    margin-top: 20px;
    color: black;
    background-color: #f8f9fa;
    margin-bottom: 20px;
}
.exitcontent li{
	margin-bottom:5px;
}

#memberExit {
    width: 1500px;
    max-width: 1200px;
    margin: auto;
    background: #fff;
    padding: 20px;
}
</style>
</head>
<body>
<div class="container" id="memberExit">
    <div class="row">
		<h3 class="text-center table-title">회원 탈퇴</h3>
		<div class="exitcontent">
			<h4 style="color: darkred; margin-top:10px;">탈퇴 전 유의사항</h4>
			<ul>
				<li>탈퇴 시, 해당 아이디로 재가입이 불가능합니다. </li>
				<li> 계정의 모든 개인정보는 삭제되며 재가입 시에도 복구되지 않습니다. </li>
				<li>배송 완료 되지 않은 주문 내역이 있는 경우 탈퇴가 불가능합니다.</li>
				<li>탈퇴 시, 작성 리뷰와 좋아요 내역, 예약내역은 즉시 삭제되며, 작성한 글과 댓글의 내용은 삭제되지 않습니다. </li>
			</ul>
		</div>
				<button class="exitbtn" @click="openModal()">회원 탈퇴</button>
		</div>
		<div class="modal" :class="{ show: showModal }" @click.self="closeModal()">
			<div class="modal-content">
				<span class="close" @click="closeModal()">&times;</span>
				<table class="table" style="margin-top: 50px; border: 1px solid lightgray;">
					<tr>
						<th width="30%">비밀번호 확인 : </th>
						<td width="70%">
						 <input type="password" v-model="inputpwd">
						</td>
					</tr>
					<tr>
						<td colspan="2" class="rmbtn">
							<button type="button" class="rmbtn btn-sm btn-danger" @click="pwdCheck()">확인</button>
							<button type="button" class="rmbtn btn-sm btn-secondary" @click="closeModal()">취소</button>
						</td>
					</tr>
				</table>
			</div>
		</div>
   </div>
<script>
let memberExitApp=Vue.createApp({
	data(){
		return{
			showModal:false,
			inputpwd:'',
			pCount:0,
			rCount:0,
			id:'${sessionScope.userId}',
			nickname:'${sessionScope.nickName}'	
		}
	},
	mounted(){
		 
 	},
	methods:{
		openModal(){
			this.getinfo()
		},
		closeModal() {
		    this.showModal = false
		},
		 memberExit(){
			axios.get('../mypage/memberExit_vue.do',{
 				params:{
 					userid:this.id,
 					rCount:this.rCount
 				}
 			}).then(response=>{
 				if(response.data === "yes")
 					{
 						alert("회원탈퇴가 성공적으로 완료되었습니다.\n그동안 WineFine을 이용해주셔서 대단히 감사합니다.")
 						this.closeModal()
 						location.href="../main/main.do"
 					}
 			}).catch(error=>{
 				console.log(error)
 			})
		 },
		 pwdCheck(){
			 axios.get('../mypage/pwdCheck_vue.do',{
	 				params:{
	 					userid:this.id,
	 					inputpwd: this.inputpwd
	 				}
	 			}).then(response=>{
					if(response.data == "yes")
						{
							this.memberExit()
						}
					else
					{
						alert("비밀번호가 일치하지 않습니다")
						return
					}
					console.log(response.data)
 			}).catch(error=>{
 				console.log(error)
 			})
		 },
		 getinfo(){
			 axios.get('../mypage/getinfo_vue.do',{
 				params:{
 					userid:this.id,
 				}
 			}).then(response=>{
					this.pCount = response.data.pCount
					this.rCount = response.data.rCount
					
					if(this.pCount > 0)
					{
						alert("진행중인 주문내역이 있으므로 탈퇴가 불가능합니다.")
						this.showModal = false
						return
					}
					if(this.rCount>0){
						if (confirm("예약 내역이 존재합니다. 정말로 회원 탈퇴하시겠습니까?")) {
				            this.showModal = true
				          }
						else{
							this.showModal = false
							}
					} else {
				        this.showModal = true
					}
					console.log(response.data)
 			}).catch(error=>{
 				console.log(error.response)
 			})
		 }
    }
}).mount('#memberExit')
</script>
</body>
</html>