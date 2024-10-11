<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<meta content="" name="keywords">
<meta content="" name="description">
<!-- Google Web Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap" rel="stylesheet">
<!-- Icon Font Stylesheet -->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
<!-- Libraries Stylesheet -->
<link href="../tem/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
<link href="../tem/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
<!-- Customized Bootstrap Stylesheet -->
<link href="../tem/css/bootstrap.min.css" rel="stylesheet">
<link href="../tem/css/modal.css" rel="stylesheet">
<!-- Template Stylesheet -->
<link href="../tem/css/style.css" rel="stylesheet">
<script src="https://unpkg.com/vue@3"></script>
<script type="text/javascript" src="http://unpkg.com/axios/dist/axios.min.js"></script>
</head>
<body>
	<tiles:insertAttribute name="header" />
	<div class=" container2 text-center">
		<div class="row">
			<div class="col-lg-2">
				<div class="panel panel-info">
					<div class="panel-heading">
						<h3 class="panel-title">개인정보</h3>
					</div>
					<!-- 사이드바 메뉴목록1 -->
					<ul class="list-group">
						<li class="list-group-item"><a href="../mypage/my_edit_member.do">회원수정</a></li>
						<li class="list-group-item"><a href="../mypage/my_change_pwd.do">비밀번호 변경</a></li>
						<li class="list-group-item"><a href="../mypage/my_member_exit.do">회원탈퇴</a></li>
						<li class="list-group-item"><a href="../mypage/delivery.do">배송주소</a></li>
					</ul>
				</div>
				<div class="panel panel-warning">
					<div class="panel-heading">
						<h3 class="panel-title sinav">관리정보</h3>
					</div>
					<!-- 사이드바 메뉴목록2 -->
					<ul class="list-group">
						<li class="list-group-item"><a href="../mypage/coupon.do">쿠폰함</a></li>
						<li class="list-group-item"><a href="../mypage/mypayment.do">구매내역</a></li>
						<li class="list-group-item"><a href="../mypage/my_reserve.do">예약내역</a></li>
						<li class="list-group-item"><a href="../mypage/myboardlist.do">작성한글</a></li>
						<li class="list-group-item"><a href="../mypage/myreview.do">작성리뷰</a></li>
						<li class="list-group-item"><a href="../mypage/my_like.do">내좋아요</a></li>
					</ul>
				</div>
			</div>

			<div class="col-lg-10">
				<tiles:insertAttribute name="mypageHome" />
			</div>
		</div>
	</div>
	<tiles:insertAttribute name="footer" />

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
	<script src="../tem/lib/easing/easing.min.js"></script>
	<script src="../tem/lib/waypoints/waypoints.min.js"></script>
	<script src="../tem/lib/lightbox/js/lightbox.min.js"></script>
	<script src="../tem/lib/owlcarousel/owl.carousel.min.js"></script>
	<script src="../tem/js/main.js"></script>
	<script src="../tem/js/test.js"></script>
</body>
</html>