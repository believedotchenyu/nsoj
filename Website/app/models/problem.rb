class Problem < ActiveRecord::Base
	validates :name, presence: {message: "题目名称不能为空"},length: {maximum: 50, message: "题目名称长度不能超过50"}
	validates :origin_id, length: {maximum: 20, message: "原题库ID长度不能超过20"}

	#常量
	TaskPending = 0
	TaskRunning = 1
	TaskFinished = 2

	belongs_to :user
	belongs_to :online_judge
	belongs_to :problem_type
	has_many :course_problem_ships
	has_many :courses, through: :course_problem_ships
	has_many :contest_problem_ships
	has_many :contests, through: :contest_problem_ships
	
	scope :visible, ->{ where(["hide = ?", false]) }
	
	def description
		file_name = "problems/#{self.id}/description.txt"
		file = File.new(file_name, "r") if File.exists?(file_name)
		str = nil
		if file != nil
			str = file.sysread(file.size).force_encoding("utf-8")
			file.close
		end
		return str
	end
	
	def description=(str)
		Dir.mkdir("problems") if Dir.exists?("problems") == false
		Dir.mkdir("problems/#{self.id}") if Dir.exists?("problems/#{self.id}") == false
		file_name = "problems/#{self.id}/description.txt"
		file = File.new(file_name, "w")
		if file != nil
			file.syswrite(str)
		end
	end
	
	def visible(from_contest = false)
		if self.hide == true
			return false
		end
		if from_contest == true
			return true
		end
		Contest.hide_problem.each do |contest|
			if contest.exists?(self)
				return false
			end
		end
		return true
	end
	
	def vaild_environments
		environments = Array.new
		if self.new_record? == false
			EnvironmentType::List.each do |env|
				if ((self.environment >> env.id) & 1) == 1
					environments << env
				end
			end
		end
		return environments
	end
end
