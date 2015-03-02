class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_action :find_current_user
  
  protected
  	def find_current_user
  		if session[:current_user_id] != nil && User.where(:id=>session[:current_user_id]).exists?
  			@current_user = User.find(session[:current_user_id])
  		end
  	end
  	
  	def check_admin_right
  		if @current_user == nil || @current_user.admin == false
  			flash[:error] = "你没有权限"
  			return redirect_to :back
  		end
  	end
  	
  	def check_login
  		if @current_user == nil
  			flash[:error] = "请先登录"
  			return redirect_to :back
  		end
  	end
  	
  	def check_logout
  		if @current_user != nil
  			flash[:error] = "请先退出"
  			return redirect_to :back
  		end
  	end
end
