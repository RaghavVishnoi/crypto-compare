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
	  		data = response['data']
	  		var kucoin = data['kucoin']
	  		var bithash = data['Bithash']
	  		var bitmex = data['bitmex']
	  		$('.wrapper-1 .trade-data .type').text(kucoin[0])
	  		$('.wrapper-1 .trade-data .trade-name').text("Kucoin - "+kucoin[2])
	  		$('.wrapper-1 .trade-data .price').text(kucoin[1])
	  		if(kucoin[0] == "sell"){
	  			if(kucoin[1] < 4000){
	  				meter = 30
	  			}else{
	  				meter = 10
	  			}
	  		}else{
	  			if(kucoin[1] < 4000){
	  				meter = 80
	  			}else{
	  				meter = 100
	  			}
	  		}
  			range_change_event('wrapper-1',meter)
	  		

	  		$('.wrapper-2 .trade-data .type').text(bitmex[0])
	  		$('.wrapper-2 .trade-data .trade-name').text("Bitmex - "+bitmex[2])
	  		$('.wrapper-2 .trade-data .price').text(bitmex[1])
	  		if(bitmex[0] == "sell"){
	  			if(bitmex[1] < 4000){
	  				meter = 30
	  			}else{
	  				meter = 10
	  			}
	  		}else{
	  			if(bitmex[1] < 4000){
	  				meter = 80
	  			}else{
	  				meter = 100
	  			}
	  		}
	  		range_change_event('wrapper-2',meter)

	  		$('.wrapper-3 .trade-data .type').text(bithash[0])
	  		$('.wrapper-3 .trade-data .trade-name').text("Bithash - "+bithash[2])
	  		$('.wrapper-3 .trade-data .price').text(bithash[1])
	  		if(bithash[0] == "sell"){
	  			if(bithash[1] < 4000){
	  				meter = 30
	  			}else{
	  				meter = 10
	  			}
	  		}else{
	  			if(bithash[1] < 4000){
	  				meter = 80
	  			}else{
	  				meter = 100
	  			}
	  		}
	  		range_change_event('wrapper-3',meter)

	  	}else{
	  		console.log(response['message'])
	  	}
	  },
	  error: function(){

	  }
	})
}

function toggleOrderBooks(exchange_name){
	if(exchange_name == 'deribit'){
		$('#deribit').attr("style", "display: block");
		$('#kraken').attr("style", "display: none");
		$('#okcoin').attr("style", "display: none");
	}else if(exchange_name == 'kraken'){
		$('#deribit').attr("style", "display: none");
		$('#kraken').attr("style", "display: block");
		$('#okcoin').attr("style", "display: none");
	}else if(exchange_name == 'okcoin'){
		$('#deribit').attr("style", "display: none");
		$('#kraken').attr("style", "display: none");
		$('#okcoin').attr("style", "display: block");
	}
}