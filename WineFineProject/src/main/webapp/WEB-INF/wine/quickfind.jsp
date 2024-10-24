<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
  <div class="QuickSearch">
    <div class="qs">
      <input type="text" size=20 v-model="namekor" class="input-sm"
       @keydown.enter="search()"  style="margin-left:15px"
      >
      <button class="btn-sm btn-primary" @onclick="search()">검색</button>
    </div>
    <div style="height: 10px"></div>
    <div class="row">
      <div class="col-md-4" v-for="vo in wine_list">
	    <div class="thumbnail">
	      <a href="#">
	        <img :src="vo._source.poster" style="width:150px;height: 230px">
	        <div class="caption">
	          <p>{{vo._source.namekor}}</p>
	        </div>
	      </a>
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