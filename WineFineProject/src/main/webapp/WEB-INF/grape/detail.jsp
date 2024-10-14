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
    border-collapse: collapse;
    margin-top: 20px;
}
.taste-item , .ti {
    border: 1px solid #ccc;
    padding: 10px 5px 10px 5px;
    text-align: center;
} 
.taste-item {
    color: black;
}
.listBtn {
	cursor: pointer; 
	margin-top: 20px;
	padding: 0px; 
	width: 88px;
	height: 30px;
	align-content: center;
	background-color: #96C4FF;
	border: none;
	border-radius: 3px;
	color: white;
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
.fa-circle {
    color: lightgray; 
}

.fa-circle.filled {
    color: #CF1D56; 
}  
</style>
</head>
<body>
<div class="container">
<div class="row">
<div class="col-sm-5">
		<div class="row" id="grapeDetail">
			<div v-if="vo">
            <div>
                <span class="namekor">{{vo.namekor}}</span>
                <span class="nameeng">{{vo.nameeng}}</span>
                <div class="header-line"></div>
            </div>
            <table>
                <tbody>
                    <tr>
                        <th class="taste-item">맛</th>
                        <td v-if="vo" class="text-left ti">
                         <div class="text-left" id="flavor">
                            <div>당도&nbsp;<span class="fa fa-circle" v-for="n in 5" :class="{'filled':n<=vo.sugar, 'empty':n>vo.sugar}"></span></div>
                            <div>산도&nbsp;<span class="fa fa-circle" v-for="n in 5" :class="{'filled':n<=vo.acid, 'empty':n>vo.acid}"></span></div>
                            <div>바디&nbsp;<span class="fa fa-circle" v-for="n in 5" :class="{'filled':n<=vo.body, 'empty':n>vo.body}"></span></div>
                            <div>타닌&nbsp;<span class="fa fa-circle" v-for="n in 5" :class="{'filled':n<=vo.tannin, 'empty':n>vo.tannin}"></span></div>
                         </div>    
                        </td>
                    </tr>
                    <tr v-show="vo.aroma!==null">
                        <th class="taste-item">아로마</th>
                        <td class="left-align ti">{{vo.aroma}}</td>
                    </tr>
                    <tr v-if="vo.nation!==null">
                        <th class="taste-item">주재배지역</th>
                        <td class="left-align ti">{{vo.nation}}</td>
                    </tr>
                    <tr v-show="vo.food!==null">
                        <th class="taste-item">추천음식</th>
                        <td class="left-align ti">{{vo.food}}</td>
                    </tr>
                </tbody>
            </table>
            <div style="margin-top: 20px;">
                <p>{{vo.content}}</p>
            </div>
          </div>
		 <div class="button-container" style="margin-top: 150px"> 
           <input type="button" class="listBtn" @click="List" value="목록">
         </div>
      </div>
	</div>
	<div class="col-sm-5" >
		    <h3>관련 와인</h3>
		    <table>
		            <tr v-for="vo in gWines" :key="vo.wno">
		                <th>{{vo.poster}}</th>
		                 <td>
			                <div>{{vo.grape}}</div>
			                <div>{{vo.namekor}}</div>
			                <div>{{vo.nameeng}}</div>
			                <div>{{vo.maker}}</div>
			                <div>{{vo.nation}}</div>
			                <div>{{vo.type}}</div>
		                 </td> 
		            </tr>
		    </table>
        </div>
        </div>
        </div>
    <script>
        let grapeDetailApp = Vue.createApp({
        	 data() {
                 return {
                	 vo: {},
                	 no:${no},
                	 gWines:[]
                 }
             },
             mounted() {
            	 this.dataRecv()
            	 this.getRelatedWines()
             },
             methods: {
            	 getRelatedWines() {
            		 console.log(this.no)
                     axios.get('../grape/relatedWines.do', {
                         params: {
                             no: this.no
                         }
                     }).then(response => {
                         this.gWines = response.data.gWines
                     }).catch(error => {
                         console.error(error)
                     })
                 },
                 dataRecv() {
                     axios.get('../grape/detailVue.do',{
                    	 params:{
             				no:this.no
             			}
                     }).then(response=>{
                             this.vo=response.data
                             console.log(response.data)
                             console.log(this.vo)
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