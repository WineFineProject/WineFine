<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1:1 문의게시판</title>
<script src="https://unpkg.com/vue@3"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<link rel="stylesheet" href="../tem/css/replyinsert.css">
</head>
<body>
<div class="container" style="width: 800px;">
   <div class="row">
        <h3 class="text-center" style="margin-top:50px;">1:1 문의 게시판</h3>
            <div class="form-group">
                <label for="category">카테고리 선택</label>
                <select class="form-control" id="category" v-model="cno" ref="cno">
                    <option value="" disabled selected>선택하세요</option>
                    <option value="1">상품 관련</option>
                    <option value="2">프로모션 관련</option>
                    <option value="3">서비스 관련</option>
                    <option value="4">정산 관련</option>
                    <option value="5">기타</option>
                </select>
            </div>
            <div class="form-group" style="margin-top: 10px;">
                <label for="title">제목</label>
                <input type="text" class="form-control" id="title" v-model="title" placeholder="제목을 입력하세요" ref="title">
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
			    <button type="button" class="btn btn-primary" @click="sendBtn">등록</button>
			    <input type="button" class="btn btn-secondary" value="취소" @click="cancelBtn">
			</div>
        </div>   
    </div>
    <script>
    let insertApp=Vue.createApp({
        data() {
            return {
                contact: 3, 
                fd: '', 
                foundProducts: [], 
                sellerName: '',
                title: '',
                content: '',
                selectedCategory: '',
                isSecret: false ,
                cno:1,
                isFd:false,
                select:{},
                sendid:''
            }
        },
        methods: {
            searchProducts() { 
                if (this.fd.length === 0) {
                    this.foundProducts = []
                    this.sellerName = ''
                    return
                }
                axios.get('../replyboard/findWine.do', { 
                    params: { 
                    	fd: this.fd 
                    }
                }).then(response => {
                    this.foundProducts = response.data
                }).catch(error => {
                	alert(error.response)
   				    console.log(error.response)
                })
            },
            selectProduct(product) {
            	this.select=product
                this.fd = product.namekor
                this.sellerName = product.mvo.nickName
                this.sendid=product.seller
                this.foundProducts = []
                this.isFd=true
            },
            cancelBtn() {
                window.location.href = '../replyboard/list.do'
            },
            sendBtn() {
            	let title = this.title
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

                axios.post('../replyboard/insertOk.do', null, {
                params:{
                	subject: this.title,
                    content: this.content,
                    cno: this.cno,
                    type: this.contact,
                    recvid: this.sendid,
                    wno: this.select.wno,
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