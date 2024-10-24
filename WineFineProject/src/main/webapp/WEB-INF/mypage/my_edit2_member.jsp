<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script type="text/javascript" src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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
	background-color: #f8f9fa; 
	cursor: not-allowed;
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
									<input type="text" readonly class="form-control" value="${sessionScope.userName}">
								</div>
							</div>
							<div class="row mb-3">
								<label class="col-sm-2 col-form-label">성별</label>
								<div class="col-sm-5">
									<input type="text" readonly class="form-control" value="${sessionScope.sex}">
								</div>
							</div>
							<div class="row mb-3">
								<label class="col-sm-2 col-form-label">아이디</label>
								<div class="col-sm-5">
									<input type="text" readonly class="form-control" value="${sessionScope.userId}">
								</div>
							</div>
							<div class="row mb-3">
								<label class="col-sm-2 col-form-label">닉네임*</label>
								<div class="col-sm-5">
									<input type="text" class="form-control" v-model="nickName" ref="nickName">
								</div>
							</div>
							<div class="row align mb-3">
								<label class="col-sm-2 col-form-label">우편번호</label>
								<div class="col-sm-5">
									<input type="text" readonly class="form-control" v-model="post" ref="post" id="post">
									&nbsp;
								</div>
								<div class="col-sm-3">
									<button type="button" class="btn border border-secondary rounded-pill px-4 py-2 mb-4 text-primary" @click="openDaumPostcode">검색</button>
								</div>
							</div>
							<div class="row mb-3">
								<label class="col-sm-2 col-form-label">주소*</label>
								<div class="col-sm-10">
									<input type="text" readonly class="form-control" id="addr1" v-model="addr1" ref="addr1">
									<br>
									<input type="text" class="form-control" v-model="addr2" ref="addr2">
								</div>
							</div>
							<div class="row mb-3">
								<label class="col-sm-2 col-form-label">전화*</label>
								<div class="col-sm-5">
									<input type="text" class="form-control" v-model="phone" ref="phone">
								</div>
							</div>
							<div class="row mb-3">
								<label class="col-sm-2 col-form-label">이메일*</label>
								<div class="col-sm-5">
									<input type="text" class="form-control" v-model="email" ref="email">
								</div>
							</div>

						</div>

						<div>
							<!-- <tr>
										<td colspan="2" class="text-center" style="border: none;">  -->
							<input type="submit" class="btn border border-secondary rounded-pill px-4 py-2 mb-4 text-primary" value="변경">
							&nbsp;&nbsp;
							<input type="button" class="btn border border-secondary rounded-pill px-4 py-2 mb-4 text-secondary" value="취소" @click="goBack()">
							<!-- </td>
									</tr> -->

						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<script>
			let edit2App=Vue.createApp({
				data(){
					return{
						
						id:'',
						userName: '',
		                sex: '',
						nickName:'',
						post:'',
						addr1:'',
						addr2:'',
						phone:'',
						email:''
					}
				},
				methods:{
					 openDaumPostcode() {
						      new daum.Postcode({
						        oncomplete: (data) => {
						          this.post = data.zonecode
						          this.addr1 = data.address 
						        }
						      }).open()
						    },
			         validate() {
	                    if (!this.nickName.trim()) {
	                        this.$refs.nickName.focus();
	                        return false
	                    }
	                    if (!this.addr2.trim()) {
	                        this.$refs.addr2.focus();
	                        return false
	                    }
	                    if (!this.phone.trim()) {
	                        this.$refs.phone.focus();
	                        return false
	                    }
	                    if (!this.email.trim()) {
	                        this.$refs.email.focus();
	                        return false
	                    }
	                    return true;
	                },
	                async submitForm() {
	                    if (!this.validate()) return                    
	                    try {
	                        const formData = new URLSearchParams();  // form 데이터 형식으로 변경
	                        formData.append('nickName', this.nickName);
	                        formData.append('userId', this.id);
	                        formData.append('post', this.post);
	                        formData.append('addr1', this.addr1);
	                        formData.append('addr2', this.addr2);
	                        formData.append('phone', this.phone);
	                        formData.append('email', this.email);

	                        const response = await axios.post('../mypage/my_edit2_member_ok_vue.do', 
	                            formData.toString(),  // 문자열로 변환
	                            {
	                                headers: {
	                                    'Content-Type': 'application/x-www-form-urlencoded'
	                                }
	                            }
	                        )
	                        
	                        if (response.data === "yes") {
	                            alert('회원정보가 성공적으로 수정되었습니다.')
	                            window.location.href = '../mypage/my_edit_member.do'
	                        } else {
	                            alert('회원정보 수정에 실패했습니다. 서버 응답: ' + response.data)
	                        }
	                    } catch (error) {
	                        console.error('Error상세정보:', {
	                            message: error.message,
	                            response: error.response?.data,
	                            status: error.response?.status,
	                            config: error.config
	                        });
	                        if (error.response) {
	                            console.error('Response data:', error.response.data);
	                            console.error('Response status:', error.response.status)
	                        }
	                        alert('회원정보 수정 중 오류가 발생했습니다. 상세 내용은 콘솔을 확인해주세요.')
	                    }
	                },
	                
	                goBack() {
	                    history.back()
	                }
	            },
	            
	            async mounted() {
	                try {
	                    const response = await axios.get('my_edit2_member_vue.do',{
	                    	params:{
	                    		id:this.id
	                    	}
	                    })
	                    const userData = response.data	                    
	                    this.nickName = userData.nickName
	                    this.post = userData.post
	                    this.addr1 = userData.addr1
	                    this.addr2 = userData.addr2
	                    this.phone = userData.phone
	                    this.email = userData.email
	                } catch (error) {
	                    console.error('Error:', error)
	                    alert('회원정보를 불러오는데 실패했습니다.')
	                }
	            }
			}).mount('#edit2')
		</script>

</body>
</html>