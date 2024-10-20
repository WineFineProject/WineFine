<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://unpkg.com/vue@3"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<link rel="stylesheet" href="../tem/css/replyinsert.css">
</head>
<body>
<div class="container" style="width: 800px;">
   <div class="row">
        <h3 class="text-center" style="margin-top:50px;">수정하기</h3>
            <div class="form-group">
                <label for="category">카테고리 선택</label>
                <select class="form-control" id="category" v-model="cno" ref="cno">
                    <option value="" disabled selected>선택하세요</option>
                    <option value="1">상품 관련</option>
                    <option value="2">배송 관련</option>
                    <option value="3">서비스 관련</option>
                    <option value="4">결제 관련</option>
                    <option value="5">기타</option>
                </select>
            </div>
            <div class="form-group" style="margin-top: 10px;">
				 <div style="margin-top: 10px;" v-if="type!==2 && namekor && seller">
                <label for="search">상품명</label>
                <span class="form-control">{{namekor}}</span>
                <label for="sellerName" style="margin-top: 10px;">판매자명</label>
                <span class="form-control">{{seller}}</span>
            </div>
            <div class="form-group" style="margin-top: 10px;">
                <label for="title">제목</label>
                <input type="text" class="form-control" id="subject" v-model="subject" placeholder="제목을 입력하세요" ref="title">
            </div>
            <div class="form-group" style="margin-top: 10px;">
                <label for="content">내용</label>
                <textarea v-model="content" class="form-control" id="content" rows="5" style="resize:none;" placeholder="문의 내용을 입력하세요" ref="contnet"></textarea>
            </div>
            <div class="form-group" style="margin-top: 10px;">
			    <input type="checkbox" id="secret" v-model="isSecret" style="margin-right: 5px;">
			    <label for="secret">비밀글</label>
			</div>
            <div style="margin-top: 10px;"></div>
            <div class="text-center">
			    <button type="button" class="btn btn-primary" @click="sendBtn">수정</button>
			    <input type="button" class="btn btn-secondary" value="취소" @click="cancelBtn">
			</div>
        </div>   
    </div>
  </div>  
 <script>
 let insertApp=Vue.createApp({
     data() {
         return {
        	 type:0,
        	 wrno: ${wrno},
        	 subject: '',
             content: '',
             selectedCategory: '',
             isSecret: false ,
             cno:1,
             seller:'',
             namekor:'',
             wno:0
         }
     },
     mounted(){
    	 axios.get('../replyboard/updatevue.do',{
    		 params:{
    			 wrno: this.wrno
    		 }
    	 }).then(response=>{
    		 this.wno=response.data.wno
    		 this.type=response.data.type
    		 this.subject=response.data.subject
    		 this.content=response.data.content
    		 this.cno=response.data.cno
    		 this.seller=response.data.wvo.mvo.nickName
    		 this.namekor=response.data.wvo.namekor
    		 this.isSecret=response.data.secret===1?true:false
    	 })
     },
     methods: {
         cancelBtn() {
             window.location.href = '../replyboard/list.do'
         },
         sendBtn() {
         	 let title = this.subject
             let content = this.content
             let secret = this.isSecret ? 1 : 0
             
             if (!title) {
                 alert('제목을 입력해주세요.')
                	this.$refs.title.focus()
                 return
             }

             if (!content) {
                 alert('내용을 입력해주세요.')
                 this.$refs.content.focus()
                 return
             }

             axios.post('../replyboard/updateOkvue.do', null, {
             params:{
            	 wrno:this.wrno,
             	 subject: this.subject,
                 content: this.content,
                 cno: this.cno,
                 wno: this.wno,
                 secret: secret
             	}
             }).then(response => {
                     window.location.href = '../replyboard/list.do'
                 })
                 .catch(error => {
                     console.error(error)
                 })
         }
     }
 }).mount('.row')
 </script> 
</body>
</html>