
%% start time
start_time = now

for i = 1:50:
    x_t_path = 'D:/dataset/x_t/' + string(i) + '.mat';
    x_t = importdata(x_t_path);
    s_t = Anti_jam(x_t);
    DOAs = music(s_t);
    
end

%% end time
end_time = now

%% elapsed time
elapsed_time = end_time - start_time
display(elapsed_time)