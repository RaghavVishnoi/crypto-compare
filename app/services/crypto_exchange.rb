class CryptoExchange
	class << self

		def full
			base_url = APP_CONSTANTS['min-api']['base_url']
			params = APP_CONSTANTS['min-api']['exchange']['full']+'?'+BTC_USD
			url = base_url+params+'&limit='+String(EXCHANGE_LIMIT)
			RestClient.get(url, headers={})
		end

		def histominute
			base_url = APP_CONSTANTS['min-api']['base_url']
			params = APP_CONSTANTS['min-api']['historical_data']['histominute']+'?'+BTC_USD
			url = base_url+params+'&limit='+String(EXCHANGE_CHART_LIMIT)
			RestClient.get(url, headers={})
		end

		def chart_details
			response = CryptoExchange.histominute
			@chart_data = JSON.parse(response.body).deep_symbolize_keys[:Data]
			Time.zone = DEFAULT_TIME_ZONE
			@chart_data.map{|chart_details| [Time.zone.parse(Time.at(chart_details[:time]).to_s).strftime('%H:%M'), chart_details[:low], chart_details[:open], chart_details[:close], chart_details[:high]]}
		end

		def trade(exchange_types)
			data = {}
			Time.zone = DEFAULT_TIME_ZONE
			client = Cryptoexchange::Client.new
			exchange_types.each do |exchange_type|
				pair = client.pairs(exchange_type).first
				trade = client.trades(pair).last
				data[exchange_type] = [trade.type, trade.amount, trade.target, Time.zone.parse(Time.at(trade.timestamp).to_s)]
			end
			data
		end

	end
end