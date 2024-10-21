<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../tem/css/coupon.css">
</head>
<body>
	<div class="report-table">
		<h3 class="table-title">신고 목록</h3>
		<table class="table" id="coupon-table" style="height: 400px;">
			<thead>
				<tr>
					<th width="5%">번호</th>
					<th width="20%">카테고리</th>
					<th width="10%">신고 Id</th>
					<th width="30%">신고 내용</th>
					<th width="10%">신고자 ID</th>
					<th width="15%">신고일</th>
					<th width="5%"></th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td style="padding: 0px;border:none" colspan="7">
						<div>
							<table style="width: 100%" id="inner-table">
								<tbody>
									<tr v-for="(vo,index) in report">
										<td style="padding: 8px" width="5%">{{count-index}}</td>
										<td width="20%">{{vo.category}}</td>
										<td width="10%">{{vo.rid}}</td>
										<td width="30%">{{vo.content}}</td>
										<td width="10%">{{vo.userid}}</td>
										<td width="15%">{{vo.dbday}}</td>
										<td width="5%"><button type="button" @click="search(vo.wreno,vo.type)" style="border:transparent;background-color: transparent"><i class="fa fa-search"></i></button></td>
									</tr>
								</tbody>
							</table>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
		<div class="modal" :class="{ show: showModal }" @click.self="changeModal(false)">
			<div class="modal-content" >
				<span class="close" @click="changeModal(false)">&times;</span>
				<table class="table" style="margin-top: 10px;">
				<h4 class="text-center">신고 게시물 확인</h4>
					<tr>
						<th width="30%">게시물 제목</th>
						<td width="70%"><input type="text"  style="width: 100%"></td>
					</tr>
					<tr>
						<th width="30%">게시물 내용</th>
						<td width="70%"><input type="text" style="width: 100%"></td>
					</tr>
					<tr style="text-align: right;">
						<td colspan="2">
							<button type="button" class="btn btn-sm btn-primary" >등록</button>
							<button type="button" class="btn btn-sm btn-warning" @click="changeModal(false)">취소</button>
						</td>
					</tr>
				</table>
			</div>
		</div>
	   <div class="col-12 text-center">
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
      let reportApp=Vue.createApp({
    	  data(){
    		  return {
    			  showModal:false,
    			  report:[],
    			  curpage:1,
				  totalpage:0,
				  startPage:0,
				  endPage:0,
				  count:0,
				  report:{}
    		  }
    	  },
          mounted() {
              this.rList()
          },
          methods:{
        	  changeModal(check){
        		 this.showModal=check
        	  },
        	  search(wreno,type){
        		  this.changeModal(true)
        		 /*  axios.get('../admin/reportBoardVue.do',{
        			  params:{
        				  wreno:wreno,
        				  type:type
        			  }
        		  }).then(response=>{
        			  this.report=response.data
        		  }) */
        	  },
        	  prev(){
       			 this.curpage=this.startPage-1
       			 this.rList()
       		 },
       		 next(){
       			 this.curpage=this.endPage+1
       			 this.rList()
       		 },
       		 pageChange(page){
       			 this.curpage=page
       			 this.rList()
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
       		rList(){
                 axios.get('../admin/reportListVue.do',{
                 	params:{
                 		page:this.curpage
                 	}
                 }).then(response=>{
                         this.report=response.data.report
                         this.curpage=response.data.curpage
					     this.totalpage=response.data.totalpage
					     this.startPage=response.data.startPage
					     this.endPage=response.data.endPage
					     this.count=response.data.count
                     }).catch(error=>{
                         alert(error.response)
                         console.log(error.response)
                     })
             }
          }
      }).mount('.report-table')
	</script>
</body>
</html>