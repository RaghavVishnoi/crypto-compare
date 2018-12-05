class SiteController < ApplicationController

	def dashboard
		@deribit_orderbook = DeribitExchange.get_order_book
		@kraken_orderbook = KrakenExchange.get_order_book
		@okcoin_orderbook = OkcoinExchange.get_order_book
		@bids_okcoin = JSON.parse(@okcoin_orderbook).deep_symbolize_keys[:bids]
		deribits_data(@deribit_orderbook)
		kraken_data(@kraken_orderbook)
		okcoin_data(@okcoin_orderbook)
	rescue StandardError => ex
		flash[:error] = ex.message
	end

	def okcoin_data(okcoin_orderbook)
		bids_okcoin = JSON.parse(okcoin_orderbook).deep_symbolize_keys[:bids]
		bids_okcoin_prices = bids_okcoin[0..10].map{|order_book| order_book[0].to_i}.sort
		asks_okcoin = JSON.parse(okcoin_orderbook).deep_symbolize_keys[:asks]
		asks_okcoin_prices = asks_okcoin[0..10].map{|order_book| order_book[0].to_i}.sort
		okcoin_count = bids_okcoin_prices.count > asks_okcoin_prices.count ? bids_okcoin_prices.count : asks_okcoin_prices.count
		first_buy = bids_okcoin_prices[0]
		first_sell = asks_okcoin_prices[0]
		@okcoins_details = []
		for i in 0...okcoin_count
			details = {}
			details['price'] = ''
			details['buy'] = -(bids_okcoin_prices[i]) rescue ''
			details['sell'] = asks_okcoin_prices[i]
			@okcoins_details.push(details)
		end
		first_price = @okcoins_details.first
		@okcoin_avg_price = first_buy > first_sell ? first_buy : first_sell
	end	

	def kraken_data(kraken_orderbook)
		bids_kraken = JSON.parse(kraken_orderbook).deep_symbolize_keys[:result][:ADACAD][:bids]
		bids_kraken_prices = bids_kraken[0..10].map{|order_book| order_book[1].to_i}.sort
		asks_kraken = JSON.parse(kraken_orderbook).deep_symbolize_keys[:result][:ADACAD][:asks]
		asks_kraken_prices = asks_kraken[0..10].map{|order_book| order_book[1].to_i}.sort
		kraken_count = bids_kraken_prices.count > asks_kraken_prices.count ? bids_kraken_prices.count : asks_kraken_prices.count
		first_buy = bids_kraken_prices[0]
		first_sell = asks_kraken_prices[0]
		@krakens_details = []
		for i in 0...kraken_count
			details = {}
			details['price'] = ''
			details['buy'] = -(bids_kraken_prices[i]) rescue ''
			details['sell'] = asks_kraken_prices[i]
			@krakens_details.push(details)
		end
		@kraken_avg_price = first_buy > first_sell ? first_buy : first_sell
	end

	def deribits_data(deribit_orderbook)
		bids_deribit = JSON.parse(deribit_orderbook).deep_symbolize_keys[:result][:bids]
		bids_deribit_prices = bids_deribit.pluck(:price).sort
		asks_deribit = JSON.parse(deribit_orderbook).deep_symbolize_keys[:result][:asks]
		asks_deribit_prices = asks_deribit.pluck(:price).sort
		deribits_count = bids_deribit_prices.count > asks_deribit_prices.count ? bids_deribit_prices.count : asks_deribit_prices.count
		first_buy = bids_deribit_prices[0]
		first_sell = asks_deribit_prices[0]
		@deribits_details = []
		for i in 0...deribits_count
			details = {}
			details['price'] = ''
			details['buy'] = -(bids_deribit_prices[i]) rescue ''
			details['sell'] = asks_deribit_prices[i]
			@deribits_details.push(details)
		end
		first_price = @deribits_details.first
		@avg_price = first_buy > first_sell ? first_buy : first_sell
	end

end