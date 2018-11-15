class CryptoNews		
	class << self
		def list
			base_url = APP_CONSTANTS['min-api']['base_url']
			latest_news = APP_CONSTANTS['min-api']['news']['latest_news']
			url = base_url+latest_news
			RestClient.get(url, headers={})
		end
	end
end