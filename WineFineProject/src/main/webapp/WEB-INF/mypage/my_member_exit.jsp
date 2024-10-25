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
</style>
</head>
<body>
<div class="container" id="memberExit">
    <div class="row">
		<h3 class="text-center table-title">회원 탈퇴</h3>
		<div class="exitcontent">
			<h4 style="color: darkred; margin-top:10px;">탈퇴 전 유의사항</h4>
			<ul>
				<li>탈퇴 시, 해당 아이디로 재가입이 불가능합니다. <br> 계정의 모든 개인정보는 삭제되며 재가입 시에도 복구되지 않습니다. </li>
				<li>배송 완료 되지 않은 주문 내역이 있는 경우 탈퇴가 불가능합니다.</li>
				<li>탈퇴 시, 작성 리뷰와 좋아요 내역, 예약내역은 즉시 삭제되며, 작성한 글과 댓글의 내용은 삭제되지 않습니다. </li>
			</ul>
		</div>
		<button class="exitbtn" @click="memberExit()">회원 탈퇴</button>
	</div>
</div>
<script>
let memberExitApp=Vue.createApp({
	data(){
		return{
			id:'${sessionScope.userId}',
			nickname:'${sessionScope.nickName}'	
		}
	},
	mounted(){
		 this.reserveCheck()
 	},
	methods:{
		 memberExit(){
			 if()
			 if (confirm("예약 내역이 존재합니다. 정말로 회원 탈퇴하시겠습니까?"))
		 },
		 reserveCheck(){
			 
		 }
    }
}).mount('#edit2')
</script>
</body>
</html>