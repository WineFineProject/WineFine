<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>주요 품종</title>
    <script src="https://unpkg.com/vue@3"></script>
    <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
</head>
<body>
    <div id="app">
        <h1>주요 품종</h1>
        <table>
            <thead>
                <tr>
                    <th>한국 이름</th>
                    <th>영어 이름</th>
                    <th>내용</th>
                    <th>상세보기</th>
                </tr>
            </thead>
            <tbody>
                <tr v-for="grape in grapes" :key="grape.namekor">
                    <td>{{ grape.namekor }}</td>
                    <td>{{ grape.nameeng }}</td>
                    <td>{{ grape.content }}</td>
                    <td><button @click="goToDetail(grape.no)">상세보기</button></td>
                </tr>
            </tbody>
        </table>
    </div>
    <script>
        const app = Vue.createApp({
            data() {
                return {
                    grapes: []
                }
            },
            methods: {
                fetchGrapes() {
                    axios.get('grape/list.do')
                        .then(response => {
                            this.grapes = response.data.grapes
                        })
                        .catch(error => {
                            console.error(error);
                        });
                },
                goToDetail(no) {
                    window.location.href = `../grape/detail.do?no=${no}`
                }
            },
            mounted() {
                this.fetchGrapes();
            }
        }).mount('#app');
    </script>
</body>
</html>