<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../tem/css/replyinsert.css">
</head>
<body>
	<div class="row" id="noticeTable">
		<h3 class="table-title text-center">공지사항 작성</h3>
		<div class="form-group" style="margin-top: 10px;">
			<label>공지 대상을 선택하세요</label>
			<div style="margin-top: 5px;">
				<div style="display: inline-block;">
					<input type="radio" name="type" :value="1" v-model="type" checked id="type1" @change="changeType()">
					<label for="type1" style="margin-right: 5px;">전체</label>
					<input type="radio" name="type" :value="2" v-model="type" id="type2" @change="changeType()">
					<label for="type2" style="margin-right: 5px;">카테고리별</label>
					<input type="radio" name="type" :value="3" v-model="type" id="type3" @change="changeType()">
					<label for="type3" style="margin-right: 5px;">제품별</label>
				</div>
			</div>
			<div v-if="type===2" style="margin-top: 10px;">
				<span>카테고리 선택</span><br> <select class="result-list" v-model="target">
					<option :value="1" class="result-item">레드</option>
					<option :value="2" class="result-item">화이트</option>
					<option :value="3" class="result-item">스파클링</option>
					<option :value="4" class="result-item">로제</option>
					<option :value="5" class="result-item">주정강화</option>
					<option :value="6" class="result-item">기타</option>
				</select>
			</div>
			<div v-if="type===3" style="margin-top: 10px;">
				<label for="search">상품 검색</label>
				<input type="text" class="form-control" v-model="fd" placeholder="상품명을 입력하세요" @keyup.enter="findWine_()" :disabled="isFd">
				<div class="result-list" v-show="isFind">
					<li v-for="product in foundProducts" class="result-item" @click="selectProduct(product)">
						<img :src="product.poster" style="width: 30px;">
						<a>{{product.namekor}}</a>
					</li>
				</div>
			</div>
			<div class="form-group" style="margin-top: 10px;">
				<label for="subject">제목</label>
				<input type="text" class="form-control" ref="subject" v-model="subject" id="subject" placeholder="제목을 입력하세요">
			</div>
			<div class="form-group" style="margin-top: 10px;">
				<label for="content">내용</label>
				<textarea class="form-control" ref="content" v-model="content" id="content" rows="5" style="resize: none;" placeholder="공지 내용을 입력하세요"></textarea>
			</div>
			<div class="form-group" style="margin-top: 10px;">
				<label for="secret" style="margin-right: 5px;">팝업공지 등록</label>
				<input type="checkbox" id="secret" v-model="isNotice">
			</div>
			<div style="margin-top: 30px;"></div>
			 <div class="button-group text-center">
				<input type="submit" class="btn btn-primary" value="등록" @click="insertNotice()">
				<input type="button" class="btn btn-danger" value="취소" onclick="javascript:history.back()">
			</div>
		</div>
	</div>
	<script>
		let noticeInsertApp=Vue.createApp({
			data(){
				return{
					type:1,
					target:1,
					content:'',
					subject:'',
					fd:'',
					isFind:false,
					isNotice:false,
					isFd:false,
					foundProducts:[]
				}
			},
			methods:{
							findWine_(){
								if(this.fd===''){
									this.isFind=false
								}
								else{
									this.isFind=true
								}
								axios.get('../seller/findWine.do', {
									params:{
										fd:this.fd
									}
								}).then(response=>{
									console.log(this.fd)
									this.foundProducts=response.data
								})
							},
	            selectProduct(product){
	            	this.target=product.wno
	            	this.fd=product.namekor
	            	this.isFind=false
	            	this.isFd=true
	            	this.foundProducts=[]
	            },
	            changeType(){
            		this.fd=''
            		this.isFind=false
            		this.isFd=false
            		this.target=1
            		this.foundProducts=[]
	            },
	            insertNotice(){
	            	if(this.type===3 && this.target===1){
	            		alert('제품을 선택해주세요')
	            		return
	            	}
	            	if(this.subject===''){
	            		alert('제목을 작성해주세요')
	            		this.$refs.subject.focus()
	            		return
	            	}
	            	if(this.content===''){
	            		alert('내용을 작성해주세요')
	            		this.$refs.content.focus()
	            		return
	            	}
	            	let notice=this.isNotice?1:0
	            	axios.post('../seller/insertNotice.do', null, {
	            		params:{
	            			subject:this.subject,
	            			content:this.content,
	            			type:this.type,
	            			target:this.target,
	            			isNotice:notice
	            		}
	            	}).then(response=>{
	            		location.href="../seller/notice.do"
	            	})
	            }
			}
		}).mount('#noticeTable')
	</script>
</body>
</html>