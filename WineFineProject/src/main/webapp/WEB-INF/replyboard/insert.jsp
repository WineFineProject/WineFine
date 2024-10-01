<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1:1 문의게시판</title>
<script src="https://unpkg.com/vue@3"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
</head>
<body>
<div class="container" style="width: 800px;">
   <div class="row">
        <h3 class="text-center" style="margin-top:150px;">1:1 문의 게시판</h3>
        <form>
            <div class="form-group">
                <label for="category">카테고리 선택</label>
                <select class="form-control" id="category">
                    <option value="">선택하세요</option>
                    <option value="product">상품 관련</option>
                    <option value="delivery">배송 관련</option>
                    <option value="service">서비스 관련</option>
                    <option value="payment">결제 관련</option>
                    <option value="other">기타</option>
                </select>
            </div>
            <div class="form-group" style="margin-top: 10px;">
                <label>문의할 대상을 선택하세요</label>
                <div style="margin-top: 5px;">
                    <input type="radio" id="admin" name="contact" value="admin" checked>
                    <label for="admin">관리자에게 문의</label>
                    <input type="radio" id="seller" name="contact" value="seller">
                    <label for="seller">판매자에게 문의</label>
                </div>
            </div>
            <div class="form-group" style="margin-top: 10px;">
                <label for="search">상품 검색</label>
                <input type="text" class="form-control" id="search" placeholder="상품명을 입력하세요">
            </div>
            <div class="form-group" style="margin-top: 10px;">
                <label for="search">판매자명</label>
                <input type="text" class="form-control">
            </div>
            <div class="form-group" style="margin-top: 10px;">
                <label for="title">제목</label>
                <input type="text" class="form-control" id="title" placeholder="제목을 입력하세요">
            </div>
            <div class="form-group" style="margin-top: 10px;">
                <label for="content">내용</label>
                <textarea class="form-control" id="content" rows="5" style="resize:none;" placeholder="문의 내용을 입력하세요"></textarea>
            </div>
            <div style="margin-top: 10px;"></div>
            <div class="text-center">
            <button type="submit" class="btn btn-primary">등록</button>
            <input type="button" class="btn btn-secondary" value="취소">
            </div>
        </form>
        </div>   
    </div>
    <script>
         
    </script>
</body>
</html>