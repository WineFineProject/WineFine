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
                    <th>번호</th>
                    <th>아이디</th>
                    <th>닉네임</th>
                    <th>이름</th>
                    <th>이메일</th>
                    <th>성별</th>
                    <th>휴대폰번호</th>
                    <th>등급</th>
                    <th>가입일</th>
                </tr>
            </thead>
            <tbody class="text-center">
                <tr v-for="(vo, index) in members" :key="vo.id">
                    <td>{{index+1}}</td>
                    <td>{{vo.id}}</td>
                    <td>{{vo.nickname}}</td>
                    <td>{{vo.name}}</td>
                    <td>{{vo.email}}</td>
                    <td>{{vo.sex}}</td>
                    <td>{{vo.phone}}</td>
                    <td>{{vo.grade}}</td>
                    <td>{{vo.dbregdate}}</td>
                </tr>
            </tbody>
        </table>
    </div>
    <script>
        let adminMemberListApp=Vue.createApp({
            data() {
                return {
                    members:[]
                }
            },
            mounted() {
                this.mList()
            },
            methods: {
                mList(){
                    axios.get('../admin/memberListVue.do') 
                        .then(response=>{
                            this.members=response.data.members
                        })
                        .catch(error=>{
                            alert(error.response)
                            console.log(error.response)
                        })
                }
            }
        }).mount('#list')
    </script>
</body>
</html>