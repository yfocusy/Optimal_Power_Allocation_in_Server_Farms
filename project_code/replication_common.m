function all_replications_common = replication_common(Tend, repli_times,w)
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Note : this function is for analysis the performance of s= 6 and s= 7
% Note : this function will call sim_PS_remove_transient_common for making at most 30 time replications.

% input : Tend = the simulation time , i.e., Tend = 4000
% input : repli_times = how many times of replications (at most 30 seeds we have)
% input : w = the number of how many jobs need to remove, w = 1000

% output : save data2_replications_15_common (for response time analysis when using common seed)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


all_replications_common = [];
tmp_replications = [];

for n = 6:7   % analysis s = 6 and s = 7
    for r = 1:repli_times
        repli = sim_PS_remove_transient_common(n, Tend ,r, w);   
        tmp_replications = [tmp_replications; repli];       
    end
    all_replications_common = [all_replications_common,tmp_replications]; 
    
    tmp_replications = []; %%updated for next server_id 
end

all_replications = all_replications_common;
%save('data2_replications_15_common','all_replications');  
save('data2_replications_30_common','all_replications'); 
end