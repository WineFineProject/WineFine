<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1:1 문의게시판</title>
</head>
<body>
	<div class="row" style="width: 1200px;" id="noticeTable">
		<h3 class="text-center">1:1 문의 게시판</h3>
		<div class="form-group" style="margin-top: 10px;">
			<div class="form-group" style="margin-top: 10px;">
				<label for="content">제목</label>
				<span class="form-control">{{detail.subject}}</span>
			</div>
			<div class="form-group" style="margin-top: 10px;">
				<label for="content">작성일</label>
				<span class="form-control">{{detail.dbday}}</span>
			</div>
			<div class="form-group" style="margin-top: 10px;">
				<label for="subject">대상</label> 
				<span class="form-control" v-if="detail.type===1">전체</span>
				<span class="form-control" v-if="detail.type===2">{{types[detail.target]}}</span>
				<span class="form-control" v-if="detail.type===3">{{detail.wvo.namekor}}</span>
			</div>
			<div class="form-group" style="margin-top: 10px;">
				<label for="content">내용</label>
				<textarea class="form-control" rows="5" style="resize: none;" disabled>{{detail.content}}</textarea>
			</div>
			<div style="margin-top: 10px;"></div>
			<div class="text-center">
				<a :href="'../seller/noticeUpdate.do?nbno='+detail.nbno" class="btn btn-primary">수정</a>
				<a href="../seller/notice.do" class="btn btn-primary">목록</a>
			</div>
		</div>
	</div>
	<script>
	let noticeDetailApp=Vue.createApp({
		data(){
			return{
				nbno:${nbno},
				detail:{},
				types:['', '레드', '화이트', '스파클링', '로제', '주정강화', '기타']
			}
		},
		mounted(){
			axios.get('../seller/vueNoticeDetail.do', {
				params:{
					nbno:this.nbno
				}
			}).then(response=>{
				console.log(response.data)
				this.detail=response.data
			})
		}
	}).mount('#noticeTable')
	</script>
</body>
</html>