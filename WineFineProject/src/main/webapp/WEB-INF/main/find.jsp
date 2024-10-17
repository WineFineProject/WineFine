<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.type-red {
	color: #fff;
	background-color: #bb2d3b;
	border: 1px solid #dc3545;
}

.type-white {
	color: #000000;
	background-color: #ffffff;
	border: 1px solid #000000;
}

.type-spark {
	color: #000000;
	background-color: #b4c5fe;
	border: 1px solid #b4c5fe;
}

.type-rose {
	color: #000000;
	background-color: #ffc1e0;
	border: 1px solid #ffc1e0;
}

.type-alcohol {
	color: #000000;
	background-color: #8dc7c7;
	border: 1px solid #8dc7c7;
}

.type-etc {
	color: #000000;
	background-color: #8dc7c7;
	border: 1px solid #8dc7c7;
}

.wine-info p {
	margin: 0px;
}

.wine-maker, .wine-nation {
	font-size: 10px;
	font-family: "Gowun Dodum", sans-serif;
}

.wine-kor {
	font-size: 20px;
	font-weight: 999;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
	margin-bottom: -8px !important;
	font-family: "Gowun Dodum", sans-serif;
	color: darkred;
}

.wine-eng {
	font-size: 14px;
	margin-bottom: 5px !important;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
	font-family: "Gowun Dodum", sans-serif;
}

.wine-info-badge {
	font-size: 10px;
	margin-bottom: 5px;
	font-family: "Gowun Dodum", sans-serif;
}
</style>
</head>
<body>
	<div class="container" id="findApp" style="margin-top: 10px;">
		<div class="row">
			<div class="col-sm-4" v-for="wvo in wList" style="margin-bottom: 10px;">
				<div class="row">
					<div class="wine-img col-sm-3">
						<a :href="'../shop/detail.do?wno='+wvo.wno">
							<img :src="wvo.poster" style="width: 100%">
						</a>
					</div>
					<div class="wine-info col-sm-9">
						<div class="wine-info-badge">
							<span class="text-center" style="border-radius: 5px; padding: 2px; width: 43px; display: inline-block;" :class="{'type-red': wvo.type === '레드','type-white': wvo.type === '화이트','type-spark': wvo.type === '스파클링','type-rose': wvo.type === '로제','type-alcohol': wvo.type === '주정강화','type-etc': wvo.type === '기타'}">{{wvo.type}}</span>
						</div>
						<div class="wine-info-name">
							<p class="wine-maker">{{wvo.maker}}</p>
							<p class="wine-kor">
								<a :href="'../shop/detail.do?wno='+wvo.wno">{{wvo.namekor}}</a>
							</p>
							<p class="wine-eng">
								<a :href="'../shop/detail.do?wno='+wvo.wno">{{wvo.nameeng}}</a>
							</p>
						</div>
						<div class="wine-info-more">
							<p class="wine-nation">{{wvo.nation}}</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script>
let findApp=Vue.createApp({
	data(){
		return{
			wList:[],
			fd:'${fd}'
		}
	},
	mounted(){
		axios.get('../main/vueFind.do', {
			params:{
				fd:this.fd
			}
		}).then(response=>{
			console.log(response.data)
			this.wList=response.data.wList
		})
	}
}).mount('#findApp')
</script>
</body>
</html>