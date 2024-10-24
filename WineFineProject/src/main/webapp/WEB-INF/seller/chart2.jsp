<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<!--
C:\springDev\SpringStudy\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\WineFineProject\images
  -->
<body>
	<div class="container" id="chart2App">
		<div class="row">
			<div class="text-center">
				<button class="btn btn-sm border-wine" @click="changes()">구매 전환율</button>
				<button class="btn btn-sm border-wine ">프로모션 효과</button>
				<button class="btn btn-sm border-wine" @click="weekChart()">주간 수익</button>
			</div>
		</div>
		<div class="row">
			<img :src="'../images/'+image">
		</div>
	</div>
	<script>
	let id='${sessionScope.userId}'
	let char2App=Vue.createApp({
		data(){
			return{
				image:''
			}
		},
		methods:{
			changes(){
				url='seller/change/'
					this.dataCall(url)
			},
			weekChart(){
				url='seller/weekChart/'
				this.dataCall(url)
			},
			dataCall(url){
				axios.get('http://127.0.0.1:8000/web/'+url,{
					params:{
						userid:id
					}
				}).then(response=>{
					console.log(response.data)
					this.image=response.data.image
				})
			}
		}
	}).mount('#chart2App')
	</script>
</body>
</html>