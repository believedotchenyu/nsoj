#ifndef WORK_INTERACTION_H
#define WORK_INTERACTION_H

#include "Config.hpp"
#include "Client_Base.hpp"

void work_interaction()
{
	result.push(Result::Sub("Compiling", 0));
	update_result();

	//download scoure code
	execute_cmd("wget -q -O \"Front\" %s%s/%d", host_path.c_str(), judger_get_problem_front_path.c_str(), problem_id);
	execute_cmd("wget -q -O \"Submit\" %s%s/%d", host_path.c_str(), judger_get_status_submit_path.c_str(), status_id);
	execute_cmd("wget -q -O \"Back\" %s%s/%d", host_path.c_str(), judger_get_problem_back_path.c_str(), problem_id);
	execute_cmd("cat Front Submit Back > Main.cpp");
	
	if(compile_interaction() != true)
	{
		if(DEBUG)
		{
			printf("[%d] compile interaction error\n", status_id);
		}
		status["finish"] = 1;
		update_status();
		update_ce();
		return;
	}else{
		
	}
	
	status["time"] = 0;
	status["memory"] = 0;
	status["score"] = 0;
	status["finish"] = 0;
	
	result.pop();
	for(int index = 1; index <= test_count; index ++)
	{
		if(DEBUG)
		{
			printf("[%d] running %d\n", status_id, index);
		}
		result.push(Result::Sub("Running", 0));
		update_result();
		
		int total_score = 100 / test_count;
		if(100 % test_count > test_count - index)
			total_score ++;
	
		//download input file
		execute_cmd("wget -q -O \"input.txt\" %s%s/%d/%d", host_path.c_str(), judger_get_problem_input_path.c_str(), problem_id, index);
		
		//download answer file
		execute_cmd("wget -q -O \"answer.txt\" %s%s/%d/%d", host_path.c_str(), judger_get_problem_output_path.c_str(), problem_id, index);
		
		Runner::StartInfo start_info;
    Runner::ProcessInfo process_info;
    
    char* exec_cmd[6];
    exec_cmd[0] = new char[BUFFER_SIZE];sprintf(exec_cmd[0], "./Main");
    exec_cmd[1] = new char[BUFFER_SIZE];sprintf(exec_cmd[1], "%d", index);
    exec_cmd[2] = new char[BUFFER_SIZE];sprintf(exec_cmd[2], "%d", total_score);
    exec_cmd[3] = new char[BUFFER_SIZE];sprintf(exec_cmd[3], "input.txt");
    exec_cmd[4] = new char[BUFFER_SIZE];sprintf(exec_cmd[4], "answer.txt");
    exec_cmd[5] = (char*)NULL;

    start_info.command = (const char**)exec_cmd;
    start_info.is_path_file = false;
    start_info.time_limit = time_limit;
    start_info.process_limit = 10;
    start_info.memory_limit = memory_limit;
    start_info.uid = judge_client_uid;

    Runner::run_command(start_info,process_info);
    result.pop();
    
    for(int i = 0;i < 5;i ++)
    	delete[] exec_cmd[i];
    
    switch(process_info.flag)
    {
    	case Runner::ProcessInfo::Failed:process_info.exit_code = RESULT_SE;break;
    	case Runner::ProcessInfo::TimeLimitError:process_info.exit_code = RESULT_TLE;break;
    	case Runner::ProcessInfo::MemoryLimitError:process_info.exit_code = RESULT_MLE;break;
    	case Runner::ProcessInfo::OutputLimitError:process_info.exit_code = RESULT_OLE;break;
    	case Runner::ProcessInfo::RuntimeError:process_info.exit_code = RESULT_RE;break;
    }

		int flag = process_info.exit_code;
		if(0 < flag && flag <= total_score)
		{
			status["time"] = max(status["time"], process_info.time);
			status["memory"] = max(status["memory"], process_info.memory);
			status["score"] = status["score"] + flag;
			if(flag == total_score)
			{
				result.push(Result::Sub("Accepted", total_score));
			}else{
				result.push(Result::Sub("Part Right", flag));
			}
		}else{
			result.push(flag2sub(flag));
		}
		
		if(DEBUG)
		{
			printf("[%d] score %lld\n", status_id, status["score"]);
		}
		update_status();
		update_result();
	}
	status["finish"] = 1;
	update_status();
}

#endif
