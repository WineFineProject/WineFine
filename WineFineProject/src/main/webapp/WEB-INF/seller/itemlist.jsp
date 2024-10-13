<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.ipagination {
        display: inline-flex;
        align-items: center;
        cursor: pointer;
    }
.page-item.active{
	background-color: #FFCC52;
	display:inline-block !important;
}
</style>
</head>
<body>
<div class="container" id="itemList">
    <h3 class="text-center" style="width:100%;"> &emsp;&emsp;&emsp;&emsp;상품 조회</h3>
     <div class="row">
     <div>
     <button type="button" style="width: 10%; float: right;">선택 삭제</button>
     <button type="button" style="width: 15%; float: right;">변경 내용 저장</button>
     <span style="width: 15%; float: left;">총 {{iCount}} 개</span>
      </div>
     <table class="table">
     	<tr>
     	<th>선택</th>
     	<th>상품번호</th>
     	<th colspan="2">상품명</th>
     	<th>정가</th>
     	<th>재고/가용</th>
     	<th>배송</th>
     	<th>조회수</th>
     	<th>등록일</th>
     	<th>판매상태</th>
     	<th>판매자 공지</th>
     	<th>수정</th>
     	</tr>
     	<tr  v-for="vo in iList">
     	<td>
     	<input type="checkbox">
     	</td>
     	<td>{{vo.wno}}</td>
     	<td>
     	<img :src="vo.poster" style="width:60px;height: 80px">
     	</td>
     	<td>
     	{{vo.namekor}}
     	</td>
     	<td>{{vo.price}}</td>
     	<td>{{vo.stack}}</td>
     	<td>기본배송</td>
     	<td>{{vo.hit}}</td>
     	<td>{{vo.dbday}}</td>
     	<td>{{getStateLabel(vo.state)}}</td>
     	<td>공지</td>
     	<td>
     	<button type="button" >수정</button>
     	<button type="button" >삭제</button>
     	</td>
     	</tr>
     	<tr>
     	 <td colspan="12" class="text-center">
     	    <div class="ipagination">
            <input type=button value="<" class="btn-sm btn-danger" @click="prev()">
                &nbsp;
                <span v-for="i in range(startPage,endPage)"
                :class="{'page-item active': i === curpage, 'page-item': i !== curpage}" 
                @click="pageChange(i)"> &nbsp; {{i}} &nbsp; </span>
                &nbsp; 
            <input type=button value=">" class="btn-sm btn-danger" @click="next()">
          </div>
          </td>
     	</tr>
     </table>
     </div>
</div>
<script>
 let itemlistApp=Vue.createApp({
    	data(){
    		return {
    			iList:[],
    			iCount:0,
    			seller:'',
    			curpage:1,
    			startPage:0,
    			endPage:0,
    			id:'${sessionScope.userId}'
    		}
    	},  
    	mounted(){
    		this.dataRecv()
    	},
    	methods:{
    		dataRecv(){
    			axios.get('../seller/itemlist_vue.do',{
    				params:{
    					seller:this.id,
    					page:this.curpage
    				}
    			}).then(response=>{
    				this.iList=response.data.iList
    				this.iCount=response.data.iCount
    				this.curpage=response.data.curpage
    				this.startPage=response.data.startPage
    				this.endPage=response.data.endPage
    				console.log(response.data)
    			}).catch(error=>{
    				console.log(error.response)
    			})
    		},
    		getStateLabel(state) {
    	        switch (state) {
    	            case 1:
    	                return '판매중'
    	            case 2:
    	                return '품절'
    	            case 3:
    	                return '판매중단'
    	            case 8:
    	                return '승인반려'
    	            case 9:
    	                return '승인대기'
    	        }
    	    },
    	    prev(){
    	    	this.curpage=this.curpage>10?this.curpage-10:1
  			    this.dataRecv()
  		   },
  		   next(){
  			   this.curpage=this.curpage+10 <= this.endPage?this.curpage+10:this.endPage
  			   this.dataRecv()
  		   },
  		  	pageChange(page){
  			   	 this.curpage=page
  	 			 this.dataRecv()
  	 		},
  	 		 range(start,end){
  	 			 let arr=[]
  	 			 let len=end-start
  	 			 for(let i=0;i<=len;i++)
  	 			 {
  	 				 arr[i]=start
  	 				 start++;
  	 			 }
  	 			 return arr
  	 		 }
    	}
    }).mount('#itemList')
 </script>      
</body>
</html>