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
<div class="row" id="myPwdApp">
	<h3 class="table-title">비밀번호 변경</h3>
	<div class="round">
            <div class="input-field">
                <label for="originalPassword">기존 비밀번호</label>
                <input type="password" id="originalPassword" v-model="userpwd" placeholder="기존 비밀번호를 입력하세요">
            </div>
                <div class="requirements">** 비밀번호는 8자리 이상이어야 하며, 영문과 숫자를 모두 포함해야 합니다.</div>
            <div class="input-field">
                <label for="newPassword">새 비밀번호</label>
                <input type="password" id="newPassword" v-model="newpwd" @keyup="pwdValue()" placeholder="새 비밀번호를 입력하세요">
                <p class="error-message" style="margin: 0 auto; color: red;" v-show="!isPwd">
				  <font size="1px">&nbsp;{{pwdMsg}}</font>
				</p>
            </div>
            <div class="input-field">
                <label for="confirmPassword">비밀번호 확인</label>
                <input type="password" id="confirmPassword" v-model="newCkpwd" @keyup="pwdValue2()" placeholder="비밀번호를 다시 입력하세요">
                <p class="error-message" style="margin: 0 auto; color: red;" :class="{font_green:isPwdCheck}">
				  <font size="1px" id="pwdState">&nbsp;{{checkPwdMsg}}</font>
				</p>
            </div>
            <button class="sub-btn" @click="ChangePwd()">비밀번호 변경</button>
        </div>
</div>	
<script>
  let myPwdApp=Vue.createApp({
	  data(){
		  return{
			    userpwd:'',
			    newpwd: '',
	            newCkpwd: '',
	            pwdMsg: '',
	            isPwd: false,
	            isPwdCheck: false,
	            checkPwdMsg: '',
	            id:'${sessionScope.userId}'
		  }
	  },
	  methods:{
		  pwdEdit(){
			  axios.get('../mypage/updatePwd.do',{
				  params:{
					  id:this.id,
					  userpwd:this.newpwd
				  }
			  })
			  .then(response=>{
				  alert('비밀번호가 변경되었습니다')
				  location.href='../mypage/mypageHome.do'
			  }).catch(error=>{
				  console.log(error)
			  })
		  },
		  ChangePwd() {
			  axios.get('../mypage/pwdCheck_vue.do',{
				  params:{
					  userid:this.id,
					  inputpwd:this.userpwd
				  }
			  }).then(response=>{
				  if(response.data == "yes")
				  {
					  this.pwdEdit()
				  }
				  else
				  {
					  alert('비밀번호가 일치하지 않습니다')
					  return
				  }
			  }).catch(error=>{
				  console.log(error)
			  })
		  },
		  pwdValue() {
	            let pwd = String(this.newpwd);
	            let num = pwd.search(/[0-9]/g);
	            let eng = pwd.search(/[a-zA-Z]/g); // 영문 대소문자 모두 포함
	            if (pwd === '') {
	                this.pwdMsg = '';
	                this.isPwd = false;
	                return;
	            }
	            if (pwd.length < 8 || pwd.length > 20) {
	                this.pwdMsg = '비밀번호는 8자리~20자리 이내로 입력';
	                this.isPwd = false;
	                return;
	            }
	            else if (pwd.search(/\s/) != -1) {
	                this.pwdMsg = "비밀번호는 공백없이 입력";
	                this.isPwd = false;
	                return;
	            }
	            else if (num < 0 || eng < 0) {
	                this.pwdMsg = "비밀번호는 영문, 숫자를 혼합해서 사용";
	                this.isPwd = false;
	                return;
	            }
	            else {
	                this.pwdMsg = '';
	                this.isPwd = true;
	            }
	        },
	        pwdValue2() {
	            if (this.newCkpwd === '') {
	                this.isPwdCheck = false;
	                this.checkPwdMsg = '';
	            }
	            else if (this.newpwd === this.newCkpwd) {
	                this.isPwdCheck = true;
	                this.checkPwdMsg = '비밀번호가 일치합니다';
	            }
	            else {
	                this.isPwdCheck = false;
	                this.checkPwdMsg = '비밀번호가 일치하지 않습니다';
	            }
	        }
	    }
  }).mount('#myPwdApp')
</script>
</body>
</html>