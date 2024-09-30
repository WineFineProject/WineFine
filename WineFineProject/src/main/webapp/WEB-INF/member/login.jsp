<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.0/css/bootstrap.min.css'>
<link rel='stylesheet' href='https://unicons.iconscout.com/release/v2.1.9/css/unicons.css'>
<link rel="stylesheet" href="../tem/css/memberStyle.css">
<script src="https://unpkg.com/vue@3"></script>
<script type="text/javascript" src="http://unpkg.com/axios/dist/axios.min.js"></script>
</head>
<body>
	<div class="section">
		<div class="container">
			<div class=" full-height justify-content-center">
				<div class="col-12 text-center align-self-center">
					<div class="section pb-5 pt-5 pt-sm-2 text-center">
						<h6 class="mb-0 pb-3">
							<span>Log In</span><span>Sign Up</span>
						</h6>
						<input class="checkbox" type="checkbox" id="reg-log" name="reg-log" />
						<label for="reg-log"></label>
						<div class="card-3d-wrap mx-auto">
							<div class="card-3d-wrapper">
								<div class="card-front">
									<div style="height: 75px;"></div>
									<div class="center-wrap">
										<div class="section text-center">
											<h4 class="mb-4 pb-3">Log In</h4>
											<div class="form-group">
												<input @keyup.enter="login()" type="text" name="logemail" class="form-style" placeholder="Your Email" v-model="id" ref="id" autocomplete="off">
												<i class="input-icon uil uil-at"></i>
											</div>
											<div class="form-group mt-2">
												<input @keyup.enter="login()" type="password" name="logpass" class="form-style" placeholder="Your Password" v-model="pwd" ref="pwd" autocomplete="off">
												<i class="input-icon uil uil-lock-alt"></i>
											</div>
											<button type="button" class="btn mt-4" @click="login()">submit</button>
											<p class="mb-0 mt-4 text-center">
												<a href="" class="link">Forgot your password?</a>
											</p>
										</div>
									</div>
									<div style="height: 225px;"></div>
								</div>
								<div class="card-back">
									<div class="center-wrap">
										<div class="section text-center">
											<h4 class="mb-4 pb-3">Sign Up</h4>
											<div class="form-group mt-2">
												<input type="text" name="logname" class="form-style" placeholder="UserName" id="logname" autocomplete="off">
												<i class="input-icon uil uil-user"></i>
											</div>
											<div class="form-group mt-2">
												<input type="text" name="logname" class="form-style" placeholder="UserId" id="logname" autocomplete="off">
												<i class="input-icon uil uil-user"></i>
											</div>
											<div class="form-group mt-2">
												<input type="text" name="logname" class="form-style" placeholder="NickName" id="logname" autocomplete="off">
												<i class="input-icon uil uil-user"></i>
											</div>
											<div class="form-group mt-2">
												<input type="password" name="logpass" class="form-style" placeholder="Password" id="logpass" autocomplete="off">
												<i class="input-icon uil uil-lock-alt"></i>
											</div>
											<div class="form-group mt-2">
												<input type="password" name="logpass" class="form-style" placeholder="Confirm Password" id="logpass" autocomplete="off">
												<i class="input-icon uil uil-lock-alt"></i>
											</div>
											<div class="form-group mt-2">
												<input type="text" name="logname" class="form-style" placeholder="Phone" id="logname" autocomplete="off">
												<i class="input-icon uil uil-user"></i>
											</div>
											<div class="form-group mt-2">
												<input type="text" name="logname" class="form-style" placeholder="Birth" id="logname" autocomplete="off">
												<i class="input-icon uil uil-user"></i>
											</div>
											<div class="form-group mt-2">
												<input type="text" name="logname" class="form-style" placeholder="Gender" id="logname" autocomplete="off">
												<i class="input-icon uil uil-user"></i>
											</div>
											<div class="form-group mt-2">
												<input type="email" name="logemail" class="form-style" placeholder="Email" id="logemail" autocomplete="off">
												<i class="input-icon uil uil-at"></i>
											</div>
											<div class="form-group mt-2">
												<input type="text" name="logname" class="form-style" placeholder="Post" id="logname" autocomplete="off">
												<i class="input-icon uil uil-user"></i>
											</div>
											<div class="form-group mt-2">
												<input type="text" name="logname" class="form-style" placeholder="Addr" id="logname" autocomplete="off">
												<i class="input-icon uil uil-user"></i>
											</div>
											<div class="form-group mt-2">
												<input type="text" name="logname" class="form-style" placeholder="Addr" id="logname" autocomplete="off">
												<i class="input-icon uil uil-user"></i>
											</div>
											<a href="#" class="btn mt-4">submit</a>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
<script>
let loginApp=Vue.createApp({
	data(){
		return{
			id:'',
			pwd:''
		}
	},
	methods:{
		login(){
			if(this.id===''){
				alert('아이디를 입력하세요')
				this.$refs.id.focus()
				return
			}
			if(this.pwd===''){
				alert('비밀번호를 입력하세요')
				this.$refs.pwd.focus()
				return
			}
			axios.post('../member/vueLogin.do', null, {
				params:{
					id:this.id,
					pwd:this.pwd
				}
			}).then(response=>{
				if(response.data==='OK'){
					location.href='../main/main.do'
				}
				else if(response.data==='NOID'){
					alert('아이디가 존재하지 않습니다')
					this.$refs.id.focus()
					this.$refs.id.value=''
					this.$refs.pwd.value=''
				}
				else{
					alert('비밀번호가 틀렸습니다')
					this.$refs.pwd.focus()
					this.$refs.pwd.value=''
				}
			})
		}
	}
}).mount('.card-front')
</script>
</body>
</html>