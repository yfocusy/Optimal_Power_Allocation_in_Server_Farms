function interval_plot(serverNum1, serverNum2)
% input : for server 3 to 10
load ('data1_replications_15', 'all_replications') 


rNum = size(all_replications,1);

ar = all_replications;
T = mean(ar)  % the sample mean
S = std(ar)%By default, the standard deviation is normalized by N-1, where N is the number of observations.
% ignore s = 1 or 2
serverNum1 = serverNum1 - 2;
serverNum2 = serverNum2 - 2; 
plot(serverNum1+2 : serverNum2+2 , T (serverNum1 : serverNum2), '.', 'markersize', 20) % plot mean as a blue small circle

hold on

% computes the 95% confidence interval for all columns(number of servers used) then plot vertical lines

lower = T - tinv(1-0.05/2,  rNum - 1 ) * S / sqrt(rNum - 1) 
upper = T + tinv(1-0.05/2,  rNum - 1 ) * S / sqrt(rNum - 1) 

for i = serverNum1+2: serverNum2+2
    
    plot([i,i] , [lower(i-2) , upper(i-2)] , 'g', 'Linewidth' ,2);
end

xlabel('Number of servers open')
ylabel('Response Time')

end