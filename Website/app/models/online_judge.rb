class OnlineJudge < ActiveRecord::Base
	validates :name, presence: {message: "OJ的名称不能为空"}, length: {maximum: 20, message: "OJ的名称长度不能超过20"}
	validates :description, presence: {message: "OJ的描述不能为空"}, length: {maximum: 1000, message: "OJ的描述长度不能超过1000"}
	validates :address, presence: {message: "OJ的地址不能为空"}, length: {maximum: 40, message: "OJ的地址长度不能超过40"}
	validates :regexp, presence: {message: "OJ的正则表达式匹配不能为空"}, length: {maximum: 20, message: "OJ的正则表达式长度不能超过20"}
	validates_length_of :hint, maximum: 20, message: "OJ的提示长度不能超过20"

	scope :local, -> { first }
	scope :vjudge, -> { where(["id > ?",1]) }

	#常量
	Local = self.local
	VJudge = self.vjudge
	List = self.all
end
