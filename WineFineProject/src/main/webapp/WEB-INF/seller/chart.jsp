<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<link rel="stylesheet" href="../tem/css/chart.css">
<link rel="stylesheet" href="../tem/css/replyinsert.css">
<style type="text/css">
.checked {
	color: darkred;
}
</style>
</head>
<body>
	<div id="chartApp">
		<div style="margin-bottom: 20px;">
			<label><input type="radio" name="chartType" v-model="mode" :value="1" @change="modeChange()">주간 수익 통계</label> <label><input type="radio" name="chartType" v-model="mode" :value="2" @change="modeChange()">프로모션 성과</label>
		</div>
		<div class="row" v-if="mode===1">
			<div class="col-sm-4" style="padding: 0px">
				<div id="priceChart"></div>
			</div>
			<div class="col-sm-4" style="padding: 0px">
				<div id="accountChart"></div>
			</div>
			<div class="col-sm-4" style="padding: 0px">
				<div id="changeChart"></div>
			</div>
			<div class="col-sm-12" id="weekChart"></div>
		</div>
		<div class="row" v-if="mode===2">
			<div class="col-sm-2">
				<ul style="overflow-y: auto; height: 400px;">
					<li class="scrollable-text" style="cursor: pointer;" :class="{'checked':selnum===index}" @click="selectChart(vo.psno, index, 1)" v-for="(vo, index) in saleList">
						<p style="margin: 0px;">{{vo.title}}</p>
					</li>
					<li class="scrollable-text" style="cursor: pointer;" :class="{'checked':selnum===index+saleList.length}" @click="selectChart(vo.pcno, index, 2)" v-for="(vo, index) in couponList">
						<p style="margin: 0px;">{{vo.title}}</p>
					</li>
					<li class="scrollable-text" style="cursor: pointer;" :class="{'checked':selnum===index+saleList.length+couponList.length}" @click="selectChart(vo.pbno, index, 3)" v-for="(vo, index) in bannerList">
						<p style="margin: 0px;">{{vo.title}}</p>
					</li>
				</ul>
			</div>
			<div class="col-sm-10">
				<div id="promotionChart"></div>
			</div>
		</div>
	</div>
	<script>
let chartApp=Vue.createApp({
	data(){
		return{
			pList:[],
			aList:[],
			wList:[],
			vList:{},
			couponList:[],
			bannerList:[],
			saleList:[],
			mode:1,
			no:5,
			sel:{},
			selnum:999999,
			type:1,
			isSelect:false,
			isMore:false,
			pieOptions:{
			    backgroundColor: 'transparent',
			    pieHole: 0.25,
			    tooltip:{
			    	trigger:'selection'
			    },
			    colors: [ "#bb2d3b", 
			              "#aaaaaa", 
			              "#b4c5fe", 
			              "#ffc1e0", 
			              "#8dc7c7", 
			              "#8dc7c7"],
			    fontName: 'Open Sans',
			    title:'주간 구매 와인',
			    pieSliceText:'value',
			    chartArea: {
			      width: '95%',
			      height: '94%'
			    },
			    legend: {
			      textStyle: {
			        fontSize: 13
			      }
			    }
			  }
		}
	},
	methods:{
		selectChart(no, index, type){
			if(type===1){
				this.selnum=index
				this.sel=this.saleList[index]
			}
			else if(type===2){
				this.selnum=index+this.saleList.length
				this.sel=this.couponList[index]
			}
			else if(type===3){
				this.selnum=index+this.saleList.length+this.couponList.length
				this.sel=this.bannerList[index]
			}
			this.isSelect=true
			this.promotionChart(no, type)
		},
		isMoreList(){
			this.isMore=!this.isMore
		},
		typeChart(){
			axios.get('../seller/vueSellerTypeChart.do').then(response=>{
				this.pList=response.data.pList
				this.aList=response.data.aList
				this.vList=response.data.vList
				this.wList=response.data.wList
				google.load("visualization", "1", {packages:["corechart"]})
				google.setOnLoadCallback(()=>{
					this.drawTypeCharts()
				});
			})
		},
		promotionChart(no, type){
			axios.get('../seller/vueSellerPromotionChart.do', {
				params:{
					no:no,
					type:type
				}
			}).then(response=>{
				this.proList=response.data.list
				google.charts.load('current', {'packages':['corechart']})
				google.charts.setOnLoadCallback(()=>{
					this.drawPromotionCharts()
				})
			})
		},
		drawTypeCharts(){
			var pieData1 = google.visualization.arrayToDataTable(this.priceType())
			var pieData2 = google.visualization.arrayToDataTable(this.accountType())
			var barData1 = google.visualization.arrayToDataTable(this.visitChange())
			var barData2 = google.visualization.arrayToDataTable(this.weekPayment())
			
		  var pieChart1 = new google.visualization.PieChart(document.getElementById('priceChart'))
		  var pieChart2 = new google.visualization.PieChart(document.getElementById('accountChart'))
		  var barChart1 = new google.visualization.ColumnChart(document.getElementById('changeChart'))
		  var barChart2 = new google.visualization.ColumnChart(document.getElementById('weekChart'))
		  
			let barOption1={
				title:'구매 전환율',
				chartArea: {
			        top: 20
			    }
			}
			let maxprice=Math.max(...barData2.getDistinctValues(1))
			if(maxprice===0)
				maxprice=1000000
			let max1=Math.max(...barData2.getDistinctValues(2))
			let max2=Math.max(...barData2.getDistinctValues(3))
			let maxdate=Math.max(max1, max2)
			if(maxdate===0)
				maxdate=50
			let barOption2={
				title:'주간 수익',
				chartArea: {
			        top: 20
			    },
			    series:{
					0: {targetAxisIndex:0},
					1:{targetAxisIndex:1},
					2:{targetAxisIndex:1}
				},
				height:500,
				vAxes:{
					0:{title:'price', viewWindow:{max:maxprice}, format:'###,###,###'},
					1:{title:'count', viewWindow:{max:maxdate*2}, gridlines: { count: 0 }, minorGridlines:{count:0}}
				}
			}
		  pieChart1.draw(pieData1, this.pieOptions);
		  pieChart2.draw(pieData2, this.pieOptions);
		  barChart1.draw(barData1, barOption1);
		  barChart2.draw(barData2, barOption2);
		},
		drawPromotionCharts(){
			let barData=google.visualization.arrayToDataTable(this.promotionList())
			let max1=Math.max(...barData.getDistinctValues(6))
			let max2=Math.max(...barData.getDistinctValues(4))
			let max3=Math.max(...barData.getDistinctValues(3))
			let max4=Math.max(...barData.getDistinctValues(5))
			
			let max5=Math.max(...barData.getDistinctValues(2))
			let max6=Math.max(...barData.getDistinctValues(1))
			let maxprice=Math.max(max5, max6)
			if(maxprice===0)
				maxprice=1000000
			
			let maxdate=Math.max(max1, max2, max3, max4)
			if(maxdate===0)
				maxdate=50
			let barOption={
				title:this.sel.title+' 성과 ('+this.sel.startDay+' ~ '+this.sel.endDay+')',
				series:{
					0: {targetAxisIndex:0},
					1:{targetAxisIndex:0},
					2:{targetAxisIndex:1},
					3:{targetAxisIndex:1},
					4:{targetAxisIndex:1},
					5:{targetAxisIndex:1}
				},
				chartArea: {
			        top: 20
			    },
				margin: { top: 0, right: 0, bottom: 0, left: 0 },
				vAxes:{
					0:{title:'price', viewWindow:{max:maxprice}, format:'###,###,###'},
					1:{title:'count', viewWindow:{max:maxdate*2}, gridlines: { count: 0 }, minorGridlines:{count:0}}
				},
				height:800
			}
			let barChart = new google.visualization.ColumnChart(document.getElementById('promotionChart'))
			barChart.draw(barData, barOption)
		},
		weekPayment(){
			list=[['date', 'payment', 'account', 'count']]
			for(let data of this.wList){
				l=[data.dbday, data.payment, data.account, data.count]
				list.push(l)
			}
			return list
		},
		priceType(){
			list=[['type', 'price']]
			for(let data of this.pList){
				l=[data.type, data.price]
				list.push(l)
			}
			return list
		},
		visitChange(){
			list=[['visit', 'count', { role: 'style' }]]
			list.push(['visit', this.vList.visit, 'blue'])
			list.push(['count', this.vList.payment, 'darkred'])
			list.push(['account', this.vList.account, 'green'])
			return list
		},
		priceRegion(){
			list=[['region', 'price']]
			for(let data of this.rList){
				l=[data.addr, data.price]
				list.push(l)
			}
			console.log(list)
			return list
		},
		accountType(){
			list=[['type', 'account']]
			for(let data of this.aList){
				l=[data.type, data.account]
				list.push(l)
			}
			return list
		},
		promotionList(){
			console.log(this.proList)
			list=[['stack', 'price', 'saleprice', 'count', 'salecount', 'account', 'saleaccount']]
			for(let data of this.proList){
				l=[data.period, data.price, data.saleprice, data.count, data.salecount, data.account, data.saleaccount]
				list.push(l)
			}
			console.log(list)
			return list
		},
		modeChange(){
			if(this.mode===1){
				this.isSelect=false
				this.isMore=false
				this.typeChart()
			}
			else{
				this.getChartInfo()
			}
		},
		getChartInfo(){
			axios.get('../seller/vuePromotionChartList.do').then(response=>{
				this.couponList=response.data.couponList
				this.saleList=response.data.saleList
				this.bannerList=response.data.bannerList
			})
		}
	},
	mounted(){
		this.typeChart()
	}
}).mount('#chartApp')
</script>
</body>
</html>