<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
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

.GrapeList {
	list-style-type: none;
	padding: 0;
	margin: 0;
}

.item {
	margin: 10px 0;
	padding: 10px;
	border-bottom: 1px solid #ccc;
}

.content {
	font-size: 16px;
	display: -webkit-box;
	-webkit-box-orient: vertical;
	-webkit-line-clamp: 2;
	overflow: hidden;
	text-overflow: ellipsis;
	max-width: 100%;
}

.namekor {
	font-size: 20px;
	font-weight: bold;
	display: inline;
}

.nameeng {
	font-size: 20px;
	color: gray;
	display: inline;
	margin-left: 10px;
}

.load-more {
	margin-top: 20px;
	cursor: pointer;
	margin-top: 20px;
	padding: 10px 20px;
	width: 240px;
	height: 50px;
	align-content: center;
}

.center {
	display: flex;
	justify-content: center;
	margin-top: 20px;
}

.header-line {
	border-top: 3px solid black;
}
</style>
</head>
<body>
	<div class="container" id="findApp" style="margin-top: 10px;">
		<div class="container-fluid fruite py-5" id="fruite">
			<div class="row text-center" style="margin: 0px auto; width: 1320px;">
				<div class="position-relative mx-auto">
					<form method="get" action="../main/find.do">
						<input class="form-control border-2 border-wine w-75 py-3 px-4 rounded-pill" type="text" name="fd" placeholder="Search" style="margin: 0px auto;">
						<button type="submit" class="btn btn-default border-2 border-wine py-3 px-4 position-absolute rounded-pill text-wine h-100" style="top: 0; right: 13%;">Submit Now</button>
					</form>
				</div>
			</div>
		</div>
		<template v-if="wCount!=0">
			<h3>와인({{wCount}}건)</h3>
			<div class="row">
				<div class="header-line" style="margin-bottom: 30px;"></div>
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
			<div style="text-align: right;" v-if="wCount>6">
				<a :href="'../shop/list.do?fd='+fd">더보기</a>
			</div>
		</template>
		<template v-if="gCount!=0">
			<div style="height: 50px;"></div>
			<h3>주요 품종({{gCount}}건)</h3>
			<div class="row">
				<div class="header-line"></div>
				<ul class="GrapeList">
					<li v-for="gvo in gList" class="item">
						<div>
							<a :href="'../grape/detail.do?no='+gvo.no">
								<span class="namekor">{{gvo.namekor}}</span> <span class="nameeng">{{gvo.nameeng}}</span>
							</a>
						</div>
						<div style="height: 10px"></div>
						<div class="content">{{gvo.content}}</div>
						<div style="height: 10px"></div>
					</li>
				</ul>
				<div style="text-align: right;" v-if="gCount>4">
					<a :href="'../grape/list.do?fd='+fd">더보기</a>
				</div>
			</div>
		</template>
		<template v-if="nCount!=0">
			<div style="height: 50px;"></div>
			<h3>생산지({{nCount}}건)</h3>
			<div class="row">
				<div class="header-line"></div>
				<ul class="GrapeList">
					<li v-for="nvo in nList" class="item">
						<div>
							<a :href="'../nation/detail.do?no='+nvo.no">
								<span class="namekor">{{nvo.namekor}}</span> <span class="nameeng">{{nvo.nameeng}}</span>
							</a>
						</div>
						<div style="height: 10px"></div>
						<div class="content">{{nvo.content}}</div>
						<div style="height: 10px"></div>
					</li>
				</ul>
				<div style="text-align: right;" v-if="nCount>4">
					<a :href="'../nation/list.do?fd='+fd">더보기</a>
				</div>
			</div>
		</template>
		<template v-if="mCount!=0">
			<div style="height: 50px;"></div>
			<h3>생산자({{mCount}}건)</h3>
			<div class="row">
				<div class="header-line"></div>
				<ul class="GrapeList">
					<li v-for="mvo in mList" class="item">
						<div>
							<a :href="'../maker/detail.do?no='+mvo.no">
								<span class="namekor">{{mvo.namekor}}</span> <span class="nameeng">{{mvo.nameeng}}</span>
							</a>
						</div>
						<div style="height: 10px"></div>
						<div class="content">{{mvo.content}}</div>
						<div style="height: 10px"></div>
					</li>
				</ul>
				<div style="text-align: right;" v-if="mCount>4">
					<a :href="'../maker/list.do?fd='+fd">더보기</a>
				</div>
			</div>
		</template>
		<template v-if="wCount+gCount+nCount+mCount===0">
			<h1 class="text-center">검색결과가 없습니다</h1>
		</template>
	</div>
	<script>
let findApp=Vue.createApp({
	data(){
		return{
			wList:[],
			gList:[],
			nList:[],
			mList:[],
			wCount:0,
			gCount:0,
			nCount:0,
			mCount:0,
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
			this.nList=response.data.nList
			this.mList=response.data.mList
			this.gList=response.data.gList
			this.wCount=response.data.wCount
			this.gCount=response.data.gCount
			this.nCount=response.data.nCount
			this.mCount=response.data.mCount
		})
	}
}).mount('#findApp')
</script>
</body>
</html>