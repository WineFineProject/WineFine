<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
					<div class="container">
						<form @submit.prevent="submitForm">
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
										v-model="nickname" ref="nickname">
								</div>
							</div>
							<div class="row mb-3">
								<label class="col-sm-2 col-form-label">우편번호</label>
								<div class="col-sm-5">
									<input type="text" readonly class="form-control"
										v-model="post" ref="post">
								</div>
							</div>
							<div class="row mb-3">
								<label class="col-sm-2 col-form-label">주소*</label>
								<div class="col-sm-10">
									<input type="text" readonly class="form-control"
										v-model="addr1" ref="addr1"><br>
									<input type="text" class="form-control"
										v-model="addr2" ref="addr2">
								</div>
							</div>
							<div class="row mb-3">
								<label class="col-sm-2 col-form-label">전화*</label>
								<div class="col-sm-5">
									<input type="text" class="form-control"
										v-model="phone" ref="phone">
								</div>
							</div>
							<div class="row mb-3">
								<label class="col-sm-2 col-form-label">이메일*</label>
								<div class="col-sm-5">
									<input type="text" class="form-control"
										v-model="email" ref="email">
								</div>
							</div>
						</form>
					</div>
						<div>
							<tr>
								<td colspan="2" class="text-center" style="border: none;">
									<input type="submit"
									class="btn border border-secondary rounded-pill px-4 py-2 mb-4 text-primary"
									value="변경"> &nbsp; <input type="button"
									class="btn border border-secondary rounded-pill px-4 py-2 mb-4 text-secondary"
									value="취소" onclick="javascript:history.back()">
								</td>
							</tr>

						</div>

					</div>
				</div>
			</div>
		</div>
		<script>
			let editApp=Vue.createApp({
				data(){
					return{
						nickname:'',
						post:'',
						addr1:'',
						addr2:''',
						phone:'',
						email:''
					}
				},
				mounted(){
					axios.get('my_edit2_member_vue.do')
				}.then(response=>{
					this.nickname=response.data.nickname,
					this.post=response.data.post,
					this.addr1=response.data.addr1,
					this.addr2=response.data.addr2,
					this.phone=response.data.phone,
					this.email=response.data.email
				}).catch(error=>{
					console.log(error.response)
				})
			}).mount('#edit2')
		</script>
</body>
</html>