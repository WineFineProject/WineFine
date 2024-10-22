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

.page-item.active {
	background-color: #FFCC52;
	display: inline-block !important;
}

.allitem {
	width: 10%;

}
.table th, .table td{
    overflow: hidden;
    text-overflow: ellipsis; 
    white-space: nowrap; 
}
.editable {
	text-decoration: underline;
	text-underline-position: under;
	cursor: pointer;
}
.itemlistright{
	text-align: right;
}
.itemlisttop{
	margin-right: 5px;
}
.ilisttable
{	
	table-layout: fixed;
	text-align: center;
}
.dbtn{
 	display: inline-block; 
    padding: 2px 4px; 
    text-decoration: none; 
    color: gray; 
    background-color: white; 
    border: 1px solid  #E66E5B; 
    border-radius: 5px; 
    font-size:14px;
    margin-left:3px;
}
#ilistth{
	background-color: #f8f8f8;
    color: #333;
}
</style>
</head>
<body>
	<div class="container" id="itemList">
		<h3 class="text-center" style="width: 100%; margin-bottom:10px; color:black;">&emsp;판매 상품 조회</h3>
		<div class="row">
			<div class="itemlistright">
				<select v-model="sortOrder" class="itemlisttop">
					<option value="recent">최근등록순</option>
					<option value="popular">인기순</option>
				</select>
				<button type="button" @click="dataRecv()" class="itemlisttop">조회</button>
				<button type="button" class="itemlisttop allitem"
					@click="saveAllChanges">변경 내용 저장</button>
				<button type="button" class="itemlisttop allitem"
					@click="deleteSelected()">선택 삭제</button>
				<span style="float: left; font-weight: bold;">총 {{iCount}} 개</span>
			</div>
			<table class="table ilisttable">
				<tr id="ilistth">
					<th width="5%">선택</th>
					<th width="8%">상품번호</th>
					<th width="5%"></th>
					<th width="17%" style="border-left:hidden">상품명</th>
					<th width="10%">정가</th>
					<th width="5%">재고</th>
					<th width="8%">배송</th>
					<th width="8%">조회수</th>
					<th width="9%">등록일</th>
					<th width="8%">판매상태</th>
					<th width="9%">판매자공지</th>
					<th width="8%">수정/삭제</th>
				</tr>
				<tr v-for="vo in iList" :key="vo.wno">
					<td width="5%"><input type="checkbox" v-model="vo.selected"></td>
					<td width="8%">{{vo.wno}}</td>
					<td width="5%">
					<img :src="vo.poster" style="width: 40px; height: 60px"></td>
					<td width="17%" class="editable ilistnamekor" style="text-align: left;">
					<input v-if="vo.isEditingName" v-model="vo.namekor"/> 
					<span v-else @dblclick="vo.isEditingName = true">{{ vo.namekor }}</span>
					</td>
					<td width="10%" class="editable">
					<input v-if="vo.isEditingPrice" v-model="vo.price" style="max-width:80px;"/> 
					<span v-else @dblclick="vo.isEditingPrice = true">{{ vo.price }}</span>
					</td>
					<td width="5%" class="editable">
					<input v-if="vo.isEditingStack" v-model="vo.stack" style="max-width:35px;"/> 
						
					<span v-else
						@dblclick="vo.isEditingStack = true">{{ vo.stack }}</span></td>
					<td width="8%">기본배송</td>
					<td width="8%">{{vo.hit}}</td>
					<td width="9%">{{vo.dbday}}</td>
					<td width="8%" class="editable" @dblclick="enableEditState(vo)">
					<select v-if="vo.isEditingState" v-model="vo.state" style="max-width:75px;">
							<option value="1">판매중</option>
							<option value="2">품절</option>
							<option value="3">판매중단</option>
					</select> 
					<span v-else @dblclick="vo.isEditingState = true">
							{{getStateLabel(vo.state) }}</span></td>
					<td width="9%" class="editable" @dblclick="enableEditNbno(vo)">
					<select v-if="vo.isEditingNbno && getFilteredNList().length > 0"
						v-model="vo.nbno" style="max-width:80px;">
							<option v-for="nvo in getFilteredNList()" :key="nvo.nbno"
								:value="nvo.nbno">{{ nvo.subject }}</option>
					    </select> 
					<span v-else @dblclick="vo.isEditingNbno = true">
							{{vo.nbno}}</span>
					</td>
					<td width="8%"><a :href="'edit.do?wno='+vo.wno" class="dbtn">수정</a>
						<button type="button" v-on:click="itemDelete(vo)" class="dbtn">삭제</button></td>
				</tr>
				<tr>
					<td colspan="12" class="text-center">
						<div class="ipagination">
							<input type=button value="<" class=" btn-sm
								btn-danger" @click="prev()"> &nbsp; <span
								v-for="i in range(startPage,endPage)"
								:class="{'page-item active': i === curpage, 'page-item': i !== curpage}"
								@click="pageChange(i)"> &nbsp; {{i}} &nbsp; </span> &nbsp; <input
								type=button value=">" class="btn-sm btn-danger" @click="next()">
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
    			nList:[],
    			filteredNList: [],
    			iCount:0,
    			seller:'',
    			sortOrder:'recent',
    			curpage:1,
    			page:1,
    			startPage:0,
    			endPage:0,
    			snbno:0,
    			totalpage:0,
    			noticetype:'',
    			noticewno:0,
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
    				this.totalpage=response.data.totalpage
    				
    			}).catch(error=>{
    				console.log(error.response)
    			})
    		},
    		getFilteredNList() {
    	        return this.nList.filter(nvo => this.shouldShowOption(nvo))
    	    },
    	    shouldShowOption(nvo) {
    	        if (!nvo) return false

    	        return (nvo.type === 1 || 
    	                (nvo.type === 2 && this.isMatchingType(nvo)) || 
    	                (nvo.type === 3 && nvo.target === this.noticewno))
    	    },
    	    isMatchingType(nvo) {
    	        const typeMapping = {
    	            '레드': 1,
    	            '화이트': 2,
    	            '스파클링': 3,
    	            '로제': 4,
    	            '주정강화': 5
    	        }
    	        return nvo.target === typeMapping[this.noticetype] || 
    	               (this.noticetype !== '레드' && 
    	                this.noticetype !== '화이트' && 
    	                this.noticetype !== '스파클링' && 
    	                this.noticetype !== '로제' && 
    	                this.noticetype !== '주정강화' && 
    	                nvo.target === 6)
    	    },
    		sellerNotice()
    		{	this.noticetype=this.noticetype
    	        this.noticewno=this.noticewno
    			axios.get('../seller/snotice_vue.do', {
    				params:{ id:this.id}
    			}).then(response=>{
    				this.nList=response.data
    			}).catch(error => {
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
    	    enableEditNbno(vo) {
    	        vo.isEditingNbno = true
    	        this.noticetype=vo.type
    	        this.noticewno=vo.wno
    	        this.sellerNotice()
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
    	            if (item.isEditingNbno) {
    	                updateItem.nbno = item.nbno
    	            } else {
    	                updateItem.nbno = item.nbno
    	                }
    	            return updateItem
    	        }).filter(item => Object.keys(item).length > 1)

    	        if (updates.length === 0) {
    	            alert("변경된 내용이 없습니다.")
    	            return
    	        }
    	        const params = new URLSearchParams()
    	        updates.forEach(item => {
    	            params.append(`updates`, JSON.stringify(item)) 
    	        })
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
                            item.isEditingNbno = false
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
                            console.error(error)
                        })
                	}
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
    }).mount('#itemList')
 </script>
</body>
</html>