<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../tem/css/memberlist.css">
</head>
<body>
    <div id="list" class="row"> 
        <h3 class="table-title text-center">가입 대기 목록</h3>
        <table class="table" style="margin-top: 20px">
            <thead class="text-center">
                <tr>
                    <th width="5%">번호</th>
                    <th width="12%">아이디</th>
                    <th width="15%">닉네임</th>
                    <th width="17%">이름</th>
                    <th width="25%">이메일</th>
                    <th width="12%">가입일</th>
                    <th width="14%"></th>
                </tr>
            </thead>
            <tbody class="text-center">
              <template v-for="(vo, index) in members">
                <tr style="vertical-align: middle;"@click="detailMember(index)">
                    <td width="5%">{{index+1}}</td>
                    <td width="12%">{{vo.userId}}</td>
                    <td width="15%">{{vo.nickName}}</td>
                    <td width="17%">{{vo.userName}}</td>
                    <td width="25%">{{vo.email}}</td>
                    <td width="12%">{{vo.regday}}</td>
                    <td width="14%"><button type="button" @click="accessBtn(index)" class="btn btn-warning">승인</button><button type="button" @click="deleteBtn(index)" class="btn btn-danger">거절</button></td>
                </tr>
                <tr v-if="isShow[index]">
						<td colspan="9" style="padding: 0px;">
							<table class="table" style="border: none;margin-bottom: 0px">
								<tr>
									<th width="15%">설립일</th>
									<th width="20%">전화번호</th>
									<th width="50%">주소</th>
									<th width="15%">사진</th>
								</tr>
								<tr>
									<td width="15%">{{vo.birthday}}</td>
									<td width="20%">{{vo.phone}}</td>
									<td width="50%">({{vo.post}})&nbsp;{{vo.addr1}}&nbsp;{{vo.addr2}}</td>
									<td width="15%"><img :src="vo.photo"></td>
								</tr>
							</table>
						</td>
					</tr>
				</template>
            </tbody>
        </table>
    </div>
    <script>
        let memberWaitListApp=Vue.createApp({
            data() {
                return {
                    members:[],
                    isShow:Array(10).fill(false)
                }
            },
            mounted() {
                this.mList()
            },
            methods: {
            	accessBtn(index){
            		axios.get('../admin/accessMember.do',{
            			params:{
            				userId:this.members[index].userId
            			}
            		}).then(response=>{
            			console.log(response.data)
            			this.isShow=Array(10).fill(false)
            			this.mList()
            		}).catch(error=>{
            			console.log(error.response)
            		})
            	},
            	deleteBtn(index){
            		axios.get('../admin/noAccessMember.do',{
            			params:{
            				userId:this.members[index].userId
            			}
            		}).then(response=>{
            			console.log(response.data)
            			this.isShow=Array(10).fill(false)
            			this.mList()
            		}).catch(error=>{
            			console.log(error.response)
            		})
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
                    axios.get('../admin/memberWaitVue.do').then(response=>{
                            this.members=response.data
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