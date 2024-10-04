<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<style type="text/css">
#nbUpdate{
   margin-top: 180px;
}
.row{
   margin: 0px auto;
   width: 1080px;
}
</style>
</head>
<body>
<div class="container" id="nbUpdate">
   <h3 class="text-center">공지사항</h3>
 
   <div class="row">
   <form @submit.prevent="submitForm">
     <h6 class="text-center" hidden>{{nbno}}</h6>
     <h6 class="text-center" hidden>{{id}}</h6>
     <table class="table">
      <tr>
       <th width="20%" class="text-center">카테고리 </th>
       <td width="80%">
         <select id="bCategory" v-model="cno" ref="cno">
                    <option value="" disabled selected>카테고리 선택</option>
                    <option value=1>일반</option>
                    <option value=2>이벤트</option>
                    <option value=3>상품</option>
          </select>
       </td>
      </tr>
      <tr>
       <th width="20%" class="text-center">제목</th>
       <td width="80%">
        <input type=text size=50 v-model="subject" ref="subject" class="input-sm">
       </td>
      </tr>
      <tr>
       <th width="20%" class="text-center">내용</th>
       <td width="80%">
        <textarea rows="10" cols="52" v-model="content" ref="content"></textarea>
       </td>
      </tr>
      <tr>
        <th width="20%" class="text-center">첨부파일</th>
        <td width="80%">
         <input type="file" ref="upfiles" class="input-sm" 
           multiple="multiple"
           accept="upload/*"
         />
        </td>
      </tr>
      <tr>
        <td colspan="2" class="text-center">
          <input type="submit" class="btn btn-sm btn-danger" value="등록">
          &nbsp;
          <input type="button" class="btn btn-sm btn-success" value="취소"
           onclick="javascript:history.back()">
        </td>
      </tr>
     </table>
     </form>
   </div>
  </div>
  <script>
    let updateApp=Vue.createApp({
    	data(){
    		return {
    			nbno:${nbno},
    			cno:'',
    			subject:'',
    			content:'',
    			id:'${sessionScope.id}',
    			upfiles:''
    			
    		}
    	},
		mounted(){
    		axios.get('update_vue.do',{
    			params:{
    				nbno:this.nbno
    			}
    		}).then(response=>{
    			this.cno=response.data.cno
    			this.subject=response.data.subject
    			this.content=response.data.content
    		}).catch(error=>{
    			console.log(error.response)
    		})
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
    			formData.append("subject",this.$refs.subject.value)
    			formData.append("content",this.$refs.content.value)
    			formData.append("nbno",this.nbno)
    			
    			let len=this.$refs.upfiles.files.length
    			
    			if(len>0) // 업로드 파일이 있는 경우 
    			{
    				for(let i=0;i<len;i++)
    				{
    					console.log(this.$refs.upfiles.files[i])
    					formData.append("files["+i+"]",this.$refs.upfiles.files[i]);
    				}
    			}
    			axios.post('../noticeboard/update_ok_vue.do',formData,{
    				headers:{
    					'Content-Type':'multipart/form-data'
    				}
    			}).then(response=>{
    				if(response.data==='yes')
    				{
    					location.href='detail.do?nbno='+this.nbno
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
    }).mount('#nbUpdate')
  </script>
</body>
</html>