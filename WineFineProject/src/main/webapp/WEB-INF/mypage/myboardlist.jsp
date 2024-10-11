<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
</style>
</head>
<body>
	<div class="container-fluid py-5" id="mbList">
		<div class="container py-5">
			<div class="row">
				<div class="col-lg-9">
				
				 <table class="cTable">
			        <tr>
			        <td width="40%">
			         <input type="button" value="전체" class="ctbtn form-control" @click="typeChange(0)">
			     	 <input type="button" value="자유" class="ctbtn form-control"  @click="typeChange(1)">
			     	 <input type="button" value="정보" class="ctbtn form-control"  @click="typeChange(2)">
			    	 <input type="button" value="질문" class="ctbtn form-control"  @click="typeChange(3)">
			    	 </td>
			      
					<div class="table-responsive" id="cartListTable">
						<table class="table">
							<thead>
								<tr>
								    <th scope="col" width="5%">번호</th>
								    <th scope="col" width="10%">분류</th>
								    <th scope="col" width="40%">제목</th>
								    <!-- <th scope="col" width="10%">첨부파일</th> -->
								    <th scope="col" width="12%">작성자</th>
								    <th scope="col" width="15%">작성일</th>
								    <th scope="col" width="8%">조회수</th>
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
						         <td width="30%"><a :href="'detail.do?bno='+vo.bno">{{vo.subject}}&nbsp;({{vo.replycount}})</a></td>
						         <td width="10%"  v-if="vo.filecount>0" class="text-center">📎</td>
						         <td width="10%"  v-else class="text-center"></td>
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
						         <td width="30%"><a :href="'detail.do?bno='+vo.bno">{{vo.subject}}&nbsp;({{vo.creplycount}})</a></td>
						         <td width="10%"  v-if="vo.filecount>0" class="text-center">📎</td>
						         <td width="10%"  v-else class="text-center"></td>
						         <td width="15%" class="text-center">{{vo.nickname}}</td>
						         <td width="15%" class="text-center">{{vo.dbday}}</td>
						         <td width="15%" class="text-center">{{vo.hit}}</td>
						        </tr>
						       </tbody>
						       
						       <tfoot>
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
						       
							<!-- <tbody>
								<tr v-for="vo in cList" :key="wine.wno">
									<td>
										<p class="mb-0 mt-4">{{vo.bno}}</p>										
									</td>
									<td>
										<p class="mb-0 mt-4" v-if="vo.cno===1">[자유]</p>
         								<p class="mb-0 mt-4" v-if="vo.cno===2">[정보]</p>
         								<p class="mb-0 mt-4" v-if="vo.cno===3">[질문]</p>
									</td>
									<td>
										<p class="mb-0 mt-4">{{vo.subject}}</p>
									</td>
									<td>
										<p class="mb-0 mt-4">{{vo.nickname}}</p>
									</td>
									<td>
										<p class="mb-0 mt-4">{{vo.dbday}}</p>
									</td>
									<td>
										<p class="mb-0 mt-4">{{vo.hit}}</p>
									</td>
								</tr>
							</tbody> -->
							
							
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script>
		let listApp=Vue.createApp({
			data(){
				return{
					list:[],
	    			cList:[],
	    			curpage:1,
	    			startPage:0,
	    			endPage:0,
	    			id:'${sessionScope.userId}',
	    			nickname:'${sessionScope.nickName}',
	    			type:0,
	    			isSearch:0,
	    			find:''
				}
			},
		mounted(){
			this.dataRecv()},
		methods:{
			dataRecv(){				
				axios.get("../mypage/myboardlist_vue.do",{
					params:{
						type:this.type,
						page:this.curpage,
						nickname: this.nickname		
						start:this.start
						end:this.end
						
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
	}).mount('#mbList')
  </script>
</body>
</html>