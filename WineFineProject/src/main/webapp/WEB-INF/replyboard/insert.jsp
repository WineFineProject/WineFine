<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1:1 문의게시판</title>
<script src="https://unpkg.com/vue@3"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<style>
.result-list {
    max-height: 200px;
    overflow-y: auto;
    border: 1px solid #ccc;
    border-radius: 5px;
    margin-top: 5px;
}
.result-item {
    display: flex; 
    align-items: center; 
    cursor: pointer; 
    border-bottom: 1px solid #e0e0e0; 
}
.result-item:last-child {
    border-bottom: none; 
}
.result-item img {
    margin-right: 10px; 
}
.result-item:hover {
    background-color: #f5f5f5;
}
</style>
</head>
<body>
<div class="container" style="width: 800px;">
   <div class="row">
        <h3 class="text-center" style="margin-top:150px;">1:1 문의 게시판</h3>
            <div class="form-group">
                <label for="category">카테고리 선택</label>
                <select class="form-control" id="category">
                    <option value="">선택하세요</option>
                    <option value="product">상품 관련</option>
                    <option value="delivery">배송 관련</option>
                    <option value="service">서비스 관련</option>
                    <option value="payment">결제 관련</option>
                    <option value="other">기타</option>
                </select>
            </div>
            <div class="form-group" style="margin-top: 10px;">
                <label>문의할 대상을 선택하세요</label>
                <div style="margin-top: 5px;">
				    <input type="radio" id="admin" name="contact" value="admin" checked @change="Contact('admin')" style="margin-right: 10px;">
				    <label for="admin">관리자에게 문의</label>
				    <div style="display: inline-block; margin-left: 20px;">
				        <input type="radio" id="seller" name="contact" value="seller" @change="Contact('seller')" style="margin-right: 10px;">
				        <label for="seller">판매자에게 문의</label>
				    </div>
				</div>
				 <div v-if="contact === 'seller'" style="margin-top: 10px;">
                <label for="search">상품 검색</label>
                <input type="text" class="form-control" v-model="fd" placeholder="상품명을 입력하세요" @input="searchProducts">
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
                <input type="text" class="form-control" id="title" placeholder="제목을 입력하세요">
            </div>
            <div class="form-group" style="margin-top: 10px;">
                <label for="content">내용</label>
                <textarea class="form-control" id="content" rows="5" style="resize:none;" placeholder="문의 내용을 입력하세요"></textarea>
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
  </div>  
    <script>
    let app = Vue.createApp({
        data() {
            return {
                contact: 'admin', 
                fd: '', 
                foundProducts: [], 
                sellerName: '',
                title: '',
                content: '',
                selectedCategory: '',
                isSecret: false 
            }
        },
        methods: {
        	Contact(value) {
                this.contact = value
            },
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
                this.fd = product.namekor
                this.sellerName = product.seller
                this.foundProducts = []
            },
            cancelBtn() {
                window.location.href = '../replyboard/list.do'
            },
            sendBtn() {
            	const title = document.getElementById('title').value
                const content = document.getElementById('content').value
                const secret = this.isSecret ? 1 : 0;
                
                if (!title) {
                    alert('제목을 입력해주세요.')
                    document.getElementById('title').focus()
                    return
                }

                if (!content) {
                    alert('내용을 입력해주세요.')
                    document.getElementById('content').focus()
                    return
                }

                const sendPost = {
                    userid: this.userid,
                    nickname: this.nickname,
                    subject: this.title,
                    content: this.content,
                    cno: this.selectedCategory,
                    type: this.contact,
                    recvid: this.sellerName,
                    wno: this.productId,
                    group_id: 1, 
                    group_step: 0, 
                    isreply: 0, 
                    secret: secret
                }

                axios.post('../replyboard/insertOk.do', sendPost)
                    .then(response => {
                        window.location.href = '../replyboard/list.do'
                    })
                    .catch(error => {
                        console.error(error);
                    })
            }
        }
    }).mount('.row')
</script>
</body>
</html>