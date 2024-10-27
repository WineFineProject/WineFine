<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../tem/css/pwd.css">
</head>
<body>
	<div id="mbList">
		<div id="MyTable">
			<h3 class="table-title">회원정보 수정</h3>
			<div class="round">
			<div class="input-f">
                <label>이름</label>
                <input type="text" readonly value="${sessionScope.userName}">
            </div>
            <div class="input-f">
                <label>성별</label>
                <input type="text" readonly value="${sessionScope.sex}">
            </div>
            <div class="input-f">
                <label>아이디</label>
                <input type="text" readonly value="${sessionScope.userId}">
            </div>
            <div class="input-f">
                <label>닉네임</label>
                <input type="text" readonly value="${sessionScope.nickName}">
            </div>
             <div class="input-f">
                <label>주소</label>
                <input type="text" readonly value="${sessionScope.address}">
            </div>
            <div class="input-f">
                <label>전화</label>
                <input type="text" readonly value="${sessionScope.phone}">
            </div>
             <div class="input-f">
                <label>이메일</label>
                <input type="text" readonly value="${sessionScope.email}">
            </div>
			<div style="margin-top: 30px">
				<a href="../mypage/my_edit2_member.do" class="sub-btn">
					<span>수정하기</span>
				</a>
			</div>
		</div>
	</div>
</div>	
</body>
</html>