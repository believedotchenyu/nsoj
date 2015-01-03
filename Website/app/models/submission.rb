class Submission < ActiveRecord::Base
	validates :submit_ip, presence: {message: "IP地址不能为空"}, format: {with: /\d+[\.\d]+/, message: "IP地址格式不正确"},
				length: {in: 7..23, message: "IP地址长度不正确"}

	belongs_to :user_course_ship, touch: true
	belongs_to :statistic, touch: true
	belongs_to :language
	belongs_to :status
	belongs_to :environment_type
	
	scope :list, ->{order("id DESC")}
	
	def source_code
		file_name = "submissions/#{self.id}/source_code.txt"
		file = File.new(file_name,"r") if File.exists?(file_name)
		code = nil
		if file != nil
			code = file.sysread(file.size)
			file.close
		end
		return code
	end
	
	def source_code=(code)
		Dir.mkdir("submissions") if Dir.exists?("submissions") == false
		Dir.mkdir("submissions/#{self.id}") if Dir.exists?("submissions/#{self.id}") == false
		file_name = "submissions/#{self.id}/source_code.txt"
		file = File.new(file_name,"w")
		if file != nil
			file.syswrite(code)
			file.close
		end
	end
	
	def problem
		return statistic.problem
	end
	
	self.per_page = 10
end
