close all;
clear all;
clc;

%% initial parameter

fc = 1575.42*10^6; % frequency of gps signal
c = 3*10^8;
lambda = c/fc;

source=4;           % signal number
interference=1;     % interference number
N=20;               %array number
ss=1;            %snapshot
snr=[-10 40 20];    %  SNR
j=sqrt(-1);
d = 0.2;
%% STEERING VECTOR
aoas=[50 80 90 100 5];
fc=1575.42*10^6;
A = steeringvector(d, fc, 20, 5, aoas);
%% SIGNAL RECEIVED
X=get_signal();

%% COVIARIANCE MATRIX
R=X*X'/ss;
Inv_Rx = inv(R);
As = A;     %****
f = [1 1 1 1 0]';       %****
  h=Inv_Rx*As*inv(As'*Inv_Rx*As)*f;  
W_opt=h/sqrt(h'*h);
%% pattern

phi=-90:1:90;
a=exp(-j*pi*(0:N-1)'*sin(phi*pi/180));
F=W_opt'*a;
%figure();
%plot(phi,F);
G=abs(F).^2./max(abs(F).^2);
% G=abs(F).^2;
G_dB=10*log10(G);
% figure();
% plot(phi,G);legend('N=8,d=lamda/2');
figure();
plot(phi,G_dB,'linewidth',2);legend('N=20,d=0.2');
xlabel('Picth Angle (\circ)');ylabel('Magnitude (dB)');
grid on;
