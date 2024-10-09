<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
#itemregister{
   margin-top: 10px;
   margin-left:10px;
}
.row{
   margin: 0px auto;
   width: 1300px;
}
.sellretext{
	resize: none;
	width:85%;
	float:center;
}
.formcontrol{
	display:inline-block;
}
</style>
</head>
<body>
<div class="container" id="itemregister">
    <h3 class="text-center">상품 등록</h3>
    <h1>&nbsp;</h1>
     <div class="row">
     	<table class="text-center">
     		<tr>
     		  <th width="10%">이름 (한글/영어)</th>
     		  <th width="10%">종류</th>
     		  <th width="10%">가격</th>
     		  <th width="10%">용량</th>
     		  <th colspan="2" width="20%">맛</th>
     		  <th width="20%">아로마</th>
     		  <th width="20%">음식</th>
     		 </tr>
     		 <tr>
     		 	<td width="10%">
     		 	<input type=text size=10 v-model="namekor" ref="namekor" class="form-control" placeholder="이름 (한글)">
     		 </td>
     		  <td width="10%">
     		  <select id="rwtype" v-model="type" ref="type" class="form-control">
                    <option value="" disabled selected>종류 선택 ▼</option>
                    <option value="레드">레드</option>
                    <option value="화이트">화이트</option>
                    <option value="스파클링">스파클링</option>
                    <option value="로제">로제</option>
                    <option value="주정강화">주정강화</option>
                    <option value="고도주">고도주</option>
         	 </select>
     		  </td>
     		  <td width="10%">
     		  <input type=text size=8 v-model="price" ref="price" class="form-control" placeholder="ex) 140000원"></td>
     		  <td width="10%">
     		  <input type=text size=5 v-model="vol" ref="vol" class="form-control" placeholder="ex) 750ml"></td>
     		  <td width="7%"> 당도 :</td>
     		  <td width="13%"> 
     		  	<input type="range" v-model="sugar" min="0" max="5" step="1" style="width: 100%;">
                <span style="position: absolute; right: 0; top: -25px; font-weight: bold;">{{ sugar }}</span>
     		  </td>
     		  <td rowspan="2" width="20%"> 
     		  	<textarea rows="2" cols="20" v-model="aroma" ref="aroma" class="sellretext form-control" placeholder=" ex) 베리, 사과, 허브 	  	예시와 같이 작성해주세요"></textarea>
     		  </td>
     		  <td rowspan="2" width="20%">
     		  <textarea rows="2" cols="20" v-model="food" ref="food" class="sellretext form-control" placeholder=" ex) 소, 비빔밥, 피자  	  	예시와 같이 작성해주세요"></textarea>
     		  </td>
     		 </tr>
     		 <tr>
     		 <td width="10%"> 
     		 	<input type=text size=10 v-model="nameeng" ref="namekor" class="form-control" placeholder="이름 (영어)">
     		 </td>
     		 <td width="10%">  </td>
     		 <td width="10%"> </td>
     		 <td width="10%"> </td>
     		 <td width="7%"> 산도 :</td>
     		  <td width="13%"> 
     		  	<input type="range" v-model="acid" min="0" max="5" step="1" style="width: 100%;">
                <span style="position: absolute; right: 0; top: -25px; font-weight: bold;">{{ acid }}</span>
     		  </td>
     		 </tr>
     		 <tr>
     		 	<td width="10%"> </td>
     		 	<td width="10%">  </td>
     		 	<td width="10%"> </td>
     		 	<td width="10%"> </td>
     		 	<td width="7%"> 바디 :</td>
     		  	<td width="13%"> 
     		  	<input type="range" v-model="body" min="0" max="5" step="1" style="width: 100%;">
                <span style="position: absolute; right: 0; top: -25px; font-weight: bold;">{{ body }}</span>
     		  	</td>
     		  	<td width="20%"> </td>
     		  	<td width="20%"> </td>
     		 </tr>
     		  <tr>
     		 	<td width="10%"> </td>
     		 	<td width="10%">  </td>
     		 	<td width="10%"> </td>
     		 	<td width="10%"> </td>
     		 	<td width="7%"> 타닌 :</td>
     		  	<td width="13%"> 
     		  	<input type="range" v-model="tannin" min="0" max="5" step="1" style="width: 100%;">
                <span style="position: absolute; right: 0; top: -25px; font-weight: bold;">{{ tannin }}</span>
     		  	</td>
     		  	<td width="20%"> </td>
     		  	<td width="20%"> </td>
     		 </tr>
     	 </table>
     	 <table class="text-center">
     	 	 <tr>
     	 	  <th width="10%">생산자</th>
     		  <th width="45%">지역</th>
     		  <th width="15%">품종</th>
     		  <th width="7%">도수</th>
     		  <th width="8%">재고</th>
     		  <th width="15%">상품 이미지</th>
     		</tr>
     		 <tr>
     	 	  <td width="10%"></td>
     		  <td width="45%">지역</td>
     		  <td width="15%">
     		  <input type="text" class="form-control" v-model="grape" :disabled="grape" placeholder="품종명을 입력하세요" @keyup.enter="searchgrape">
                <div class="gList" v-if="gList.length > 0">
                	<ul>
                        <li v-for="grape in gList" :key="grape.no" @click="selectgrape(grape)">
                            <a>{{grape.namekor}}</a> 
                        </li>
                     </ul>
                </div>
     		  </td>
     		  <td width="7%">
     		  <input type=text size=5 v-model="alcohol" ref="alcohol" class="form-control" placeholder="ex) 14"></td>
     		  <td width="8%">
     		  <input type=text size=5 v-model="stack" ref="stack" class="form-control" placeholder="ex) 200"></td>
     		  <td width="15%">
     		  
     		  </td>
     		</tr>
     		
     	</table>
     </div>
 </div>
</body>
</html>