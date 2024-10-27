<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.fixed-button {
	position: fixed;
	bottom: 80px;
	right: 80px;
	background-color: darkred;
	color: white;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	width: 60px;
	height: 60px;
}
</style>
</head>
<body>
	<div class="container-fluid bg-dark text-white-50 footer pt-5 mt-5" id="footerApp">
		<div class="container py-5">
			<div class="row g-5">
				<div class="footer-item">
					<p class="mb-0">
						<a href="../noticeboard/list.do" style="color: white;">공지사항</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="../replyboard/list.do" style="color: white;">&nbsp;&nbsp;1:1문의&nbsp;&nbsp;</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="../board/FaqList.do " style="color: white;">&nbsp;&nbsp;FAQ</a>
					</p>
				</div>
				<div class="d-flex flex-column text-start footer-item col-sm-6" style="margin-top: 10px;">
					<h4 class="text-light mb-3">WineFine Project&nbsp;&nbsp;</h4>
					<p>멤버 : 김경주 | 김민선 | 이규혁 | 이은영 | 한혜진</p> <p>깃허브 : https://github.com/WineFineProject/WineFine</p> <p>10/18 ~ 11/11</p>
				</div>
				<div class="footer-item col-sm-6" style="text-align: right;margin-top: 10px;">
					<h4 class="text-light mb-3">Contact</h4>
					<p>Address: 서울특별시 마포구 월드컵북로 21 풍성빌딩 2,3,4층 쌍용강북교육센터</p>
					<p>Email: Example@gmail.com</p>
					<p>Phone: 02-336-8546~8</p>
					<img src="img/payment.png" class="img-fluid" alt="">
				</div>
			</div>
		</div>
	</div>
</body>
</html>