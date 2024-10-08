<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>CodePen - Sign Up/Sign In Responsive form</title>
<link rel="stylesheet" href="../tem/css/membersstyle.css">
<script type="text/javascript" src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link href='https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css' rel='stylesheet'>
<script src="https://unpkg.com/vue@3"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script type="text/javascript" src="http://unpkg.com/axios/dist/axios.min.js"></script>
<style type="text/css">
body {
	margin: 0;
	padding: 0;
	background: url('dust.png') no-repeat center center fixed;
	background-size: cover;
	font-family: Arial, sans-serif;
}

.login {
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
}

.login__create, .login__find {
	left: -4rem;
}

.font_green {
	color: green !important;
}
</style>
</head>
<body>
	<!-- partial:index.partial.html -->

	<div class="login">
		<div class="login__content">
			<div class="login__forms">
				<!--         login form -->
				<div id="loginApp">
					<form action="../member/login.do" method="post" class="login__register" id="login-in">
						<h1 class="login__title">Sign In</h1>
						<div class="login__box">
							<i class='bx bx-user login__icon'></i>
							<input type="text" placeholder="Username" class="login__input" name="userId" v-model="userId" ref="userId">
						</div>
						<div class="login__box">
							<i class='bx bx-lock login__icon'></i>
							<input type="password" placeholder="Password" class="login__input" name="userPwd" v-model="userPwd" ref="userPwd">
						</div>
						<div class="login__box">
							<input type="checkbox" class="login__input" name="remember-me">자동로그인
						</div>
						<div class="login__box">
							<span class="text-center" style="color: red">${message }</span>
						</div>
						<button type="button" class="login__button" @click="login()">Sign In</button>
						<div>
							<span class="login__signin login__signin--signup" id="forgot">Forgot Account? </span>&nbsp;<span class="login__signin login__signin--signup"
								id="forgotPwd">Forgot Password? </span><br> <span class="login__account login__account--account">Don't Have an Account?</span> <span
								class="login__signin login__signin--signup" id="sign-up">Sign Up</span>
						</div>
					</form>
				</div>
				<!-- 회원가입 -->
				<div class="login__create none" id="login-up">
					<form action="../member/joinOk.do" method="post" @submit.prevent="insertMember()" id="signupForm">
						<h1 class="login__title">Create Account</h1>
						<div class="login__box">
							<i class='bx bx-face login__icon'></i>
							<input type="text" placeholder="Username" class="login__input" ref="userName" name="userName" v-model="userName">
						</div>

						<div class="login__box">
							<i class='bx bx-user login__icon'></i>
							<input type="text" placeholder="ID" class="login__input" ref="userId" name="userId" v-model="userId" :readonly="isIdCheck">
							<input type="button" value="중복확인" v-show="!isIdCheck" @click="checkId()">
						</div>

						<div class="login__box">
							<i class='bx bx-ghost login__icon'></i>
							<input type="text" placeholder="Nick name" class="login__input" ref="nickName" name="nickName" v-model="nickName" :readonly="isNickCheck">
							<input type="button" value="중복확인" v-show="!isNickCheck" @click="checkNick()">
						</div>

						<div class="login__box">
							<i class='bx bx-lock login__icon'></i>
							<input type="text" placeholder="Password" class="login__input" ref="userPwd" name="userPwd" v-model="userPwd" @keyup="pwdValidate()">
							<p style="margin: 0 auto; color: red;" v-show="!isPwdValid">
								<font size="1px">&nbsp;{{pwdMsg}}</font>
							</p>
						</div>

						<div class="login__box">
							<i class='bx bx-lock login__icon'></i>
							<input type="text" placeholder="Confirm Password" class="login__input" id="pwdCheck" v-model="checkPwd" @keyup="pwdValidate2()">
							<p style="margin: 0 auto; color: red;" :class="{font_green:isPwdCheck}">
								<font size="1px" id="pwdState">&nbsp;{{checkPwdMsg}}</font>
							</p>
						</div>

						<div class="login__box">
							<i class='bx bx-phone login__icon'></i>
							<input type="text" placeholder="Phone" class="login__input" readonly>
							<div class="phone-container">
								<select name="phone1" class="phone-prefix" style="margin-right: 6px;" v-model="phone1" @change="hasPhone()">
									<option value="">없음</option>
									<option value="02">02</option>
									<option value="010">010</option>
									<option value="011">011</option>
								</select>
								<input type="text" placeholder="Phone" class="phone-input" style="margin-right: 6px;" name="phone2" maxlength="4" :readonly="isPhoneCheck"
									v-show="isPhoneNone" v-model="phone2">
								<input type="text" placeholder="Phone" class="phone-input" name="phone3" maxlength="4" :readonly="isPhoneCheck" v-show="isPhoneNone"
									v-model="phone3">
								<input type="button" value="중복확인" id="phoneCheck" v-show="!isPhoneCheck&isPhoneNone" @click="checkPhone">
							</div>
						</div>
						<div class="login__box">
							<i class='bx bx-cake login__icon'></i>
							<input type="text" placeholder="Birth" class="login__input" readonly>
							<input type="date" name="birthday" v-model="birthday">
						</div>
						<div class="login__box" style="text-align: right;" id="sexCheck">
							<i class='bx bx-heart login__icon'></i>
							<input type="text" placeholder="Gender" class="login__input" readonly>
							<label class="login__input"> <input type="radio" value="남자" name="sex" v-model="sex"> 남자
							</label> <label class="login__input"> <input type="radio" value="여자" name="sex" v-model="sex"> 여자
							</label>
						</div>

						<div class="login__box">
							<i class='bx bx-at login__icon'></i>
							<input type="text" placeholder="Email" name="email" class="login__input" ref="email" v-model="email" :readonly="isEmailCheck">
							<input type="button" value="중복확인" v-show="!isEmailCheck" @click="checkEmail">
						</div>

						<div class="login__box">
							<i class='bx bx-mail-send login__icon'></i>
							<input type="text" placeholder="post" name="post" class="login__input" readonly="readonly" ref="post" v-model="post">
							<input type="button" value="우편번호 찾기" @click="postFind()">
						</div>
						<div class="login__box">
							<i class='bx bx-map login__icon'></i>
							<input type="text" placeholder="addr" name="addr1" class="login__input" readonly="readonly" ref="addr1" v-model="addr1">
						</div>
						<div class="login__box">
							<i class='bx bx-map login__icon'></i>
							<input type="text" placeholder="addr" name="addr2" class="login__input" ref="addr2" v-model="addr2">
						</div>
						<button type="submit" class="login__button" id="signUpBtn">Sign Up</button>
						<div>
							<span class="login__account login__account--account">Already have an Account?</span> <span class="login__signup login__signup--signup"
								id="sign-in">Sign In</span>
						</div>
					</form>
				</div>
				<!-- 아이디찾기 페이지 -->
				<div class="login__find none" id="find-account">
					<h1 class="login__title">Find Account</h1>
					<div class="login__box" id="findType">
						<i class='bx bx-search login__icon'></i>
						<input type="text" placeholder="type" class="login__input" readonly>
						<label class="login__input"> <input type="radio" value="1" name="type" id="type"> 전화번호
						</label> <label class="login__input"> <input type="radio" value="2" name="type" id="type"> 이메일
						</label>
					</div>
					<div class="login__box none" id="findPhone">
						<i class='bx bx-phone login__icon'></i>
						<input type="text" placeholder="Phone" class="login__input" readonly>
						<div class="phone-container">
							<select name="phone1" class="phone-prefix" style="margin-right: 6px;" id="phone1">
								<option value="02">02</option>
								<option value="010">010</option>
								<option value="011">011</option>
							</select>
							<input type="text" placeholder="Phone" class="phone-input" style="margin-right: 6px;" id="phone2" maxlength="4">
							<input type="text" placeholder="Phone" class="phone-input" id="phone3" maxlength="4">
						</div>
					</div>
					<div class="login__box none" id="findEmail">
						<i class='bx bx-search login__icon'></i>
						<input type="text" placeholder="Email" class="login__input" id="findEmailData">
					</div>
					<div class="none" id="findBtn">
						<span style="cursor: pointer;" class="login__button">Find</span>
					</div>
					<div id="findResultDiv none">
						<span id="findResult" class="login__account login__account--account" style="font-size: 25px;"></span>
					</div>
					<div>
						<span class="login__account login__account--account">Already have an Account?</span> <span class="login__signup login__signup--signup"
							id="returnLogin">Sign In</span>
					</div>
				</div>
				<!-- 비밀번호찾기 페이지 -->
				<div class="login__find none" style="height: 360px !important;" id="find-Pwd">
					<h1 class="login__title">Find Password</h1>
					<div class="login__box" id="findIdPwd">
						<i class='bx bx-user login__icon'></i>
						<input type="text" placeholder="ID" class="login__input" id="idPwd">
					</div>
					<div class="login__box" id="findTypePwd">
						<i class='bx bx-search login__icon'></i>
						<input type="text" placeholder="type" class="login__input" readonly>
						<label class="login__input"> <input type="radio" value="1" name="typePwd" id="typePwd"> 전화번호
						</label> <label class="login__input"> <input type="radio" value="2" name="typePwd" id="typePwd"> 이메일
						</label>
					</div>
					<div class="login__box none" id="findPhonePwd">
						<i class='bx bx-phone login__icon'></i>
						<input type="text" placeholder="Phone" class="login__input" readonly>
						<div class="phone-container">
							<select name="phone1Pwd" class="phone-prefix" style="margin-right: 6px;" id="phone1Pwd">
								<option value="02">02</option>
								<option value="010">010</option>
								<option value="011">011</option>
							</select>
							<input type="text" placeholder="Phone" class="phone-input" style="margin-right: 6px;" id="phone2Pwd" maxlength="4">
							<input type="text" placeholder="Phone" class="phone-input" id="phone3Pwd" maxlength="4">
						</div>
					</div>
					<div class="login__box none" id="findEmailPwd">
						<i class='bx bx-search login__icon'></i>
						<input type="text" placeholder="Email" class="login__input" id="findEmailDataPwd">
					</div>
					<div class="none" id="findBtnPwd">
						<span style="cursor: pointer;" class="login__button">Find</span>
					</div>
					<div id="findResultDivPwd none">
						<span id="findResultPwd" class="login__account login__account--account" style="font-size: 25px;"></span>
					</div>
					<div>
						<span class="login__account login__account--account">Already have an Account?</span> <span class="login__signup login__signup--signup"
							id="returnLoginPwd">Sign In</span>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- partial -->
	<script src="../tem/js/memberscript.js"></script>
	<script>
	let joinApp=Vue.createApp({
		data(){
			return{
				userId:'',
				userName:'',
				userPwd:'',
				checkPwd:'',
				nickName:'',
				phone1:'',
				phone2:'',
				phone3:'',
				birthday:'',
				post:'',
				addr1:'',
				addr2:'',
				pwdMsg:'',
				pwdCheck:'',
				checkPwdMsg:'',
				sex:'남자',
				email:'',
				isIdCheck:false,
				isNickCheck:false,
				isEmailCheck:false,
				isPhoneCheck:false,
				isPhoneNone:false,
				isPwdCheck:false,
				isPwdValid:false
			}
		},
		methods:{
			checkId(){
				if(this.userId===''){
					alert('아이디를 입력하세요')
					this.$refs.userId.focus()
					return
				}
				axios.get('../member/vueCheckId.do', {
						params:{
						userId:this.userId
					}
				}).then(response=>{
					if(response.data===0){
						this.isIdCheck=true
					}
					else{
						alert('이미 존재하는 아이디입니다')
						this.userId=''
					}
				})
			},
			checkNick(){
				if(this.nickName===''){
					alert('닉네임을 입력하세요')
					this.$refs.nickName.focus()
					return
				}
				axios.get('../member/vueCheckNick.do', {
						params:{
						nickName:this.nickName
					}
				}).then(response=>{
					if(response.data===0){
						this.isNickCheck=true
					}
					else{
						alert('이미 존재하는 닉네임입니다')
						this.nickName=''
					}
				})
			},
			checkEmail(){
				if(this.email===''){
					alert('이메일을 입력하세요')
					this.$refs.email.focus()
					return
				}
				axios.get('../member/vueCheckEmail.do', {
						params:{
						email:this.email
					}
				}).then(response=>{
					if(response.data===0){
						this.isEmailCheck=true
					}
					else{
						alert('이미 존재하는 이메일입니다')
						this.email=''
					}
				})
			},
			checkPhone(){
				if(this.phone2+this.phone3===''){
					alert('전화번호를 입력하세요')
					return
				}
				axios.get('../member/vueCheckPhone.do', {
					params:{
						phone:this.phone1+"-"+this.phone2+"-"+this.phone3
					}
				}).then(response=>{
					if(response.data===0){
						this.isPhoneCheck=true
					}
					else{
						alert('이미 존재하는 번호입니다')
						this.phone2=''
						this.phone3=''
					}
				})
			},
			postFind(){
				let _this=this
				new daum.Postcode({
					oncomplete:function(data){
						 _this.post=data.zonecode
						 _this.addr1=data.address
					}
				}).open()
			},
			hasPhone(){
				if(this.phone1===''){
					this.phone2=''
					this.phone3=''
					this.isPhoneNone=false
					this.isPhoneCheck=false
				}
				else{
					this.isPhoneNone=true
					this.isPhoneCheck=false
				}
			},
			insertMember(){
				if(this.userName===''){
					alert('이름을 입력해주세요')
					return
				}
				if(this.isIdCheck===false){
					alert('아이디 중복확인을 해주세요')
					return
				}
				if(this.isNickCheck===false){
					alert('닉네임 중복확인을 해주세요')
					return
				}
				if(!this.isPwdValid){
					alert('형식에 맞는 비밀번호를 입력해주세요')
					return
				}
				if(!this.isPwdCheck){
					alert('비밀번호 확인을 해주세요')
					return
				}
				if(!this.isPhoneCheck&this.isPhoneNone){
					alert('전화번호 중복확인을 해주세요')
					return
				}
				if(this.birthday===''){
					alert('생일을 선택해주세요')
					return
				}
				if(this.isEmailCheck===false){
					alert('이메일 중복확인을 해주세요')
					return
				}
				if(this.post===''){
					alert('주소를 입력해주세요')
					return
				}
				document.getElementById('signupForm').submit()
			},
			pwdValidate(){
				let pwd=String(this.userPwd)
				let num=pwd.search(/[0-9]/g)
				let eng=pwd.search(/[a-z]/g)
				if(pwd===''){
					this.pwdMsg=''
					this.isPwdValid=false
					return
				}
				if(pwd.length<8 || pwd.length>20){
					this.pwdMsg='비밀번호는 8자리~20자리 이내로 입력'
					this.isPwdValid=false
					return
				}
				else if(pwd.search(/\s/)!=-1){
					this.pwdMsg="비밀번호는 공백없이 입력"
					this.isPwdValid=false
					return
				}
				else if(num<0 || eng<0){
					this.pwdMsg="비밀번호는 영문, 숫자를 혼합해서 사용"
					this.isPwdValid=false
					return
				}
				else{
					this.pwdMsg=''
					this.isPwdValid=true
				}
			},
			pwdValidate2(){
				if(this.checkPwd===''){
					this.isPwdCheck=false
					this.checkPwdMsg=''
				}
				else if(this.userPwd===this.checkPwd){
					this.isPwdCheck=true
					this.checkPwdMsg='비밀번호가 일치합니다'
				}
				else{
					this.isPwdCheck=false
					this.checkPwdMsg='비밀번호가 일치하지 않습니다'
				}
			}
		}
	}).mount('#login-up')
	let loginApp=Vue.createApp({
		data(){
   		 return {
   			 userId:'',
   			 userPwd:''
   		 }
   	 },
   	 methods:{
   		 login(){
   			 if(this.userId==="")
   			 {
   				 this.$refs.userId.focus()
   				 return
   			 }
   			 if(this.userPwd==="")
   			 {
   				 this.$refs.userPwd.focus()
   				 return 
   			 }
   			 $('#login-in').submit()
   		 }
   	 }
	}).mount('#loginApp')
	</script>
</body>
</html>
