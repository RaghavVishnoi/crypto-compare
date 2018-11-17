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

	end
end