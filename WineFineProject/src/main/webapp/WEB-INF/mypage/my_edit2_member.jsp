<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
        background-color: #f8f9fa;  /* Bootstrap의 기본 옅은 회색 */
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
					<div class="container" v-for="vo in list">
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
								<label class="col-sm-2 col-form-label">닉네임*</label>
								<div class="col-sm-5">
									<input type="text" class="form-control"
										v-model="nickname" ref="nickname" value="${sessionScope.nickName}">
								</div>
							</div>
							<div class="row align mb-3">
								<label class="col-sm-2 col-form-label">우편번호</label> 
								<div class="col-sm-5"> 
									<input type="text" readonly class="form-control"
										id="post" v-model="post" ref="post" value="${sessionScope.post}">&nbsp;								
								</div>
								<div class="col-sm-3">
									<button type="button" class="btn border border-secondary rounded-pill px-4 py-2 mb-4 text-primary" id="postBtn">검색</button>
								</div>
							</div>
							<div class="row mb-3">
								<label class="col-sm-2 col-form-label">주소*</label>
								<div class="col-sm-10">
									<input type="text" readonly class="form-control"
										id="addr1" v-model="addr1" ref="addr1" value="${sessionScope.address}"><br>
									<input type="text" class="form-control"
										v-model="addr2" ref="addr2" value="${sessionScope.addr2}">
								</div>
							</div>
							<div class="row mb-3">
								<label class="col-sm-2 col-form-label">전화*</label>
								<div class="col-sm-5">
									<input type="text" class="form-control"
										v-model="phone" ref="phone" value="${sessionScope.phone}">
								</div>
							</div>
							<div class="row mb-3">
								<label class="col-sm-2 col-form-label">이메일*</label>
								<div class="col-sm-5">
									<input type="text" class="form-control"
										v-model="email" ref="email" value="${sessionScope.email}">
								</div>
							</div>
						
							</div>
							
								<div>
									<tr>
										<td colspan="2" class="text-center" style="border: none;">
											<input type="submit" class="btn border border-secondary rounded-pill px-4 py-2 mb-4 text-primary" value="변경">
										    <input type="button" class="btn border border-secondary rounded-pill px-4 py-2 mb-4 text-secondary" value="취소" @click="goBack">
										</td>
									</tr>
		
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
						id:'${sessionScope.userId}'
						nickname:'',
						post:'',
						addr1:'',
						addr2:'',
						phone:'',
						email:''
					}
				},
				methods:{
					  submitForm(){
					    let formData = new FormData()
					    formData.append("nickname", this.nickname)
					    formData.append("post", this.post)
					    formData.append("addr1", this.addr1)
					    formData.append("addr2", this.addr2)
					    formData.append("phone", this.phone)
					    formData.append("email", this.email)
					    formData.append("id", this.id)
					    
					    axios.post('../mypage/edit2_ok_vue_do',formData,{
					      headers: {
					        'Content-Type': 'multipart/form-data'
					      }
					    }).then(response => {
					      console.log('User info updated successfully:', response.data);
					      alert('정보가 성공적으로 업데이트되었습니다.');
					      // 페이지 이동 또는 새로고침
					      window.location.href = '/mypage'; // 마이페이지로 이동
					    }).catch(error => {
					      console.error('Error updating user info:', error);
					      alert('정보 업데이트 중 오류가 발생했습니다.');
					    })
					  },
					  goBack() {
					    history.back();
					  }
					},
				mounted(){
					axios.get('my_edit2_member_vue.do',{
						params:{
							id:this.id
							}
						}).then(response => {
						    const data = response.data;
						    this.nickname = data.nickname;
						    this.post = data.post;
						    this.addr1 = data.addr1;
						    this.addr2 = data.addr2;
						    this.phone = data.phone;
						    this.email = data.email;
						  }).catch(error => {
						    console.log(error.response);
						    alert('정보를 불러오는 데 실패했습니다.');
						  })
					}
			}).mount('#edit2')
		</script>
</body>
</html>