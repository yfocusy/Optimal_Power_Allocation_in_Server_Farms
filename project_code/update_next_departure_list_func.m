function next_departure_list = update_next_departure_list_func(master_clock,job_list,s)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% input : master_clock
% input : job_list = all unfinished jobs 
% input : s = the number of servers opened i.e., s = 7

% output:next_departure_list = great a new next_departure_list at this master_clock  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



next_departure_list = Inf * ones(s,3); 

for i = 1:s
    next_departure_list(i,1) = i;
end
next_departure_list;

 
% find the mini still_need time in each server and add it to next_departure_list
for server_number = 1:s  
    this_server_job_list = [Inf,Inf,Inf];
    [i,j] = find(job_list(:,1)==server_number);
    jobNUM_this_server = size(i,1);  %%% i is the number of how many jobs in this server 
    if jobNUM_this_server > 0 % not zero and not empty
        
        this_server_job_list = [this_server_job_list;job_list(i,:)];
        [min_job_still_need, x]= min(this_server_job_list(:,3)) ; % find the mini still_need time in each server
    
        next_departure_time = master_clock + min_job_still_need * jobNUM_this_server;
        arrival_time_next_departure = this_server_job_list(x,2); % second column is the arrival time
        next_departure_list(server_number,:) = [server_number, next_departure_time,arrival_time_next_departure];
        
    end
end

end