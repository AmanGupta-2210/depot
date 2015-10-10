module SessionCount
	private
	def increase_count
		if session[:count].nil?
			session[:count] = 1
		else
			session[:count] += 1
		end
	end

	def reset_count
		session[:count] = 1
	end
end