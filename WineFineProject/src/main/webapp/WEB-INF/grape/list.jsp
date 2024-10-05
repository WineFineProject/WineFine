<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주요 품종</title>
<script src="https://unpkg.com/vue@3"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<style>
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
.search-container {
	display: flex;
	justify-content: space-between;
	align-items: center;
}
.search-input {
    width: 220px;
    margin-bottom: 5px;
	margin-left: auto;
	padding: 5px;
	font-size: 16px;
	border: 1px solid #ccc;
	border-radius: 4px;
}
</style>
</head>
<body>
  <div class="container py-5">
    <div class="row" id="grapeList" style="margin-top: 150px">
    <div class="search-container" style="padding: 0px">
            <h3>주요 품종({{grapes.length}}건)</h3>
            <input type="text" class="search-input" placeholder=" 주요품종 내 검색" v-model="searchQuery" @input="filterGrapes">
            </div>
            <div class="header-line"></div>
            <ul class="GrapeList">
                <li v-for="vo in listGrapes" :key="vo.no" class="item">
                    <div>
                        <span class="namekor">{{vo.namekor}}</span>
                        <span class="nameeng">{{vo.nameeng}}</span>
                    </div>
                    <div style="height: 10px"></div>
                    <div class="content">{{ vo.content }}</div>
                    <div style="height: 10px"></div>
                </li>
            </ul>
           <div class="center"> 
            <input type="button" v-if="MoreGrapes" class="load-more" @click="loadMore" value="더보기">
           </div> 
        </div>
   </div> 
    <script>
        let grapeListapp = Vue.createApp({
            data() {
                return {
                    grapes: [],
                    Showgrapes: 10, 
                }
            },
            computed: {
            	listGrapes() {
                    return this.grapes.slice(0, this.Showgrapes)
                },
                MoreGrapes() {
                    return this.Showgrapes<this.grapes.length
                }
            },
            methods: {
            	loadMore() {
                    this.Showgrapes+=10
                },
                gList() {
                    axios.get('../grape/listVue.do')
                        .then(response => {
                            this.grapes = response.data.grapes
                        })
                        .catch(error => {
                            console.error(error)
                        })
                }
            },
            mounted() {
                this.gList()
            }
        }).mount('#grapeList')
    </script>
</body>
</html>