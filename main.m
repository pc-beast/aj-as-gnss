clc;
clear all;
close all;
k = 8; % k : number of signals
% k = 8 since 4 original signals and 4 spoofed signals\
rng(2); % for reproducability
aoa = [50 80 -45 -10 0 0 0 0]; % aoa: array of angle of arrivals of k signals
% 4 angles are 0 since they are from spoofers

f = 1575.42*10^6; % frequency of gps signal
T = 0:0.01:10;
S = [];

%
for i = 1:k
    s = transpose(20*sin(2*pi*f*T + i));
    S = [S [s]];
end
% array of sinusoidal signals for example here, can be changesd to gps
% signal

N = 20; % number of antennas
%

d = 0.002; % distance between antennas
A = []; % steering matrix
c = 3*10^8;
lambda = c/f;
pos = (0:0.002:0.038);
aoa_authentic = [50 80 -45 -10];
ang_authentic = [[aoa_authentic]; 0 0 0 0];
A_theta = steervec(pos/lambda, ang_authentic);
% additive white gaussian matrix
A_a = [20 30 40 25];
phi_a = (pi/45)*rand(4, 1);
t = 0:(1/3069000):1;
%prn = mod((nav_message()+cacode(1)),2);
sigma_first_term = zeros(1, 3069001);
for i =1:4
    signal = nav_message().*cacode(i);
    s_a = A_a(i)*(signal.*sin(2*pi*f*t + phi_a(i)));
    as = A_theta(:,i)*s_a;
    sigma_first_term = sigma_first_term + as;
end
sigma_first_term = sum(first_term);

A_s = A_a*2;
phi_s = phi_a - pi/8;
sigma_second_term = zeros(1, 3069001);
ang_spoofed = zeros(2, 4);
A_phi = steervec(pos/lambda, ang_spoofed);
for i =1:4
    signal = nav_message().*cacode(i);
    s_s = A_s(i)*(signal.*sin(2*pi*f*t + phi_s(i)));
    as = A_phi(:,i)*s_s;
    sigma_second_term = sigma_second_term + as;
end
sigma_second_term = sum(second_term);

r_t = sigma_first_term + sigma_second_term;


disp(size(signal));

disp(size(s_a));
figure(1)
subplot(2,1,2)
plot(t,s_a);