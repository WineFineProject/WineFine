<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="container-fluid py-5" id="couponDiv">
		<div class="container py-5">
			<div class="table-responsive">
				<table class="table">
					<thead>
						<tr>
							<th scope="col"></th>
							<th scope="col">이벤트명</th>
							<th scope="col">대상상품</th>
							<th scope="col">할인율</th>
							<th scope="col">시작일</th>
							<th scope="col">종료일</th>
						</tr>
					</thead>
					<tbody>
						<tr v-for="vo in currentPromotion">
							<th scope="row">
								<div class="d-flex align-items-center">
									<img :src="vo.wvo.poster" class="img-fluid me-5 rounded-circle" style="width: 80px; height: 80px;" alt="">
								</div>
							</th>
							<td>
								<p class="mb-0 mt-4">{{vo.title}}</p>
							</td>
							<td>
								<p class="mb-0 mt-4"></p>
							</td>
							<td>
								<p class="mb-0 mt-4">{{vo.discount}}%</p>
							</td>
							<td>
								<p class="mb-0 mt-4">{{vo.startday}}%</p>
							</td>
							<td>
								<p class="mb-0 mt-4">{{vo.endday}}%</p>
							</td>
						</tr>
					</tbody>
				</table>
				<table class="table">
					<thead>
						<tr>
							<th scope="col"></th>
							<th scope="col">이벤트명</th>
							<th scope="col">대상상품</th>
							<th scope="col">할인율</th>
							<th scope="col">시작일</th>
							<th scope="col">종료일</th>
							<th scope="col"></th>
						</tr>
					</thead>
					<tbody>
						<tr v-for="vo in upcommingPromotion">
							<th scope="row">
								<div class="d-flex align-items-center">
									<img :src="vo.wvo.poster" class="img-fluid me-5 rounded-circle" style="width: 80px; height: 80px;" alt="">
								</div>
							</th>
							<td>
								<p class="mb-0 mt-4">{{vo.title}}</p>
							</td>
							<td>
								<p class="mb-0 mt-4"></p>
							</td>
							<td>
								<p class="mb-0 mt-4">{{vo.discount}}%</p>
							</td>
							<td>
								<p class="mb-0 mt-4">{{vo.startday}}%</p>
							</td>
							<td>
								<p class="mb-0 mt-4">{{vo.endday}}%</p>
							</td>
							<td>
								<button class="btn border-wine rounded-pill px-4 py-3 text-primary" type="button">X</button>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</body>
</html>