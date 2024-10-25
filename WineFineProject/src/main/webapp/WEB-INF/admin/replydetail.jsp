<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../tem/css/replydetail.css">
</head>
<body>
	<div id="replyDetail" style="margin-top: 50px">
		<div class="detail-box">
			<td width="35%">
				<span v-if="vo.type===2">{{cnos[vo.cno]}}&nbsp;</span> 
				<span v-if="vo.type===3">{{cno[vo.cno]}}&nbsp;</span>
			</td>
			<h2 class="post-title">{{vo.subject}}</h2>
			<div class="post-meta">
				<span class="author-name">{{vo.nickname}}</span> 
				<span class="meta-separator">|</span> 
				<span class="post-date">{{vo.dbday}}</span> 
				<span class="meta-separator">|</span> 
				<span class="view-count"><i class="fas fa-eye"></i>&nbsp;{{vo.hit}}</span>
			</div>
			<div class="content-box">{{vo.content}}</div>
			<div class="button-group">
				<button type="button" class="btn btn-secondary" onclick="javascript:history.back()">목록</button>
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
			  cnos: ['', '상품 관련', '프로모션 관련', '서비스 관련', '정산 관련', '기타'],
              cno: ['', '상품 관련', '배송 관련', '서비스 관련', '결제 관련', '기타']
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