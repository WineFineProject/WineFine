<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.page-item{
	cursor: pointer;
}
.page-item.active{
	background-color: #FFCC52;
	display:inline-block !important;
}

.ctbtn{
width: 15%; 
display: inline-block; 
margin-left:5px;
background-color: #C91C40 !important; 
border-color: white;
color: white;
}
.bsbtn{
	background-color: #FFCC52 !important;
	color:gray;
	width: 18%; 
	text-align: center;
}
.blistsub{
	white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    width:400px !important;
}
.table-fixed {
    width: 100%; 
    table-layout: fixed; 
}
</style>
</head>
<body>
  <div class="container" id="bList">
    <h3 class="text-center">자유게시판</h3>
    <div class="row">
      <table class="cTable">
        <tr>
        <td width="40%">
         <input type="button" value="전체" class="ctbtn form-control" @click="typeChange(0)">
     	 <input type="button" value="자유" class="ctbtn form-control"  @click="typeChange(1)">
     	 <input type="button" value="정보" class="ctbtn form-control"  @click="typeChange(2)">
    	 <input type="button" value="질문" class="ctbtn form-control"  @click="typeChange(3)">
    	 </td>
    	 <!-- 검색 -->
    	 <td width="60%" style="float: right;">
    		<select id="bfilter" v-model="isSearch" ref="isSearch" class="form-control" style="width: 25%; display: inline-block; margin-right:5px;">
                    <option value="" disabled selected>검색 조건 선택 ▼ </option>
                    <option value="0">제목</option>
                    <option value="1">작성자</option>
            </select>
          <input type=text size=20 v-model="find" ref="find" class="form-control" placeholder="검색어를 입력해주세요" style="width: 50%; display: inline-block; margin-right:5px;">
          <input type="button" value="검색" class="ctbtn form-control" @click="findboard()">
    	 </td>
        </tr>
      </table>
      <table class="table table-fixed">
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
        <tr v-for="vo in list">
         <td width="5%" class="text-center">{{vo.bno}}</td>
         <td width="10%" class="text-center">
         	<span v-if="vo.cno==1">[자유]</span>
         	<span v-if="vo.cno==2">[정보]</span>
         	<span v-if="vo.cno==3">[질문]</span>
         </td>
         <td width="40%" v-if="vo.filecount>0" class="blistsub"><a :href="'detail.do?bno='+vo.bno">&#127748; {{vo.subject}}&nbsp;({{vo.replycount}})</a></td>
         <td width="40%" v-else class="blistsub"><a :href="'detail.do?bno='+vo.bno">{{vo.subject}}&nbsp;({{vo.replycount}})</a></td>
         <td width="15%" class="text-center">{{vo.nickname}}</td>
         <td width="15%" class="text-center">{{vo.dbday}}</td>
         <td width="15%" class="text-center">{{vo.hit}}</td>
        </tr>
       </tbody>
       <tbody v-else>
       <tr v-for="vo in cList">
         <td width="5%" class="text-center">{{vo.bno}}</td>
         <td width="10%" class="text-center">
         	<span v-if="vo.cno==1">[자유]</span>
         	<span v-if="vo.cno==2">[정보]</span>
         	<span v-if="vo.cno==3">[질문]</span>
         </td>
         <td width="40%" v-if="vo.filecount>0" class="blistsub"><a :href="'detail.do?bno='+vo.bno">&#127748; {{vo.subject}}&nbsp;({{vo.creplycount}})</a></td>
         <td width="40%" v-else class="blistsub"><a :href="'detail.do?bno='+vo.bno">{{vo.subject}}&nbsp;({{vo.creplycount}})</a></td>
         <td width="15%" class="text-center">{{vo.nickname}}</td>
         <td width="15%" class="text-center">{{vo.dbday}}</td>
         <td width="15%" class="text-center">{{vo.hit}}</td>
        </tr>
       </tbody>
       <tfoot style="border-color:white;">
         <tr>
          <!-- 로그인 상태에서만 글쓰기 버튼 보이게 -->
         <td colspan="3" class="text-left">
            <a v-if="id!=''" href="../board/insert.do" class="bsbtn form-control">글쓰기</a>
    		<p v-else>로그인 후 글을 작성할 수 있습니다</p>
         </td>
        </tr>
        <tr>
          <td colspan="7" class="text-center">
            <input type=button value="<" class="btn-sm btn-danger" @click="prev()">
                &nbsp;
                <span v-for="i in range(startPage,endPage)"
                :class="{'page-item active': i === curpage, 'page-item': i !== curpage}" 
                @click="pageChange(i)"> &nbsp; {{i}} &nbsp; </span>
                &nbsp; 
            <input type=button value=">" class="btn-sm btn-danger" @click="next()">
          </td>
          </tr>
       </tfoot>
      </table>
    </div>
  </div>
  <script>
    let listApp=Vue.createApp({
    	data(){
    		return {
    			list:[],
    			cList:[],
    			curpage:1,
    			startPage:0,
    			endPage:0,
    			id:'${sessionScope.userId}',
    			type:0,
    			isSearch:0,
    			find:''
    		}
    	},  
    	mounted(){
    		this.dataRecv()
    	},
    	methods:{
    		dataRecv(){
    			axios.get('../board/list_vue.do',{
    				params:{
    					page:this.curpage,
    					type:this.type
    				}
    			}).then(response=>{
    				this.list=response.data.list
    				this.cList=response.data.cList
    				this.curpage=response.data.curpage
    				this.startPage=response.data.startPage
    				this.endPage=response.data.endPage
    				
    			}).catch(error=>{
    				console.log(error.response)
    			})
    		},
    		 findboard() {
    			localStorage.setItem('isSearch', this.isSearch);
    		    localStorage.setItem('find', this.find.trim());
    		    localStorage.setItem('type', this.type);
    		    location.href = "../board/find.do";
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
 			   this.curpage=this.curpage<this.endPage?this.curpage+1:this.curpage
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
 	 		 }
    	}
    }).mount('#bList')
  </script>
</body>
</html>