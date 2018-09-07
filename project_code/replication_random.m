function all_replications = replication_random(Tend, repli_times,w)
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Note : this function will call sim_PS_remove_transient for making at most 30 time replications.

% input : Tend = the simulation time , i.e., Tend = 4000
% input : repli_times = how many times of replications 
% input : w = the number of how many jobs need to remove

% output : save data1_replications_15 (for response time analysis)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s = 10; %% server 

all_replications = [];
tmp_replications = [];

for n = 3:s
    for r = 1:repli_times
        repli = sim_PS_remove_transient(n, Tend, r ,w);   
        tmp_replications = [tmp_replications; repli];        
    end
    all_replications = [all_replications,tmp_replications];   
    
    tmp_replications = []; %%updated for next server_id 
end


save('data1_replications_15','all_replications');  


end