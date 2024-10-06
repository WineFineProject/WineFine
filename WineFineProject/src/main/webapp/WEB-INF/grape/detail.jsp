<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>품종 상세 페이지</title>
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
		<div class="row" id="grapeDetail" style="margin-top: 150px">
			<div v-if="vo">
            <div>
                <span class="namekor">{{vo.namekor}}</span>
                <span class="nameeng">{{vo.nameeng}}</span>
                <div class="header-line"></div>
            </div>
            <table>
                <tbody>
                    <tr>
                        <th>맛</th>
                        <td v-if="vo" class="text-left">
                         <div class="text-left" id="flavor">
                            <div>당도: {{vo.sugar}}</div>
                            <div>산도: {{vo.acid}}</div>
                            <div>바디: {{vo.body}}</div>
                            <div>타닌: {{vo.tannin}}</div>
                         </div>    
                        </td>
                    </tr>
                    <tr>
                        <th>아로마</th>
                        <td class="left-align">{{vo.aroma}}</td>
                    </tr>
                    <tr>
                        <th>주재배지역</th>
                        <td class="left-align">{{vo.nation}}</td>
                    </tr>
                    <tr>
                        <th>추천음식</th>
                        <td class="left-align">{{vo.food}}</td>
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
        let grapeDetailApp = Vue.createApp({
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
                     axios.get('../grape/detailVue.do',{
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
                     window.location.href='../grape/list.do'
                 }
             }
        }).mount('#grapeDetail')
    </script>
</body>
</html>