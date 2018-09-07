function job_list = delete_departure_func(first_departure_server,first_departure_arrival_time, job_list)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% input : first_departure_server = the #server with the mini still_need time
% input : first_departure_arrival_time = its arrival time
% input : job_list

% output:return the updated job_list with removing the departure job
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


num = size(job_list,1); % how many jobs at this moment in the whole server farm


for i = 1:num   

    if job_list(i,2) == first_departure_arrival_time
        if job_list(i,1) == first_departure_server
            job_list(i,:);
            job_list(i,:) ;
            job_list(i,:) = [];
            break   % each time just allow one job to depart     
        end        
    end   
end

end