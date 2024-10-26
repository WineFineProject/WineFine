<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../tem/css/replydetail.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<style type="text/css">
#bDetail{
   margin-top: 20px;
   margin-bottom: 100px;
   width: 1080px;
}
.content-box, .detail-box{
 margin-top: 10px;
}
.brbtn{
	font-weight:bold; 
	size:16px; 
	color:#57102F;
	background-color:white !important;
	width: 70px;
	height: 40px;
}
.rmbtn{
	text-align: center;
	margin-right:10px;
}
.boarddetailtop{
	display: inline-block;
}
.breport{
background-color: white;
border: hidden; 
font-family: 'OpenSans', sans-serif;
}
.rtable22 td, .rtable22 th, .brreport{
background-color: #F5F5F5;
border:hidden;
font-family: 'OpenSans', sans-serif;
}
.rtable22 pre{
	color:black;
	font-size:16px;
	font-family: 'OpenSans', sans-serif;
}
.brrreport{
	text-align: right !important;
}
</style>
</head>
<body>
 <div class="container" id="bDetail">
     <h3 class="text-center">자유게시판</h3>
     <div class="detail-box">
          <span v-if="vo.cno==1" class="boardetailtop">&nbsp;[자유]&nbsp;</span>
          <span v-if="vo.cno==2" class="boardetailtop">&nbsp;[정보]&nbsp;</span>
          <span v-if="vo.cno==3" class="boardetailtop">&nbsp;[질문]&nbsp;</span>
          <button v-if="id!==''" @click="changeModal(true, vo, 1)" type="button" class="boardetailtop breport" style="float:right;">신고</button>
        <h2 class="post-title">{{vo.subject}}</h2>
           <span class="author-name">{{vo.nickname}}</span>
           <span class="meta-separator">|</span>
           <span class="post-date">{{vo.dbday}}</span>
           <span class="meta-separator">|</span>
           <span class="view-count"><i class="fas fa-eye"></i>&nbsp;{{vo.hit}}</span>
	  <div class="content-box" v-html="formattedContent"></div>
       <div class="button-group">
            <a :href="'update.do?bno='+vo.bno" v-if="id === vo.id" class="btn btn-primary">수정</a>
            <input type=button value="삭제" v-if="id === vo.id" class="btn btn-danger"
            ref="deleteBtn" @click="boardDelete()">
        <button type="button" class="btn btn-secondary" onclick="javascript:history.back()">목록</button>
      </div>
     </div>
      <!-- 댓글 출력 -->
      <p v-if="reply_list.count === 0 || rcount===0" style="color:black;">댓글이 없습니다.</p>
      <p v-else class="text-left" style="color:black; font-weight: bold;">댓글 수: &nbsp;{{rcount}}&nbsp;</p>
      <div v-if="id!==''" style="margin-bottom:20px">
     	    <textarea rows="4" cols="62" ref="msg" v-model="msg" class= "form-control" style="width: 90%; float: left; resize: none; display:inline-block; margin-bottom:20px;"></textarea>
            <button class= "form-control" style="float: left;background-color:#57102F; color:white; width: 100px; height: 110px; display:inline-block; margin-left:7px; margin-bottom:20px;" @click="replyWrite()">댓글쓰기</button>
         </div>
      <div v-if="id===''" style="margin-bottom:20px">
    		<p>로그인 후 댓글을 작성할 수 있습니다.</p>
      </div>
      <table class="table rtable22" v-for="rvo in reply_list" style="margin-bottom:0px;">
      <!--  
      <tr style="width:100%;">
      <td> <h6 class="text-center" style="font-size: 5px; display: none;">{{rvo.bno}}</h6></td>
      </tr>
      -->
     	<tr class="text-left">
     		<td colspan="2" v-if="rvo.depth===1" style="color:black; font-weight: bold; ">{{rvo.nickname}}</td>
     		<td rowspan="4" v-if="rvo.depth===1 && id!==''">
     		<button v-if="id!==''" @click="changeModal(true, rvo, 2)" type="button" class="brreport">신고</button>
     	</td>
     		<td colspan="2" v-if="rvo.depth===2" style="color:black; font-weight: bold; margin-left: 15px;">⤷&nbsp;{{rvo.nickname}}</td>
     		<td rowspan="4" v-if="rvo.depth===2 && id!==''">
     		<button v-if="id!==''" @click="changeModal(true, rvo, 2)" type="button" class="brreport">신고</button>
     		</td>
     	</tr>
     	<tr class="text-left">
            <td colspan="3" v-if="rvo.depth===1"><pre style="white-space: pre-wrap;">{{rvo.msg}}</pre></td>
            <td colspan="3" v-if="rvo.depth===2"><pre style="margin-left: 15px; white-space: pre-wrap;">{{rvo.msg}}</pre></td>
        </tr>
        <tr class="text-left" style="border-color: white;">   
            <td colspan="3" v-if="rvo.depth===1"><span>{{rvo.dbday}}</span></td>
            <td colspan="3" v-if="rvo.depth===2"><span style="margin-left: 15px;">{{rvo.dbday}}</span></td>
        </tr>
        <tr class="text-left">
            <td width="20%" v-if="rvo.depth===1">
            <button class="brbtn form-control" style="float: left;" @click="toggleReplyInput(rvo)">답글</button>
            </td>
            <td width="20%" v-if="rvo.depth===2">
            <h5> </h5>
            </td>
            <td width="60%" v-if="id===rvo.id">
            <button class="brbtn form-control" style="float: right;" @click="replyDelete(rvo.brno, rvo.depth)">삭제</button>
            <button class="brbtn form-control brupbtn ups" style="float: right; margin-right: 5px;" :id="'up'+rvo.brno" @click="replyUpdateForm(rvo.brno)">수정</button>
            </td>
            <td width="60%" v-else></td>
        </tr>
          <tr v-if="rvo.showReplyInput && id!==''">
		    <td colspan="6">
		        <textarea rows="4" cols="62" ref="msg" v-model="replyMsg[rvo.brno]" style="float: left; border-radius: 5px; ">{{rvo.msg}}</textarea>
		        <button style="float: left; background-color:#57102F; color:white;width: 100px;height: 100px; border-radius: 5px;" @click="reReplyWrite(rvo.brno, rvo.root)">답글쓰기</button>
		    </td>
		  </tr>
		    <tr>
	        <td colspan="2" v-if="rvo.isEditing">
	         <textarea rows="4" cols="62"  v-model="rvo.msg" style="float: left"></textarea>
	         <button style="float: left;background-color:#57102F; color:white;width: 100px;height: 100px; border-radius: 5px;" @click="replyUpdate(rvo.brno)">등록</button>
	        </td>
	       </tr>
      </table>
      <div class="modal" :class="{ show: showModal }" @click.self="changeModal(false)">
			<div class="modal-content">
				<span class="close" @click="changeModal(false)">&times;</span>
				<table class="table" style="margin-top: 50px;">
					<tr>
						<td hidden>{{vo.dbday}}</td>
						<td hidden></td>
					<tr>
					<tr>
						<th width="30%">신고자 ID : </th>
						<td width="70%">{{id}}</td>
					</tr>
					<tr>
						<th width="30%">신고대상 ID : </th>
						<td width="70%">{{type === 1 ? vo.id : rvo.id}}</td>
					</tr>
					<tr>
						<th width="30%">신고 사유:</th>
						<td width="70%">
						<select v-model="brrcategory">
							<option value="욕설/비방">욕설/비방</option>
							<option value="홍보/도배">홍보/도배</option>
							<option value="부적절한 내용">부적절한 내용</option>
						</select>
						</td>
					</tr>
					<tr>
						<th width="30%">상세 사유:</th>
						<td width="70%"><textarea rows="2" cols="30"  v-model="brrcontent" style="width: 100%; resize: none;"></textarea>
					</tr>
					<tr>
						<td colspan="2" class="rmbtn">
							<button type="button" class="rmbtn btn-sm btn-danger" @click="insertrreport()">접수</button>
							<button type="button" class="rmbtn btn-sm btn-secondary" @click="changeModal(false)">취소</button>
						</td>
					</tr>
				</table>
			</div>
		</div>
   </div>
   <script>
    let detailApp=Vue.createApp({
    	data(){
    		return {
    			vo:{},
    			reply_list:[],
    			rcount:0,
    			rvo:{},
    			replyMsg: {},
    			msg:'',
    			bno:${bno},
    			brno:0,
    			sbrno:0,
    			tno:0,
    			rid:'',
    			nickname:'${sessionScope.nickName}',
    			root:'',
    			isEditing:false,
    			showModal:false,
    			selectedreply:{},
    			brrcontent:'',
    			type:0,
    			brrcategory:"",
     			id:'${sessionScope.userId}'
    		}
    	},
    	mounted(){
    		axios.get('../board/detail_vue.do',{
    			params:{
    				bno:this.bno
    			}
    		}).then(response=>{
    			this.vo=response.data
    		}).catch(error=>{
    			console.log(error.response)
    		})
    		
    		this.replyRead()
    	},
    	computed: {
            formattedContent() {
                return this.vo.content ? this.vo.content.replace(/\n/g, '<br>') : '';
            }
        },
    	methods:{
            	changeModal(check, report=null, reportType){
    				this.showModal=check
    				if (report) {
    			        this.type=reportType
    			        if (reportType === 1) { 
    			            this.vo = report
    			        } else if (reportType === 2) { 
    			            this.rvo = report
    			        }
    			    }
    			},
    			insertrreport(){
    				if(this.brrcontent==="")
    				  {
    					 alert("신고 상세 사유를 입력해주세요")
    					  return
    				  }
    				this.tno = (this.type === 1) ? this.vo.bno : this.rvo.brno
    				this.rid = (this.type === 1) ? this.vo.id : this.rvo.id
    				axios.post('../board/breport_insert.do', null, {
    					params:{
    						type:this.type,
    						tno: this.tno,
    						userid:this.id,
    						category:this.brrcategory,
    						rid:this.rid,
    						content:this.brrcontent
    					}
    				}).then(response=>{
    					alert('신고 접수완료')
    					this.changeModal(false)
    					this.brrcontent = ""
    			        this.brrcategory = ""
    				})
    			},
          	toggleReplyInput(rvo) {
    				const reply = this.reply_list.find(reply => reply.root === rvo.root)
            	    if (reply) {
            	                reply.showReplyInput = !reply.showReplyInput
            	            }
            	    else {
            	        this.reply_list.push({
            	            root: rvo.root,
            	            showReplyInput: true 
            	        })
            	    }
    				axios.post('../board/reReply_count_vue.do', null, {
            	        params: {
            	            root: rvo.root
            	        }
            	    }).then(response => {
            	        const rereplycount = response.data
            	    }).catch(error => {
            	        console.log(error.response)
            	    })
                },
            reReplyWrite(brno, root) {
                	const msg = this.replyMsg[brno]
                	
                    if (msg === "") {
                        this.$refs.msg[brno].focus()
                        return
                    }
                    
                    axios.post('../board/reReply_insert_vue.do', null, {
                        params: {
                            bno: this.bno,
                            msg: msg,
                            id: this.id,
                            nickname: this.nickname,
                            root:root
                        }
                    }).then(response => {
                        console.log(response.data)
                        this.reply_list = response.data.list
                        const reply = this.reply_list.find(r => r.brno === brno)
                        this.replyRead(this.bno)
                    }).catch(error => {
                        console.log(error.response)
                    })
                  },
                
    		replyRead:function(){
    		axios.get('../board/reply_read_vue.do',{
						params:{
							bno:this.bno
						}
					}).then(response=>{
						  console.log(response.data)
						  this.reply_list=response.data.list
						  this.rcount=response.data.count
					}).catch(error=>{
						console.log(error.response)
					})
		    	},
    	  replyWrite:function(){
			  if(this.msg==="")
			  {
				  this.$refs.msg.focus()
				  return
			  }
			  axios.post('../board/reply_insert_vue.do',null,{
				  params:{
					  bno:this.bno,
					  msg:this.msg,
					  id:this.id,
  					  nickname:this.nickname
				  }
			  }).then(response=>{
				  console.log(response.data)
				  this.reply_list=response.data
				  this.msg='';
				  this.replyRead();
			  }).catch(error=>{
				  console.log(error.response)
			  })
		  },
		  replyDelete:function(brno, depth){
			  axios.get('../board/reply_delete_vue.do',{
				  params:{
					  bno:this.bno,
					  brno:brno,
					  depth:depth
				  }
			  }).then(response=>{
				  console.log(response.data)
				  this.reply_list=response.data.list
				  this.rcount=response.data.count
				  alert("댓글 삭제가 완료되었습니다")
			  }).catch(error=>{
				  console.log(error.response)
			  })
		  },
		  replyUpdateForm(brno){
			  const reply = this.reply_list.find(r => r.brno === brno)
			    if (reply) {
			        reply.isEditing = !reply.isEditing;
			    }
		  },
		  replyUpdate(brno){
			  const reply = this.reply_list.find(r => r.brno === brno)
			  axios.post('../board/reply_update_vue.do',null,{
				  params:{
					  bno:this.bno,
					  brno:brno,
					  msg:reply.msg
				  }
			  }).then(response=>{
				  console.log(response.data)
				  this.reply_list=response.data.list
				  const reply = this.reply_list.find(r => r.brno === brno)
			        if (reply) {
			            reply.isEditing = false // 수정 상태 해제
			        }
			  }).catch(error=>{
				  console.log(error.response)
			  })
		  },
    		boardDelete(){
    			axios.get('../board/delete_vue.do',{
    				params:{
    					bno:this.bno
    				}
    			}).then(response=>{
    					if(response.data==="yes")
    					{alert("게시물 삭제가 완료되었습니다")
    					location.href="list.do"}
    			}).catch(error=>{
    				console.log(error.response)
    			})
    		}
    	}
    }).mount('#bDetail')
   </script>
</body>
</html>