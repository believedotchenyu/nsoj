class User < ActiveRecord::Base
	validates :username, presence: {message: "用户名不能未空"}, format: { with: /\A\w{1,30}\z/, message: "用户名由1-30个字符构成" },
				uniqueness: {message: "用户名已存在"}
	validates :password, presence: {message: "密码不能未空"}, format: { with: /\A\w{1,30}\z/, message: "密码由1-30个字符构成" },
				confirmation: {message: "两次输入的密码不一致"}
	validates :password_confirmation, presence: {message: "请再次输入密码"}
end
