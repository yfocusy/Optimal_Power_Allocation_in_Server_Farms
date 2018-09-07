function Tave = sim_PS(s,Tend)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% input : s = the number of servers opened i.e., s = 7
% input : Tend = the simulation time , i.e., Tend = 4000
% output : save file1_running_mean_7_4000 (for transient analysis)
% output : Tave = the estimated mean response time
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --------------- fixed seed ------------------------------------------- 
load p1_rand_setting_arrival 
rng(rand_setting) 
% ----------------generate 30 ranom seeds to save ----------------------
% rand_setting = rng;
% save seed_7_1 rand_setting  %% generate 30  random seeds to save


T = 0; % T is the cumulative response time 
N = 0; % number of completed jobs at the end of the simulation

running_mean = [0;];  % for transient analysis
% mean response time R = T/N 

lambda = 7.2;
p = 2000/s;  
f = 1.25 + 0.31 * (p/200 - 1);  
% r = 1.2889;
next_arrival_time = (-log(1-rand(1))/lambda) *(0.75+(1.17-0.75)*rand(1));   %%%%% CHECKED
service_time_next_arrival = (nthroot(0.14/1.2889*rand(1) + 0.43^0.14, 0.14))/f;
% G(t) = (1-b)/r*y+a1^(1-b);
counter = 1;     % couter how many jobs have been generated
next_departure_list = Inf * ones(s,3); % put 'Inf' in servers 

for i = 1:s  % add server number in the first column of the next_departure_list
    next_departure_list(i,1) = i;
end

job_list = [Inf,Inf,Inf];
master_clock = 0;

while(master_clock < Tend)
    [first_departure_time,first_departure_server] = min(next_departure_list(:,2));
    first_departure_arrival_time = next_departure_list(first_departure_server,3);
    % 1. arrival event
    if (next_arrival_time < first_departure_time) 
        next_event_time = next_arrival_time;   
        next_event_type = 1;     
    % 2. departure event  
    else 
        next_event_time = first_departure_time;   
        next_event_type = 0; 
    end        
    % update master clock
    last_clock = master_clock;
    master_clock = next_event_time; 
    gap = master_clock - last_clock;
    % update the job_list
    job_list = update_job_list_func(gap,job_list,s); 
    
    % 1. process an arrival event
    if (next_event_type == 1)      
        go_server_number = find_serverNUM_func(counter,s);
        % add newJob to job_list
        job_list = add_job_func(next_arrival_time,service_time_next_arrival,go_server_number,job_list);
        % update the the next_departure_list
        next_departure_list = update_next_departure_list_func(master_clock,job_list,s);   
        % generate a new job and schedule its arrival
        next_arrival_time = next_arrival_time + (-log(1-rand(1))/lambda) *(0.75+(1.17-0.75)*rand(1));   %%%%% done
        service_time_next_arrival = (nthroot(0.14/1.2889*rand(1) + 0.43^0.14, 0.14))/f;
        counter = counter + 1;
        % event = [next_arrival_time service_time_next_arrival];
        
    % 2. process a departure event     
    else      
        % delete the departure from job_list
        job_list = delete_departure_func(first_departure_server,first_departure_arrival_time, job_list);
        % add cumulative response time
        R = master_clock - next_departure_list(first_departure_server,3);
        T = T + master_clock - next_departure_list(first_departure_server,3);
        % add completed jobs number
        N = N + 1; 
        mean = T/N ;
        running_mean = [[running_mean]; mean];
        % update next_departure_list for next master clock
        next_departure_list = update_next_departure_list_func(master_clock,job_list,s);
    end 
end  % end while

% ---output----
T
N
Tave = T/N;
save file1_running_mean_7_4000 running_mean;
disp(['The estimated mean response time is ',num2str(Tave)])
%end