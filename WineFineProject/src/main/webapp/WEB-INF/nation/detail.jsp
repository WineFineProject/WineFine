<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>생산지역 상세 페이지</title>
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
    width: 100%;
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
.left-align {
    text-align: left;
}    
</style>
</head>
<body>
<div class="container py-5">
		<div class="row" id="nationDetail">
			<div v-if="vo">
            <div>
                <span class="namekor">{{vo.namekor}}</span>
                <span class="nameeng">{{vo.nameeng}}</span>
                <div style="height: 10px"></div>
                <div>{{vo.nation}}</div>
            </div>
                <div class="header-line"></div>
            <table>
                <tbody>
                    <tr>
                        <th>주재배품종</th>
                        <td class="left-align">{{vo.grape}}</td>
                    </tr>
                </tbody>
            </table>
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
        let nationDetailApp = Vue.createApp({
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
                     axios.get('../nation/detailVue.do',{
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
                     window.location.href='../nation/list.do'
                 }
             }
        }).mount('#nationDetail')
    </script>
</body>
</html>