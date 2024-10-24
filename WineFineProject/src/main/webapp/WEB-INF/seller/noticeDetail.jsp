<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" href="../tem/css/replydetail.css">
</head>
<body>
	<div class="row" id="noticeTable">
		<h3 class="text-center" style="margin-bottom: 30px">공지사항</h3>
		<div>
        <div class="detail-box" style="width:800px;margin: 0 auto">
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
                <a href="../seller/notice.do" class="btn btn-secondary">목록</a>
            </div>
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