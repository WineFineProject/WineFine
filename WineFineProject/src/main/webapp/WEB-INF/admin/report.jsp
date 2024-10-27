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
								<tr v-if="report.length===0"><td colspan="7">신고 내역이 없습니다.</td></tr>
									<tr v-for="(vo,index) in report">
										<td style="padding: 8px" width="5%">{{count-index}}</td>
										<td width="20%">{{vo.category}}</td>
										<td width="10%">{{vo.rid}}</td>
										<td width="30%">{{vo.content}}</td>
										<td width="10%">{{vo.userid}}</td>
										<td width="15%">{{vo.dbday}}</td>
										<td width="5%">
										<button  @click="messageInsert2(index)" v-if="vo.state===0 && ((vo.count1===0 && vo.type===1) || (vo.count2===0 && vo.type===2) || (vo.count3===0 && vo.type===3) || (vo.count4===0 && vo.type===4))" type="button" style="border:transparent;background-color: transparent"><i class="fa-solid fa-pen-to-square"></i></button>
										<button v-else-if="vo.state===1" type="button" style="border:transparent;background-color: transparent"><i class="fa-solid fa-user-check"></i></button>
										<button v-else type="button" @click="search(vo.wreno,vo.type)" style="border:transparent;background-color: transparent"><i class="fa fa-search"></i></button>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
		<div class="modal" :class="{show: showModal}" v-if="state===1">
			<div class="modal-content" style="width: 580px; height: 580px;margin-top: 7%;">
            <div class="modal-header">
                <h5 class="modal-title">신고 게시물 확인</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" @click="changeModal(false)"></button>
            </div>
            <div class="modal-body">
                    <div class="mb-3">
                        <label for="subject" class="label">제목</label>
                        <input type="text" class="form-control" :value="detail.bvo.subject" disabled>
                    </div>
                    <div class="mb-3">
                        <label class="label">내용</label><br>
                        <div class="r-box" style="text-align: left">{{detail.bvo.content}}</div>
                    </div>
                    <div style="float:right"> 
                    <button class="btn-lg" @click="messageInsert()" style="background-color: transparent;border:transparent"><i class="fa-solid fa-pen-to-square-plane"></i></button>
                    <button class="btn-lg" @Click="deleteReport(detail.tno, detail.type)" style="border:transparent;background-color: transparent"><i class="fa-solid fa-trash-can"></i></button>
                    </div>
                </div>
			</div>
		</div>
		<div class="modal" :class="{show: showModal}" v-if="state===2">
			<div class="modal-content" style="width: 580px; height: 400px;margin-top: 7%;">
            <div class="modal-header">
                <h5 class="modal-title">신고 댓글 확인</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" @click="changeModal(false)"></button>
            </div>
            <div class="modal-body">
                    <div class="mb-3">
                        <label class="label">내용</label><br>
                        <div class="r-boxs" style="text-align: left">{{detail.brvo.msg}}</div>
                    </div>
                    <div style="float:right">
                    <button class="btn-lg" @click="messageInsert()" style="background-color: transparent;border:transparent"><i class="fa-solid fa-pen-to-square"></i></button>
                    <button class="btn-lg" @Click="deleteReport(detail.tno, detail.type)" style="border:transparent;background-color: transparent"><i class="fa-solid fa-trash-can"></i></button>
                    </div>
                </div>
			</div>
		</div>
		<div class="modal" :class="{show: showModal}" v-if="state===3">
			<div class="modal-content" style="width: 650px; height: 600px;margin-top: 7%;">
            <div class="modal-header">
                <h5 class="modal-title">신고 상품 확인</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" @click="changeModal(false)"></button>
            </div>
            <div class="modal-body">
            <div class="row">
                <div class="col-3">
                    <img :src="detail.wvo.poster" style="width: 125px; height: 160px;">
                </div>
                <div class="col-9">
                    <div class="mb-3">
                        <label for="subject" class="label">상품명</label>
                        <input type="text" class="form-control" :value="detail.wvo.namekor" disabled>
                    <div class="mb-3">
                    <table style="width:100%">
                    <tr>
                    <td style="text-align: left" width="50%">타입</td>
                    <td style="text-align: left" width="50%">가격</td>
                    </tr>
                    <tr>
                    <td width="50%"><input type="text" class="form-control" :value="detail.wvo.type" disabled></td>
                    <td width="50%"><input type="text" class="form-control" :value="detail.wvo.price" disabled></td>
                    </tr>
                    </table>
                    </div>
                    </div>
                </div>
                    <div class="mb-3">
                    <table style="width:100%">
                    <tr>
                    <td style="text-align: left" width="30%">도수</td>
                    <td style="text-align: left" width="70%">포도품종</td>
                    </tr>
                    <tr>
                    <td width="30%"><input type="text" class="form-control" :value="detail.wvo.alcohol" disabled></td>
                    <td width="70%"><input type="text" class="form-control" :value="detail.wvo.grape" disabled></td>
                    </tr>
                    </table>
                    </div>
                    <div class="mb-3">
                        <label for="price" class="label">생산지</label>
                        <input type="text" class="form-control" :value="detail.wvo.nation" disabled>
                    </div>
                    <div class="mb-3">
                        <label for="price" class="label">생산자</label>
                        <input type="text" class="form-control" :value="detail.wvo.maker" disabled>
                    </div>
                    <div style="text-align:right">
                       <button class="btn-lg" @click="messageInsert()" style="background-color: transparent;border:transparent"><i class="fa-solid fa-pen-to-square"></i></button>
                       <button class="btn-lg" @Click="deleteReport(detail.tno, detail.type)" style="border:transparent;background-color: transparent"><i class="fa-solid fa-trash-can"></i></button>
                    </div>
			</div>
		  </div>
		</div>
	   </div>
	   	<div class="modal" :class="{show: showModal}" v-if="state===4">
			<div class="modal-content" style="width: 580px; height: 400px;margin-top: 7%;">
            <div class="modal-header">
                <h5 class="modal-title">신고 리뷰 확인</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" @click="changeModal(false)"></button>
            </div>
            <div class="modal-body">
                    <div class="mb-3">
                        <label class="label">내용</label><br>
                        <div class="r-boxs" style="text-align: left">{{detail.wrvo.content}}</div>
                    </div>
                    <div style="text-align:right">
                       <button class="btn-lg" @click="messageInsert()" style="background-color: transparent;border:transparent"><i class="fa-solid fa-pen-to-square"></i></button>
                       <button class="btn-lg" @Click="deleteReport(detail.tno, detail.type)" style="border:transparent;background-color: transparent"><i class="fa-solid fa-trash-can"></i></button>
                    </div>
                </div>
			</div>
		</div>
		
		<div class="modal" :class="{ show: sModal }">
			<div class="modal-content" style="width: 400px;height: 350px">
				<div class="modal-header">
                <h4 class="modal-title">신고 처리 내용</h4>
            </div>
            <div class="mb-3">
            <div style="margin-top:10px;">
                <textarea v-model="message" ref="message"
					 class="r-boxss" style="resize:none"></textarea>
            </div>
            <div style="margin-top:15px;text-align:right">
            <button @click="sendMessage()" style="background-color: transparent"><i class="fa-solid fa-paper-plane"></i></button></div>
			</div>
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
				  detail:{},
				  state:'',
				  sModal:false,
                  message:''
    		  }
    	  },
          mounted() {
              this.rList()
          },
          methods:{
        	  deleteReport(tno, type){
        		  axios.get('../admin/reportDelete.do',{
        			  params:{
        				  tno:tno,
        				  type:type
        			  }
        		  }).then(response=>{
        			  this.messageInsert()
        		  }).catch(error=>{
        			  console.log(response.error)
        		  })
        	  },
        	  messageInsert2(index){
        		  this.detail=this.report[index]
        		  this.sModal=true
        	  },
        	  messageInsert(){
        		  this.sModal=true
        	  },
        	  sendMessage(){
          		if(this.message===''){
  					this.$refs.message.focus()
  					return
  				}
  				axios.get('../admin/reportState.do',{
  					params:{
  						wreno:this.detail.wreno
  					}
  				}).then(response=>{
  					axios.post('../notice/vueAdminNoticeSend.do',null,{
  	  					params:{
  	  						recvid:this.detail.userid,
  	  						subject:encodeURIComponent('신고 처리 관련 공지'),
  	  						content:encodeURIComponent(this.detail.userid+'님 신고하신 내용이 정상 처리되었습니다')
  	  					}
  	  				}).then(response=>{
  	  				axios.post('../notice/vueAdminNoticeSend.do', null, {
  	  					params:{
  	  						subject:encodeURIComponent('신고 처리 관련 공지'),
  	  						content:encodeURIComponent(this.message),
  	  						recvid:this.detail.rid
  	  					}
  	  				}).then(response=>{
  	  					this.sModal=false
  	  					this.message=''
  	  					this.showModal=false
  	  					this.curpage=1
  	  					this.rList()
  	  				})
  	  				})
  				})
  				
          	},
        	  changeModal(check){
        		 this.showModal=check
        	  },
        	  search(wreno,type){
        		 axios.get('../admin/reportBoardVue.do',{
        			  params:{
        				  wreno:wreno,
        				  type:type
        			  }
        		  }).then(response=>{
        		      this.state=type
        			  this.detail=response.data
        		  	  this.changeModal(true)
        		  })
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
                	 	console.log(response.data)
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