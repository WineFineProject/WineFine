<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div id="spinner"
		class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
		<div class="spinner-grow text-wine" role="status"></div>
	</div>
	<div class="container-fluid fixed-top">
		<div class="container topbar bg-wine d-none d-lg-block">
			<div class="d-flex justify-content-between">
				<div class="top-info ps-2">
					<small class="me-3"><i class="fas fa-map-marker-alt me-2 text-wine"></i> <a href="#" class="text-white">123 Street, New York</a></small> <small
						class="me-3"><i class="fas fa-envelope me-2 text-wine"></i> <a href="#" class="text-white">Email@Example.com</a></small>
				</div>
				<div class="top-link pe-2">
					<a href="#" class="text-white">
						<small class="text-white mx-2">Privacy Policy</small>/
					</a>
					<a href="#" class="text-white">
						<small class="text-white mx-2">Terms of Use</small>/
					</a>
					<a href="#" class="text-white">
						<small class="text-white ms-2">Sales and Refunds</small>
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
								<a href="../shop/list.do" class="dropdown-item">일반판매</a>
								<a href="../replyboard/list.do" class="dropdown-item">예약판매</a>
							</div>
						</div>
						<a href="../mypage/mypageHome.do" class="nav-item nav-link">mypage</a>
						<a href="../admin/adminHome.do" class="nav-item nav-link">admin</a>
						<a href="../seller/sellerHome.do" class="nav-item nav-link">seller</a>
						<div class="nav-item dropdown">
							<a href="" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">와인</a>
							<div class="dropdown-menu m-0 bg-light rounded-0">
								<a href="../board/list.do" class="dropdown-item">주요품종</a>
								<a href="../noticeboard/list.do" class="dropdown-item">생산지역</a>
								<a href="../replyboard/list.do" class="dropdown-item">생산자</a>
							</div>
						</div>
						<div class="nav-item dropdown">
							<a href="" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">커뮤니티</a>
							<div class="dropdown-menu m-0 bg-light rounded-0">
								<a href="../board/list.do" class="dropdown-item">자유게시판</a>
								<a href="../noticeboard/list.do" class="dropdown-item">공지사항</a>
								<a href="../replyboard/list.do" class="dropdown-item">1:1 문의</a>
							</div>
						</div>
					</div>
					<div class="d-flex m-3 me-0">
						<button class="btn-search btn border border-secondary btn-md-square rounded-circle bg-white me-4" data-bs-toggle="modal"
							data-bs-target="#searchModal">
							<i class="fas fa-search text-wine"></i>
						</button>
						<a href="#" class="position-relative me-4 my-auto">
							<i class="fa fa-shopping-bag fa-2x"></i> <span
								class="position-absolute bg-secondary rounded-circle d-flex align-items-center justify-content-center text-dark px-1"
								style="top: -5px; left: 15px; height: 20px; min-width: 20px;">3</span>
						</a>
						<c:if test="${sessionScope.id==null }">
							<a href="../member/login.do" class="my-auto">
								<i class="fas fa-user fa-2x"></i>
							</a>
						</c:if>
						<c:if test="${sessionScope.id!=null }">
							<a href="../member/logout.do" class="my-auto">
								<i class="fas fa-user fa-2x"></i>
							</a>
						</c:if>
					</div>
				</div>
			</nav>
		</div>
	</div>
	<div class="modal fade" id="searchModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-fullscreen">
			<div class="modal-content rounded-0">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Search by keyword</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body d-flex align-items-center">
					<div class="input-group w-75 mx-auto d-flex">
						<input type="search" class="form-control p-3" placeholder="keywords" aria-describedby="search-icon-1">
						<span id="search-icon-1" class="input-group-text p-3"><i class="fa fa-search"></i></span>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>