class ExchangesController < ApplicationController

	def index
		response = CryptoExchange.full
		if response.code == t('response.status.code.success')
			@exchange_list = JSON.parse(response.body).deep_symbolize_keys[:Data][:Exchanges]
			@total_available_exchanges = @exchange_list.count
			@exchange_list = @exchange_list.paginate(:page => params[:page], per_page: EXCHANGE_PER_PAGE)
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

	def trades
		trades = DEFAULT_TRADES
		if params[:trade] != nil
			trades = params[:trade].split(',')
		end
		data = CryptoExchange.trade(trades)
		render json: {status: t('response.status.code.success'), data: data}
	rescue StandardError => ex
		render json: {status: t('response.status.code.internal_server'), message: ex.message}
	end

	def get_order_book(exchange_name)
		client = Cryptoexchange::Client.new
		pair = client.pairs(exchange_name).first
	end

end