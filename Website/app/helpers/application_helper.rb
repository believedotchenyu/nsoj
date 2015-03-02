module ApplicationHelper
	def display_code_line(line)
		return line.gsub('\t','    ')
	end
	
	def display_friendly_time(time)
		time = time.to_f
		return "#{time}ms" if  time < 1000
		return "#{time/1000}s"
	end
	
	def display_friendly_memory(memory)
		memory = memory.to_f
		return "#{memory}B" if memory < 1024
		return "#{memory/1024}KB" if memory < 1024 * 1024
		return "#{memory/1024/1024}MB" if memory < 1024 * 1024 * 1024
		return "#{memory/1024/1024/1024}GB"
	end
	
	def display_friendly_datetime(datetime)
		return datetime.to_s
	end
	
	def test
		return "abc"
	end
end
