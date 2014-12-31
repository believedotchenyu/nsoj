class Submission < ActiveRecord::Base
	validates :submit_ip, presence: {message: "IP地址不能为空"}, format: {with: /\d+[\.\d]+/, message: "IP地址格式不正确"},
				length: {in: 7..23, message: "IP地址长度不正确"}

	belongs_to :user, touch: true
	belongs_to :statistic, touch: true
	belongs_to :language
	belongs_to :status
	belongs_to :environment_type
end
