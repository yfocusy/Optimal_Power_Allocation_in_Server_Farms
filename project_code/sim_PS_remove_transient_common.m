function Tave = sim_PS_remove_transient_common(s, Tend ,replication_id, w)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Note : this function will be called for making common seed replications.

% input : s = the number of servers need to be compared i.e., s = 6 and s = 7
% input : Tend = the simulation time , i.e., Tend = 4000
% input : w = the number of how many jobs need to remove, w = 1000
% input : replication_id = for choosing different seed, up to 30 times

% output : save file3_running_mean_transient_7_4000_common (for s= 6 and s= 7 analysis)
% output : Tave = the estimated mean response time without the non-steady
% part of s = 6 and s= 7
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% common seed for s = 6 and s = 7 ,differ seed for different replication ----------
seed = strcat('seed_7_', int2str(replication_id));
load (seed)
rng(rand_setting) 


T = 0; % T is the cumulative response time 
N = 0; % number of completed jobs at the end of the simulation

T_transient = 0;
N_transient = 0;

running_mean = [0;];
running_mean_transient = [0;];


lambda = 7.2;
p = 2000/s;  
f = 1.25 + 0.31 * (p/200 - 1);  
%r = 1.2889;
next_arrival_time = (-log(1-rand(1))/lambda) *(0.75+(1.17-0.75)*rand(1));   %%%%% CHECKED
service_time_next_arrival = (nthroot(0.14/1.2889*rand(1) + 0.43^0.14, 0.14))/f;
%%% G(t) = (1-b)/r*y+a1^(1-b);
counter = 1; 

next_departure_list = Inf * ones(s,3); % put 'Inf' in servers  
for i = 1:s
    next_departure_list(i,1) = i;
end

job_list = [Inf,Inf,Inf];
master_clock = 0;

while(master_clock < Tend)
    [first_departure_time,first_departure_server] = min(next_departure_list(:,2));
    first_departure_arrival_time = next_departure_list(first_departure_server,3);
    % 1. arrival_event
    if (next_arrival_time < first_departure_time)  
        next_event_time = next_arrival_time;   
        next_event_type = 1;    
    % 2.departure event  
    else % next_arrival_time >= first_departure_time
        next_event_time = first_departure_time;   
        next_event_type = 0; 
    end        
    % update master clock
    last_clock = master_clock;
    master_clock = next_event_time; 
    gap = master_clock - last_clock;
    % update the job_list
    job_list = update_job_list_func(gap,job_list,s); 
    
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
        
    else % a departure, no new next_arrival
        
        % delete the departure from job_list
        job_list = delete_departure_func(first_departure_server,first_departure_arrival_time, job_list);
        % add cumulative response time
        R = master_clock - next_departure_list(first_departure_server,3);
        %%% response_list = [response_list; R];
        T = T + master_clock - next_departure_list(first_departure_server,3);
        % add completed jobs number
        N = N + 1; 
        ss = T/N;
        mean = T/N ;
        if (N > w)  
           T_transient =  T_transient + R;
           N_transient = N_transient + 1;
           mean_transient = T_transient / N_transient;
           running_mean_transient = [[running_mean_transient]; mean_transient];
        end
        

        running_mean = [[running_mean]; mean];
        % update next_departure_list for next master clock
        next_departure_list = update_next_departure_list_func(master_clock,job_list,s);
    end 
end  % end while

% ---end----
T;
N;
Tave = T/N;

T_transient;
N_transient;
mean_transient = T_transient / N_transient;

save file3_running_mean_transient_7_4000_common running_mean_transient;
disp(['The estimated removed transient mean response time is ',num2str(mean_transient)])
end