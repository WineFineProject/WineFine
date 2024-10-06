<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>생산자</title>
<style>
.MakerList {
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
    <div class="row" id="makerList" style="margin-top: 150px">
    <div class="search-container" style="padding: 0px">
            <h3>생산자({{makers.length}}건)</h3>
            <input type="text" class="search-input" placeholder=" 생산자 내 검색">
            </div>
            <div class="header-line"></div>
            <ul class="MakerList">
                <li v-for="vo in listMakers" :key="vo.no" class="item">
                    <div>
                      <a :href="'detail.do?no='+vo.no">
                        <span class="namekor">{{vo.namekor}}</span>
                        <span class="nameeng">{{vo.nameeng}}</span>
                      </a>  
                    </div>
                    <div style="height: 10px"></div>
                    <div class="content">{{vo.content}}</div>
                    <div style="height: 10px"></div>
                    <div style="font-weight: bold;">{{vo.nation}}</div>
                </li>
            </ul>
           <div class="center"> 
            <input type="button" v-if="MoreMakers" class="load-more" @click="loadMore" value="더보기">
           </div> 
        </div>
   </div> 
    <script>
        let makerListapp = Vue.createApp({
            data() {
                return {
                	makers: [],
                    Showmakers: 10, 
                }
            },
            computed: {
            	listMakers() {
                    return this.makers.slice(0, this.Showmakers)
                },
                MoreMakers() {
                    return this.Showmakers<this.makers.length
                }
            },
            methods: {
            	loadMore() {
                    this.Showmakers+=10
                },
                mList() {
                    axios.get('../maker/listVue.do')
                        .then(response=>{
                            this.makers=response.data.makers
                        })
                        .catch(error=>{
                            console.error(error)
                        })
                }
            },
            mounted() {
                this.mList()
            }
        }).mount('#makerList')
    </script>
</body>
</html>