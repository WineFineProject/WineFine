<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../tem/css/coupon.css">
</head>
<body>
	<div class="promotion_table myboard">
		<h3 class="table-title">작성한 글</h3>
	<div class="button-group" style="display: flex;justify-content: flex-start;margin-bottom: 15px">
        <button class="btn btn-myb" style="margin-right: 10px;" :class="{active: type === '1'}" @click="type = '1'; dataRecv()">게시글</button>
        <button class="btn btn-myb" style="margin-right: 10px;" :class="{active: type === '2'}" @click="type = '2'; dataRecv()">문의글</button>
        <button :class="{active: type === '3'}" @click="type = '3'; dataRecv()" class="btn btn-myb">댓글</button>
    </div>
		<table v-if="type==='1'" class="table" id="coupon-table">
			<thead>
				<tr>
					<th width="5%">번호</th>
					<th width="40%">제목</th>
					<th width="12%">작성자</th>
					<th width="15%">작성일</th>
					<th width="8%">조회수</th>
				</tr>
			</thead>
			  <tr v-for="(vo,index) in list" style="cursor: pointer;">
			   <td colspan="5" id="tmp" style="border:none">
				<div>
				 <table class="table" id="inner-table" style="margin: 0px">
				  <tbody>
				   <tr>
					<td width="5%" class="text-center">{{list.length*curpage-index}}</td>
					<td width="40%"><a :href="'../board/detail.do?bno='+vo.bno">{{vo.subject}}</a></td>
					<td width="12%" class="text-center">{{vo.nickname}}</td>
					<td width="15%" class="text-center">{{vo.dbday}}</td>
					<td width="8%" class="text-center">{{vo.hit}}</td>
				   </tr>
				  </tbody>
				 </table>  	
				</div>
			   </td>	
			  </tr>
		</table>
		<table v-if="type==='2'" class="table" id="coupon-table">
			<thead>
				<tr>
					<th width="5%">번호</th>
					<th width="40%">제목</th>
					<th width="12%">작성자</th>
					<th width="15%">작성일</th>
					<th width="8%">조회수</th>
				</tr>
			</thead>
			  <tr v-for="(vo,index) in list" style="cursor: pointer;">
			   <td colspan="5" id="tmp" style="border:none">
				<div>
				 <table class="table" id="inner-table" style="margin: 0px">
				  <tbody>
				   <tr>
					<td width="5%" class="text-center">{{list.length*curpage-index}}</td>
					<td width="40%"><a :href="'../replyboard/detail.do?wrno='+vo.bno">{{vo.subject}}</a></td>
					<td width="12%" class="text-center">{{vo.nickname}}</td>
					<td width="15%" class="text-center">{{vo.dbday}}</td>
					<td width="8%" class="text-center">{{vo.hit}}</td>
				   </tr>
				  </tbody>
				 </table>  	
				</div>
			   </td>	
			  </tr>
		</table>
		<table v-if="type==='3'" class="table" id="coupon-table">
			<thead>
				<tr>
					<th width="8%">번호</th>
					<th width="45%">내용</th>
					<th width="12%">작성자</th>
					<th width="15%">작성일</th>
				</tr>
			</thead>
			  <tr v-for="(vo,index) in list" style="cursor: pointer;">
			   <td colspan="5" id="tmp" style="border:none">
				<div>
				 <table class="table" id="inner-table" style="margin: 0px">
				  <tbody>
				   <tr>
					<td width="8%" class="text-center">{{list.length*curpage-index}}</td>
					<td width="45%"><a :href="'../board/detail.do?bno='+vo.bno">{{vo.msg}}</a></td>
					<td width="12%" class="text-center">{{vo.nickname}}</td>
					<td width="15%" class="text-center">{{vo.dbday}}</td>
				   </tr>
				  </tbody>
				 </table>  	
				</div>
			   </td>	
			  </tr>
		</table>
	</div>
	<script>
		let listApp=Vue.createApp({
			data(){
				return{
					list:[],
	    			totalpage:0,
	    			curpage:1,
	    			type:'1'
	    		}
			},
		mounted(){
			this.dataRecv()
			},
		methods:{
			dataRecv(){				
				axios.get('../mypage/myboardlist_vue.do',{
					params:{
						page:this.curpage,
						type:this.type
					}
				}).then(response=>{
					console.log(response.data)
    				this.list=response.data.list
    				this.totalpage=response.data.totalpage
    				this.curpage=response.data.curpage
    			}).catch(error=>{
    				console.log(error.response)
    			})
			}
			
		}
	}).mount('.myboard')
  </script>
</body>
</html>

