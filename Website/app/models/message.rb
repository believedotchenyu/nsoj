class Message < ActiveRecord::Base
	validates :title, presence: {message: "私信的标题不能为空"}, length: {maximum: 50, message: "私信的标题长度不能超过50"}
	validates :body, presence: {message: "私信的内容不能为空"}, length: {maximum: 1000, message: "私信的内容长度不能超过1000"}

	belongs_to :from_user, class_name: "User", inverse_of: :send_messages
	belongs_to :receive_user, class_name: "User", inverse_of: :receive_messages
	
	scope :notread, -> { where(read: false) }
	scope :all_messages, ->(user) { where(["from_user_id=? or receive_user_id=?",user.id,user.id]).order("id DESC") }
	
	self.per_page = 10
end
