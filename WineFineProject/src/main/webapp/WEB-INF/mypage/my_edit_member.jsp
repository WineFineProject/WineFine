<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    .text-primary {
      color: #722F37 !important;
    }
    .border-secondary {
      border-color: red !important;
    }
  </style>
</head>
<body>
	<div class="container-fluid py-5" id="mbList">
		<div class="container py-5">
			<div class="row">
				<div class="col-lg-12">
					<div class="table-responsive" id="MyTable">
						<table class="table" border="1">
							<tr>
								<th><b>이름</b></th>
								<td>${sessionScope.userName}</td>	
							</tr>
							<tr>
								<th><b>성별</b></th>
								<td>${sessionScope.sex }</td>
							</tr>
							<tr>
								<th><b>아이디</b></th>
								<td>${sessionScope.userId}</td>
							</tr>	
							<tr>
								<th><b>닉네임</b></th>
								<td>${sessionScope.nickName}</td>					
							</tr>
							<tr>
								<th><b>주소</b></th>
								<td>${sessionScope.address }</td>
							</tr>
							<tr>
								<th><b>전화</b></th>
								<td>${sessionScope.phone }</td>
							</tr>
							<tr>
								<th><b>이메일</b></th>
								<td>${sessionScope.email }</td>
							</tr>
							
						</table>
						<div>
							 <a href="../mypage/my_edit2_member.do" class="btn border border-secondary rounded-pill px-4 py-2 mb-4 text-primary">
						        <span>수정하기</span>
						    </a>
						</div>
						
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>