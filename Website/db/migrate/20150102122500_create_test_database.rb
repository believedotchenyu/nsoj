class CreateTestDatabase < ActiveRecord::Migration
  def up
  	root=User.first
  	test=User.new(:username=>"test",:password=>"test",:create_ip=>"127.0.0.1")
  	test.password_confirmation = "test"
  	test.save!
  	
  	problem=Problem.new(:name=>"题目名称",:answer_limit=>100,:time_limit=>1000,:memory_limit=>1024)
  	problem.user=root
  	problem.online_judge=OnlineJudge::Local
  	problem.problem_type=ProblemType::Normal
  	problem.environment = 0
  	EnvironmentType::List.each do |env|
  		problem.environment |= 1 << env.id
  	end
  	problem.save!
  	
  	course=Course.first
  	course.course_problem_ships.create!(:user=>root,:problem=>problem)
  	
  	running_contest = Contest.new(:contest_type=>ContestType::OI,:course=>Course::LocalCourse,:user=>root,:name=>"正在进行中的比赛",:description=>"正在进行中的比赛",:start_time=>Time.now,:end_time=>Time.now+1.hour)
  	running_contest.save(validate: false)
  	pending_contest = Contest.create!(:contest_type=>ContestType::OI,:course=>Course::LocalCourse,:user=>root,:name=>"即将到来的比赛",:start_time=>Time.now+1.hour,:end_time=>Time.now+2.hour)
  	finished_contest = Contest.new(:contest_type=>ContestType::OI,:course=>Course::LocalCourse,:user=>root,:name=>"已经结束的比赛",:description=>"已经结束的比赛",:start_time=>Time.now-1.hour,:end_time=>Time.now)
  	finished_contest.save(validate: false)
  end
  
  def down
  	User.where(:username=>"test").destroy_all
  	Problem.all.destroy_all
  	Contest.all.destroy_all
  end
end
