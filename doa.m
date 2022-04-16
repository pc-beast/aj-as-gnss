%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;
clear all;
close all;
k = 8; % k : number of signals
% k = 8 since 4 original signals and 4 spoofed signals\

aoa = [50.0 80.0 -45.0 -10.0 0.0 0.0 0.0 0.0]; % aoa: array of angle of arrivals of k signals
% 4 angles are 0 since they are from spoofers

f = 1575.42*10^6; % frequency of gps signal
T = 0:0.01:10;
S = [];
for i = 1:k
    s = transpose(20*sin(2*pi*f*T + i));
    S = [S [s]];
end
% array of sinusoidal signals for example here, can be changesd to gps
% signal

N = 20; % number of antennas
d = 0.002; % distance between antennas
c = 3*10^8;
lambda = c/f;
pos = (0:0.002:0.038);
ang = aoa;
A = steervec(pos/lambda, ang); % steering matrix


as = A*transpose(S);
% afrter additive white gaussian matrix
snr = 5; % for experimentation
Y = awgn(as, snr);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% doa using music
cov = sensorcov(pos, ang, db2pow(-1));
doa_s = musicdoa(cov, 8);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% DOA Algorithm based on compressed sensing theory
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
R = Y; % recieved signal
p = 0.01; % step length
t = 1000; % number of iterations
G = eye(N); % phase error matrix
A_dictionary = []; % dictionary matrix

for i=1:1:t
    X_hat = SOMP()


