<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../tem/css/noticestyle.css">
<style type="text/css">
.hide {
	display: none !important;
}

.active {
	display: block !important;
}
</style>
</head>
<body>
	<div id="spinner" class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
		<div class="spinner-grow text-wine" role="status"></div>
	</div>
	<div class="container-fluid" id="navbar">
		<div class="container topbar bg-wine d-none d-lg-block">
			<div class="d-flex justify-content-between">
				<div class="top-info ps-2">
					<small class="me-3"><i class="fas fa-map-marker-alt me-2 text-wine"></i> <a href="#" class="text-white">123 Street, New York</a></small> <small class="me-3"><i class="fas fa-envelope me-2 text-wine"></i> <a href="#" class="text-white">Email@Example.com</a></small>
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
				<a href="../main/main.do" class="navbar-brand">
					<img src="../img/logo.png" style="width:200px; height:100px; margin-left:30px; margin-right:50px;">
				</a>
				<button class="navbar-toggler py-2 px-3" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
					<span class="fa fa-bars text-wine"></span>
				</button>
				<div class="collapse navbar-collapse bg-white" id="navbarCollapse">
					<div class="navbar-nav">
						<a href="../main/main.do" class="nav-item nav-link active">Home</a>
						<div class="nav-item dropdown" style="text-align: left;">
							<a href="" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">와인샵</a>
							<div class="dropdown-menu m-0 bg-light rounded-0">
								<a href="../shop/list.do" class="dropdown-item">일반판매</a>
								<a href="../wine/quickfind.do" class="dropdown-item">빠른검색</a>
							</div>
						</div>
						<div class="nav-item dropdown" style="text-align: left;">
							<a href="" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">이벤트</a>
							<div class="dropdown-menu m-0 bg-light rounded-0">
								<a href="../event/list.do" class="dropdown-item">시음회</a>
							</div>
						</div>
						<div class="nav-item dropdown" style="text-align: left;">
							<a href="" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">와인</a>
							<div class="dropdown-menu m-0 bg-light rounded-0">
								<a href="../grape/list.do" class="dropdown-item">주요품종</a>
								<a href="../nation/list.do" class="dropdown-item">생산지역</a>
								<a href="../maker/list.do" class="dropdown-item">생산자</a>
							</div>
						</div>
						<div class="nav-item dropdown" style="text-align: left;">
							<a href="" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">커뮤니티</a>
							<div class="dropdown-menu m-0 bg-light rounded-0">
								<a href="../board/list.do" class="dropdown-item">자유게시판</a>
								<a href="../noticeboard/list.do" class="dropdown-item">공지사항</a>
								<a href="../replyboard/list.do" class="dropdown-item">1:1 문의</a>
							</div>
						</div>
						<sec:authorize access="hasRole('ROLE_USER')"> 
						<a href="../mypage/mypageHome.do" class="nav-item nav-link">mypage</a>
						</sec:authorize>
						<sec:authorize access="hasRole('ROLE_ADMIN')"> 
						<a href="../admin/adminHome.do" class="nav-item nav-link">admin</a>
						</sec:authorize>
						<sec:authorize access="hasRole('ROLE_SELLER')"> 
						<a href="../seller/sellerHome.do" class="nav-item nav-link">seller</a>
						</sec:authorize>
					</div>
					<div class="d-flex m-3 me-0"  style="margin-left: 350px !important;">
						<a class="position-relative me-4 my-auto" style="cursor: pointer;" @click="changeNotice()">
							<i class="fas fa-comment-alt fa-2x"></i> <span :class="{hide:count===0}" class="position-absolute bg-secondary rounded-circle d-flex align-items-center justify-content-center text-dark px-1" style="top: -5px; left: 15px; height: 20px; min-width: 20px;">{{count}}</span>
						</a>
						<div class="notice_list" :class="{hide:!isShow, active:isShow}">
							<h4 class="text-center" style="margin-top: 10px;">미확인 알림 {{count}}건</h4>
							<table class="table" style="width: 90%; table-layout: fixed; margin: 0px auto;">
								<tr v-for="(vo, index) in newNotice" @click="showInfo(vo)">
									<td width="5%">{{index+1}}</td>
									<td width="55%" class="scrollable-text">
										<p>{{vo.subject}}</p>
									</td>
									<td width="13%">{{vo.sendid}}</td>
									<td width="27%">{{vo.dbday}}</td>
								</tr>
							</table>
							<hr class="note_list">
							<h4 class="text-center" style="margin-top: 20px;">확인 알림</h4>
							<table class="table" style="width: 90%; table-layout: fixed; margin: 0px auto;">
								<tr v-for="(vo, index) in oldNotice" @click="showInfo(vo)">
									<td width="5%">{{index+1}}</td>
									<td width="55%" class="scrollable-text">
										<p>{{vo.subject}}</p>
									</td>
									<td width="13%">{{vo.sendid}}</td>
									<td width="27%">{{vo.dbday}}</td>
								</tr>
							</table>
						</div>
						<a href="../cart/inMyCart.do" class="position-relative me-4 my-auto">
							<i class="fa fa-shopping-bag fa-2x"></i>
							<c:if test="${sessionScope.userId!=null }">
								<span v-show="cartCount>0" class="position-absolute bg-secondary rounded-circle d-flex align-items-center justify-content-center text-dark px-1" style="top: -5px; left: 15px; height: 20px; min-width: 20px;">{{cartCount}}</span>
							</c:if>
						</a>
						<c:if test="${sessionScope.userId==null }">
							<a href="../member/login.do" class="my-auto">
								<i class="fas fa-user fa-2x"></i>
							</a>
						</c:if>
						<c:if test="${sessionScope.userId!=null }">
							<a href="../member/logout.do" class="my-auto">
								<i class="fas fa-sign-out-alt fa-2x"></i>
							</a>
						</c:if>
					</div>
				</div>
			</nav>
			<div class="modal" :class="{ show: showModal }" @click.self="changeModal(false)">
				<div class="modal-content" style="height: 455px;">
					<span class="close" @click="changeModal(false)">&times;</span>
					<table class="table ttt" style="table-layout: fixed; margin-top: 25px;">
						<tr>
							<th class="centered" width="20%">제목</th>
							<td colspan="3" class="scrollable-text" style="border: 1px solid #e1e1e1">
								<p style="margin-bottom: 0px">{{select.subject}}</p>
							</td>
						</tr>
						<tr>
							<th class="centered" width="20%">보낸이</th>
							<td class="centered" width="30%">{{select.sendid}}</td>
							<th class="centered" width="20%">작성일</th>
							<td class="centered" width="30%" style="border: 1px solid #e1e1e1">{{select.dbday}}</td>
						</tr>
						<tr>
							<td colspan="4" class="content-box">
								<pre>{{select.content}}</pre>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>
	<script>
	let navApp=Vue.createApp({
		data(){
			return{
				newNotice:[],
				oldNotice:[],
				isShow:false,
				count:0,
				showModal:false,
				select:{},
				cartCount:0
			}
		},
		methods:{
			changeNotice(){
				this.isShow=!this.isShow
			},
			getNotice(){
				axios.get('../notice/vueNotice.do', null).then(response=>{
					this.count=response.data.count
					this.newNotice=response.data.newNotice
					this.oldNotice=response.data.oldNotice
					this.cartCount=response.data.cartCount
				})
			},
			changeModal(check){
				if(check===false){
					this.select={}
					this.getNotice()
				}
				changeModal(this, check)
			},
			showInfo(select){
				this.select=select
				this.changeModal(true)
				axios.get('../notice/vueNoticeStateUpdate.do', {
					params:{
						nno:this.select.nno
					}
				})
			}
		},
		mounted(){
			this.getNotice()
		}
	}).mount('#navbar')
	</script>
</body>
</html>