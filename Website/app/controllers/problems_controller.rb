class ProblemsController < ApplicationController

	def index
	end
	
	def single
	end
	
	def single_submit
		return redirect_to status_single_path(0)
	end

	def append
		return redirect_to problems_edit_path(0)
	end
	
	def edit
	end
	
	def edit_submit
		return redirect_to problems_edit_description_path(0)
	end
	
	def edit_description
	end
	
	def edit_description_submit
		return redirect_to problems_edit_judge_path(0)
	end
	
	def edit_judge
	end
	
	def edit_judge_submit
		return redirect_to problems_index_path
	end
	
end
