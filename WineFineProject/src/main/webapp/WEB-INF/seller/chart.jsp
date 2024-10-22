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
		<div>
			<div id="regionChart">
				<ul class="korea-map-font-v1">
					<li class="강원">a</li>
					<li class="경기">b</li>
					<li class="경남">c</li>
					<li class="경북">d</li>
					<li class="광주">e</li>
					<li class="대구">f</li>
					<li class="대전">g</li>
					<li class="부산">h</li>
					<li class="서울">i</li>
					<li class="세종">j</li>
					<li class="울산">k</li>
					<li class="인천">l</li>
					<li class="전남">m</li>
					<li class="전북">n</li>
					<li class="제주">o</li>
					<li class="충남">p</li>
					<li class="충북">q</li>
				</ul>
			</div>
		</div>
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
				  },
		regionOptions:{
			region:'KR',
			colorAxis: {colors: ['#f0f8ff', '#003399']}
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
		drawTypeCharts(){
			var pieData1 = google.visualization.arrayToDataTable(this.priceType())
			var pieData2 = google.visualization.arrayToDataTable(this.accountType())
			
		  var pieChart1 = new google.visualization.PieChart(document.getElementById('priceChart'))
		  var pieChart2 = new google.visualization.PieChart(document.getElementById('accountChart'))
		  
		  pieChart1.draw(pieData1, this.pieOptions);
		  pieChart2.draw(pieData2, this.pieOptions);
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
		drawRegionCharts(){
			var regionData = google.visualization.arrayToDataTable(this.priceRegion())
			var regionChart = new google.visualization.GeoChart(document.getElementById('regionChart'))
			regionChart.draw(regionData, this.regionOptions)
		}
	},
	mounted(){
		this.typeChart()
	}
}).mount('#chartApp')
</script>
</body>
</html>