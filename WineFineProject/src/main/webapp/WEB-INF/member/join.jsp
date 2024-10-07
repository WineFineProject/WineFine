<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="login">
		<div class="login__content">
			<div class="login__forms">
				<!--         login form -->
				<div class="login__create none" id="login-up">
					<h1 class="login__title">Create Account</h1>
					<div class="login__box">
						<i class='bx bx-face login__icon'></i>
						<input type="text" placeholder="Username" class="login__input" id="name" required>
					</div>
					<div class="login__box">
						<i class='bx bx-user login__icon'></i>
						<input type="text" placeholder="ID" class="login__input" id="signUpId">
						<input type="button" value="중복확인" id="idCheck">
						<img src="check.png" width="20px" id="idIcon" height="20px" style="background: none; display: none;">
					</div>
					<div class="login__box">
						<i class='bx bx-ghost login__icon'></i>
						<input type="text" placeholder="Nick name" class="login__input" id="nick">
						<input type="button" value="중복확인" id="nickCheck">
						<img src="check.png" width="20px" id="nickIcon" height="20px" style="background: none; display: none;">
					</div>
					<div class="login__box">
						<i class='bx bx-lock login__icon'></i>
						<input type="text" placeholder="Password" class="login__input" id="signUppwd">
					</div>
					<div class="login__box">
						<i class='bx bx-lock login__icon'></i>
						<input type="text" placeholder="Confirm Password" class="login__input" id="pwdCheck">
						<p style="margin: 0 auto;">
							<font size="1px" id="pwdState">&nbsp;</font>
						</p>
					</div>
					<div class="login__box">
						<i class='bx bx-phone login__icon'></i>
						<input type="text" placeholder="Phone" class="login__input" readonly>
						<div class="phone-container">
							<select name="phone" class="phone-prefix" style="margin-right: 6px;" id="phone_first">
								<option value="">없음</option>
								<option value="02">02</option>
								<option value="010">010</option>
								<option value="011">011</option>
							</select>
							<input type="text" placeholder="Phone" class="phone-input" style="margin-right: 6px;" id="phone_second" readonly maxlength="4">
							<input type="text" placeholder="Phone" class="phone-input" id="phone_third" readonly maxlength="4">
							<input type="button" value="중복확인" id="phoneCheck">
							<img src="check.png" width="20px" id="phoneIcon" height="20px" style="background: none; display: none;">
						</div>
					</div>

					<div class="login__box">
						<i class='bx bx-cake login__icon'></i>
						<input type="text" placeholder="Birth" class="login__input" readonly>
						<input type="date" required id="birth">
					</div>
					<div class="login__box" style="text-align: right;" id="sexCheck">
						<i class='bx bx-heart login__icon'></i>
						<input type="text" placeholder="Gender" class="login__input" readonly>
						<label class="login__input"> <input type="radio" value="남자" name="sex" id="sex" checked> 남자
						</label> <label class="login__input"> <input type="radio" value="여자" name="sex" id="sex"> 여자
						</label>
					</div>
					<div class="login__box">
						<i class='bx bx-at login__icon'></i>
						<input type="text" placeholder="Email" class="login__input" id="email">
						<input type="button" value="중복확인" id="emailCheck">
						<img src="check.png" width="20px" id="emailIcon" height="20px" style="background: none; display: none;">
					</div>
					<div class="login__box">
						<i class='bx bx-mail-send login__icon'></i>
						<input type="text" placeholder="post" class="login__input" readonly="readonly" id="post">
						<input type="button" value="우편번호 찾기" id="postBtn" required>
					</div>
					<div class="login__box">
						<i class='bx bx-map login__icon'></i>
						<input type="text" placeholder="addr" class="login__input" readonly="readonly" id="addr1">
					</div>
					<div class="login__box">
						<i class='bx bx-map login__icon'></i>
						<input type="text" placeholder="addr" class="login__input" id="addr2">
					</div>
					<a href="#" class="login__button" id="signUpBtn">Sign Up</a>
					<div>
						<span class="login__account login__account--account">Already have an Account?</span> <span class="login__signup login__signup--signup"
							id="sign-in">Sign In</span>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>