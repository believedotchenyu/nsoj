class BannedIp < ActiveRecord::Base
	validates_presence_of :banned_ip, message: "IP地址不能为空"
	validates_format_of :banned_ip, with: /\d+[\.\d]+/, message: "IP地址不正确"
	validates_length_of :banned_ip, in: 7..23, message: "IP地址长度不正确"
	validates_presence_of :deadline, message: "过期时间不能为空"
	validate :check_deadline

	protected
		def check_deadline
			if self.deadline != nil && self.deadline <= Time.now
				errors.add(:base,"过期时间不能比当前时间早")
			end
		end

	belongs_to :user

	scope :valid, -> { where(["deadline > ?",Time.now]) }
end
