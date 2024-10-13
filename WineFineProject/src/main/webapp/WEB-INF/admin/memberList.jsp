<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 목록</title>
<link rel="stylesheet" href="../tem/css/memberlist.css">
<style type="text/css">
.pagination{
	cursor: pointer;
}
</style>
</head>
<body>
    <div id="list" class="row"> 
        <h3 class="text-center" style="width: 80%">회원 목록</h3>
        <table class="table" style="margin-top: 20px">
            <thead class="text-center">
                <tr>
                    <th>번호</th>
                    <th>아이디</th>
                    <th>닉네임</th>
                    <th>이름</th>
                    <th>이메일</th>
                    <th>성별</th>
                    <th>휴대폰번호</th>
                    <th>등급</th>
                    <th>가입일</th>
                </tr>
            </thead>
            <tbody class="text-center">
                <tr v-for="(vo, index) in members" :key="vo.userId">
                    <td>{{index+1}}</td>
                    <td>{{vo.userId}}</td>
                    <td>{{vo.nickName}}</td>
                    <td>{{vo.userName}}</td>
                    <td>{{vo.email}}</td>
                    <td>{{vo.sex}}</td>
                    <td>{{vo.phone}}</td>
                    <td>{{vo.grade}}</td>
                    <td>{{vo.regday}}</td>
                </tr>
            </tbody>
        </table>
        <div class="col-12 text-center" >
        <div class="pagination-area d-sm-flex mt-15" style="justify-content: center">
            <nav aria-label="#">
               <ul class="pagination" style="display: flex;">
                   <li class="page-item" v-if="startPage>1">
                     <a class="page-link" @click="prev()"><i class="fa fa-angle-double-left" aria-hidden="true"></i> 이전</a>
                    </li>
                     <li :class="i===curpage?'page-item active':'page-item'" v-for="i in range(startPage,endPage)">
                      <a class="page-link" @click="pageChange(i)">{{i}}</a>
                     </li>
                     <li class="page-item" v-if="endPage<totalpage">
                      <a class="page-link" @click="next()">다음 <i class="fa fa-angle-double-right" aria-hidden="true"></i></a>
                     </li>
                 </ul>
             </nav>
          </div>
       </div>
    </div>
    <script>
        let adminMemberListApp=Vue.createApp({
            data() {
                return {
                    members:[],
                    curpage:1,
	       			totalpage:0,
	       			startPage:0,
	       			endPage:0
                }
            },
            mounted() {
                this.mList()
            },
            methods: {
            	prev(){
          			 this.curpage=this.startPage-1
          			 this.mList()
          		 },
          		 next(){
          			 this.curpage=this.endPage+1
          			 this.mList()
          		 },
          		 pageChange(page){
          			 this.curpage=page
          			 this.mList()
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
                mList(){
                    axios.get('../admin/memberListVue.do',{
                    	params:{
                    		page:this.curpage
                    	}
                    }).then(response=>{
                            this.members=response.data.members
                            this.curpage=response.data.curpage
	           				this.totalpage=response.data.totalpage
	           				this.startPage=response.data.startPage
	           				this.endPage=response.data.endPage
                        }).catch(error=>{
                            alert(error.response)
                            console.log(error.response)
                        })
                }
            }
        }).mount('#list')
    </script>
</body>
</html>