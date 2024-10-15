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
.allitem{
	width: 10%; 
	float: right;
}
.editable{
	text-decoration: underline;
	cursor: pointer;
}
</style>
</head>
<body>
<div class="container" id="itemList">
    <h3 class="text-center" style="width:100%;"> &emsp;&emsp;&emsp;&emsp;상품 조회</h3>
     <div class="row">
     <div>
     <select v-model="sortOrder">
     	<option value="recent">최근등록순</option>
		<option value="popular">인기순</option>
     </select>
     <button type="button" class="allitem" @click="deleteSelected()">선택 삭제</button>
     <button type="button" class="allitem" @click="saveAllChanges">변경 내용 저장</button>
     <span style="width: 15%; float: left;">총 {{iCount}} 개</span>
      </div>
     <table class="table">
     	<tr>
     	<th>선택</th>
     	<th>상품번호</th>
     	<th colspan="2" class="text-center">상품명</th>
     	<th>정가</th>
     	<th>재고</th>
     	<th>배송</th>
     	<th>조회수</th>
     	<th>등록일</th>
     	<th>판매상태</th>
     	<th>판매자 공지</th>
     	<th>수정/삭제</th>
     	</tr>
     	<tr v-for="vo in iList" :key="vo.wno">
     	<td>
     	<input type="checkbox" v-model="vo.selected">
     	</td>
     	<td>{{vo.wno}}</td>
     	<td>
     	<img :src="vo.poster" style="width:40px;height:60px">
     	</td>
     	<td class="editable">
     	    <input v-if="vo.isEditingName" v-model="vo.namekor"/>
            <span  v-else @dblclick="vo.isEditingName = true">{{ vo.namekor }}</span>
     	</td>
     	<td class="editable">
     		<input v-if="vo.isEditingPrice" v-model="vo.price"/>
            <span  v-else @dblclick="vo.isEditingPrice = true">{{ vo.price }}</span>
        </td>
     	<td class="editable">
     	<input v-if="vo.isEditingStack" v-model="vo.stack"/>
            <span v-else @dblclick="vo.isEditingStack = true">{{ vo.stack }}</span>
        </td>
     	<td>기본배송</td>
     	<td>{{vo.hit}}</td>
     	<td>{{vo.dbday}}</td>
     	<td class="editable" @dblclick="enableEditState(vo)">
		    <select v-if="vo.isEditingState" v-model="vo.state">
		        <option value="1">판매중</option>
		        <option value="2">품절</option>
		        <option value="3">판매중단</option>
		    </select>
		    <span v-else @dblclick="vo.isEditingState = true">{{ getStateLabel(vo.state) }}</span>
		</td>
     	<td class="editable">공지 선택</td>
     	<td>
     	<a :href="'edit.do?wno='+vo.wno" class="dbtn">수정</a>
     	<button type="button" v-on:click="itemDelete(vo)">삭제</button>
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
    			sortOrder:'recent',
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
    					sortOrder:this.sortOrder,
    					page:this.curpage
    				}
    			}).then(response=>{
    				this.iList=response.data.iList
    				this.iCount=response.data.iCount
    				this.curpage=response.data.curpage
    				this.startPage=response.data.startPage
    				this.endPage=response.data.endPage
    				this.dataRecv()
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
    	        }
    	    },
    	    deleteSelected() {
    	        const selectedIds = this.iList.filter(vo => vo.selected).map(vo => vo.wno)
    	        
    	        if (selectedIds.length === 0) {
    	            alert("삭제할 상품을 선택해주세요.")
    	            return
    	        }
    	        else{
    	        confirm("상품 삭제시 복구가 불가능합니다.")
    	        }
    	        const params = new URLSearchParams()
    	        selectedIds.forEach(id => params.append('wnos', id))
				console.log(params.toString())
				
    	        axios.post('../seller/deleteitems_vue.do', params.toString(),{
    	            headers: {
    	                'Content-Type': 'application/x-www-form-urlencoded'
    	            }
    	        }).then(response => {
    	            	if(response.data === "OK"){
    	                this.iList = this.iList.filter(vo => !vo.selected)
    	                this.iCount = this.iList.length
    	                alert("선택된 상품이 삭제되었습니다.")
    	            	}
    	            })
    	            .catch(error => {
    	                console.error(error)
    	                alert("삭제 중 오류가 발생했습니다.")
    	            })
    	    },
    	    enableEditState(vo) {
    	        vo.isEditingState = true
    	    },
    	    saveAllChanges() {
    	    	const updates = this.iList.map(item => {
    	            const updateItem = { wno: item.wno }

    	            if (item.isEditingName) updateItem.namekor = item.namekor
    	            if (item.isEditingPrice) updateItem.price = item.price
    	            if (item.isEditingStack) {
    	                updateItem.stack = parseInt(item.stack, 10)
    	            } else {
    	                updateItem.stack = parseInt(item.stack, 10)
    	            }
    	            if (item.isEditingState) {
    	                updateItem.state = parseInt(item.state, 10)
    	            } else {
    	                updateItem.state = parseInt(item.state, 10)
    	            }

    	            return updateItem
    	        }).filter(item => Object.keys(item).length > 1)

    	        if (updates.length === 0) {
    	            alert("변경된 내용이 없습니다.")
    	            return;
    	        }

    	        const params = new URLSearchParams()
    	        updates.forEach(item => {
    	            params.append(`updates`, JSON.stringify(item)) 
    	        });

    	        axios.post('../seller/updateitems_vue.do', params.toString(), {
    	            headers: {
    	                'Content-Type': 'application/x-www-form-urlencoded'
    	            }
    	        		})
                    .then(response => {
                    	if(response.data === "OK"){
                        alert("변경 내용이 저장되었습니다.")
                        // 모든 편집 상태 초기화
                        this.iList.forEach(item => {
                            item.isEditingName = false
                            item.isEditingPrice = false
                            item.isEditingStack = false
                            item.isEditingState = false
                         })
                         this.dataRecv()
                    	}
                        else{
                        	alert("변경 사항 저장 중 오류가 발생했습니다.")
                        }
                    })
                    .catch(error => {
                        console.error(error)
                        alert("변경 사항 저장 중 오류가 발생했습니다.")
                    })
            },
            itemDelete(vo) {
            	if (confirm("정말로 이 상품을 삭제하시겠습니까?")) {
                    axios.post('../seller/itemdelete_vue.do', null, {
                        params: { wno: vo.wno } 
                    }).then(response => {
                            if (response.data === "OK") {
                                this.iList = this.iList.filter(item => item.wno !== vo.wno)
                                this.iCount = this.iList.length
                                alert("상품이 삭제되었습니다.")
                            } else {
                                alert("삭제 중 오류가 발생했습니다.")
                            }
                        })
                        .catch(error => {
                            console.error(error);
                            alert("삭제 중 오류가 발생했습니다.")
                        })
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