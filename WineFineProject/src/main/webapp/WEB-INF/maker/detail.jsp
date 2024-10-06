<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>생산자 상세 페이지</title>
<style>
.namekor {
    font-size: 24px;
    font-weight: bold;
}
.nameeng {
    font-size: 20px;
    color: gray;
    margin-left: 10px;
}
table {
    width: 80%;
    border-collapse: collapse;
    margin-top: 20px;
}
th, td {
    border: 1px solid #ccc;
    padding: 10px;
    text-align: center;
} 
.listBtn {
	cursor: pointer; 
	margin-top: 20px;
	padding: 0px; 
	width: 88px;
	height: 30px;
	align-content: center;
}
.header-line {
	border-top: 3px solid black;
	margin-top: 10px;
} 
.button-container {
    text-align: center; 
    margin-top: 20px;
}
#flavor {
    display: flex;
    display: flex; 
    gap: 20px; 
}
.left-align {
    text-align: left;
}    
</style>
</head>
<body>
<div class="container py-5">
		<div class="row" id="makerDetail" style="margin-top: 150px">
			<div v-if="vo">
            <div>
                <span class="namekor">{{vo.namekor}}</span>
                <span class="nameeng">{{vo.nameeng}}</span>
                <div style="height: 10px"></div>
                <div>{{vo.nation}}</div>
                <div class="header-line"></div>
            </div>
            <div style="margin-top: 20px;">
                <p>{{vo.content}}</p>
            </div>
          </div>
		 <div class="button-container"> 
           <input type="button" class="listBtn" @click="List" value="목록">
         </div>
      </div>
	</div>
    <script>
        let makerDetailApp = Vue.createApp({
        	 data() {
                 return {
                	 vo: {},
                	 no:${no}
                 }
             },
             mounted() {
                 this.dataRecv()
             },
             methods: {
                 dataRecv() {
                     axios.get('../maker/detailVue.do',{
                    	 params:{
             				no:this.no
             			}
                     }).then(response=>{
                             this.vo=response.data
                         }).catch(error=>{
                             console.error(error)
                         })
                 },
                 List() {
                     window.location.href='../maker/list.do'
                 }
             }
        }).mount('#makerDetail')
    </script>
</body>
</html>