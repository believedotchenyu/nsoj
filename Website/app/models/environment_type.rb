class EnvironmentType < ActiveRecord::Base
	validates :name, presence: {message: "运行环境的名称不能为空"}, length: {maximum: 20, message: "运行环境的名称长度不能超过20"}
	validates :description, presence: {message: "运行环境的描述不能为空"}, length: {maximum: 1000, message: "运行环境的描述长度不能超过1000"}

	#常量
	List = self.all

	has_many :submissions
end
