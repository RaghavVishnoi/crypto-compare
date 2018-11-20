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
	end

	def chart_details
		@chart_data = CryptoExchange.chart_details
		render json: @chart_data
	end

end