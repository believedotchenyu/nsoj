class JudgerController < ApplicationController
	skip_before_filter :verify_authenticity_token
	
	before_action :check_judge_client
	
	@@mutex = Mutex.new
	
	def get_waiting_status
		result = ""
		@@mutex.synchronize do
			@status = Status.where(:task=>false).order(id: :asc).first
			if @status == nil
				result = "N"
			else
				@status.update!(:task=>true)
				result = "Y"
				result += "\n#{@status.id}"
				result += "\n#{@status.problem_id}"
				result += "\n#{@status.language_id}"
			end
		end
		return render plain: result
	end
	
	def get_status_submit
		@status = Status.find(params[:status_id])
		return send_file @status.submit_file if not @status.submit_file == nil
		return render plain: ""
	end
	
	def get_status_submit_zip
		@status = Status.find(params[:status_id])
		return render plain: @status.submit_zip(params[:index])
	end
	
	def get_problem_info
		@problem = Problem.find(params[:problem_id])
		result = "Y"
		result += "\n#{@problem.problem_type_id}"
		result += "\n#{@problem.time_limit}"
		result += "\n#{@problem.memory_limit}"
		result += "\n#{@problem.test_count}"
		return render plain: result
	end
	
	def get_problem_spj
		@problem = Problem.find(params[:problem_id])
		return send_file @problem.spj_file if not @problem.spj_file == nil
		return render plain: ""
	end
	
	def get_problem_front
		@problem = Problem.find(params[:problem_id])
		return send_file @problem.front_file if not @problem.front_file == nil
		return render plain: ""
	end
	
	def get_problem_back
		@problem = Problem.find(params[:problem_id])
		return send_file @problem.back_file if not @problem.back_file == nil
		return render plain: ""
	end
	
	def get_problem_input
		@problem = Problem.find(params[:problem_id])
		return render plain: @problem.data_input(params[:index])
	end
	
	def get_problem_output
		@problem = Problem.find(params[:problem_id])
		return render plain: @problem.data_output(params[:index])
	end
	
	def update_status_info
		@status = Status.find(params[:status_id])
		return render plain: "Y" if @status.update(params.permit(:score, :time, :memory, :finish))
		return render plain: "N"
	end
	
	def update_status_ce
		@status = Status.find(params[:status_id])
		@status.ce = request.body
		return render plain: "Y"
	end
	
	def update_status_result
		@status = Status.find(params[:status_id])
		@status.result = request.body
		return render plain: "Y"
	end
	
	private
		def check_judge_client
		end
end
