<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link rel="stylesheet" href="../tem/css/orderlist.css">
<style>
#FAQList{
	width:960px;
	margin-top:20px;
	
}
.fth, .ftd{
	padding-top:5px;
	padding-bottom:5px;
	text-align:left !important;
}
.fth{
	padding-left:5px;
}
.ftd{
	padding-left:15px;
}
</style>
</head>
<body>
<div class="container" id="FAQList">
  <div class="row">
	<h3 class="table-title text-center"> 자주묻는질문 (FAQ) </h3>
	<table class="table mp">
	 <template v-for="(vo, index) in fList">
		<tr id="olistth" @click="moreInfo(index)">
			<th class="fth">Q. &nbsp; {{vo.subject}}</th>
		</tr>
		<tr v-if="isShow[index]">
			<td v-html="formattedContent(vo)" class="ftd"></td>
		</tr>
		</template>
		</table>
	</div>
</div>
<script>
    let detailApp=Vue.createApp({
    	data(){
    		return {
    			fList:[],
    			isShow:[]
    		}
    	},
    	mounted(){	
    		this.dataRecv()
    	},
    	computed: {
            formattedContent() {
            	return (vo) => vo.content ? vo.content.replace(/\n/g, '<br>') : ''
            }
        },
    	methods:{
    		dataRecv(){
    			axios.get('../board/FAQlist_vue.do',{
    				params:{}
    			}).then(response=>{
    				this.fList=response.data
    				this.isShow = Array(this.fList.length).fill(false)
    			}).catch(error=>{
    				console.log(error.response)
    			})
    		},
    		moreInfo(index){
    			this.isShow[index] = !this.isShow[index]
			}
    	}
    }).mount('#FAQList')
   </script>
</body>
</html>