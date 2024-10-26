<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1:1 문의게시판</title>
<link rel="stylesheet" href="../tem/css/replyinsert.css">
</head>
<body>
   <div class="row" id="replyInsertApp">
        <h3 class="table-title text-center" style="margin-top:20px;">문의 작성</h3>
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
                <div style="margin-top: 5px;">
				    <div style="display: inline-block; margin-left: 20px;">
				        <input type="radio" id="seller" name="contact" value="1" v-model="contact" style="margin-right: 10px;">
				        <label for="seller">판매자에게 문의</label>
				    </div>
				</div>
				 <div  style="margin-top: 10px;">
                <label for="search">상품 검색</label>
                <input type="text" class="form-control" v-model="fd" :disabled="isFd" placeholder="상품명을 입력하세요" @keyup.enter="searchProducts">
                <div class="result-list" v-if="foundProducts.length > 0">
                        <li v-for="product in foundProducts" :key="product.wno" class="result-item" @click="selectProduct(product)">
                            <img :src="product.poster" style="width: 30px;">
                            <a>{{product.namekor}}</a> 
                        </li>
                </div>
                <label for="sellerName" style="margin-top: 10px;">판매자명</label>
                <input type="text" class="form-control" v-model="sellerName" readonly>
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
			<div style="margin-top: 50px;"></div>
			<div class="text-center button-group">
				<button type="button" class="btn btn-primary" @click="sendBtn">등록</button>
				<input type="button" class="btn btn-danger" value="취소" @click="cancelBtn">
			</div>
        </div>   
    </div>
    <script>
    let insertApp=Vue.createApp({
        data() {
            return {
                contact: 1, 
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
                history.back()
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
                        history.back()
                    })
                    .catch(error => {
                        console.error(error)
                    })
            }
        }
    }).mount('#replyInsertApp')
</script>
</body>
</html>