class OkcoinExchange

	def self.get_order_book
		base_url = APP_CONSTANTS['okcoin-api']['base_url']
		params = APP_CONSTANTS['okcoin-api']['order-book']+'?'+OKCOIN_SYMBOL
		url = base_url+params
		RestClient.get(url, headers={})
	end

end