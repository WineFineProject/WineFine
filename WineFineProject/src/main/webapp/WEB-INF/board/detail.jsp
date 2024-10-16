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
   margin: 0px auto;
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
</style>
</head>
<body>
 <div class="container" id="bDetail">
     <h3 class="text-center">자유게시판</h3>
     <div class="detail-box">
          <span v-if="vo.cno==4">&nbsp;[일반]&nbsp;</span>
          <span v-if="vo.cno==5">&nbsp;[이벤트]&nbsp;</span>
          <span v-if="vo.cno==6">&nbsp;[상품]&nbsp;</span>
        <h2 class="post-title">{{vo.subject}}</h2>
           <span class="author-name">{{vo.nickname}}</span>
           <span class="meta-separator">|</span>
           <span class="post-date">{{vo.dbday}}</span>
           <span class="meta-separator">|</span>
           <span class="view-count"><i class="fas fa-eye"></i>&nbsp;{{vo.hit}}</span>
        <div v-show="vo.filecount!==0">
          <span class="author-name"> 첨부파일 : </span>
          <span class="author-name"> {{vo.filename}} </span>
       	</div>
          <div class="content-box">{{vo.content}}</div>
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
      <div v-if="id!==''">
     	    <textarea rows="4" cols="62" ref="msg" v-model="msg" class= "form-control" style="width: 70%; float: left; resize: none; display:inline-block;"></textarea>
            <button class= "form-control" style="float: left;background-color:#57102F; color:white; width: 100px; height: 110px; display:inline-block;" @click="replyWrite()">댓글쓰기</button>
         </div>
      <div v-if="id===''">
    		<p>로그인 후 댓글을 작성할 수 있습니다.</p>
      </div>
      <table class="table" v-for="rvo in reply_list">
      <tr style="border-bottom-color: white;">
      <td> <h6 class="text-center" style="font-size: 5px; display: none;">{{rvo.bno}}</h6></td>
      </tr>
     	<tr class="text-left" style="border-bottom-color: white; border-top-color: white;">
     		<td colspan="2" v-if="rvo.depth===1" style="color:black; font-weight: bold; ">{{rvo.nickname}}</td>
     		<td v-if="rvo.depth===1 && id!==''">
     		<button @click="changeModal(true, rvo)" type="button" style="background-color: white;border: none; font-family: 'OpenSans', sans-serif;">신고</button>
     	</td>
     		<td colspan="2" v-if="rvo.depth===2" style="color:black; font-weight: bold; margin-left: 15px;">⤷&nbsp;{{rvo.nickname}}</td>
     		<td v-if="rvo.depth===2 && id!==''">
     		<button @click="changeModal(true, rvo)" type="button" style="background-color: white;border: none; font-family: 'OpenSans', sans-serif;">신고</button>
     		</td>
     	</tr>
     	<tr class="text-left" style="border-color: white;">
            <td colspan="3" v-if="rvo.depth===1"><pre style="white-space: pre-wrap;background-color: white;border: none; font-family: 'OpenSans', sans-serif;">{{rvo.msg}}</pre></td>
            <td colspan="3" v-if="rvo.depth===2"><pre style="margin-left: 15px; white-space: pre-wrap;background-color: white;border: none; font-family: 'OpenSans', sans-serif;">{{rvo.msg}}</pre></td>
        </tr>
        <tr class="text-left" style="border-color: white;">   
            <td colspan="3" v-if="rvo.depth===1"><pre style="font-family: 'OpenSans', sans-serif;">{{rvo.dbday}}</pre></td>
            <td colspan="3" v-if="rvo.depth===2"><pre style="margin-left: 15px; font-family: 'OpenSans', sans-serif;">{{rvo.dbday}}</pre></td>
        </tr>
        <tr class="text-left">
            <td width="20%" v-if="rvo.depth===1">
            <button class="brbtn form-control" style="float: left; " @click="toggleReplyInput(rvo)">답글</button>
            </td>
            <td width="20%" v-if="rvo.depth===2">
            <h5> </h5>
            </td>
            <td width="60%" v-if="id===rvo.id">
            <button class="brbtn form-control" style="float: right;  " @click="replyDelete(rvo.brno, rvo.depth)">삭제</button>
            <button class="brbtn form-control" style="float: right; margin-right: 5px;" class="brupbtn ups" :id="'up'+rvo.brno" @click="replyUpdateForm(rvo.brno)">수정</button>
            </td>
            <td width="20%"> </td>
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
						<td hidden>{{selectedreply.brno}}</td>
						<td hidden>{{vo.dbday}}</td>
					<tr>
					<tr>
						<th width="30%">신고 댓글 내용:</th>
						<td width="70%">{{selectedreply.msg}}</td>
					</tr>
					<tr>
						<th width="30%">신고자 ID : </th>
						<td width="70%">{{id}}</td>
					</tr>
					<tr>
						<th width="30%">신고대상 ID : </th>
						<td width="70%">{{selectedreply.id}}</td>
					</tr>
					<tr>
						<th width="30%">신고 사유:</th>
						<td width="70%"><textarea rows="2" cols="30"  v-model="brrcontent" style="width: 100%; resize: none;"></textarea>
					</tr>
					<tr>
						<td colspan="2" class="rmbtn">
							<button type="button" class="rmbtn btn-sm btn-danger" @click="">접수</button>
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
    			nickname:'${sessionScope.nickName}',
    			root:'',
    			isEditing:false,
    			filename:[],
    			filesize:[],
    			showModal:false,
    			selectedreply:{},
    			brrcontent:'',
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
    			let count=response.data.filecount
    			if(count>0)
    			{
    				this.filename=response.data.filename.split(",")
    				this.filesize=response.data.filesize.split(",")
    			}
    		}).catch(error=>{
    			console.log(error.response)
    		})
    		
    		// 댓글 읽기
    		this.replyRead()
    	},
    	methods:{
            	changeModal(check, report=null){
    				this.showModal=check
    				if (report) {
    			        this.selectedreply = report
    			    }
    			},
    			insertrreport(){
    				if(this.brrcontent==="")
    				  {
    					 alert("신고 사유를 입력해주세요")
    					  return
    				  }
    				axios.post('../board/rreport_Insert.do', null, {
    					params:{
    						tno:this.sbrno,
    						sendid:sessionScope.id,
    						recvid:this.id,
    						content:this.brrcontent
    					}
    				}).then(response=>{
    					alert('댓글 신고 접수완료')
    					this.changeModal(false)
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
    					alert("게시물 삭제가 완료되었습니다")
    					location.href="list.do"
    			}).catch(error=>{
    				console.log(error.response)
    			})
    		}
    	}
    }).mount('#bDetail')
   </script>
</body>
</html>