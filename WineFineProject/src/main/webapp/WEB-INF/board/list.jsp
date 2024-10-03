<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
#bList{
   margin-top: 180px;
}
.page-item{
	cursor: pointer;
}
.page-item.active{
	background-color: #FFF7B3;
}
.row{
   margin: 0px auto;
   width: 1080px;
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
         <input type="button" value="전체" class="ctbtn btn-sm" style="margin-left: 5px; background-color: white; border-color: darkred;" @click="typeChange(0)">
     	 <input type="button" value="자유" class="ctbtn btn-sm" style="margin-left: 5px; background-color: white; border-color: darkred;" @click="typeChange(1)">
     	 <input type="button" value="정보" class="ctbtn btn-sm" style="margin-left: 5px; background-color: white; border-color: darkred;" @click="typeChange(2)">
    	 <input type="button" value="질문" class="ctbtn btn-sm" style="margin-left: 5px; background-color: white; border-color: darkred;" @click="typeChange(3)">
    	 </td>
    	 <td width="60%" class="text-right">
    	 <!-- 검색 -->
    	 </td>
        </tr>
      </table>
      <table class="table">
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
         <td width="40%"><a :href="'detail.do?bno='+vo.bno">{{vo.subject}}</a></td>
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
         <td width="40%"><a :href="'detail.do?bno='+vo.bno">{{vo.subject}}</a></td>
         <td width="15%" class="text-center">{{vo.nickname}}</td>
         <td width="15%" class="text-center">{{vo.dbday}}</td>
         <td width="15%" class="text-center">{{vo.hit}}</td>
        </tr>
       </tbody>
       <tfoot style="border-color:white;">
         <tr>
          <!-- 로그인 상태에서만 글쓰기 버튼 보이게 -->
         <td colspan="3" class="text-left">
            <a v-if="id!=''" href="../board/insert.do" class="btn btn-sm" style="background-color: #FFF7B3; color:gray;">글쓰기</a>
    		<p v-else>로그인 후 글을 작성할 수 있습니다</p>
         </td>
        </tr>
        <tr>
          <td colspan="6" class="text-center">
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
    			totalpage:0,
    			startPage:0,
    			endPage:0,
    			id:'${sessionScope.id}',
    			type:0
    		}
    	},  
    	mounted(){
    		this.dataRecv()
    		console.log(type)
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
    }).mount('#bList')
  </script>
</body>
</html>