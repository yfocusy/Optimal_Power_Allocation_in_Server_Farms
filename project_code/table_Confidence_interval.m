%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% output: list =  [lower; upper; T ; S; ]
% output: Repli_list = [i,lower_diff, upper_diff; ] for Common random
% numbers method ANALYSIS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% for 15 independent replication  for s = 3 to 10
%load('data1_replications_15','all_replications')

% for 15 independent replication Common random numbers method for s = 6 and s = 7
%load('data2_replications_15_common','all_replications')

% for 30 independent replication Common random numbers method for s = 6 and s = 7
load('data2_replications_30_common','all_replications') 

rNum = size(all_replications,1)  % column
EMRT_diff_list = [];
for i = 1: rNum
    EMRT_diff = all_replications(i,2) - all_replications(i,1);
    EMRT_diff_list = [EMRT_diff_list;i,all_replications(i,1),all_replications(i,2), EMRT_diff,];
end
EMRT_diff_list;

Repli_list = [];
for i = 15:5:30
    T_tmp_diff_list=[];
    for j = 1:i
        List = [];
        T_tmp_diff = EMRT_diff_list(j,4);
        List= [List;j,T_tmp_diff];
        T_tmp_diff_list = [T_tmp_diff_list;List];
    end
    T_mean_diff = mean(T_tmp_diff_list(:,2));
    S_diff = std(T_tmp_diff_list(:,2));
    lower_diff = T_mean_diff - tinv(1-0.05/2 , i - 1 ) * S_diff / sqrt (i - 1); 
    upper_diff = T_mean_diff + tinv(1-0.05/2 , i - 1 ) * S_diff / sqrt (i - 1); 
    Repli_list = [Repli_list;i,lower_diff, upper_diff; ];
end


T = mean(all_replications);
S = std(all_replications);%By default, the standard deviation is normalized by N-1, where N is the number of observations.

lower = T - tinv(1-0.05/2 , rNum - 1 ) * S / sqrt (rNum - 1);
upper = T + tinv(1-0.05/2 , rNum - 1 ) * S / sqrt (rNum - 1); 

list = [lower; upper; T ; S; ];
list
Repli_list








