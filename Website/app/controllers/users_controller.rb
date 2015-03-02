class UsersController < ApplicationController
	before_action :check_login, only: [:logout, :edit, :edit_submit]
	before_action :check_logout, only: [:login, :login_submit, :register, :register_submit]

	def login
		@user = User.new
	end
	
	def login_submit
		if User.where(:username=>params[:user][:username]).exists? == false
			flash[:info] = "用户名 #{params[:user][:username]} 不存在"
			return redirect_to users_login_path
		elsif User.where(:username=>params[:user][:username], :password=>params[:user][:password]).exists? == false
			flash[:info] = "用户名或密码错误"
			return redirect_to users_login_path
		else
			flash[:success] = "登录成功"
			session[:current_user_id] = User.where(:username=>params[:user][:username], :password=>params[:user][:password]).first.id
			return redirect_to root_path
		end
	end
	
	def logout
		flash[:success] = "退出成功"
		session[:current_user_id] = nil
		return redirect_to :back
	end
	
	def register
		@user = User.new
	end
	
	def register_submit
		@user = User.new(params[:user].permit(:username, :password, :password_confirmation))
		if @user.save == true
			flash[:success] = "注册成功"
			session[:current_user_id] = @user.id
			return redirect_to root_path
		else
			return render :register
		end
	end
	
	def edit
		@user = @current_user
	end
	
	def edit_submit
		@user = @current_user
		if params[:user][:old_password] != @user.password
			flash[:error] = "原密码错误"
			return redirect_to :back
		elsif @user.update(params[:user].permit(:password, :password_confirmation)) == false
			return render :edit
		else
			flash[:success] = "修改成功"
			return redirect_to root_path
		end
	end

end
