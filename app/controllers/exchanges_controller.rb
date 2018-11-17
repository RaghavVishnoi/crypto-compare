class ExchangesController < ApplicationController

	def index
		response = CryptoExchange.full
		if response.code == t('response.status.code.success')
			@exchange_list = JSON.parse(response.body).deep_symbolize_keys[:Data][:Exchanges]
		else
			@error = t('response.message.errors.internal_server')
		end
	rescue StandardError => ex
		@error = ex.message	
	end

	def chart_data
		response = CryptoExchange.histominute
		@chart_data = JSON.parse(response.body).deep_symbolize_keys[:Data]
		@chart_data = @chart_data.map{|chart_details| [Time.at(chart_details[:time]).strftime('%H:%M'), chart_details[:close]]}
	end

end