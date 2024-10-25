<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 목록</title>
<link rel="stylesheet" href="../tem/css/memberlist.css">
</head>
<body>
    <div id="list" class="row"> 
        <h3 class="table-title text-center">회원 목록</h3>
        <table class="table" style="margin-top: 20px;">
            <thead class="text-center" style="margin-bottom: 0px">
                <tr>
                    <th width="5%">번호</th>
                    <th width="10%">아이디</th>
                    <th width="17%">닉네임</th>
                    <th width="17%">이름</th>
                    <th width="29%">이메일</th>
                    <th width="5%">성별</th>
                    <th width="17%">마지막 접속일</th>
                </tr>
            </thead>
            <tbody class="text-center">
              <template v-for="(vo, index) in members">
                <tr style="vertical-align: middle;"@click="detailMember(index)">
                    <td width="5%">{{index+1+(curpage-1)*10}}</td>
                    <td width="10%">{{vo.userId}}</td>
                    <td width="17%">{{vo.nickName}}</td>
                    <td width="17%">{{vo.userName}}</td>
                    <td width="29%">{{vo.email}}</td>
                    <td width="5%">{{vo.sex}}</td>
                    <td width="17%">{{vo.lastloginday}}</td>
                </tr>
                <tr v-if="isShow[index]">
						<td colspan="9" style="padding: 0px;">
							<table class="table" style="border: none;margin-bottom: 0px">
								<tr>
									<th width="12%">생일</th>
									<th width="12%">전화번호</th>
									<th width="43%">주소</th>
									<th width="11%">등급</th>
									<th width="10%">포인트</th>
									<th width="12%">가입일</th>
								</tr>
								<tr>
									<td width="12%">{{vo.birthday}}</td>
									<td width="12%">{{vo.phone}}</td>
									<td width="43%">({{vo.post}})&nbsp;{{vo.addr1}}{{vo.addr2}}</td>
									<td width="11%"><button type="button" @click="downBtn(index)" style="border:none; background-color: white; float: left;"><i class="fa-solid fa-caret-down"></i></button>{{vo.grade}}<button type="button" @click="upBtn(index)" style="border:none; background-color: white;float: right;"><i class="fa-solid fa-caret-up"></i></button></td>
									<td width="10%">{{vo.point}}</td>
									<td width="12%">{{vo.regday}}</td>
								</tr>
							</table>
						</td>
					</tr>
				</template>
            </tbody>
        </table>
        <div class="col-12 text-center">
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
    </div>
    <script>
        let adminMemberListApp=Vue.createApp({
            data() {
                return {
                    members:[],
                    isShow:Array(10).fill(false),
                    curpage:1,
				    totalpage:0,
				    startPage:0,
				    endPage:0
                }
            },
            mounted() {
                this.mList()
            },
            methods: {
            	downBtn(index){
            		if(this.members[index].grade===1){
            			return
            		}
            		axios.get('../admin/memberGradeDown.do',{
            			params:{
            				userId:this.members[index].userId
            				}
            		}).then(response=>{
            			console.log(response.data)
            			this.mList()
            		}).catch(error=>{
            			console.log(error.response)
            		})
            	},
            	upBtn(index){
            		if(this.members[index].grade===3){
            			return
            		}
            		axios.get('../admin/memberGradeUp.do',{
            			params:{
            				userId:this.members[index].userId
            			}
            		}).then(response=>{
            			console.log(response.data)
            			this.mList()
            		}).catch(error=>{
            			console.log(error.response)
            		})
            	},
            	prev(){
          			 this.curpage=this.startPage-1
          			 this.isShow=Array(10).fill(false)
          			 this.mList()
          		 },
          		 next(){
          			 this.curpage=this.endPage+1
          			 this.isShow=Array(10).fill(false)
          			 this.mList()
          		 },
          		 pageChange(page){
          			 this.curpage=page
          			 this.isShow=Array(10).fill(false)
          			 this.mList()
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
          		detailMember(index){
             		if(this.isShow[index]===true){
             			this.isShow[index]=false
             		}
             		else{
             		this.isShow[index]=true
             		}
             	},
                mList(){
                    axios.get('../admin/memberListVue.do',{
                    	params:{
                    		page:this.curpage
                    	}
                    }).then(response=>{
                            this.members=response.data.members
                            this.curpage=response.data.curpage
					        this.totalpage=response.data.totalpage
					        this.startPage=response.data.startPage
					        this.endPage=response.data.endPage
                        }).catch(error=>{
                            alert(error.response)
                            console.log(error.response)
                        })
                }
            }
        }).mount('#list')
    </script>
</body>
</html>