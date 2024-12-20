<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>생산지역</title>
<link rel="stylesheet" href="../tem/css/info.css">
</head>
<body>
  <div class="container-fluid page-header py-5">
		<h1 class="text-center text-white display-6">생산지</h1>
		<ol class="breadcrumb justify-content-center mb-0">
		</ol>
	</div>
  <div class="container py-5">
    <div class="row" id="nationList">
    <div class="search-container" style="padding: 0px">
            <h3>생산지역({{count}}건)</h3>
            <input type="text" class="search-input" placeholder=" 생산지역 내 검색" v-model="fd" @keyup.enter="nList()">
            </div>
            <div class="header-line"></div>
            <ul class="NationList">
                <li v-for="vo in nations" :key="vo.no" class="item">
                    <div>
                      <a :href="'../nation/detail.do?no='+vo.no">
                        <span class="namekor">{{vo.namekor}}</span>
                        <span class="nameeng">{{vo.nameeng}}</span>
                      </a>  
                    </div>
                    <div style="height: 10px"></div>
                    <div class="content">{{vo.content}}</div>
                    <div style="height: 10px"></div>
                </li>
            </ul>
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
</div> 
    <script>
        let nationListapp = Vue.createApp({
            data() {
                return {
                    nations: [],
                    curpage:1,
	       			totalpage:0,
	       			startPage:0,
	       			endPage:0,
	       			count:0,
	       			fd:'${fd}'
                }
            },
            methods: {
            	prev(){
       			 this.curpage=this.startPage-1
       			 this.nList()
       		 },
       		 next(){
       			 this.curpage=this.endPage+1
       			 this.nList()
       		 },
       		 pageChange(page){
       			 this.curpage=page
       			 this.nList()
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
             nList() {
       			  if(this.fd) {
 			         this.curpage = 1
 			      } 
                  axios.get('../nation/listVue.do',{
                    	params:{
                    		page:this.curpage,
                    		fd:this.fd
                    	}
                    }).then(response=>{
                            this.nations=response.data.nations
                            this.curpage=response.data.curpage
	           				this.totalpage=response.data.totalpage
	           				this.startPage=response.data.startPage
	           				this.endPage=response.data.endPage
	           				this.count=response.data.count
                    }).catch(error=>{
                            console.error(error)
                        })
                }
            },
            mounted() {
                this.nList()
            }
        }).mount('#nationList')
    </script>
</body>
</html>