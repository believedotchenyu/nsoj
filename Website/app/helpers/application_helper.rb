module ApplicationHelper
	def display_code_line(line)
		return line.gsub('\t','    ')
	end
end
