<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
#bInsert{
   margin-top: 20px;
   margin-bottom: 100px;
   width: 960px;
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
 <div class="container" id="bInsert">
   <h3 class="text-center">자유게시판</h3>
 
   <div class="row">
   <form @submit.prevent="submitForm">
     <h6 class="text-center" style="display:none;">{{id}}</h6>
     <h6 class="text-center" style="display:none;">{{nickname}}</h6>
     <table class="table bitable">
      <tr>
       <th width="20%" class="text-center">카테고리 </th>
       <td width="80%">
         <select id="bCategory" class="form-control" v-model="cno" ref="cno">
                    <option value="" disabled selected>카테고리 선택 &nbsp;▼ </option>
                    <option value=1>자유</option>
                    <option value=2>정보</option>
                    <option value=3>질문</option>
          </select>
       </td>
      </tr>
      <tr>
       <th width="20%" class="text-center">제목</th>
       <td width="80%">
        <input type=text size=50 class="form-control" v-model="subject" ref="subject">
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
          <input type="submit"  class="btn btn-danger" value="등록">
          &nbsp;
          <input type="button"  class="btn btn-secondary" value="취소"
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
    			cno:'',
    			subject:'',
    			content:'',
    			id:'${sessionScope.userId}',
    			nickname:'${sessionScope.nickName}'
    			
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
    			formData.append("nickname",this.nickname)    			
    			formData.append("subject",this.$refs.subject.value)
    			formData.append("content",this.$refs.content.value)
    			
    			for (const x of formData) {
   				 console.log(x);
   				}
    			axios.post('../board/insert_vue.do',formData,{
    				headers:{
    					'Content-Type':'multipart/form-data'
    				}
    			}).then(response=>{
    				if(response.data==='yes')
    				{
    				    location.href='list.do'	
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
    }).mount('#bInsert')
  </script>
</body>
</html>