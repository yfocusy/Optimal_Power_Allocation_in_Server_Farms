% ------- 1. for sim_PS -------------------------------  
load('file1_running_mean_7_4000','running_mean')


% ------- 2. for sim_PS_remove_transient_common ------- 
% load('file3_running_mean_transient_7_4000_common','running_mean_transient')
% runnin_mean = running_mean_transient;


% number of jobs in each simulation
jobNum = size(running_mean,1); 
mt = running_mean;
% smooth it with different values of w 
% w = 1;
% w = 500;
w = 1000;

mt_smooth = zeros(1,jobNum - w); 

for i = 1:(jobNum-w)
    if ( i<=w )
        mt_smooth(i) = mean(mt(1 : (2*i-1)));
    else
        mt_smooth(i) = mean(mt((i-w) : (i+w)));
    end
end

% plot the smoothed batch mean
xv = 1: (jobNum - w); % from 1 to jobNum - w
plot(mt_smooth', 'Linewidth',3);
title(['w = ' , int2str(w)],'FontSize',18)
