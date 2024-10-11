<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<style type="text/css">

</style>
</head>
<body>
 <div class="container" id="nbDetail">
     <h3 class="text-center">공지사항</h3>
     <span>  </span>
     <div class="row">
      <table class="table">
        <tr style="background-color:lightgray; color:black; font-size: 18px; font-weight: bold;">
          <td colspan="3" class="text-left">
          <span v-if="vo.cno==4">&nbsp;[일반]&nbsp;{{vo.subject}}</span>
          <span v-if="vo.cno==5">&nbsp;[이벤트]&nbsp;{{vo.subject}}</span>
          <span v-if="vo.cno==6">&nbsp;[상품]&nbsp;{{vo.subject}}</span>
          </td>
        </tr>
        <tr>
          <td width="15%" class="text-center" style="color:black; font-size: 16px; font-weight: bold;">관리자</td>
          <td width="45%" class="text-left" style="font-size: 16px;" >{{vo.dbday}}</td>
          <td width="40%" style="text-align:right; color:black; font-size: 16px;" >조회수 &nbsp; {{vo.hit}} &nbsp;&nbsp;</td>
        </tr>
        <tr>
          <td colspan="3" class="text-left" valign="top" height="200">
        	<div style="white-space: pre-wrap; color:black; font-size:16px; font-family: 'OpenSans', sans-serif; background-color: white; border:none;">
            {{vo.content}}</div>
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
     </div>
   </div>
   <script>
    let detailApp=Vue.createApp({
    	data(){
    		return {
    			vo:{},
    			bno:${bno},
    			id:'${sessionScope.userId}'
    		}
    	},
    	mounted(){
    		axios.get('../noticeboard/detail_vue.do',{
    			params:{
    				bno:this.bno
    			}
    		}).then(response=>{
    			this.vo=response.data
    		}).catch(error=>{
    			console.log(error.response)
    		})
    	},
    	methods:{
    		boardDelete(){
    			axios.get('../noticeboard/delete_vue.do',{
    				params:{
    					bno:this.bno
    				}
    			}).then(response=>{
    				   alert("공지 삭제가 완료되었습니다")
    					location.href="list.do"
    			}).catch(error=>{
    				console.log(error.response)
    			})
    		}
    	}
    }).mount('#nbDetail')
   </script>
</body>
</html>