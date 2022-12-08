i=971;
doa_authentic_path = 'D:/dataset/doa_authentic/' + string(i) + '.mat';
doa_jamming_path = 'D:/dataset/doa_jamming/' + string(i) + '.mat';
doa_spoofed_path = 'D:/dataset/doa_spoofed/' + string(i) + '.mat';
amplitudes_authentic = 'D:/dataset/amplitudes_authentic/' + string(i) + '.mat';
r_s_path = 'D:/dataset/r_s/' + string(i) + '.mat';
r_t_path = 'D:/dataset/r_t/' + string(i) + '.mat';
x_t_path = 'D:/dataset/x_t/' + string(i) + '.mat';

load(r_s_path, 'r_s');
load(r_t_path, 'r_t');
load(x_t_path,'x_t');

r_s_c = r_s*x_t'; % spoofed covariance
x_t_c = x_t*x_t'; % original signal covariance
r_t_c = r_t*x_t'; % spoofed and jammed covarince

 figure(1);
 heatmap(real(r_s_c), 'Colormap', hot);
 figure(2);
 heatmap(real(x_t_c), 'Colormap', hot); 
 figure(3);
 heatmap(real(r_t_c), 'Colormap', hot);