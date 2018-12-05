class KrakenExchange

	def self.get_order_book
		base_url = APP_CONSTANTS['kraken-api']['base_url']
		params = APP_CONSTANTS['kraken-api']['order-book']+'?'+KRAKEN_PAIR
		url = base_url+params
		RestClient.get(url, headers={})
	end

end