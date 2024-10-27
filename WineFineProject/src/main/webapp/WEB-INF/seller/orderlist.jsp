<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link rel="stylesheet" href="../tem/css/orderlist.css">
</head>
<body>
<div class="container" id="orderList">
	<div class="row">
	<h3 class="table-title text-center"> 주문 현황 </h3>
		<table class="mp">
		<tr id="olistth">
			<th width="15%" class="ordercheck"> 전체주문 </th>
			<th width="10%" class="ordercheck"> 결제완료 </th>
			<th width="15%" class="ordercheck"> 배송준비중 </th>
			<th width="10%" class="ordercheck"> 배송중 </th>
			<th width="10%" class="ordercheck"> 배송완료 </th>
			<th width="10%" class="ordercheck"> 반품요청 </th>
			<th width="15%" class="ordercheck"> 판매자취소 </th>
			<th width="15%" class="ordercheck"> 반품완료 </th>
		</tr>
		<tr>
			<td width="15%" class="orderchecktd"> {{totalCount}} </td>
			<td width="10%" class="orderchecktd"> {{completed}} </td>
			<td width="15%" class="orderchecktd"> {{preparing}} </td>
			<td width="10%" class="orderchecktd"> {{delivering}} </td>
			<td width="10%" class="orderchecktd"> {{delivered}} </td>
			<td width="10%" class="orderchecktd"> {{returnRequested}} </td>
			<td width="15%" class="orderchecktd"> {{sellerCancelled}} </td>
			<td width="15%" class="orderchecktd"> {{returnCompleted}} </td>
		</tr>
		</table>
		<table class="table mp">
			<tr id="olistth">
				<th width="10%" class="text-center">주문번호</th>
				<th width="12%" class="text-center">날짜</th>
				<th width="10%" class="text-center">구매자ID</th>
				<th width="21%" class="text-center">품목</th>
				<th width="5%" class="text-center">수량</th>
				<th width="12%" class="text-center">결제금액</th>
				<th width="12%" class="text-center">주문상태</th>
				<th width="9%" class="text-center">반품요청</th>
				<th width="9%" class="text-center">주문취소</th>
			</tr>
			<tr v-if="oList.length===0"><td colspan="9">주문내역이 없습니다</td></tr>
			<template v-for="(vo, index) in oList">
			<tr @click="moreInfo(index)">
				<td width="10%" class="text-center">{{vo.wpno}}</td>
				<td width="12%" class="text-center">{{vo.dbday}}</td>
				<td width="10%" class="text-center">{{vo.userid}}</td>
				<td width="21%" class="text-center scrollable-text"><p>{{vo.wvo.namekor}}</p></td>
				<td width="5%" class="text-center">{{vo.account}}</td>
				<td width="12%" class="text-center">{{formatPayment(vo.payment)}}</td>
				<td width="12%" class="text-center">{{vo.state===0?'결제완료':vo.state===1?'배송준비중':vo.state===2?'배송중':vo.state===3?'배송완료':vo.state===7?'반품요청':vo.state===8?'판매자취소':vo.state===9?'반품완료':'상태없음'}}</td>
				<td width="9%" class="text-center">
				<button class="btn btn-sm orderbtn" v-if="vo.state===7" @click="changeModal(true, vo)"><i class="fa-regular fa-file-lines fa-lg"></i></button></td> 
				<td width="9%" class="text-center"><button class="btn btn-sm orderbtn" v-if="vo.state<2" @click="orderCancel(vo)"><i class="fa-solid fa-square-xmark fa-lg"></i></button></td>
			</tr>
			<tr v-if="isShow[index]">
			<td colspan="9" style="padding: 0px;">
				<table class="table mp" style="margin-bottom: 0px">
						<tr>
						<th width="15%" class="text-center">정가</th>
						<th width="25%" class="text-center">{{vo.mcno!==0?'적용쿠폰':'적용할인'}}</th>
						<th width="20%" class="text-center">할인율</th>
						<th width="20%" class="text-center">사용 포인트</th>
						<th width="20%" class="text-center">지급 포인트</th>
						</tr>
						<tr>
						<td width="15%" class="text-center">{{vo.wvo.price}}</td>
						<td width="25%" class="text-center">{{vo.mcno!==0?vo.mcvo.title:vo.psno!==0?vo.svo.title:'할인적용 안함'}}</td>
						<td width="20%" class="text-center">{{vo.mcno!==0?vo.mcvo.discount+'%':vo.psno!==0?vo.svo.discount+'%':'할인적용 안함'}}</td>
						<td width="20%" class="text-center">{{vo.mipoint}}</td>
						<td width="20%" class="text-center">{{vo.plpoint}}</td>
						</tr>
					</table>
					<table class="table mp" style="margin-bottom: 0px">
						<tr>
						<th width="15%" class="text-center">배송지명</th>
						<th width="10%" class="text-center">우편번호</th>
						<th width="40%" class="text-center">주소</th>
						<th width="35%" class="text-center">배송요청사항</th>
						</tr>
						<tr>
						<td width="15%" class="text-center">{{vo.dvo.name}}</td>
						<td width="10%" class="text-center">{{vo.dvo.post}}</td>
						<td width="40%" class="text-center scrollable-text"><p>{{vo.dvo.addr1+' '+vo.dvo.addr2}}</p></td>
						<td width="35%" class="text-center">{{vo.dvo.msg}}</td>
						</tr>
					</table>
				</td>
				</tr>
			</template>
		</table>
		<table>
				<div class="col-12 text-center" >
        <div class="pagination-area d-sm-flex mt-15" style="justify-content: center">
            <nav aria-label="#">
               <ul class="pagination" style="display: flex;">
                   <li class="page-item" v-if="startPage>1">
                     <a class="page-link" @click="prev()"><i class="fa fa-angle-double-left" aria-hidden="true"></i> 이전</a>
                    </li>
                     <li :class="i===curpage?'page-item active':'page-item'" v-for="i in range(startPage,endPage)">
                      <a class="page-link" @click="pageChange(i)">{{i}}</a>
                     </li>
                     <li class="page-item" v-if="endPage<totalpage">
                      <a class="page-link" @click="next()">다음 <i class="fa fa-angle-double-right" aria-hidden="true"></i></a>
                     </li>
                 </ul>
             </nav>
          </div>
       </div>
		</table>
	</div>
	 <div class="modal" :class="{ show: showModal }" @click.self="changeModal(false)">
			<div class="modal-content" style="height: 320px">
			<h4 class="modal-title text-center">반품 요청 상세보기</h4>
				<span class="close" @click="changeModal(false)">&times;</span>
				<table class="table mp" style="margin-top: 10px;">
					<tr>
						<th width="30%" class="text-center">반품 신청 ID</th>
						<td width="70%">{{sendid}}</td>
					</tr>
					<tr>
						<th width="30%" class="text-center">반품 신청일</th>
						<td width="70%">{{dbday}}</td>
					</tr>
					<tr>
						<th width="30%" class="text-center">반품 신청 사유</th>
						<td width="70%">{{subject}}</td>
					</tr>
					<tr>
						<th width="30%" class="text-center">상세 사유</th>
						<td width="70%"><span style="width: 300px; height:400px;">{{content}}</span>
					</tr>
				</table>
						<div class="rmbtn text-center" style="margin:0px">
							<button type="button" class="rmbtn btn btn-sm btn-danger" @click="orderReturnCheck(wpno)">승인</button>
							<button type="button" class="rmbtn btn btn-sm btn-secondary" @click="changeModal(false)">취소</button>
						</div>
			</div>
		</div>
	</div>
<script>
 let orderListApp=Vue.createApp({
    	data(){
    		return {
    			oList:[],
    			startPage:0,
    			endPage:0,
    			curpage:1,
    			totalpage:0,
    			totalCount:0,
    			completed:0,
    			preparing:0,
    			delivering:0,
    			delivered:0,
    			returnRequested:0,
    			sellerCancelled:0,
    			returnCompleted:0,
    			showModal:false,
    			isShow:Array(10).fill(false),
    			reno:0,
    			sendid:'',
    			recvid:'',
    			wpno:0,
    			content:'',
    			subject:'',
    			dbday:'',
    			id:'${sessionScope.userId}'
    		}
    	},  
    	mounted(){
    		this.dataRecv()
    	},
    	methods:{
    		prev(){
      			 this.curpage=this.startPage-1
      			 this.nList()
      		 },
      		 next(){
      			 this.curpage=this.endPage+1
      			 this.nList()
      		 },
      		 pageChange(page){
      			 this.curpage=page
      			 this.nList()
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
      		 },
    		dataRecv(){
    			axios.get('../seller/orderList_vue.do',{
    				params:{
    					id:this.id,
    					page:this.curpage
    				}
    			}).then(response=>{
    				this.oList=response.data.oList
    				this.startPage=response.data.startPage
    				this.endPage=response.data.endPage
    				this.curpage=response.data.curpage
    				this.totalpage=response.data.totalpage
    				this.totalCount=response.data.totalCount
    				this.completed=response.data.completed
    				this.preparing=response.data.preparing
    				this.delivering=response.data.delivering
    				this.delivered=response.data.delivered
    				this.returnRequested=response.data.returnRequested
    				this.sellerCancelled=response.data.sellerCancelled
    				this.returnCompleted=response.data.returnCompleted
    				
    			}).catch(error=>{
    				console.log(error.response)
    			})
    		},  
    		changeModal(check, order=null){
    			this.showModal=check
    			if (order) {
    		        this.getReturnCheck(order);
    		    }
    		},
    		getReturnCheck(vo){
    			axios.get('../seller/returnCheck_vue.do',{
    				params:{
    					wpno:vo.wpno
    				}
    			}).then(response=>{
    				this.reno=response.data.reno
    				this.sendid=response.data.sendid
    				this.recvid=response.data.recvid
    				this.wpno=response.data.wpno
    				this.content=response.data.content
    				this.subject=response.data.subject
    				this.dbday=response.data.dbday
    			}).catch(error=>{
    				console.log(error.response)
    			})
    		},
            orderCancel(vo) {
            	if (confirm("정말로 이 주문을 취소하시겠습니까?")) {
                    axios.post('../seller/orderCancel_vue.do', null, {
                        params: { wpno: vo.wpno } 
                    }).then(response => {
                            if (response.data === "OK") {
                              	this.dataRecv()
                                alert("주문이 취소되었습니다.")
                            } else {
                                alert("주문 취소 중 오류가 발생했습니다.")
                            }
                        })
                        .catch(error => {
                            console.error(error)
                        })
                	}
                },
            orderReturnCheck(wpno) {
            	if (confirm("정말로 이 반품요청을 승인하시겠습니까?")) {
                    axios.post('../seller/orderReturnCheck_vue.do', null, {
                        params: { wpno: wpno } 
                    }).then(response => {
                            if (response.data === "OK") {
                            	this.showModal=false
                              	this.dataRecv()
                                alert("반품요청이 승인되었습니다.")
                            } else {
                                alert("반품요청 승인 중 오류가 발생했습니다.")
                            }
                        })
                        .catch(error => {
                            console.error(error)
                        })
                	}
                },
                moreInfo(index){
    				if(this.isShow[index]===true){
    					this.isShow[index]=false
    				}
    				else{
    					this.isShow=Array(10).fill(false)
    					this.isShow[index]=true
    				}
    			},
                formatPayment(payment) {
                    const numericValue = payment.toString().replace(/[^0-9]/g, '')
                    const formattedValue = numericValue.replace(/\B(?=(\d{3})+(?!\d))/g, ',') + (numericValue ? '원' : '')
                    return formattedValue
                },
                prev(){
    				if(this.curpage === 1){
    					alert('첫 페이지 입니다')
    					return
    				}
    				    this.startPage>10 ? this.curpage=this.startPage-1 : this.curpage=this.startPage
    			        this.dataRecv() 			    
    			},
    			next() {
    			    if (this.curpage === this.totalpage) {
    			        alert('마지막 페이지 입니다')
    			        return
    			    }
    			    this.endPage+1<=this.totalpage? this.curpage=this.endPage+1 : this.curpage=this.endPage
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
    }).mount('#orderList')
 </script>
</body>
</html>