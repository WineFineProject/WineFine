<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../tem/css/replydetail.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<style type="text/css">
.detail-box, .post-title, .content-box{
	text-align: left !important;
}
#nbDetail{
width: 960px;
margin-top: 20px;
}
.content-box{
 margin-top: 10px;
}
</style>
</head>
<body>
 <div class="container" id="nbDetail">
     <h3 class="text-center" style="margin-bottom:10px;">공지사항</h3>
      <div class="detail-box">
          <span v-if="vo.cno==4">&nbsp;[일반]&nbsp;</span>
          <span v-if="vo.cno==5">&nbsp;[이벤트]&nbsp;</span>
          <span v-if="vo.cno==6">&nbsp;[상품]&nbsp;</span>
        <h2 class="post-title">{{vo.subject}}</h2>
           <span class="author-name">관리자</span>
           <span class="meta-separator">|</span>
           <span class="post-date">{{vo.dbday}}</span>
           <span class="meta-separator">|</span>
           <span class="view-count"><i class="fas fa-eye"></i>&nbsp;{{vo.hit}}</span>
        <div class="content-box" v-html="formattedContent"></div>
         <div class="button-group">
            <a :href="'update.do?bno='+vo.bno" v-if="id === vo.id" class="btn btn-primary">수정</a>
            <input type=button value="삭제" v-if="id === vo.id" class="btn btn-danger"
            ref="deleteBtn" @click="boardDelete()">
             <button type="button" class="btn btn-secondary" onclick="javascript:history.back()">목록</button>
      </div>
     </div>
   </div>
   <script>
    let detailApp=Vue.createApp({
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
    	computed: {
            formattedContent() {
                return this.vo.content ? this.vo.content.replace(/\n/g, '<br>') : '';
            }
        },
    	methods:{
    		boardDelete(){
    			axios.get('../noticeboard/delete_vue.do',{
    				params:{
    					bno:this.bno
    				}
    			}).then(response=>{
    				   alert("공지 삭제가 완료되었습니다")
    					location.href="list.do"
    			}).catch(error=>{
    				console.log(error.response)
    			})
    		}
    	}
    }).mount('#nbDetail')
   </script>
</body>
</html>