class DeribitExchange

	def self.get_order_book
		base_url = APP_CONSTANTS['deribit-api']['base_url']
		params = APP_CONSTANTS['deribit-api']['order-book']+'?'+DERIBIT_INSTRUMENT
		url = base_url+params
		RestClient.get(url, headers={})
	end

end