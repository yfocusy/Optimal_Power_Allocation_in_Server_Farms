function go_server_number = find_serverNUM_func(job_number,s)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% input : job_number = the counter of the current job
% input : s = the number of servers opened i.e., s = 7

% output: go_server_number = which server the job should be assigned to
% (round robin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    tmp = rem(job_number,s); 
    if tmp ==0
        go_server_number = s;
    else
        go_server_number = tmp; 
    end