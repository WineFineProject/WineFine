<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
#itemEdit{
  width: 1100px;
}
.sellretext{
	resize:none;
	width:90%;
	float:center;
}
.form-control{
	display:inline-block;
	width:90%;
	margin: 0 auto;
	border:none;
	border-radius: 0px;
}
.gList , .mList {
    position: absolute;  
    background: white;   
    border: 1px solid #ccc;  
    z-index: 1000;   
    cursor: pointer;  
}
.rname{
	width:90%;
}
.rnation{
	width:24%;
	float:left;
	margin-right: 3px;
	margin-left: 2px;
}
.text-left{
	text-align: left;
}
.rtable1{
   border: medium solid;
   border-color: gray;
   border-bottom-style: hidden;
}
.rtable2, .rtable3{
   border-right: medium solid;
   border-left: medium solid;
   border-color: gray;
   border-bottom: hidden;
   border-top: thin;
}
.rtable3, .rtable4{
   width:100%;
}
.rtable4{
   border-right: medium solid;
   border-left: medium solid;
   border-color: gray;
   border-bottom: medium solid;
   border-top: thin;
   padding-top: 10px;
   padding-bottom: 10px;
}
.rheader{
    border: thin solid;
	border-color: gray;
	margin-bottom:-1px;
	padding-top:10px;
	text-align: left;
}
.rsubject{
	margin-top:10px;
	margin-bottom:20px;
	color: black;
	background-color: #FFE4D8;
	border: thin solid;
	border-color: gray;
	padding-left: 10px;
}
.rcontent{
	padding-top: 10px;
	padding-bottom: 10px;
	padding-left:3px;
}
form{
	padding-left:0px;
}
td{
	background-color: #F5F5F5;
	border: thin solid;
	border-color: gray;
}
#rwtypetd
{
	vertical-align: baseline;
}
.flavor{
	font-weight: 500;
	background-color: #F5F5F5;
	color:black;
	text-align: center;
	border-right: hidden;
	border-bottom:hidden;
}
.flavor2{
    font-weight: 500;
	background-color: #F5F5F5;
	color:black;
	text-align: center;
	border-right: hidden;
	border-left: hidden;
}
.rcontent2{
	border-bottom:hidden;
}
input[type=range]{
	-webkit-appearance:none;
	background-color:transparent;
	border-radius: 10px;
	margin-top:7.2px;
	margin-right:7px;
	height:10px;
	float:left;
	width: 75%;
}
.rcontent3{
	padding:5px;
	color:black;
	
}
input[type=range]::-webkit-slider-thumb{
	-webkit-appearance: none;
	border-radius: 10px;
	width: 15%;
	height: 14px;
	background-color: darkred;
	cursor: pointer;
	float: center;
	box-shadow: 0 0 0 1px #fff;
}
input[type=range]::-webkit-slider-runnable-track{
	background:white;
	border-radius: 7.5px;
}
input[type=range]::-webkit-slider-thumb:active,
input[type=range]::-webkit-slider-thumb:focus,
input[type=range]::-webkit-slider-thumb:hover {
    background-color: #FF8484;
    transform: scale(1.1); 
    box-shadow: 0 0 0 1px #fff;
    transition: background-color 0.2s, transform 0.2s, border 0.2s;
    
}
.alldel{
	width:90%; 
	font-size:12px;
	text-align: center;
	margin-bottom:5px;
}
.alldelbtn{
    border-radius: 5px;
	border: thin;
	float: center;
}
#rwineposter{
	padding-left: 20px;
	width: 80px;
	height: 100px;
}
.postertd{
	height:120px;
}
.mList, .gList{
	overflow-y:scroll; 
	height: 100px;
	width:250px;
}
#cleargrapes{
    border-radius: 5px;
	border: thin;
	float: center;
	margin-left: 5px;
}
.glistinput{
	width: 220px;
}
.dbtn{
 	display: inline-block; 
    padding: 8px 16px; 
    text-decoration: none; 
    color: #E66E5B; 
    background-color: white; 
    border: 2px solid gray; 
    border-radius: 5px; 
    font-size:17px;
    margin-left:3px;
}
</style>
</head>
<body>
<div class="container" id="itemEdit" style="margin-left:10px; margin-top:8px;">
     <div class="row">
     <form @submit.prevent="submitForm" @keydown.enter.prevent>
     	<table class="rtable1">
     	<tr>
     		<th colspan="8" class="rheader">
     		<h4 style="width:100%;color:black;"> &emsp; 상품 수정</h4>
     		</th>
     		</tr>
    	<tr>
     		  <th width="15%" class="rsubject">상품명 (한글)</th>
     		  <th width="20%" class="rsubject">가격</th>
     		  <th width="10%" class="rsubject">도수</th>
     		  <th width="15%" class="rsubject">종류</th>
     		  <th colspan="4" width="40%" class="rsubject">맛</th>
     		 </tr>
     	 <tr>
     		 	<td width="15%" class="rcontent">
     		 	<input type=text size=10 v-model="namekor" ref="namekor" class="form-control" placeholder="이름 (한글)">
     		 </td>
     		  <td width="20%" class="rcontent">
     		  <input type=text size=18 v-model="price" ref="price" class="form-control" placeholder="숫자만 입력해주세요"></td>
     		  <td width="10%" class="rcontent">
     		  <input type=text size=8 v-model="alcohol" ref="alcohol" class="form-control" placeholder="ex) 14"></td>
     		  <td width="15%" class="rcontent" rowspan="3" id="rwtypetd">
     		  <select id="rwtype" v-model="type" ref="type" class="form-control">
                    <option value="" disabled selected>종류 선택 ▼</option>
                    <option value="레드">레드</option>
                    <option value="화이트">화이트</option>
                    <option value="스파클링">스파클링</option>
                    <option value="로제">로제</option>
                    <option value="주정강화">주정강화</option>
                    <option value="기타">기타</option>
         	 </select>
     		  </td>
     		  <th width="7%" class="rcontent flavor"> 당도 :</th>
     		  <td width="13%"  class="rcontent2"> 
     		  	<input type="range" class="rrange" v-model="sugar" ref="sugar" min="0" max="5" step="1">
                <span style="font-weight: bold;">{{ sugar }}</span>
     		  </td>
     		  <th width="7%" class="rcontent flavor2 flavor"> 산도 :</th>
     		  <td width="13%" class="rcontent2"> 
     		  	<input type="range" class="rrange" v-model="acid" ref="acid" min="0" max="5" step="1">
                <span style="font-weight: bold;">{{ acid }}</span>
     		  </td>
     	  </tr>
     	  <tr>
     	  	 <th width="15%" class="rsubject">상품명 (영어)</th>
     		 <th width="20%" class="rsubject">용량</th>
     		  <th width="10%" class="rsubject">재고</th>
     		 	<th width="7%" class="rcontent flavor" rowspan="2"> 바디 :</th>
     		  	<td width="13%"  rowspan="2"> 
     		  	<input type="range" class="rrange" v-model="body" ref="body" min="0" max="5" step="1">
                <span style="font-weight: bold;">{{ body }}</span>
     		  	</td>
     		 	<th width="7%" class="rcontent flavor2" rowspan="2"> 타닌 :</th>
     		  	<td width="13%" rowspan="2"> 
     		  	<input type="range" class="rrange" v-model="tannin" ref="tannin" min="0" max="5" step="1">
                <span style="font-weight: bold;">{{ tannin }}</span>
     		  	</td>	
     		 </tr>
     	  <tr>
     		 <td width="15%" class="rcontent"> 
     		 	<input type=text size=13 v-model="nameeng" ref="nameeng" class="form-control" placeholder="이름 (영어)">
     		 </td>
     		  <td width="20%" class="rcontent">
     		  <input type=text size=18 v-model="vol" ref="vol" class="form-control" placeholder="ex) 750ml"></td>
     	     <td width="10%" class="rcontent">
     		  <input type=text size=13 v-model="stack" ref="stack" class="form-control" placeholder="ex) 200"></td>
     	    </tr>
     	 </table>

     	 <table class="rtable2">
     	 	 <tr>
     	 	  <th colspan="2" width="35%" class="rsubject">아로마</th>
     		  <th colspan="2" width="35%" class="rsubject">음식매칭</th>
     		  <th colspan="2" width="30%" class="rsubject">상품이미지</th>
     		</tr>
     		 <tr>
     		  <td width="35%"  colspan="2" class="rcontent rcontent2"> 
     		  <input type="text" v-model="aromaInput" @keyup.enter="addAroma" class="sellretext form-control" placeholder=" ex) 베리 (1개씩 입력해주세요)">
     		  	<button type="button" @click="clearAromas" class="alldelbtn">&#9747;</button>
       		  </td>
     		  <td width="35%"  colspan="2" class="rcontent rcontent2">
     		  <input type="text" v-model="foodInput" @keyup.enter="addfood" class="sellretext form-control" placeholder=" ex) 피자 (1개씩 입력해주세요)">   
     		  <button type="button" @click="clearFoods" class="alldelbtn">&#9747;</button>
     		  </td>
     		  <td width="20%" class="rcontent" rowspan="2">
     			<input type=text size=60 v-model="poster" ref="poster" class="form-control" placeholder="이미지 주소를 입력하세요">
     			</td>
     			<td width="10%" class="rcontent postertd" rowspan="2">
     			<img :src="poster" v-show="poster!==''" id="rwineposter">
     		    </td>
     		  </tr>
     		 <tr>
     		  <td colspan="2" width="35%" class="rcontent3"> 
     		  	<span class="rname">선택한 아로마: {{ aroma }}</span>
     		  </td>
     		  <td colspan="2" width="35%" class="rcontent3">
     		  	<span class="rname">선택한 음식: {{ food }}</span>
     		  </td>
     		  </tr>
     		 </table>
           <table class="rtable3">
     		 <tr>
     		  <th width="25%" class="rsubject" >생산자</th>
     		  <th width="25%" class="rsubject" >품종</th>
     		  <th width="50%" class="rsubject">지역</th>
     		 </tr>
     		 <tr>
     	 	  <td width="25%" class="rcontent rcontent2">
     	 	  <input type="text" class="form-control" v-model="fmaker" placeholder="생산자명(한글) 검색" @keyup.enter="searchmaker">
                <div class="mList" v-if="mList.length > 0">
                	<ul>
                        <li v-for="mvo in mList" :key="mvo.no" @click="selectmaker(mvo)">
                            <a>{{mvo.namekor}}</a> 
                        </li>
                     </ul>
                </div>
     	 	  </td>
     		  <td width="25%" class="rcontent rcontent2">
     		  <input type="text" class="form-control glistinput" v-model="fgrape" placeholder="품종명(한글) 검색" @keyup.enter="searchgrape">
                <div class="gList" v-if="gList.length > 0">
                	<ul>
                        <li v-for="gvo in gList" :key="gvo.no" @click="selectgrape(gvo)">
                            <a>{{gvo.namekor}}</a> 
                        </li>
                     </ul>
     		    </div>
     		  	<button type="button" @click="cleargrapes" id="cleargrapes">&#9747;</button>
     		  </td>
     		  <td width="50%" rowspan="2">
     		  <select id="n1" v-model="nation1" ref="nation1" class="rnation form-control" @click="nation1list()">
                    <option value="" disabled selected>나라 선택 ▼</option>
                    <option  v-for="n1 in n1List" :key="n1.no" :value="n1.no">{{n1.namekor}}</option>
         	 </select>
     		  <select id="n2" v-model="nation2" ref="nation2" class="rnation form-control" @click="nation2list(n1no)">
                    <option value="" disabled selected>지역1 선택 ▼</option>
                    <option  v-for="n2 in n2List" :key="n2.no" :value="n2.no">{{n2.namekor}}</option>
         	 </select>
         	 <select id="n3" v-model="nation3" ref="nation3" class="rnation form-control" @click="nation3list(n2no)">
                    <option value="" disabled selected>지역2 선택 ▼</option>
                    <option  v-for="n3 in n3List" :key="n3.no" :value="n3.no">{{n3.namekor}}</option>
         	 </select>
         	 <select id="n4" v-model="nation4" ref="nation4" class="rnation form-control" @click="nation4list(n3no)">
                    <option value="" disabled selected>지역3 선택 ▼</option>
                    <option  v-for="n4 in n4List" :key="n4.no" :value="n4.no">{{n4.namekor}}</option>
         	 </select>
     		  </td>
     		</tr>
     		 <tr>
     	 	  <td width="25%" class="rcontent3">
     	 	  <span class="rname">생산자: {{ makername }}</span></td>
     		  <td width="25%" class="rcontent3">
     		  <span class="rname">선택한 품종: {{ grapename }}</span>
     		  </td>
     		</tr>
     	</table>
     	<table class="rtable4">
     	<tr>
        <td style="text-align: center; padding: 10px; background-color: white">
          <input type="submit"  class="btn btn-default dbtn" value="등록">
          &nbsp;
          <input type="button"  class="btn btn-default dbtn" value="취소"
           onclick="javascript:history.back()">
        </td>
      </tr>
     	</table>
     	</form>
     </div>
 </div>
 <script>
 let editApp=Vue.createApp({
 	data(){
 		return {
 			wno:0,
 			namekor:'',
 			nameeng:'',
 			type:'',
 			price:'',
 			vol:'',
 			sugar:0, 
 			acid:0, 
 			body:0,
 			tannin:0,
 			stack:'',
 			aroma:'',
 			food:'',
 			alcohol:'',
 			find:'',
 			nation:'',
 			grape:'',
 			grapename:'',
 			gList:[],
 			fgrape:'',
 			maker:'',
 			makernum:0,
 			makername:'',
 			mList:[],
 			fmaker:'',
 			poster:'',
 			n1List:[],
 			nation1:'',
 			nation11:'',
 			n2List:[],
 			nation2:'',
 			nation22:'',
 			n3List:[],
 			nation3:'',
 			nation33:'',
 			n4List:[],
 			nation4:'',
 			nation44:'',
 			nation1name:'',
 			nation2name:'',
 			nation3name:'',
 			nation4name:'',
 			n1no:0,
 			n2no:0,
 			n3no:0,
 			aromaInput:'',
 			aromaList:[],
 			foodInput:'',
 			foodList:[],
 			id:'${sessionScope.userId}',
 			nickname:'${sessionScope.nickName}'	
 		}
 	},
	mounted(){
 		const urlParams = new URLSearchParams(window.location.search)
 	    this.wno = urlParams.get('wno')
 		axios.get('edit_vue.do',{
			params:{
				wno:this.wno
			}
		}).then(response=>{
			const data = response.data
			  this.namekor = data.namekor
		      this.nameeng = data.nameeng
		      this.type = data.type
		      this.price = data.price
		      this.vol = data.vol
		      this.stack = data.stack
		      this.acid = data.acid
		      this.body = data.body
		      this.grape = data.grape
		      this.maker = data.maker
		      this.nation = data.nation
		      this.alcohol = data.alcohol
		      this.aroma = data.aroma
		      this.food = data.food
		      this.poster = data.poster
		      this.sugar = data.sugar
		      this.tannin = data.tannin
		      this.loadmakername()
		      this.loadGrapeNames()
		      this.loadNations()
			console.log(response.data)
		}).catch(error=>{
			console.log(error.response)
		})
 	},
 	methods:{
 		loadmakername(){
 			this.makernum = parseInt(this.maker, 10)
 			axios.get('prevmaker_vue.do', {
 			    params: {
 			        maker: this.makernum
 			    }
 			}).then(response => {
 				this.makername = response.data
 			}).catch(error => {
 			    console.error(error)
 			})
 		},
 		loadGrapeNames(grapeNumbers) {
 		      axios.get('prevgrapes_vue.do', {
 		        params: { grapeNumbers: this.grape }
 		      }).then(response => {
 		        this.grapename = response.data
 		      }).catch(error => {
 		        console.error(error)
 		      })
 		    },
 		 loadNations(){
 		       const nations = this.nation.split(',')
 		       if (nations.length > 0) this.nation11 = nations[0]
 		       if (nations.length > 1) this.nation22 = nations[1]
 		       if (nations.length > 2) this.nation33 = nations[2]
 		       if (nations.length > 3) this.nation44 = nations[3]
 		       this.nation1 = this.nation11
 		       this.nation2 = this.nation22
 		       this.nation3 = this.nation33
 		       this.nation4 = this.nation44
 		       this.nation1list()
 		       if (this.nation2) this.nation2list()
 		       if (this.nation3) this.nation3list()
 		       if (this.nation4 !== '') this.nation4list()   
 		    },
 		searchmaker(){
 			 if (this.fmaker.length === 0) {
                 return
 			 }
             axios.get('../seller/register_maker_find_vue.do', { 
                     params: { 
                     	find: this.fmaker 
                     }
                 }).then(response => {
                     this.mList = response.data
                 }).catch(error => {
                 	alert(error.response)
    				console.log(error.response)
                 })
 		},
 		searchgrape(){
			 if (this.fgrape.length === 0) {
                return
			 }
            axios.get('../seller/register_grape_find_vue.do', { 
                    params: { 
                    	find: this.fgrape 
                    }
                }).then(response => {
                    this.gList = response.data
                }).catch(error => {
                	alert(error.response)
   				console.log(error.response)
                })
		},
		selectmaker(mvo){
			this.maker = mvo.no
			this.makername = mvo.namekor
			this.mList = []
		},
		selectgrape(gvo) {
			this.grape += (this.grape ? ',' : '') + gvo.no
			this.grapename += (this.grapename ? ', ' : '') + gvo.namekor
		    this.fgrape = ''
		    this.gList = []
		},
		cleargrapes(event){
			this.grape = ''
			this.grapename = ''
		},
		nation1list(){
			
            axios.get('../seller/register_nation1_list_vue.do', { 
                    
                }).then(response => {
                	if (response.data.length === 0) {
                        alert("나라를 선택해주세요.") 
                    } else {
                        this.n1List = response.data
                    }  
                }).catch(error => {
                	console.log(error.response)
                })
		},
		nation2list(n1no){
				this.n1no = this.nation1
		         axios.get('../seller/register_nation2_list_vue.do', { 
            	 params: { no: this.n1no }
                }).then(response => {
                	if (response.data.length === 0) {
                        alert("하위 지역이 없습니다.") 
                    } else {
                        this.n2List = response.data
                    }  
                }).catch(error => {
   				   console.log(error.response)
                })
		},
		nation3list(n2no){
			this.n2no = this.nation2
            axios.get('../seller/register_nation3_list_vue.do', { 
            	 params: { no: this.n2no }
                }).then(response => {
                	if (response.data.length === 0) {
                        alert("하위 지역이 없습니다.") 
                    } else {
                        this.n3List = response.data
                    }                   
                }).catch(error => {
   					console.log(error.response)
                })
		},
		nation4list(n3no){
			this.n3no = this.nation3
            axios.get('../seller/register_nation4_list_vue.do', { 
            	 params: { no: this.n3no }
                }).then(response => {
                	if (response.data.length === 0) {
                        alert("하위 지역이 없습니다.") 
                    } else {
                        this.n4List = response.data
                    }                   
                }).catch(error => {
   					console.log(error.response)
                })
		},
		addAroma(event) {
			event.preventDefault()
	        if (this.aromaInput.trim() !== '') {
	            this.aromaList.push(this.aromaInput.trim()) 
	            this.aromaInput = ''
	            this.updateAroma()
	        }
	    },
	    updateAroma() {
	        this.aroma = this.formattedAroma
	    },
		addfood(event) {
	    	event.preventDefault()
	        if (this.foodInput.trim() !== '') {
	            this.foodList.push(this.foodInput.trim()) 
	            this.foodInput = ''
	            this.updatefood()
	        }
	    },
	    updatefood() {
	        this.food = this.formattedfood
	    },
	    clearAromas() {
	        this.aromaList = []
	        this.updateAroma()
	    },
	    clearFoods() {
	        this.foodList = []
	        this.updatefood()
	    },
	    setNations() {
	    	 this.nation = [this.nation1,this.nation2,this.nation3,this.nation4].filter(Boolean).join(',')
	    },
 		submitForm(){
	    	if (!this.poster) {
	            this.poster = 'https://wine21.speedgabia.com/no_image2.jpg'
	        }
	    	const fields = [
	            { value: this.namekor, ref: this.$refs.namekor, name: '이름 (한글)' },
	            { value: this.nameeng, ref: this.$refs.nameeng, name: '이름 (영어)' },
	            { value: this.price, ref: this.$refs.price, name: '가격' },
	            { value: this.vol, ref: this.$refs.vol, name: '용량' },
	            { value: this.aroma, ref: this.$refs.aroma, name: '아로마' },
	            { value: this.food, ref: this.$refs.food, name: '음식' },
	            { value: this.stack, ref: this.$refs.stack, name: '재고' },
	            { value: this.alcohol, ref: this.$refs.alcohol, name: '도수' },
	            { value: this.sugar, ref: this.$refs.sugar, name: '당도' },
	            { value: this.acid, ref: this.$refs.acid, name: '산도' },
	            { value: this.body, ref: this.$refs.body, name: '바디' },
	            { value: this.tannin, ref: this.$refs.tannin, name: '타닌' },
	            { value: this.grape, ref: null, name: '품종' }, 
	            { value: this.maker, ref: null, name: '생산자' }, 
	            { value: this.nation, ref: null, name: '나라' }
	        ]
	    	
	    	for (const field of fields) {
	            if (!field.value) {
	            	field.ref.focus()
	            	alert(`모든 항목을 빠짐없이 입력해 주세요.`)
	                return
	            }
	        }
 			let formData=new FormData()
 			formData.append("wno", this.wno)
 			formData.append("namekor",this.namekor)
 			formData.append("nameeng",this.nameeng)
 			formData.append("type",this.type) 			
 			formData.append("price",this.price)    			
 			formData.append("vol",this.vol)
 			formData.append("aroma",this.aroma)
 			formData.append("food",this.food)
 			formData.append("alcohol",this.alcohol)
 			formData.append("stack",this.stack !== 0 ? Number(this.stack) : 0)
 			formData.append("poster",this.poster)
 			formData.append("sugar",this.sugar !== 0 ? Number(this.sugar) : 0)
 			formData.append("acid",this.acid !== 0 ? Number(this.acid) : 0)
 			formData.append("body",this.body !== 0 ? Number(this.body) : 0)
 			formData.append("tannin",this.tannin !== 0 ? Number(this.tannin) : 0)
 			formData.append("grape",this.grape)
 			formData.append("maker",String(this.maker))
 			formData.append("nation",this.nation)
 			formData.append("seller",this.id)
 			
 			axios.post('../seller/update_vue.do',formData,{
 			}).then(response=>{
 				if(response.data==='yes')
 				{
 				    alert("상품 수정이 완료되었습니다")
 				    
 				}
 				else
 				{
 					alert(response.data)
 				}
 			}).catch(error=>{
 				console.log(error.response)
 			})
 		} 		 
 	},
 computed: {
 	   formattedAroma() {
 	        return this.aromaList.join(',')
 	    },
 	   formattedfood() {
 	        return this.foodList.join(',')
 	    },
 	   formattedPrice: {
 		  get() {
 	            return this.price;
 	        },
 	        set(value) {
 	            const numericValue = value.replace(/[^0-9]/g, '')
 	            const formattedValue = numericValue.replace(/\B(?=(\d{3})+(?!\d))/g, ',') + (numericValue ? '원' : '')
 	            this.price = formattedValue
 	        }
 	    }
 	},
  watch: {
	  price(newVal) {
	        this.formattedPrice = this.formattedPrice
	    },
	    nation1(newValue) {
	    if (newValue !== this.nation11){
		        this.nation2 = ''
		        this.nation3 = ''
		        this.nation4 = ''
		        this.setNations()
		    	}
	    },
	    nation2(newValue) {
	    if (newValue !== this.nation22){
	        this.nation3 = ''
	        this.nation4 = ''
	        this.setNations()
	       }
	    },
	    nation3(newValue) {
	    if (newValue !== this.nation33){
	        this.nation4 = ''
	        this.setNations()
	       }
	    },
 	}
 }).mount('#itemEdit')
 </script>
</body>
</html>