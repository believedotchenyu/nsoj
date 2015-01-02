class ProblemController < ApplicationController

	def list
		@course_problem_ships = @current_user.current_course.course_problem_ships.list.paginate(:page=>params[:page])
	end

	def show
		@course = Course.find(params[:course_id])
		@user_course_ship = @course.user_course_ships.where(:user=>@current_user).first
		if @user_course_ship == nil || @user_course_ship.status != UserCourseShip::StatusPassed
			flash[:error] = "你不能查看本题目"
		end
		@course_problem_ship = @course.course_problem_ships.find(params[:problem_id])
		@problem = @course_problem_ship.problem
	end
end
