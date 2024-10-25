<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
#anbInsert{
   margin-top: 20px;
   margin-bottom: 100px;
   width: 960px;
   margin-left: 15px;
}
.bitable{
	border-top: 1px solid #E0E0E0;
	border-right: 1px solid #E0E0E0;
}
#btntd{
	border-right:hidden;
	border-left:hidden;
	border-bottom:hidden;
}
</style>
</head>
<body>
 <div class="container" id="anbInsert">
   <h3 class="text-center">공지사항 관리</h3>
 
   <div class="row">
   <form @submit.prevent="submitForm">
     <h6 class="text-center" hidden>{{id}}</h6>
     <table class="table bitable">
      <tr>
       <th width="20%" class="text-center">카테고리 </th>
       <td width="80%">
         <select id="bCategory" class="form-control" v-model="cno" ref="cno">
                    <option value="" disabled selected>카테고리 선택 &nbsp;▼</option>
                    <option value=4>일반</option>
                    <option value=5>이벤트</option>
                    <option value=6>상품</option>
          </select>
       </td>
      </tr>
      <tr>
       <th width="20%" class="text-center">제목</th>
       <td width="80%">
        <input type=text size=50 v-model="subject" ref="subject" class="form-control">
       </td>
      </tr>
      <tr>
       <th width="20%" class="text-center">내용</th>
       <td width="80%">
        <textarea rows="10" cols="52" class="form-control" v-model="content" ref="content" style="resize: none;"></textarea>
       </td>
      </tr>
      <tr>
        <td colspan="2" class="text-center" id="btntd">
          <input type="submit" class="btn btn-danger" value="등록">
          &nbsp;
          <input type="button" class="btn btn-secondary" value="취소"
           onclick="javascript:history.back()">
        </td>
      </tr>
     </table>
     </form>
   </div>
  </div>
  <script>
    let insertApp=Vue.createApp({
    	data(){
    		return {
    			cno:4,
    			subject:'',
    			content:'',
    			id:'${sessionScope.userId}'
    		}
    	},
		mounted(){
    		
    	},
    	methods:{
    		submitForm(){
    			if(this.cno==="")
    			{
    				this.$refs.cno.focus()
    				return
    			}
    			if(this.subject==="")
    			{
    				this.$refs.subject.focus()
    				return
    			}
    			if(this.content==="")
    			{
    				this.$refs.content.focus()
    				return
    			}
    			
    			let formData=new FormData()
    			formData.append("cno",this.$refs.cno.value)
    			formData.append("id",this.id)    			
    			formData.append("subject",this.$refs.subject.value)
    			formData.append("content",this.$refs.content.value)
    			
    			axios.post('../noticeboard/insert_vue.do',formData,{
    			}).then(response=>{
    				if(response.data==='yes')
    				{
    				    location.href='noticeboard.do'	
    				}
    				else
    				{
    					alert(response.data)
    				}
    			}).catch(error=>{
    				console.log(error.response)
    			})
    		}
    	}
    }).mount('#anbInsert')
  </script>
</body>
</html>