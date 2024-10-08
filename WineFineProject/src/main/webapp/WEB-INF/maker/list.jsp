<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>생산자</title>
<style>
.MakerList {
	list-style-type: none; 
	padding: 0; 
	margin: 0; 
}
.item {
	margin: 10px 0; 
	padding: 10px;
	border-bottom: 1px solid #ccc; 
}
.content {
	font-size: 16px; 
	display: -webkit-box; 
	-webkit-box-orient: vertical; 
	-webkit-line-clamp: 2;
	overflow: hidden; 
	text-overflow: ellipsis; 
	max-width: 100%; 
}
.namekor {
	font-size: 20px; 
	font-weight: bold; 
	display: inline;
}
.nameeng {
	font-size: 20px; 
	color: gray; 
	display: inline; 
	margin-left: 10px; 
}
.load-more {
	margin-top: 20px; 
	cursor: pointer; 
	margin-top: 20px;
	padding: 10px 20px; 
	width: 240px;
	height: 50px;
	align-content: center;
}
.center {
	display: flex;
	justify-content: center; 
	margin-top: 20px; 
}
.header-line {
	border-top: 3px solid black;
}
.search-container {
	display: flex;
	justify-content: space-between;
	align-items: center;
}
.search-input {
    width: 220px;
    margin-bottom: 5px;
	margin-left: auto;
	padding: 5px;
	font-size: 16px;
	border: 1px solid #ccc;
	border-radius: 4px;
}
.page-link {
    position: relative;
    display: block;
    color : #881824 !important;
    background-color: #fff;
    border: 1px solid #881824 !important;
    transition: color .15s ease-in-out, background-color .15s ease-in-out, border-color .15s ease-in-out, box-shadow .15s ease-in-out;
}
.pagination{
	cursor: pointer;
}
</style>
</head>
<body>
  <div class="container py-5">
    <div class="row" id="makerList">
    <div class="search-container" style="padding: 0px">
            <h3>생산자({{count}}건)</h3>
            <input type="text" class="search-input" placeholder=" 생산자 내 검색" v-model="fd" @keyup.enter="mList()">
            </div>
            <div class="header-line"></div>
            <ul class="MakerList">
                <li v-for="vo in makers" :key="vo.no" class="item">
                    <div>
                      <a :href="'detail.do?no='+vo.no">
                        <span class="namekor">{{vo.namekor}}</span>
                        <span class="nameeng">{{vo.nameeng}}</span>
                      </a>  
                    </div>
                    <div style="height: 10px"></div>
                    <div class="content">{{vo.content}}</div>
                    <div style="height: 10px"></div>
                    <div style="font-weight: bold;">{{vo.nation}}</div>
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
        let makerListapp = Vue.createApp({
            data() {
                return {
                	makers: [],
                	curpage:1,
	       			totalpage:0,
	       			startPage:0,
	       			endPage:0,
	       			count:0,
	       			fd:''
                }
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
                mList() {
          			if(this.fd) {
     			       this.curpage = 1
     			    }  
                    axios.get('../maker/listVue.do',{
                    	params:{
                    		page:this.curpage,
                    		fd:this.fd
                    	}
                    }).then(response=>{
                            this.makers=response.data.makers
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
                this.mList()
            }
        }).mount('#makerList')
    </script>
</body>
</html>