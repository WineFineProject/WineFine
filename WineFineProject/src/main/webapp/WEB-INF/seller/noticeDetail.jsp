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
		<table class="table">
			<tr>
				<th width="5%" class="text-center">닉네임</th>
				<td width="15%">
					<span class="form-control">{{detail.nickname}}</span>
				</td>
				<th width="5%" class="text-center">작성일</th>
				<td width="15%">
					<span class="form-control">{{detail.dbday}}</span>
				</td>
				<th width="5%" class="text-center">조회수</th>
				<td width="15%">
					<span class="form-control">{{detail.hit}}</span>
				</td>
			</tr>
			<tr>
				<th width="10%" class="text-center">제목</th>
				<td colspan="5">
					<span class="form-control">{{detail.subject}}</span>
				</td>
			</tr>
			<tr>
				<th width="10%" class="text-center">내용</th>
				<td colspan="5">
					<span style="height: 300px;" class="form-control">{{detail.content}}</span>
				</td>
			</tr>
		</table>
				<div style="text-align: right;">
					<a :href="'../seller/noticeUpdate.do?nbno='+detail.nbno" class="btn btn-primary">수정</a>
					<a href="../seller/notice.do" class="btn btn-primary">목록</a>
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