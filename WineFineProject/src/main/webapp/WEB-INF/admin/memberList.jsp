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
        <h3 class="text-center">회원 목록</h3>
        <table class="table" style="margin-top: 20px">
            <thead class="text-center">
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
                    <td>{{index+1+(curpage-1)*10}}</td>
                    <td>{{vo.userId}}</td>
                    <td>{{vo.nickName}}</td>
                    <td>{{vo.userName}}</td>
                    <td>{{vo.email}}</td>
                    <td>{{vo.sex}}</td>
                    <td>{{vo.lastloginday}}</td>
                </tr>
                <tr v-if="isShow[index]">
						<td colspan="9" style="padding: 0px;">
							<table class="table" style="border: none;">
								<tr>
									<th width="15%">생일</th>
									<th>전화번호</th>
									<th>주소</th>
									<th>등급</th>
									<th>포인트</th>
									<th>가입일</th>

								</tr>
								<tr>
									<td>{{vo.birthday}}</td>
									<td>{{vo.phone}}</td>
									<td>({{vo.post}})&nbsp;{{vo.addr1}}{{vo.addr2}}</td>
									<td>{{vo.grade}}</td>
									<td>{{vo.point}}</td>
									<td>{{vo.regday}}</td>
								</tr>
							</table>
						</td>
					</tr>
				</template>
            </tbody>
        </table>
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
            	prev(){
          			 this.curpage=this.startPage-1
          			 this.mList()
          		 },
          		 next(){
          			 this.curpage=this.endPage+1
          			 this.mList()
          		 },
          		 pageChange(page){
          			 this.curpage=page
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