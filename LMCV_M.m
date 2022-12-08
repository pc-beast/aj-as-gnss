%% LCMV beamforming
%% initial parameter
close all;clear all;clc;
M=5;               % array number
N=5;                % number of sources
ss=90;              % snapshot
j=sqrt(-1);

%% SIGNAL RECEIVED
X=Anti_jam();
%% COVIARIANCE MATRIX
R=X*X'/ss;
Inv_Rx = inv(R);
d=0.2;
fc=1575*10^6;

A_s = steeringvector(d, fc, M, 4, [35 40 45 67]);
A_i = steeringvector(d, fc, M, 1, 5);
As = [A_s(:, 1:4) A_i];
f = [1 1 1 1 0]';
W_opt=Inv_Rx*As*inv(As'*Inv_Rx*As)*f;  
W_opt=W_opt/sqrt(W_opt'*W_opt);
%% pattern
phi=-89:1:90;
a=exp(-j*pi*(0:M-1)'*sin(phi*pi/180));
F=W_opt'*a;
G=abs(F).^2./max(abs(F).^2);
G_dB=10*log10(G);
figure(2);
plot(phi,G_dB,'linewidth',2);legend('M=20,d=0.2');
xlabel('Angle (\circ)');ylabel('Magnitude (dB)');
grid on;

% %%
% freq_dopp = linspace(-5e3,5e3,301);          % Woodward ambiguity function
% WAF = zeros(length(signal),length(freq_dopp));
% for i=1:length(freq_dopp)
%     fasor = exp(-1j*2*pi*freq_dopp(i).*time_s)';
%     WAF(:,i) = fftshift(ifft(fft(fasor.*signal).*conj(SIGNAL)));
% end
% WAF = WAF/sqrt(length(signal));
% 
% 
% figure(2)
%         mesh(freq_dopp/1e3,time_s*1e3,abs(WAF).^2);
%         title('WAF');
%         xlabel('Doppler (kHz)');
%         ylabel('delay (ms)'); 
%         xlim([0 0.1]);

