<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원 목록</title>
    <style>
        .table {
            width: 100%;
            border-collapse: collapse;
        }
        .table th, .table td {
            border: 1px solid #ddd;
            padding: 8px;
        }
        .table th {
            background-color: #f2f2f2;
        }
        .btn {
            cursor: pointer;
            color: white;
            background-color: olive; 
            border: none;
            padding: 5px 10px;
            border-radius: 5px;
        }
    </style>
    <script src="https://unpkg.com/vue@3"></script>
   <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
</head>
<body>
    <div class="container">
        <h1>회원 목록</h1>
        <table class="table">
            <thead>
                <tr>
                    <th>번호</th>
                    <th>아이디</th>
                    <th>이름</th>
                    <th>성별</th>
                    <th>이메일</th>
                    <th>등급</th>
                    <th>관리</th>
                </tr>
            </thead>
            <tbody>
                <tr v-for="(vo,index) in members">
                    <td>{{index + 1}}</td>
                    <td>{{vo.id}}</td>
                    <td>{{vo.name}}</td>
                    <td>{{vo.sex}}</td>
                    <td>{{vo.email}}</td>
                    <td>{{vo.grade}}</td>
                    <td>
                        <input type="button" class="btn btn-lg btn-primary" id="blackListBtn" value="블랙리스트">
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
    <script>
        let memberListApp=Vue.createApp({
            data() {
                return {
                    members: []
                }
            },
            mounted() {
                this.mList()
            },
            methods: {
                mList() {
                    axios.get('../seller/memberList.do') 
                        .then(response => {
                            this.members = response.data
                        }).catch(error => {
                        	alert(error.response)
           				 console.log(error.response)
                        })
                }
            }
        }).mount('.container')
    </script>
</body>
</html>