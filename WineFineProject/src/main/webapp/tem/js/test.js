function findWine(instance){
	if(instance.fd===''){
		instance.isFind=false
	}
	else{
		instance.isFind=true
	}
	axios.get('../seller/findWine.do', {
		params:{
			fd:instance.fd
		}
	}).then(response=>{
		console.log(instance.fd)
		instance.list=response.data
	})
}