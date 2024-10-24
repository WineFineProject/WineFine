<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../tem/css/quick.css">
</head>
<body>
<div class="qs">
  <div class="QuickSearch">
    <div class="text-center">
      <div style="padding-top: 20px">
        <div class="input-group">
          <input type="text" @keydown.enter="search()" size="30" 
               class="textw"  v-model="namekor" placeholder="상품명 검색">
          <button type="button" class="wbtn" @click="search()">
            <i class="fa fa-search"></i>
          </button>
        </div>
      </div>
      <div style="height: 50px"></div>
      <div class="wrow">
        <div class="col-md-3" v-for="vo in wine_list" :key="vo._id">
          <div class="thumbw">
            <a :href="'../shop/detailBefore.do?wno='+vo._source.wno">
              <img :src="vo._source.poster" class="wimg">
              <div class="cap">
                <p>{{vo._source.namekor}}</p>
              </div>
            </a>
          </div>
        </div>
      </div>
    </div> 
  </div>
</div> 
<script>
   let app=Vue.createApp({
	   data(){
		   return{
			   wine_list:[],
			   namekor:''
		   }
	   },
	   methods:{
		   search(){
			   axios.get('http://localhost:8080/controller/wine/quickfindVue.do',{
				   params:{
					   namekor:this.namekor
				   }
			   }).then(response=>{
				   console.log(response.data.hits.hits)
				   this.wine_list=response.data.hits.hits
			   }).catch(error=>{
				   console.log(error.response)
			   })
		   }
	   }
   }).mount(".QuickSearch")
  </script>
</body>
</html>