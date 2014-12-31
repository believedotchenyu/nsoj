class Notice < ActiveRecord::Base
	validates :title, presence: {message: "公告的标题不能为空"}, length: {maximum: 20, message: "公告的标题长度不能超过20"}
	validates :body, presence: {message: "公告的内容不能为空"}, length: {maximum: 10000, message: "公告的内容长度不能超过10000"}

	belongs_to :course
	belongs_to :user

	scope :public, -> { where(["course_id = ? or course_id = ?",nil,0]) }
end
