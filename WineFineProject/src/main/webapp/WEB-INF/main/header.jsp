<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.hide {
	display: none !important;
}

.active {
	display: block !important;
}

.notice_list {
	position: absolute;
	z-index: 1000;
	top: 88px;
	width: 450px;
	height: 600px; min-width : 10rem;
	padding: .5rem 0;
	margin: 0;
	font-size: 1rem;
	color: #747d88;
	text-align: left;
	list-style: none;
	background-color: #fff;
	background-clip: padding-box;
	border: 1px solid rgba(0, 0, 0, .15);
	border-radius: 10px;
	min-width: 10rem;
}

.notice_list::before {
  content: "";
  position: absolute;
  top: -20px; /* 더 긴 삼각형 때문에 위로 이동 */
  left: 67px; /* 위치 조정 */
  border-width: 0 14px 20px 14px; /* 아래쪽(밑변) 길이를 늘림 */
  border-style: solid;
  border-color: transparent transparent rgba(0, 0, 0, 0.15) transparent; /* 테두리 색상 */
}

.notice_list::after {
  content: "";
  position: absolute;
  top: -18px; /* 내부 삼각형도 위로 이동 */
  left: 69px; /* 흰색 삼각형 위치 조정 */
  border-width: 0 12px 18px 12px; /* 아래쪽(밑변) 길이를 늘림 */
  border-style: solid;
  border-color: transparent transparent #fff transparent; /* 내부 삼각형 색상 */
}
</style>
</head>
<body>
	<div id="spinner" class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
		<div class="spinner-grow text-wine" role="status"></div>
	</div>
	<div class="container-fluid fixed-top" id="navbar">
		<div class="container topbar bg-wine d-none d-lg-block">
			<div class="d-flex justify-content-between">
				<div class="top-info ps-2">
					<small class="me-3"><i class="fas fa-map-marker-alt me-2 text-wine"></i> <a href="#" class="text-white">123 Street, New York</a></small> <small class="me-3"><i
						class="fas fa-envelope me-2 text-wine"></i> <a href="#" class="text-white">Email@Example.com</a></small>
				</div>
				<div class="top-link pe-2">
					<a href="#" class="text-white"> <small class="text-white mx-2">Privacy Policy</small>/
					</a> <a href="#" class="text-white"> <small class="text-white mx-2">Terms of Use</small>/
					</a> <a href="#" class="text-white"> <small class="text-white ms-2">Sales and Refunds</small>
					</a>
				</div>
			</div>
		</div>
		<div class="container px-0">
			<nav class="navbar navbar-light bg-white navbar-expand-xl">
				<a href="index.html" class="navbar-brand">
					<h1 class="text-wine display-6">Fruitables</h1>
				</a>
				<button class="navbar-toggler py-2 px-3" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
					<span class="fa fa-bars text-wine"></span>
				</button>
				<div class="collapse navbar-collapse bg-white" id="navbarCollapse">
					<div class="navbar-nav mx-auto">
						<a href="../main/main.do" class="nav-item nav-link active">Home</a>
						<div class="nav-item dropdown">
							<a href="" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">와인샵</a>
							<div class="dropdown-menu m-0 bg-light rounded-0">
								<a href="../shop/list.do" class="dropdown-item">일반판매</a> <a href="../replyboard/list.do" class="dropdown-item">예약판매</a>
							</div>
						</div>
						<a href="../mypage/mypageHome.do" class="nav-item nav-link">mypage</a> <a href="../admin/adminHome.do" class="nav-item nav-link">admin</a> <a href="../seller/sellerHome.do"
							class="nav-item nav-link">seller</a>
						<div class="nav-item dropdown">
							<a href="" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">와인</a>
							<div class="dropdown-menu m-0 bg-light rounded-0">
								<a href="../board/list.do" class="dropdown-item">주요품종</a> <a href="../noticeboard/list.do" class="dropdown-item">생산지역</a> <a href="../replyboard/list.do" class="dropdown-item">생산자</a>
							</div>
						</div>
						<div class="nav-item dropdown">
							<a href="" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">커뮤니티</a>
							<div class="dropdown-menu m-0 bg-light rounded-0">
								<a href="../board/list.do" class="dropdown-item">자유게시판</a> <a href="../noticeboard/list.do" class="dropdown-item">공지사항</a> <a href="../replyboard/list.do" class="dropdown-item">1:1 문의</a>
							</div>
						</div>
					</div>
					<div class="d-flex m-3 me-0">
						<button class="btn-search btn border border-secondary btn-md-square rounded-circle bg-white me-4" data-bs-toggle="modal" data-bs-target="#searchModal">
							<i class="fas fa-search text-wine"></i>
						</button>
						<a class="position-relative me-4 my-auto" style="cursor: pointer;" @click="changeNotice()"> <i class="fas fa-comment-alt fa-2x"></i> <span :class="{hide:count===0}"
							class="position-absolute bg-secondary rounded-circle d-flex align-items-center justify-content-center text-dark px-1" style="top: -5px; left: 15px; height: 20px; min-width: 20px;">{{count}}</span>
						</a>
						<div class="notice_list" :class="{hide:!isShow, active:isShow}">
							<div>
								<h3>미확인 알림</h3>
								<table></table>
							</div>
						</div>
						<a href="#" class="position-relative me-4 my-auto"> <i class="fa fa-shopping-bag fa-2x"></i> <span
							class="position-absolute bg-secondary rounded-circle d-flex align-items-center justify-content-center text-dark px-1" style="top: -5px; left: 15px; height: 20px; min-width: 20px;">3</span>
						</a>
						<c:if test="${sessionScope.id==null }">
							<a href="../member/login.do" class="my-auto"> <i class="fas fa-user fa-2x"></i>
							</a>
						</c:if>
						<c:if test="${sessionScope.id!=null }">
							<a href="../member/logout.do" class="my-auto"> <i class="fas fa-sign-out-alt fa-2x"></i>
							</a>
						</c:if>
					</div>
				</div>
			</nav>
		</div>
	</div>
	<script>
	let navApp=Vue.createApp({
		data(){
			return{
				list:[],
				isShow:false,
				count:0
			}
		},
		methods:{
			changeNotice(){
				this.isShow=!this.isShow
			}
		}
	}).mount('#navbar')
	</script>
</body>
</html>