<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../tem/css/memberlist.css">
</head>
<body>
	<div id="list" class="row">
		<h3 class="text-center">블랙리스트</h3>
		<div class="row">
		<table>
		<tr>
		<td width="60%" style="text-align: right;">
    		<select id="filter" v-model="option" ref="option" class="form-control" style="width: 10%; display: inline-block; margin-right:5px;">
                    <option value="nickname">닉네임</option>
                    <option value="username">이름</option>
            </select>
          <input type=text size=20 v-model="fdtmp" ref="fd" class="form-control" placeholder="검색어를 입력해주세요" style="width: 25%; display: inline-block; margin-right:5px;">
          <input type="button" value="검색" class="ctbtn form-control" @click="findblack()" style="width:5%; display: inline-block">
    	 </td>
    	 </tr>
    	</table> 
		<table class="table" style="margin-top: 20px">
			<thead class="text-center">
				<tr>
					<th width="5%">번호</th>
					<th width="15%">아이디</th>
					<th width="15%">닉네임</th>
					<th width="10%">이름</th>
					<th width="20%">이메일</th>
					<th width="5%">성별</th>
					<th width="5%">등급</th>
					<th width="15%">마지막 접속일</th>
					<th width="10%">관리</th>
				</tr>
			</thead>
			<tbody class="text-center">
				<template v-for="(vo, index) in black">
					<tr style="vertical-align: middle;"@click="detailMember(index)">
						<td width="5%">{{index+1+(curpage-1)*10}}</td>
						<td width="15%">{{vo.userId}}</td>
						<td width="15%">{{vo.nickName}}</td>
						<td width="10%">{{vo.userName}}</td>
						<td width="20%">{{vo.email}}</td>
						<td width="5%">{{vo.sex}}</td>
						<td width="5%">{{vo.grade}}</td>
						<td width="15%">{{vo.lastloginday}}</td>
						<td width="10%">
							<button type="button" class="btn btn-sm btn-warning" 
								id="blackListBtn" @click="blackListDelete(vo.userId)">해제</button>
						</td>
					</tr>
					<tr v-if="isShow[index]">
						<td colspan="9" style="padding: 0px;">
							<table class="table" style="border: none;margin-bottom: 0px">
								<tr>
									<th>생일</th>
									<th>전화번호</th>
									<th>주소</th>
									<th>포인트</th>
									<th>가입일</th>

								</tr>
								<tr>
									<td>{{vo.birthday}}</td>
									<td>{{vo.phone}}</td>
									<td>({{vo.post}})&nbsp;{{vo.addr1}}{{vo.addr2}}</td>
									<td>{{vo.point}}</td>
									<td>{{vo.regday}}</td>
								</tr>
							</table>
						</td>
					</tr>
				</template>
			</tbody>
			
		</table>
		<div class="modal" :class="{ show: showModal }">
			<div class="modal-content" style="height: 200px;">
				<h3 class="text-center">사유 작성</h3>
				<input type="text" v-model="message" ref="message"
					@keyup.enter="sendMessage()">
			</div>
		</div>
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
        let blackListApp=Vue.createApp({
            data() {
                return {
                	black:[],
                	fd:'',
                    tmp:'',
                    fdtmp:'',
                    showModal:false,
                    message:'',
                    isShow:Array(10).fill(false),
                    curpage:1,
				    totalpage:0,
				    startPage:0,
				    endPage:0,
				    option:'nickname'

                }
            },
            mounted() {
                this.bList()
            },
            methods: {
            	findblack(){
            		this.fd=this.fdtmp
            		this.bList()
            	},
            	prev(){
         			 this.curpage=this.startPage-1
         			 this.bList()
         		 },
         		 next(){
         			 this.curpage=this.endPage+1
         			 this.bList()
         		 },
         		 pageChange(page){
         			 this.curpage=page
         			 this.bList()
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
            	detailMember(index){
            		if(this.isShow[index]===true){
            			this.isShow[index]=false
            		}
            		else{
            		this.isShow[index]=true
            		}
            	},
            	sendMessage(){
            		if(this.message===''){
    					this.$refs.message.focus()
    					return
    				}
            		console.log(this.tmp)
            		axios.get('../seller/blackListDelete.do', {
            	        params:{
            	        	recvid: this.tmp 
            	        }
            	    }).then(response => {
            	        this.bList()
            	    }).catch(error => {
            	    })
    				axios.post('../notice/vueSellerNoticeSend.do',null,{
    					params:{
    						content:encodeURIComponent(this.message),
    						recvid:this.tmp,
    						subject:encodeURIComponent('블랙리스트 해제 안내 공지')
    					}
    				}).then(response=>{
    					this.message=''
    					this.tmp=''
    					this.showModal=false
    				})
            	},
                bList(){
            		if(this.fd) {
      			       this.curpage = 1
      			    }
                    axios.get('../seller/blackListVue.do',{
                    	params:{
                    		  page:this.curpage,
                    		  fd:this.fd,
                    		  option:this.option
                    	}
                    }).then(response=>{
                            this.black=response.data.black
                            this.curpage=response.data.curpage
					        this.totalpage=response.data.totalpage
					        this.startPage=response.data.startPage
					        this.endPage=response.data.endPage
                        }).catch(error=>{
                            alert(error.response)
                            console.log(error.response)
                        })
                },
                blackListDelete(id){
                	this.tmp=id
                	this.showModal=true
                }
            }
        }).mount('#list')
    </script>
</body>
</html>