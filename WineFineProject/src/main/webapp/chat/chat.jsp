<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="container-fluid bg-dark text-white-50 footer pt-5 mt-5" id="chatApp">
		<div class="chat_list" :class="{hide:!isShow, active:isShow}">
			<h4 class="text-center">채팅 가능 목록</h4>
			<table class="table">
				<tr>
					<th></th>
				</tr>
			</table>
		</div>
		<button @click="changeShow()" class="btn border-wine fixed-button text-center">
			<i class='fas fa-comment' style="font-size: 40px;"></i>
		</button>
		</div>
		<script>
	let websocket
	let name
	let chatApp=Vue.createApp({
		
		data(){
			return{
				isShow:false
			}
		},
		methods:{
			changeShow(){
				this.isShow=!this.isShow
			},
			connection(){
				// 서버 연결 
				websocket=new WebSocket("ws://localhost:8080/controller/chat/chat-ws")
				websocket.onopen=this.onOpen
				websocket.onmessage=this.onMessage
			},
			disConnection(){
				if(websocket)
					websocket.close()
			},
			onOpen(event){
				 alert("채팅서버에 연결되었습니다!!")
			},
			onClose(event){
				 alert("채팅서버가 연결을 종료하였습니다!!")
			},
			onMessage(event) {
	            let data = event.data;
	            if (data.substring(0, 4) === 'msg:') {
	                this.messages.push({ text: data.substring(4), color: 'red', align: 'left' });
	            } else if (data.substring(0, 3) === 'my:') {
	                this.messages.push({ text: data.substring(3), color: 'blue', align: 'right' });
	            } else if (data.substring(0, 4) === 'you:') {
	                this.messages.push({ text: data.substring(4), color: 'black', align: 'left' });
	            }
	        }
		},
		mounted(){
			this.connection()
		}
	}).mount('#chatApp')
	</script>
</body>
</html>