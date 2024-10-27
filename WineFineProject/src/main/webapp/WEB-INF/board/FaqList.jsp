<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link rel="stylesheet" href="../tem/css/orderlist.css">
</head>
<body>
<div class="container" id="FAQList">
  <div class="row">
	<h3 class="table-title text-center"> 자주묻는질문 (FAQ) </h3>
	<table class="table mp">
	 <template v-for="(vo, index) in fList">
		<tr id="olistth" @click="moreInfo(index)">
			<th><i class="fa fa-quora" aria-hidden="true"></i> &nbsp; {{vo.subject}}</th>
		</tr>
		<tr v-if="isShow[index]">
			<td v-html="formattedContent(vo)"></td>
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
            formattedContent(vo) {
                return this.vo.content ? this.vo.content.replace(/\n/g, '<br>') : '';
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