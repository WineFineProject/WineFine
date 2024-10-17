<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>       
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="container" style="margin-top:50px;" id="replyList">
     <h3 class="text-center">1:1 문의게시판</h3>
     <div class="row" style="margin-top: 50px">
     <div>
       <sec:authorize access="hasRole('ROLE_USER')"> 
                   <a href="../replyboard/insert1.do" class="btn btn-sm" style="background-color: #FCD500;">글쓰기</a>
       </sec:authorize>
       <sec:authorize access="hasRole('ROLE_SELLER')"> 
                   <a href="../replyboard/insert2.do" class="btn btn-sm" style="background-color: #FCD500;">글쓰기</a>
       </sec:authorize>
      </div>
     <table class="table table-hover" style="margin-top: 10px">
       <tr>
        <th width=10% class="text-center">번호</th>
        <th width=35% class="text-center">제목</th>
        <th width=15% class="text-center">이름</th>
        <th width=15% class="text-center">작성일</th>
        <th width=10% class="text-center">조회수</th>
        <th width=15% class="text-center">답변상태</th>
       </tr>
         <tr v-for="(vo,index) in list">
            <td width=10% class="text-center">{{count-index}}</td>
	        <td width=35%>
	          <span style="color: darkred" v-if="id!==vo.userid&&vo.secret===1&&vo.group_step===0"><i class="fa fa-lock" aria-hidden="true"></i>&nbsp;비밀글입니다</span>
	          <span style="color: darkred" v-else-if="id!==vo.recvid&&vo.secret===1&&vo.group_step===1">ㄴ&nbsp;<i class="fa fa-lock" aria-hidden="true"></i>&nbsp;비밀글입니다</span>
	          <a :href="'../replyboard/detail.do?wrno='+vo.wrno" v-else><span v-if="vo.group_step===1">ㄴ</span><span v-if="vo.type===2">[{{cnos[vo.cno]}}]&nbsp;</span>
	          <span v-if="vo.type===3">[{{cno[vo.cno]}}]&nbsp;</span>{{vo.subject}}</a>
	        </td>
	        <td width=15% class="text-center">{{vo.nickname}}</td>
	        <td width=15% class="text-center">{{vo.dbday}}</td>
	        <td width=10% class="text-center">{{vo.hit}}</td>
	        <td width=15% class="text-center" style="color: blue" v-if="vo.isreply===0&&vo.group_step===0">답변대기</td>
	        <td width=15% class="text-center" style="color: green" v-if="vo.isreply===1">답변완료</td>
	        <td width=15% class="text-center" style="color: orange" v-if="vo.isreply===0&&vo.group_step===1">문의답변</td>
         </tr>
     </table>
          <div class="text-center" style="margin-top: 50px">
           <a href="#" class="btn btn-sm btn-primary">이전</a>
             {{curpage}} page / {{totalpage}} pages
           <a href="#" class="btn btn-sm btn-primary">다음</a>
          </div>
     </div>
   </div>
  <script>
    let listApp=Vue.createApp({
    	data(){
    		return {
    			vo:{},
    			list:[],
    			curpage:1,
    			totalpage:0,
    			count:0,
    			id:'${sessionScope.userId}',
    			cnos:['','상품 관련', '프로모션 관련','서비스 관련','정산 관련','기타'],
    			cno:['','상품 관련', '배송 관련','서비스 관련','결제 관련','기타']
    		}
    	},
    	mounted(){
    		this.dataRecv()
    	},
    	methods:{
    		dataRecv(){
    			axios.get('../replyboard/listvue.do',{
    				params:{
    					page:this.curpage,
    					totalpage:this.totalpage
    				}
    			}).then(response=>{
    				this.vo=response.data
    				this.list=response.data.list
    				this.curpage=response.data.curpage
    				this.totalpage=response.data.totalpage
    				this.count=response.data.count
    				this.today=response.data.today
    			}).catch(error=>{
    				console.log(error.response)
    			})
    		}
    	}
    }).mount('#replyList')
  </script> 
</body>
</html>