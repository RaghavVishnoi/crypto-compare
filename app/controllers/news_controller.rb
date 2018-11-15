class NewsController < ApplicationController

	def index
		response = get_crypto_news
		if response.code == t('response.status.code.success')
			@news_list = JSON.parse(response.body).deep_symbolize_keys[:Data]
			@news_list = @news_list.paginate(:page => params[:page], per_page: NEWS_PER_PAGE)
		else
			flash['error'] = t('response.message.errors.internal_server')
		end
	rescue StandardError => ex
		flash['error'] = ex.message	
	end

	def show
		response = get_crypto_news
		if response.code == t('response.status.code.success')
			news_list = JSON.parse(response.body).deep_symbolize_keys[:Data]
			@news_details =  news_list.map{|det| det if det[:id] == params[:id]}.compact.first
		else
			flash['error'] = t('response.message.errors.internal_server')
		end
	rescue StandardError => ex
		flash['error'] = ex.message
	end

	private
		def get_crypto_news
			CryptoNews.list
		end

end
