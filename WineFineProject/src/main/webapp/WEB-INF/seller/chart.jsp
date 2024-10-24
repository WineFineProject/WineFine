<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<link rel="stylesheet" href="../tem/css/chart.css">
<link rel="stylesheet" href="../tem/css/korea.css">
</head>
<body>
	<div class="row" id="chartApp">
		<div class="col-sm-4">
			<div id="priceChart"></div>
		</div>
		<div class="col-sm-4">
			<div id="accountChart"></div>
		</div>
		<div id="promotionChart"></div>
	</div>
	<script>
let chartApp=Vue.createApp({
	data(){
		return{
			pList:[],
			aList:[],
			rList:[],
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
		typeChart(){
			axios.get('../seller/vueSellerTypeChart.do').then(response=>{
				this.pList=response.data.pList
				this.aList=response.data.aList
				this.rList=response.data.rList
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
			
		  var pieChart1 = new google.visualization.PieChart(document.getElementById('priceChart'))
		  var pieChart2 = new google.visualization.PieChart(document.getElementById('accountChart'))
		  
		  pieChart1.draw(pieData1, this.pieOptions);
		  pieChart2.draw(pieData2, this.pieOptions);
		},
		drawPromotionCharts(){
			let barData=google.visualization.arrayToDataTable(this.promotionList())
			let max1=Math.max(...barData.getDistinctValues(2))
			let max2=Math.max(...barData.getDistinctValues(4))
			let max3=Math.max(...barData.getDistinctValues(3))
			let max4=Math.max(...barData.getDistinctValues(5))
			
			let maxdate=Math.max(max1, max2, max3, max4)
			
			console.log(barData)
			let barOption={
				title:'test',
				series:{
					0: {targetAxisIndex:0},
					1:{targetAxisIndex:0},
					2:{targetAxisIndex:1},
					3:{targetAxisIndex:1},
					4:{targetAxisIndex:1},
					5:{targetAxisIndex:1}
				},
				vAxes:{
					0:{title:'price', format:'###,###,###'},
					1:{title:'count', viewWindow:{max:maxdate*2}, gridlines: { count: 0 }, minorGridlines:{count:0}}
				},
				height:800
			}
			let barChart = new google.visualization.ColumnChart(document.getElementById('promotionChart'))
			barChart.draw(barData, barOption)
		},
		priceType(){
			list=[['type', 'price']]
			for(let data of this.pList){
				l=[data.type, data.price]
				list.push(l)
			}
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
				l=[data.PERIOD, data.PRICE, data.SALEPRICE, data.COUNT, data.SALECOUNT, data.ACCOUNT, data.SALEACCOUNT]
				list.push(l)
			}
			return list
		}
	},
	mounted(){
		this.typeChart()
		this.promotionChart(5, 1)
	}
}).mount('#chartApp')
</script>
</body>
</html>