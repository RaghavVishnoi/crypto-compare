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
			Time.zone = 'Central Time (US & Canada)'
			@chart_data.map{|chart_details| [Time.zone.parse(Time.at(chart_details[:time]).to_s).strftime('%M'), chart_details[:low], chart_details[:open], chart_details[:close], chart_details[:high]]}
		end

	end
end