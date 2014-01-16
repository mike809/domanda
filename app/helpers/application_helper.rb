module ApplicationHelper

	def flash_msg(msgs, type = :danger)
		flash[type] ||= []
		flash[type].concat(msgs)
	end

	def flash_now(msgs, type = :danger)
		flash.now[type] ||= []
		flash.now[type].concat(msgs)
	end

end
