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
  end
  
  def down
  	User.where(:username=>"test").destroy_all
  	Problem.all.destroy_all
  end
end
