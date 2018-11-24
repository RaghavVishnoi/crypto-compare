function trade_data(type){
	$.ajax({
	  url: "/exchange_trades",
	  type: "GET",
	  body: {
	    exchange_type: type
	  },
	  dataType: "text",

	  complete: function(){

	  },
	  success: function(data){
	  	response = JSON.parse(data)
	  	if(response['status'] == 200){
	  		console.log(response['data'])
	  	}else{
	  		console.log(response['message'])
	  	}
	  },
	  error: function(){

	  }
	})
}