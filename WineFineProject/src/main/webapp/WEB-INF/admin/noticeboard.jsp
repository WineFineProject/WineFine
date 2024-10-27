<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../tem/css/replydetail.css">
</head>
<body>
  <div class="container" id="anbList">
    <h3 class="table-title text-center" style="color: #333;">공지사항 관리</h3>
    <div class="row">
      <table class="cTable">
        <tr>
        <td width="40%">
         <input type="button" value="전체" class="ctbtn form-control"  @click="typeChange(0)">
     	 <input type="button" value="일반" class="ctbtn form-control"  @click="typeChange(4)">
     	 <input type="button" value="이벤트" class="ctbtn ectbtn form-control" @click="typeChange(5)">
    	 <input type="button" value="상품" class="ctbtn form-control"  @click="typeChange(6)">
    	 </td>
    	 <td width="60%" class="text-right">
    	 &nbsp;
    	 </td>
        </tr>
      </table>
      <table class="table trb">
       <thead>
        <tr>
         <th width="5%" class="text-center">번호</th>
         <th width="10%" class="text-center">분류</th>
         <th width="40%" class="text-center">제목</th>
         <th width="15%" class="text-center">작성자</th>
         <th width="15%" class="text-center">작성일</th>
         <th width="15%" class="text-center">조회수</th>
        </tr>
       </thead>
		<tbody v-if="type===0">
		<tr v-if="list.length===0"><td colspan="6">작성한 공지가 없습니다</td></tr>
        <tr v-for="(vo, index) in list">
         <td width="5%" class="text-center">{{list.length - index}}</td>
         <td width="10%" class="text-center">
         	<span v-if="vo.cno==4">[일반]</span>
         	<span v-if="vo.cno==5">[이벤트]</span>
         	<span v-if="vo.cno==6">[상품]</span>
         </td>
         <td width="40%" style="text-align: left"><a :href="'noticedetail.do?bno='+vo.bno">{{vo.subject}}</a></td>
         <td width="15%" class="text-center">관리자</td>
         <td width="15%" class="text-center">{{vo.dbday}}</td>
         <td width="15%" class="text-center">{{vo.hit}}</td>
        </tr>
       </tbody>
       <tbody v-else>
       <tr v-if="cList.length===0"><td colspan="6">작성한 공지가 없습니다</td></tr>
       <tr v-for="(vo, index) in cList">
         <td width="5%" class="text-center">{{cList.length - index}}</td>
         <td width="10%" class="text-center">
         	<span v-if="vo.cno==4">[일반]</span>
         	<span v-if="vo.cno==5">[이벤트]</span>
         	<span v-if="vo.cno==6">[상품]</span>
         </td>
         <td width="40%" class="blistsub"><a :href="'noticedetail.do?bno='+vo.bno">{{vo.subject}}</a></td>
         <td width="15%" class="text-center">관리자</td>
         <td width="15%" class="text-center">{{vo.dbday}}</td>
         <td width="15%" class="text-center">{{vo.hit}}</td>
        </tr>
       </tbody>
      </table>
      <div>
          <c:if test="${sessionScope.userId!=null }">
                <div class="login">
                  <sec:authorize access="hasRole('ROLE_ADMIN')">         
            		<a href="../admin/noticeinsert.do" class="btn btn-sm" style="background-color: #FFEC96; color:#333; float:left;">글쓰기</a>   
                  </sec:authorize>
                </div>
             </c:if>
      </div>
       <div class="text-center" style="margin-top: 50px">
           <input type="button" class="btn btn-sm btn-primary" value="이전" @click="prev()">
             {{curpage}} page / {{totalpage}} pages
           <input type="button" class="btn btn-sm btn-primary" value="다음" @click="next()">
          </div>
    </div>
  </div>
  <script>
    let nlistApp=Vue.createApp({
    	data(){
    		return {
    			list:[],
    			cList:[],
    			curpage:1,
    			totalpage:0,
    			admin:0,
    			id:'',
    			type:0
    		}
    	},  
    	mounted(){
    		this.dataRecv()
    	},
    	methods:{
    		prev(){
    			this.curpage=this.curpage>1?this.curpage-1:this.curpage
    			this.dataRecv()
    		},
    		next(){
    			this.curpage=this.curpage<this.totalpage?this.curpage+1:this.curpage
    	    	this.dataRecv()
    		},
    		dataRecv(){
    			axios.get('../noticeboard/list_vue.do',{
    				params:{
    					page:this.curpage,
    					type:this.type
    				}
    			}).then(response=>{
    				this.list=response.data.list
    				this.cList=response.data.cList
    				this.curpage=response.data.curpage
    				this.totalpage=response.data.totalpage
    				this.startPage=response.data.startPage
    				this.endPage=response.data.endPage
    			}).catch(error=>{
    				console.log(error.response)
    			})
    		},
    		typeChange(type){
    			this.curpage=1
    			this.type=type
    			this.dataRecv()
    		},
    	   prev(){
 			   this.curpage=this.curpage>1?this.curpage-1:this.curpage
 			   this.dataRecv()
 		   },
 		   next(){
 			   this.curpage=this.curpage<this.totalpage?this.curpage+1:this.curpage
 			   this.dataRecv()
 		   },
 		  	pageChange(page){
 			   	 this.curpage=page
 	 			 this.dataRecv()
 	 		},
 	 		 range(start,end){
 	 			 let arr=[]
 	 			 let len=end-start
 	 			 for(let i=0;i<=len;i++)
 	 			 {
 	 				 arr[i]=start
 	 				 start++;
 	 			 }
 	 			 return arr
 	 		 },
    	}
    }).mount('#anbList')
  </script>
</body>
</html>