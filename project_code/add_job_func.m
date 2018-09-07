function job_list = add_job_func(next_arrival_time,service_time_next_arrival,go_server_number,job_list)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% input : next_arrival_time
% input : service_time_next_arrival 
% input : go_server_number
% input : job_list

% output:return the updated job_list with adding the new job
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
newJob = [go_server_number, next_arrival_time, service_time_next_arrival];
job_list = [job_list; newJob];

[x,y] = find(job_list(:,1)==Inf);  % remove inf
job_list(x,:)=[];


end