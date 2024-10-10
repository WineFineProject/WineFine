<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
     <div class="row">
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
       <c:set var="count" value="${count}"/>
       <c:forEach var="vo" items="${list}">
         <tr>
            <td width=10% class="text-center">${count}</td>
	        <td width=35%>
	          <a href="../replyboard/detail.do?no=${vo.wrno}">${vo.subject}</a>
	        </td>
	        <td width=15% class="text-center">${vo.nickname}</td>
	        <td width=15% class="text-center">${vo.dbday}</td>
	        <td width=10% class="text-center">${vo.hit}</td>
	        <td width=15% class="text-center">${vo.isreply}</td>
         </tr>
         <c:set var="count" value="${count-1}"/>
       </c:forEach>
     </table>
      <table class="table">
        <tr>
          <td class="text-center">
           <a href="#" class="btn btn-sm btn-danger">이전</a>
             ${curpage } page / ${totalpage } pages
           <a href="#" class="btn btn-sm btn-danger">다음</a>
          </td>
        </tr>
      </table>
     </div>
   </div>
  <script>
    let listApp=Vue.createApp({
    	data(){
    		return {
    			
    		}
    	},
    	methods:{
    		
    	}
    }).mount()
  </script> 
</body>
</html>