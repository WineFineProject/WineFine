<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="container">
		<table class="table">
			<tr>
				<td colspan="6" class="text-right">
					<button class="btn-search btn border border-secondary btn-md-square rounded-circle bg-white me-4" data-bs-toggle="modal"
						data-bs-target="#searchModal">
						<i class="fas fa-search text-wine"></i>
					</button>
				</td>
			</tr>
		</table>
		<table class="table" style="height: 400px;">
			<thead>
				<tr>
					<th width="25%">이벤트명</th>
					<th width="8%"></th>
					<th width="25%">대상상품</th>
					<th width="10%">할인율</th>
					<th width="16%">시작일</th>
					<th width="16%">종료일</th>
				</tr>
			</thead>
			<tbody>
				<tr v-for="vo in currentPromotion">
					<td>{{vo.title}}</td>
					<td><img :src="vo.wvo.poster" class="img-fluid me-5 rounded-circle" style="width: 30px; height: 30px;" alt=""></td>
					<td></td>
					<td>{{vo.discount}}%</td>
					<td>{{vo.startday}}</td>
					<td>{{vo.endday}}</td>
				</tr>
			</tbody>
		</table>
		<table class="table" style="height: 400px;">
			<thead>
				<tr>
					<th>이벤트명</th>
					<th></th>
					<th>대상상품</th>
					<th>할인율</th>
					<th>시작일</th>
					<th>종료일</th>
					<th></th>
				</tr>
			</thead>
			<tbody>
				<tr v-for="vo in upcommingPromotion">
					<td>{{vo.title}}</td>
					<td><img :src="vo.wvo.poster" class="img-fluid me-5 rounded-circle" style="width: 30px; height: 30px;" alt=""></td>
					<td>
						<p class="mb-0 mt-4"></p>
					</td>
					<td>{{vo.discount}}%</td>
					<td>{{vo.startday}}%</td>
					<td>{{vo.endday}}%</td>
					<td>
						<button class="btn btn-sm border-wine rounded-pill text-wine" type="button">X</button>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<div class="modal fade" id="searchModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-fullscreen">
			<div class="modal-content rounded-0">
				<div class="modal-header">
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body" style="margin: 0px auto; vertical-align: middle;">
					<table class="table" style="width: 500px; height: 300px;">
						<tr>
							<th width="20%">이벤트명</th>
							<td width="80%"><input type="text" width="85%"></td>
						</tr>
						<tr>
							<th width="20%">할인대상</th>
							<td width="80%"><select>
									<option>전체</option>
									<option>카테고리별</option>
									<option>제품별</option>
							</select></td>
						</tr>
						<tr>
							<th width="20%">제품선택</th>
							<td width="80%"></td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>
</body>
</html>