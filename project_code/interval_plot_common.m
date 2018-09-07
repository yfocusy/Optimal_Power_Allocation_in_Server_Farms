function interval_plot_common(serverNum1, serverNum2)

% input:  for comparing server 6 and 7 
%load ('data2_replications_15_common', 'all_replications') 
load ('data2_replications_30_common', 'all_replications') 

rNum = size(all_replications,1);

ar = all_replications
T = mean(ar)
S = std(ar);%By default, the standard deviation is normalized by N-1, where N is the number of observations.

serverNum1 = serverNum1 - 2;
serverNum2 = serverNum2 - 2; 
plot(serverNum1+2 : serverNum2+2 , T (1 : 2), '.', 'markersize', 20) % plot mean as a blue small circle

hold on 
%
% computes the 95% confidence interval for all columns(number of servers used) then plot vertical lines

lower = T - tinv(1-0.05/2,  rNum - 1 ) * S / sqrt(rNum - 1)
upper = T + tinv(1-0.05/2,  rNum - 1 ) * S / sqrt(rNum - 1)


for i = serverNum1+2: serverNum2+2
    plot([i,i] , [lower(i-5) , upper(i-5)] , 'g', 'Linewidth' ,2);
end

xlabel('Number of servers open')
ylabel('Response Time')

end