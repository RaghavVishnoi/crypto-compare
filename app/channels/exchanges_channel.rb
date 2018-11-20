class ExchangesChannel < ApplicationCable::Channel
	def subscribed
	  stream_from 'exchanges'
	end

	def receive(data)
	  ActionCable.server.broadcast "exchanges", data
	end
end