<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../tem/css/replydetail.css">
</head>
<body>
	<div id="noticeTable" style="margin-top: 50px">
        <div class="detail-box">
            <h2 class="post-title">{{detail.subject}}</h2>
            <div class="post-meta">
                <span class="author-name">{{detail.nickname}}</span>
                <span class="meta-separator">|</span>
                <span class="post-date">{{detail.dbday}}</span>
                <span class="meta-separator">|</span>
                <span class="view-count"><i class="fas fa-eye"></i>&nbsp;{{detail.hit}}</span>
            </div>
            <div class="content-box">{{detail.content}}</div>
            <div class="button-group">
                <a :href="'../seller/noticeUpdate.do?nbno='+detail.nbno" class="btn btn-primary">수정</a>
                <input type=button value="삭제" class="btn btn-danger">
                <a href="../seller/notice.do" class="btn btn-secondary">목록</a>
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