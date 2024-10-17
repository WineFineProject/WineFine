<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://unpkg.com/vue@3"></script>
<script src="http://unpkg.com/axios/dist/axios.min.js"></script>
<style type="text/css">
</style>
</head>
<body>
	<div class="container-fluid py-5" >
		<div class="container py-5" >
			<div class="row">
				<div class="col-lg-12">
				
					<div class="table-responsive" id="boardListTable" >
						<table class="table">
							<thead>
								<tr>
								    <th scope="col" width="5%">번호</th>
								    <!-- <th scope="col" width="10%">분류</th> -->
								    <th scope="col" width="40%">제목</th>
								    <!-- <th scope="col" width="10%">첨부파일</th> -->
								    <th scope="col" width="12%">작성자</th>
								    <th scope="col" width="15%">작성일</th>
								    <th scope="col" width="8%">조회수</th>
								</tr>
							</thead>
							
							<tbody>
						        <tr v-for="vo in list" :key="vo.bno" >
						         <td width="5%" class="text-center">{{vo.bno}}</td>
						         <!-- <td width="10%" class="text-center">
						         	<span v-if="vo.cno==1">[자유]</span>
						         	<span v-if="vo.cno==2">[정보]</span>
						         	<span v-if="vo.cno==3">[질문]</span>
						         </td> -->
						         <td width="40%"><a :href="'../board/detail.do?bno='+vo.bno">{{vo.subject}}&nbsp;</a></td>
						         <!-- <td width="10%"  v-if="vo.filecount>0" class="text-center">📎</td> -->
						         <td width="15%" class="text-center">{{vo.nickname}}</td>
						         <td width="15%" class="text-center">{{vo.dbday}}</td>
						         <td width="15%" class="text-center">{{vo.hit}}</td>
						        </tr>
						       <!--  <tr v-else>
						        	<td colspan="5">데이터 없음</td>
						        </tr>
						       </tbody> -->

						     
						       <%-- <tfoot>
						       	<tr>
						          <td colspan="7" class="text-center">
						            <input type=button value="<" class="btn-sm btn-danger" @click="prev()">
						                &nbsp;
						                <span v-for="i in range(startpage,endpage)"
						                :class="{'page-item active': i === curpage, 'page-item': i !== curpage}" 
						                @click="pageChange(i)"> &nbsp; {{i}} &nbsp; </span>
						                &nbsp; 
						            <input type=button value=">" class="btn-sm btn-danger" @click="next()">
						          </td>
						          </tr>
						       </tfoot> --%>
						       
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
					loading: true,
	    			/* curpage:1,
	    			startpage:0,
	    			endpage:0, 
	    			id:'${sessionScope.userId}',*/
	    			nickname:'${sessionScope.nickName}',
	    		}
			},
		mounted(){
			this.dataRecv()
			},
		methods:{
			dataRecv(){				
				axios.get("../mypage/myboardlist_vue.do",{
					params:{
						/* page:this.curpage, */
						nickname: this.nickname							
					}
				}).then(response=>{
					 console.log("mbl서버 응답:", response.data)
    				this.list=response.data.list
    				this.loading=false
    				/* this.curpage=response.data.page
    				this.startpage=response.data.start
    				this.endpage=response.data.end */
    				
    			}).catch(error=>{
    				console.log(error.response)
    				this.loading=false
    			})
			},
    	  /*  prev(){
 			   this.curpage=this.curpage>1?this.curpage-1:this.curpage
 			   this.dataRecv()
 		   },
 		   next(){
 			   this.curpage=this.curpage<this.endpage?this.curpage+1:this.curpage
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
 	 		 } */
			
		}
	}).mount('#boardListTable')
  </script>
</body>
</html>

