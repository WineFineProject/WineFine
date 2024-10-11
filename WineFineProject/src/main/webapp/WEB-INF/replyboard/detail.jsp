<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="container" id="replyDetail" style="margin-top: 50px;width: 1000px;">
		<div class="row">
			<table class="table" style="margin:auto;">
				<tr>
				    <th width="5%" class="text-center">번호</th>
					<td width="7%" class="text-center">{{vo.wrno}}</td>
					<th width="15%" class="text-center">닉네임</th>
					<td width="13%" class="text-center">{{vo.nickname}}</td>
					<th width="15%" class="text-center">작성일</th>
					<td width="15%" class="text-center">{{vo.dbday}}</td>
					<th width="15%" class="text-center">조회수</th>
					<td width="15%">{{vo.hit}}</td>
				</tr>
				<tr>
					<th width="10%" class="text-center">제목</th>
					<td colspan="7">{{vo.subject}}</td>
				</tr>
				<tr>
					<th width="10%" class="text-center">내용</th>
					<td colspan="7"><span style="height: 300px;"
						class="form-control" v-model="content" ref="content">{{vo.content}}</span>
					</td>
				</tr>
			</table>
			<div style="text-align: right">
				<a :href="'../replyboard/update.do?wrno='+vo.wrno" class="btn btn-info">수정</a>
				&nbsp;
				<button type="button" class="btn btn-primary" @click="cancelBtn">삭제</button>
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
	  methods:{
		  cancelBtn(){
			  axios.get('../replyboard/deletevue.do',{
				  params:{
					  wrno:this.wrno
				  }
			  }).then(response=>{
				  location.href='../replyboard/list.do'
			   })
		  }
	  },
	  mounted(){
		  axios.get('../replyboard/detailvue.do',{
			  params:{
				  wrno:this.wrno
			  }
		  }).then(response=>{
			   console.log(response.data)
			   this.vo=response.data
		   })
	  }
  }).mount('#replyDetail')
</script>
</html>