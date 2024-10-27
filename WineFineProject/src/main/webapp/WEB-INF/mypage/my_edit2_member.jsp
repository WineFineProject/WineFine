<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script type="text/javascript"
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
	$(function() {
		$('#postBtn').click(function() {
			new daum.Postcode({
				oncomplete : function(data) {
					$('#post').val(data.zonecode)
					$('#addr1').val(data.address)
				}
			}).open()
		})
	})
</script>
<style type="text/css">
input[readonly] {
	background-color: #f8f9fa; /* Bootstrap의 기본 옅은 회색 */
	cursor: not-allowed;
}

.valid-feedback {
	color: green;
	display: none;
}

.invalid-feedback {
	color: red;
	display: none;
}

.btn {
	min-width: 120px !important; /* 모든 버튼의 최소 너비 지정 */
	text-align: center !important;
	padding-left: 20px !important;
	padding-right: 20px !important;
}
</style>
</head>
<body>
	<div class="container-fluid py-5" id="edit2">
		<div class="container py-5">
			<div class="row">
				<div class="col-lg-12">
					<form @submit.prevent="submitForm">
						<div class="container">

							<div class="row mb-3">
								<label class="col-sm-2 col-form-label">이름</label>
								<div class="col-sm-5">
									<input type="text" readonly class="form-control"
										value="${sessionScope.userName}">
								</div>
							</div>

							<div class="row mb-3">
								<label class="col-sm-2 col-form-label">성별</label>
								<div class="col-sm-5">
									<input type="text" readonly class="form-control"
										value="${sessionScope.sex}">
								</div>
							</div>

							<div class="row mb-3">
								<label class="col-sm-2 col-form-label">아이디</label>
								<div class="col-sm-5">
									<input type="text" readonly class="form-control"
										value="${sessionScope.userId}">
								</div>
							</div>

							<div class="row mb-3">
								<label class="col-sm-2 col-form-label">닉네임</label>
								<div class="col-sm-5">
									<input type="text" class="form-control" v-model="nickName"
										ref="nickName"
										:class="{'is-valid': isNickNameChecked && isNickNameValid, 
                                        	     'is-invalid': isNickNameChecked && !isNickNameValid}">
									<div class="valid-feedback">사용 가능한 닉네임입니다.</div>
									<div class="invalid-feedback">이미 사용중인 닉네임입니다.</div>
								</div>
								<div class="col-sm-3">
									<button type="button"
										class="btn border border-secondary rounded-pill px-4 py-2 mb-4 text-primary"
										@click="checkNickName">중복확인</button>
								</div>
							</div>

								<div class="row align mb-3">
									<label class="col-sm-2 col-form-label">우편번호</label>
									<div class="col-sm-5">
										<input type="text" readonly class="form-control"
											v-model="post" ref="post" id="post">
									</div>
									<div class="col-sm-3">
										<button type="button"
											class="btn border border-secondary rounded-pill px-4 py-2 mb-4 text-primary"
											@click="openDaumPostcode">검색</button>
									</div>
								</div>

								<div class="row mb-3">
									<label class="col-sm-2 col-form-label">주소*</label>
									<div class="col-sm-10">
										<input type="text" readonly class="form-control" id="addr1"
											v-model="addr1" ref="addr1"><br> <input
											type="text" class="form-control" v-model="addr2" ref="addr2">
									</div>
								</div>
								<div class="row mb-3">
									<label class="col-sm-2 col-form-label">전화</label>
									<div class="col-sm-5">
										<input type="text" class="form-control" v-model="phone"
											ref="phone"
											:class="{'is-valid': isPhoneChecked && isPhoneValid, 
                                        	     'is-invalid': isPhoneChecked && !isPhoneValid}">
										<div class="valid-feedback">사용 가능한 전화번호입니다.</div>
										<div class="invalid-feedback">이미 등록된 전화번호입니다.</div>
									</div>
									<div class="col-sm-3">
										<button type="button"
											class="btn border border-secondary rounded-pill px-4 py-2 mb-4 text-primary"
											@click="checkPhone">중복확인</button>
									</div>
								</div>
								<div class="row mb-3">
									<label class="col-sm-2 col-form-label">이메일</label>
									<div class="col-sm-5">
										<input type="text" class="form-control" v-model="email"
											ref="email"
											:class="{'is-valid': isEmailChecked && isEmailValid, 
                                           'is-invalid': isEmailChecked && !isEmailValid}">
										<div class="valid-feedback">사용 가능한 이메일입니다.</div>
										<div class="invalid-feedback">이미 등록된 이메일입니다.</div>
									</div>
									<div class="col-sm-3">
										<button type="button"
											class="btn border border-secondary rounded-pill px-4 py-2 mb-4 text-primary"
											@click="checkEmail">중복확인</button>
									</div>
								</div>

								<div class="form-group mb-3">
								    <label>현재 비밀번호 확인</label>
								    <div class="input-group">
								        <input type="password" 
								               class="form-control" 
								               v-model="currentPassword"
								               ref="passwordInput"
								               :disabled="isPasswordVerified"
								               placeholder="현재 비밀번호를 입력하세요">
								        <button type="button" 
								                class="btn btn-outline-secondary"
								                @click="verifyPassword"
								                :disabled="isPasswordVerified">
								            비밀번호 확인
								        </button>
								    </div>
								    <small class="form-text text-success" v-if="isPasswordVerified">
								        <i class="fas fa-check"></i> 비밀번호가 확인되었습니다
								    </small>
								</div>

							</div>

							<div>
								<div class="text-center mb-2" v-if="!canSubmit">
									<small class="text-danger"> 다음 항목을 확인해주세요: <span
										v-if="!isNickNameChecked || !isNickNameValid">닉네임 중복확인</span>
										<span
										v-if="(!isNickNameChecked || !isNickNameValid) && (!isPhoneChecked || !isPhoneValid || !isEmailChecked || !isEmailValid || !addr2.trim())">,
									</span> <span v-if="!isPhoneChecked || !isPhoneValid">전화번호 중복확인</span>
										<span
										v-if="(!isPhoneChecked || !isPhoneValid) && (!isEmailChecked || !isEmailValid || !addr2.trim())">,
									</span> <span v-if="!isEmailChecked || !isEmailValid">이메일 중복확인</span>
										<span
										v-if="(!isEmailChecked || !isEmailValid) && !addr2.trim()">,
									</span> <span v-if="!addr2.trim()">상세주소 입력</span> <span
										v-if="!addr2.trim() && !isPasswordValid">, </span> <span
										v-if="!isPasswordChecked || !isPasswordValid">비밀번호 확인</span>
									</small>
								</div>
								<input type="submit"
									class="btn border border-secondary rounded-pill px-4 py-2 mb-4 text-primary"
									value="변경" :disabled="!canSubmit">
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input
									type="button"
									class="btn border border-secondary rounded-pill px-4 py-2 mb-4 text-secondary"
									value="취소" @click="goBack()">
								<!-- </td>
									</tr> -->

							</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<script>
		let edit2App = Vue.createApp({
		    data() {
		        return {
		            id: '',
		            userName: '',
		            sex: '',
		            nickName: '',
		            post: '',
		            addr1: '',
		            addr2: '',
		            phone: '',
		            email: '',
		            isNickNameChecked: false,
		            isPhoneChecked: false,
		            isEmailChecked: false,
		            isNickNameValid: false,
		            isPhoneValid: false,
		            isEmailValid: false,
		            
		            currentPassword: '',
		            isPasswordVerified: false
		        }
		    },
		    computed: {
		    	canSubmit() {
		            return this.addr2.trim() !== '' &&
		                   this.isNickNameChecked && this.isNickNameValid &&
		                   this.isPhoneChecked && this.isPhoneValid &&
		                   this.isEmailChecked && this.isEmailValid &&		                   
		                   this.currentPassword !=='' && this.isPasswordVerified;
		        }
		    },
		    methods: {
		        openDaumPostcode() {
		            new daum.Postcode({
		                oncomplete: (data) => {
		                    this.post = data.zonecode
		                    this.addr1 = data.address 
		                }
		            }).open()
		        },
		        async checkNickName() {
		            if (!this.nickName.trim()) {
		                alert('닉네임을 입력해주세요');
		                return;
		            }
		            try {
		                const response = await axios.get('../mypage/nickname_check_vue.do', {
		                    params: {
		                        nickName: this.nickName,
		                        userId: '${sessionScope.userId}'
		                    }
		                });
		                this.isNickNameChecked = true;
		                this.isNickNameValid = response.data === 'yes';
		            } catch (error) {
		                console.error('닉네임 중복체크 오류:', error);
		                alert('중복체크 중 오류가 발생했습니다.');
		            }
		        },
		        async checkPhone() {
		            if (!this.phone.trim()) {
		                alert('전화번호를 입력해주세요');
		                return;
		            }
		            try {
		                const response = await axios.get('../mypage/phone_check_vue.do', {
		                    params: {
		                        phone: this.phone,
		                        userId: '${sessionScope.userId}'
		                    }
		                });
		                this.isPhoneChecked = true;
		                this.isPhoneValid = response.data === 'yes';
		            } catch (error) {
		                console.error('전화번호 중복체크 오류:', error);
		                alert('중복체크 중 오류가 발생했습니다.');
		            }
		        },
		        async checkEmail() {
		            if (!this.email.trim()) {
		                alert('이메일을 입력해주세요');
		                return;
		            }
		            try {
		                const response = await axios.get('../mypage/email_check_vue.do', {
		                    params: {
		                        email: this.email,
		                        userId: '${sessionScope.userId}'
		                    }
		                });
		                this.isEmailChecked = true;
		                this.isEmailValid = response.data === 'yes';
		            } catch (error) {
		                console.error('이메일 중복체크 오류:', error);
		                alert('중복체크 중 오류가 발생했습니다.');
		            }
		        },
		        async verifyPassword() {
		            if (!this.currentPassword) {
		                alert('현재 비밀번호를 입력해주세요.');
		                return;
		            }
		            
		            try {
		                const formData = new URLSearchParams();
		                formData.append('userId','${sessionScope.userId}');
		                formData.append('currentPassword', this.currentPassword);
		                
		                console.log('비밀번호 확인 요청:', {
		                    userId: '${sessionScope.userId}',
		                    password: this.currentPassword
		                });
		                
		                const response = await axios.post('../mypage/verify_password.do', 
		                    formData.toString(),
		                    {
		                        headers: {
		                            'Content-Type': 'application/x-www-form-urlencoded'
		                        }
		                    }
		                );
		                
		                console.log('서버 응답:', response.data);
		                
		                if (response.data === 'yes') {
		                    this.isPasswordVerified = true;
		                    alert('비밀번호가 확인되었습니다.');
		                    // 비밀번호 입력필드 비활성화 또는 숨기기
		                    this.$refs.passwordInput.disabled = true;
		                } else {
		                    this.isPasswordVerified = false;
		                    alert('비밀번호가 일치하지 않습니다.(응답: ' + response.data + ')');
		                }
		            } catch (error) {
		                console.error('비밀번호 확인 오류:', error);
		                console.error('상태코드:', error.response.status);
		                alert('비밀번호 확인 중 오류가 발생했습니다.');
		            }
		        },
		        
		        validate() {
		            if (!this.nickName.trim() || !this.isNickNameValid) {
		                this.$refs.nickName.focus();
		                return false;
		            }
		            if (!this.addr2.trim()) {
		                this.$refs.addr2.focus();
		                return false;
		            }
		            if (!this.phone.trim() || !this.isPhoneValid) {
		                this.$refs.phone.focus();
		                return false;
		            }
		            if (!this.email.trim() || !this.isEmailValid) {
		                this.$refs.email.focus();
		                return false;
		            }
		            
		            if (!this.isPasswordVerified) {
		                alert('현재 비밀번호를 확인해주세요.');
		                this.$refs.passwordInput.focus();
		                return false;
		            }
		            return true;
		        },
		        async submitForm() {
		            if (!this.validate()) return                    
		            try {
		                const formData = new URLSearchParams();
		                formData.append('nickName', this.nickName);
		                formData.append('userId', this.id);
		                formData.append('post', this.post);
		                formData.append('addr1', this.addr1);
		                formData.append('addr2', this.addr2);
		                formData.append('phone', this.phone);
		                formData.append('email', this.email);

		                const response = await axios.post('../mypage/my_edit2_member_ok_vue.do', 
		                    formData.toString(),
		                    {
		                        headers: {
		                            'Content-Type': 'application/x-www-form-urlencoded'
		                        }
		                    }
		                )
		                
		                if (response.data === "yes") {
		                    alert('회원정보가 성공적으로 수정되었습니다.')
		                    //window.location.href = '../mypage/my_edit_member.do'
		                } else {
		                    alert('회원정보 수정에 실패했습니다. 서버 응답: ' + response.data)
		                }
		            } catch (error) {
		                console.error('Error상세정보:', error);
		                alert('회원정보 수정 중 오류가 발생했습니다.')
		            }
		        },
		        goBack() {
		            history.back()
		        },
		        async loadUserData() {
		            try {
		                const response = await axios.get('my_edit2_member_vue.do', {
		                    params: {
		                        id: this.id
		                    }
		                });
		                
		                const userData = response.data;
		                
		                this.nickName = userData.nickName;
		                this.post = userData.post;
		                this.addr1 = userData.addr1;
		                this.addr2 = userData.addr2;
		                this.phone = userData.phone;
		                this.email = userData.email;
		                
		                this.isNickNameChecked = true;
		                this.isNickNameValid = true;
		                this.isPhoneChecked = true;
		                this.isPhoneValid = true;
		                this.isEmailChecked = true;
		                this.isEmailValid = true;
		                
		            } catch (error) {
		                console.error('Error:', error);
		                alert('회원정보를 불러오는데 실패했습니다.');
		            }
		        }
		        
		    },
		    mounted() {
		        this.id = '${sessionScope.userId}';
		        
		        if (!this.id) {
		            console.error('사용자 ID를 찾을 수 없습니다.');
		            alert('로그인이 필요합니다.');
		            window.location.href = '../member/login.do';
		            return;
		        }
		        
		        this.loadUserData();
		    },
		    watch: {
		        nickName() {
		            this.isNickNameChecked = false;
		            this.isNickNameValid = false;
		        },
		        phone() {
		            this.isPhoneChecked = false;
		            this.isPhoneValid = false;
		        },
		        email() {
		            this.isEmailChecked = false;
		            this.isEmailValid = false;
		        },
		        currentPassword() {
		           
		            this.isPasswordVerified = false;
		        }
		    }
		}).mount('#edit2')
		</script>
</body>
</html>