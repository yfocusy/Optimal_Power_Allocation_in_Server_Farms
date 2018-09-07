function job_list = update_job_list_func(gap,job_list,s)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% input : gap = master_clock - last_clock
% input : job_list = all unfinished jobs 
% input : s = the number of servers opened i.e., s = 7

% output:return the updated job_list with during the gap  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

this_server_job_list = [Inf,Inf,Inf];
for serverNum = 1:s
    this_server_job_list = [Inf,Inf,Inf];
    %serverNum
    [i,j] = find(job_list(:,1)==serverNum);
    jobNUM_this_server = size(i,1);
    if jobNUM_this_server > 0 
        this_server_job_list = [this_server_job_list;job_list(i,:)]; 
        job_list(i,:) = [];
        done_in_gap = gap/jobNUM_this_server;
        still_need_list = this_server_job_list(:,3) - done_in_gap;
        this_server_job_list(:,3) = still_need_list;
        job_list = [job_list;this_server_job_list];
    end
          
end
[x,y] = find(job_list(:,1)==Inf);  % remove inf
job_list(x,:)=[];

end
