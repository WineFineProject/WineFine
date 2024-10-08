<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<style type="text/css">
#bDetail{
   margin-top: 180px;
}
.row{
   margin: 0px auto;
   width: 1080px;
}
.brbtn{
	font-weight:bold; 
	size:16px; 
	color:#57102F;
	background-color:white !important;
	width: 70px;
	height: 40px;
}
</style>
</head>
<body>
 <div class="container" id="bDetail">
     <h3 class="text-center">자유게시판</h3>
     <span>  </span>
     <div class="row">
      <table class="table">
        <tr style="background-color:lightgray; color:black; font-size: 18px; font-weight: bold;">
          <td colspan="3" class="text-left">
          <span v-if="vo.cno==1">&nbsp;[자유]&nbsp;{{vo.subject}}</span>
          <span v-if="vo.cno==2">&nbsp;[정보]&nbsp;{{vo.subject}}</span>
          <span v-if="vo.cno==3">&nbsp;[질문]&nbsp;{{vo.subject}}</span>
          </td>
        </tr>
        <tr>
          <td width="15%" class="text-center" style="color:black; font-size: 16px; font-weight: bold;">{{vo.nickname}}</td>
          <td width="45%" class="text-left" style="font-size: 16px;" >{{vo.dbday}}</td>
          <td width="40%" style="text-align:right; color:black; font-size: 16px;" >조회수 &nbsp; {{vo.hit}} &nbsp;&nbsp;</td>
        </tr>
        <tr v-show="vo.filecount!==0">
          <td width="15%" class="text-center">첨부파일</td>
          <td colspan="2" class="text-left">
          {{vo.filename}}
          <!-- 첨부파일 다운로드 기능
          <ul>
              <li v-for="(fn,index) in filename">
               <a :href="'download.do?fn='+fn">{{fn}}</a>({{filesize[index]}}Bytes)
              </li>
            </ul>
             -->
          </td>
        </tr>
        <tr>
          <td colspan="3" class="text-left" valign="top" height="200">
        	<div style="margin-left:5px; white-space: pre-wrap; color:black; font-size:16px; font-family: 'OpenSans', sans-serif; background-color: white; border:none;">
            <div v-html="vo.content"></div>
        	</div>
   		  </td>
        </tr>
        <tr style="border-bottom-color: white;">
          <td colspan="3" style="text-align: right; margin-right:5px; margin-left:5px; font-weight:bold; size:16px; color:#57102F;">
            <a :href="'update.do?bno='+vo.bno" v-if="id === vo.id" class="dbtn">수정</a>
            <input type=button value="삭제" v-if="id === vo.id" class="dbtn" style="box-shadow:none; font-weight:bold; border: none; font-size:16px; color:rgb(139, 0, 0) !important; background-color: white;"
            ref="deleteBtn" v-on:click="boardDelete()">
            <a href="list.do" class="dbtn">목록</a>
          </td>
        </tr>
      </table>
      <!-- 댓글 출력 -->
      <p style="background-color: lightgray;">&nbsp;</p>
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
      <td> <h6 class="text-center" hidden style="font-size: 5px;">{{rvo.bno}}</h6></td>
      </tr>
     	<tr class="text-left" style="border-bottom-color: white; border-top-color: white;">
     		<td colspan="2" v-if="rvo.depth===1" style="color:black; font-weight: bold; ">{{rvo.nickname}}</td>
     		<td v-if="rvo.depth===1 && id!==''">
     		<!--  
     		<button @click="changeModal(true)" v-model="sbrno" type="button" style="background-color: white;border: none; font-family: 'OpenSans', sans-serif;">신고</button>
     		-->
     	</td>
     		<td colspan="2" v-if="rvo.depth===2" style="color:black; font-weight: bold; margin-left: 15px;">⤷&nbsp;{{rvo.nickname}}</td>
     		<td v-if="rvo.depth===2 && id!==''">
     		<!-- 
     		<button @click="changeModal(true)" v-model="sbrno[rvo.brno]" type="button" style="background-color: white;border: none; font-family: 'OpenSans', sans-serif;">신고</button>
     		-->
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
            <button class="brbtn form-control" style="float: right;  " @click="replyDelete(rvo.brno)">삭제</button>
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
      <div>
      <h1>   </h1>
      </div>
     <!-- 
      <div class="modal" :class="{ show: showModal }" @click.self="changeModal(false)">
			<div class="modal-content">
				<span class="close" @click="changeModal(false)">&times;</span>
				<table class="table" style="margin-top: 50px;">
					<tr>
						<td hidden>{{sbrno}}</td>
						<td hidden>{{vo.dbday}}</td>
					<tr>
					<tr>
						<th width="30%">신고 댓글 내용:</th>
						<td width="70%">{{smsg}}</td>
					</tr>
					<tr>
						<th width="30%">신고자 ID : </th>
						<td width="70%">${sessionScope.id}</td>
					</tr>
					<tr>
						<th width="30%">신고대상 ID : </th>
						<td width="70%">{{vo.id}}</td>
					</tr>
					<tr>
						<th width="30%">신고 사유:</th>
						<td width="70%"><textarea rows="2" cols="30"  v-model="brrcontent" style="width: 100%"></textarea>
					</tr>
					<tr v-show="isBtn">
						<td colspan="2">
							<button type="button" class="btn btn-sm btn-wine" @click="">접수</button>
							<button type="button" class="btn btn-sm btn-wine" @click="changeModal(false)">취소</button>
						</td>
					</tr>
				</table>
			</div>
		</div>
		-->
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
            	/* changeModal(check){
    				if(check===false){
    					
    					this.sbrno=0
    					this.sid=''
    					this.smsg=''
    					this.isBtn=false
    					this.brrcontent=''
    				}
    				changeModal(this, check)
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
    			*/
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
		  replyDelete:function(brno){
			  axios.get('../board/reply_delete_vue.do',{
				  params:{
					  bno:this.bno,
					  brno:brno
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