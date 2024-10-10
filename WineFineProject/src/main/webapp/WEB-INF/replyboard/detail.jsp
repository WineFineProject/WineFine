<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="container" id="replyDetail" style="margin-top: 50px">
		<div class="row">
			<table class="table">
				<tr>
					<th width="5%" class="text-center">닉네임</th>
					<td width="15%"><span class="form-control" v-model="subject"
						ref="subject">{{vo.hit}}</span></td>
					<th width="5%" class="text-center">작성일</th>
					<td width="15%"><span class="form-control" v-model="subject"
						ref="subject">{{vo.wrno}}</span></td>
					<th width="5%" class="text-center">조회수</th>
					<td width="15%"><span class="form-control" v-model="subject"
						ref="subject">{{vo.hit}}</span></td>
				</tr>
				<tr>
					<th width="10%" class="text-center">제목</th>
					<td colspan="5"><span class="form-control" v-model="subject"
						ref="subject">{{vo.subject}}</span></td>
				</tr>
				<tr>
					<th width="10%" class="text-center">내용</th>
					<td colspan="5"><span style="height: 300px;"
						class="form-control" v-model="content" ref="content">{{vo.content}}</span>
					</td>
				</tr>
			</table>
			<div style="text-align: right">
				<button type="button" class="btn btn-info">수정</button>
				&nbsp;
				<button type="button" class="btn btn-primary">삭제</button>
				&nbsp;
				<button type="button" class="btn btn-secondary"
					onclick="javascript:history.back()">목록</button>
			</div>
		</div>
	</div>
</body>
<script>
  let replyDetailApp=Vue.createApp({
	  data(){
		  return{
			  vo:{},
			  wrno:${wrno},
			  id:'${sessionScope.userId}',
			  nickname:'${sessionScope.nickName}'
		  }
	  },
	  mounted(){
		  axios.get('../replyboard/detailvue.do',{
			  params:{
				  wrno:this.wrno
			  }
		  }).then(response=>{
			   console.log(response.data)
		   })
	  }
  }).mount('#replyDetail')
</script>
</html>