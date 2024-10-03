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
          <ul>
              <li v-for="(fn,index) in filename">
               <a :href="'download.do?fn='+fn">{{fn}}</a>({{filesize[index]}}Bytes)
              </li>
            </ul>
          </td>
        </tr>
        <tr>
          <td colspan="3" class="text-left" valign="top" height="200">
           <pre style="white-space: pre-wrap; color:black; font-size:14px; font-family: 'OpenSans', sans-serif; background-color: white; border:none;">{{vo.content}}</pre>
          </td>
        </tr>
        <tr>
          <td colspan="3" style="text-align: right; margin-right:5px; margin-left:5px; font-weight:bold; size:16px; color:#57102F;">
            <a :href="'update.do?bno='+vo.bno" v-if="id === vo.id" class="dbtn">수정</a>
            <input type=button value="삭제" v-if="id === vo.id" class="dbtn" style="box-shadow:none; font-weight:bold; border: none; font-size:16px; color:rgb(139, 0, 0) !important; background-color: white;"
            ref="deleteBtn" v-on:click="boardDelete()">
            <a href="list.do" class="dbtn">목록</a>
          </td>
        </tr>
      </table>
      <table>
      <!-- 댓글 출력 -->
      </table>
     </div>
   </div>
   <script>
    let detailApp=Vue.createApp({
    	data(){
    		return {
    			vo:{},
    			bno:${bno},
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
    	},
    	methods:{
    		boardDelete(){
    			axios.get('../board/delete_vue.do',{
    				params:{
    					bno:this.bno
    				}
    			// 결과값 읽기 => 요청 : 응답을 받는다 
    			}).then(response=>{
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