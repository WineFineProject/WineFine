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
     	    <textarea rows="4" cols="62" ref="msg" v-model="msg" style="float: left; border-radius: 5px;"></textarea>
            <button style="float: left;background-color:#57102F; color:white;width: 100px;height: 100px; border-radius: 5px;" @click="replyWrite()">댓글쓰기</button>
         </div>
      <div v-if="id===''">
    		<p>로그인 후 댓글을 작성할 수 있습니다.</p>
      </div>
      <table class="table" v-for="rvo in reply_list">
      <tr style="border-bottom-color: white;">
      <td> <h6 class="text-center" hidden style="font-size: 5px;">{{rvo.bno}}</h6></td>
      </tr>
     	<tr class="text-left" style="border-bottom-color: white; border-top-color: white;">
     		<td colspan="3" v-if="rvo.depth===1" style="color:black; font-weight: bold; ">{{rvo.nickname}}</td>
     		<td colspan="3" v-if="rvo.depth===2" style="color:black; font-weight: bold; margin-left: 15px;">⤷&nbsp;{{rvo.nickname}}</td>
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
            <button style="float: left; font-weight:bold; size:16px; color:#57102F;background-color:white; border-radius: 5px; width: 50px;height: 30px" @click="toggleReplyInput(rvo)">답글</button>
            </td>
            <td width="20%" v-if="rvo.depth===2">
            <h5> </h5>
            </td>
            <td width="60%" v-if="id===rvo.id">
            <button style="float: right;  font-weight:bold; size:16px; color:#57102F;background-color:white; border-radius: 5px; width: 50px;height: 30px" @click="replyDelete(rvo.brno)">삭제</button>
            <button style="float: right;  font-weight:bold; size:16px; color:#57102F;background-color:white; border-radius: 5px; width: 50px;height: 30px; margin-right: 5px;" class="brupbtn ups" :id="'up'+rvo.brno" @click="replyUpdateForm(rvo.brno)">수정</button>
            </td>
            <td width="20%"> </td>
        </tr>
          <tr v-if="rvo.depth === 1 && rvo.showReplyInput && id!==''">
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
    			nickname:'',
    			root:'',
    			isEditing:false,
    			filename:[],
    			filesize:[],
     			id:'${sessionScope.id}'
    			
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
    		
    		this.fetchNickname()
    	},
    	methods:{
    		fetchNickname() {
                axios.post('../board/get_nickname.do')
                    .then(response => {
                        this.nickname = response.data
                    })
                    .catch(error => {
                        console.log(error.response)
                    })
            	},
                toggleReplyInput(rvo) {
                    // 답글이 작성되었는지 확인
                    if (rvo.replyWritten) {
                        alert("답글은 1개까지 작성이 가능합니다.")
                        rvo.showReplyInput=false
                    } 
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
                        if (reply) {
                            reply.replyWritten = true // 답글 작성 상태 업데이트
                            rvo.showReplyInput = false
                        } // 답글 작성 상태 업데이트
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