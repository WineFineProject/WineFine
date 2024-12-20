<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>시음회 목록</title>
<link rel="stylesheet" href="../tem/css/event2.css">
</head>
<body>
  <div class="container-fluid page-header py-5">
		<h1 class="text-center text-white display-6">시음회</h1>
		<ol class="breadcrumb justify-content-center mb-0">
		</ol>
	</div>
  <div class="container py-5">
    <div class="row" id="EventList">
    <div class="search-container" style="padding: 0px">
            <h3>시음회({{count}}건)</h3>
            </div>
            <div class="header-line"></div>
            <ul class="eventList">
                <li v-for="vo in list" class="item">
                    <div>
                      <a :href="'detail.do?weno='+vo.weno">
                        <span class="namekor">{{vo.title}}</span>
                      </a>  
                    </div>
                    <div style="height: 5px"></div>
                    <span style="color: black">{{vo.address}}</span>
                    <div>{{vo.eday}}</div>
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
        let EventListapp = Vue.createApp({
            data() {
                return {
                	list:[],
                    curpage:1,
	       			totalpage:0,
	       			startPage:0,
	       			endPage:0,
	       			count:0,
                }
            },
            methods: {
            	 prev(){
        			 this.curpage=this.startPage-1
        			 this.eList()
        		 },
        		 next(){
        			 this.curpage=this.endPage+1
        			 this.eList()
        		 },
        		 pageChange(page){
        			 this.curpage=page
        			 this.eList()
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
                eList() {
                    axios.get('../event/listVue.do',{
                    	params:{
                    		page:this.curpage
                    	}
                    }).then(response=>{
                            this.list=response.data.list
                            this.curpage=response.data.curpage
	           				this.totalpage=response.data.totalpage
	           				this.startPage=response.data.startPage
	           				this.endPage=response.data.endPage
	           				this.count=response.data.count
                        })
                        .catch(error=>{
                            console.error(error)
                        })
                }
            },
            mounted() {
                this.eList()
            }
        }).mount('#EventList')
    </script>
</body>
</html>