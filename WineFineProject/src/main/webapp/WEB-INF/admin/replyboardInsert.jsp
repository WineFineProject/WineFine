<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1:1 문의 답변</title>
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
	<div class="row" id="replyInsertApp">
		<h3 class="text-center">답변 작성</h3>
		<div class="form-group" style="margin-top: 10px;">
			<table class="table">
				<tr>
					<th width="10%" class="text-center">질문 카테고리</th>
					<td width="90%"><span class="form-control">{{detail.type===2?cnos1[detail.cno]:cnos2[detail.cno]}}</span></td>
				</tr>
				<tr>
					<th width="10%" class="text-center">질문 제목</th>
					<td width="90%"><span class="form-control">{{detail.subject}}</span></td>
				</tr>
				<tr>
					<th width="10%" class="text-center">질문 내용</th>
					<td width="90%"><span class="form-control">{{detail.content}}</span></td>
				</tr>
			</table>
			<div class="form-group" style="margin-top: 10px;">
				<label for="subject">제목</label> <input type="text" class="form-control" ref="subject" v-model="subject" id="subject" placeholder="제목을 입력하세요">
			</div>
			<div class="form-group" style="margin-top: 10px;">
				<label for="content">내용</label>
				<textarea class="form-control" ref="content" v-model="content" id="content" rows="5" style="resize: none;" placeholder="공지 내용을 입력하세요"></textarea>
			</div>
			<div style="margin-top: 10px;"></div>
			<div class="text-center">
				<button type="button" class="btn btn-primary" @click="replyInsert">등록</button>
				<input type="button" class="btn btn-secondary" value="취소" onclick="javascript:history.back()">
			</div>
		</div>
	</div>
	<script>
	let replyInsertApp=Vue.createApp({
		data(){
			return{
				wrno:${wrno},
				detail:{},
				subject:'',
				content:'',
				cnos1:['','상품 관련', '배송 관련','서비스 관련','결제 관련','기타'],
				cnos2:['', '상품 관련', '프로모션 관련', '서비스 관련', '정산 관련', '기타']
			}
		},
		methods:{
			replyInsert(){
				if(this.subject===''){
					this.$refs.subject.focus()
					return
				}
				if(this.content===''){
					this.$refs.content.focus()
					return
				}
				axios.post('../replyboard/adminReplyInsert.do', null, {
					params:{
						subject:this.subject,
						content:this.content,
						group_id:this.detail.group_id,
						recvid:this.detail.userid,
						wno:this.detail.wno,
						wrno:this.detail.wrno,
						secret:this.detail.secret,
						type:this.detail.type,
						cno:this.detail.cno
					}
				}).then(response=>{
					location.href='../admin/replyboard.do'
				})
			}
		},
		mounted(){
			axios.get('../replyboard/updatevue.do',{
	    		 params:{
	    			 wrno: this.wrno
	    		 }
	    	 }).then(response=>{
	    		 this.detail=response.data
	    	 })
		}
	}).mount('#replyInsertApp')
	</script>
</body>
</html>