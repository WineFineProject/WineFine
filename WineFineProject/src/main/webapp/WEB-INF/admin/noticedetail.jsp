<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../tem/css/replydetail.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<style type="text/css">
.detail-box, .post-title, .content-box {
	text-align: left !important;
}

#anbDetail {
	max-width: 800px;
	margin: 0 auto;
}

.content-box {
	margin-top: 10px;
}
</style>
</head>
<body>
	<div class="container" id="anbDetail">
		<h4 class="text-center" style="margin-bottom: 10px;">공지사항 관리</h4>
		<div class="detail-box">
			<span v-if="vo.cno==4">&nbsp;[일반]&nbsp;</span> <span v-if="vo.cno==5">&nbsp;[이벤트]&nbsp;</span> <span v-if="vo.cno==6">&nbsp;[상품]&nbsp;</span>
			<h2 class="post-title">{{vo.subject}}</h2>
			<span class="author-name">관리자</span> <span class="meta-separator">|</span> <span class="post-date">{{vo.dbday}}</span> <span class="meta-separator">|</span> <span class="view-count"><i class="fas fa-eye"></i>&nbsp;{{vo.hit}}</span>
			<div class="content-box">{{vo.content}}</div>
			<div class="button-group">
				<a :href="'../admin/noticeupdate.do?bno='+vo.bno" class="btn btn-primary">수정</a>
				<input type=button value="삭제" class="btn btn-danger" ref="deleteBtn" @click="boardDelete()">
				<button type="button" class="btn btn-secondary" onclick="javascript:history.back()">목록</button>
			</div>
		</div>
	</div>
	<script>
    let noticedetailApp=Vue.createApp({
    	data(){
    		return {
    			vo:{},
    			bno:${bno},
    			id:'${sessionScope.userId}'
    		}
    	},
    	mounted(){
    		axios.get('../noticeboard/detail_vue.do',{
    			params:{
    				bno:this.bno
    			}
    		}).then(response=>{
    			this.vo=response.data
    		}).catch(error=>{
    			console.log(error.response)
    		})
    	},
    	methods:{
    		boardDelete(){
    			axios.get('../noticeboard/delete_vue.do',{
    				params:{
    					bno:this.bno
    				}
    			}).then(response=>{
    				   alert("공지 삭제가 완료되었습니다")
    					location.href="../admin/noticeboard.do"
    			}).catch(error=>{
    				console.log(error.response)
    			})
    		}
    	}
    }).mount('#anbDetail')
   </script>
</body>
</html>