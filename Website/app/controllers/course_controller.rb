class CourseController < ApplicationController
	before_action :check_login, only: [:choose,:my_list,:join,:revoke,:exit,:user_list]
	before_action :check_logout, only: []
	
	def list
		@courses = Course.list.paginate(:page=>params[:page])
	end
	
	def choose
		if @current_user.courses.where(:id=>params[:course_id]).exists? == false
			flash[:error] = "你没有报名这们课程或者你的申请还没有通过"
		else
			@current_user.update_column(:current_course_id,params[:course_id])
			flash[:success] = "课程切换成功"
		end
		return redirect_to root_path
	end
	
	def my_list
		@courses = @current_user.courses.list.paginate(:page=>params[:page])
	end
	
	def show
		@course = Course.find(params[:course_id])
		@user_course_ship = @course.user_course_ships.where(:user=>@current_user).first
	end
	
	def join
		@course = Course.find(params[:course_id])
		@user_course_ship = @course.user_course_ships.where(:user=>@current_user).first
		if @user_course_ship != nil && @user_course_ship.status == UserCourseShip::StatusPassed
			flash[:error] = "你已加入该课程，无需再申请加入"
			return redirect_to :back
		end
		if @user_course_ship != nil && @user_course_ship.status == UserCourseShip::StatusWaiting
			flash[:error] = "你的申请正在审核中"
			return redirect_to :back
		end
		if @user_course_ship == nil
			@user_course_ship = UserCourseShip.new(:user=>@current_user,:course=>@course)
		end
		@user_course_ship.status = UserCourseShip::StatusWaiting
		@user_course_ship.level = UserCourseShip::LevelCommon
		@user_course_ship.save!
		flash[:success] = "课程申请已发出，正在等待管理员审核"
		return redirect_to :back
	end
	
	def revoke
		@course = Course.find(params[:course_id])
		@user_course_ship = @course.user_course_ships.where(:user=>@current_user).first
		if @user_course_ship == nil || @user_course_ship.status == UserCourseShip::StatusRefusee
			flash[:error] = "你没有申请加入该课程，无需撤销"
			return redirect_to :back
		end
		if @user_course_ship.status == UserCourseShip::StatusPassed
			flash[:error] = "你的申请已通过，不能撤销"
			return redirect_to :back
		end
		@user_course_ship.status = UserCourseShip::StatusRefusee
		@user_course_ship.level = UserCourseShip::LevelCommon
		@user_course_ship.save!
		flash[:success] = "课程申请已撤销"
		return redirect_to :back
	end
	
	def exit
		@course = Course.find(params[:course_id])
		@user_course_ship = @course.user_course_ships.where(:user=>@current_user).first
		if @user_course_ship == nil || @user_course_ship.status != UserCourseShip::StatusPassed
			flash[:error] = "你尚未加入该课程，无需退出"
			return redirect_to :back
		end
		if @course == Course::LocalCourse || @course == Course::VJudgeCourse
			flash[:error] = "你不能退出该课程"
			return redirect_to :back
		end
		@user_course_ship.status = UserCourseShip::StatusRefusee
		@user_course_ship.level = UserCourseShip::LevelCommon
		@user_course_ship.save!
		flash[:success] = "已退出课程 #{@course.name}"
		return redirect_to :back
	end
	
	def user_list
		@course = Course.find(params[:course_id])
		@user_course_ship = @course.user_course_ships.where(:user=>@current_user).first
		if @current_user.level < User::LevelWatcher && (@user_course_ship == nil || @user_course_ship.status != UserCourseShip::StatusPassed)
			flash[:error] = "你没有权限查看本页面"
			return redirect_to :back
		end
		@users = @course.users.paginate(:page=>params[:page])
	end
end
