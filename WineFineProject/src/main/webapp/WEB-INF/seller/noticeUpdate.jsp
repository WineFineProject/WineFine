<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" href="../tem/css/replyinsert.css">
</head>
<body>
	<div class="row"  id="noticeTable">
		<h3 class="table-title text-center">공지사항 수정</h3>
		<div class="form-group" style="margin-top: 10px;">
			<div class="form-group" style="margin-top: 10px;">
				<label for="subject">제목</label>
				<input type="text" class="form-control" ref="subject" v-model="subject" id="subject" placeholder="제목을 입력하세요">
			</div>
			<div class="form-group" style="margin-top: 10px;">
				<label for="subject">대상</label> 
				<span class="form-control" v-if="detail.type===1">전체</span>
				<span class="form-control" v-if="detail.type===2">{{types[detail.target]}}</span>
				<span class="form-control" v-if="detail.type===3">{{detail.wvo.namekor}}</span>
			</div>
			<div class="form-group" style="margin-top: 10px;">
				<label for="content">내용</label>
				<textarea class="form-control" ref="content" v-model="content" id="content" rows="5" style="resize: none;" placeholder="공지 내용을 입력하세요">{{detail.content}}</textarea>
			</div>
			<div class="form-group" style="margin-top: 10px;">
				<label for="secret" style="margin-right: 5px;">팝업공지 등록</label>
				<input type="checkbox" id="secret" v-model="isNotice">
			</div>
			<div style="margin-top: 30px;"></div>
			<div class="button-group text-center">
			    <input type="submit" class="btn btn-primary" value="등록" @click="updateNotice()">
				<input type="button" class="btn btn-danger" value="취소" onclick="javascript:history.back()">
			</div>
		</div>
	</div>
	<script>
		let noticeInsertApp=Vue.createApp({
			data(){
				return{
					content:'',
					subject:'',
					isNotice:false,
					types:['', '레드', '화이트', '스파클링', '로제', '주정강화', '기타'],
					nbno:${nbno},
					detail:{}
				}
			},
			methods:{
				updateNotice(){
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
	            	axios.post('../seller/vueNoticeUpdate.do', null, {
	            		params:{
	            			nbno:this.nbno,
	            			subject:this.subject,
	            			content:this.content,
	            			type:this.detail.type,
	            			target:this.detail.target,
	            			isNotice:notice
	            		}
	            	}).then(response=>{
	            		location.href="../seller/noticeDetail.do?nbno="+this.nbno
	            	})
	            }
			},
			mounted(){
				axios.get('../seller/vueNoticeDetailData.do', {
					params:{
						nbno:this.nbno
					}
				}).then(response=>{
					this.detail=response.data
					this.subject=response.data.subject
					this.content=response.data.content
				})
			}
		}).mount('#noticeTable')
	</script>
</body>
</html>