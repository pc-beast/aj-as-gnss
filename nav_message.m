function nav = nav_message()
n=50;        % number of bits
%b = 2*(rand(1,n)>0.5)-1;
rng(2); % for reproducability
b = rand(1,n)>0.5;
n = 3069000/50;
bitrate = 50;
%fs = 100; % 2*fm nyquist frequency
T = length(b)/bitrate;
N = n*length(b);
dt = T/N;
t = 0:dt:T;
nav = zeros(1,length(t));
for i=1:length(b)
  if b(i)==1
    nav((i-1)*n+1:i*n) = 1;
  else
    nav((i-1)*n+1:i*n) = -1;
  end
end
% figure(2) 
% plot(t,nav); 
% xlabel('Time axis'); 
% ylabel('Amplitude'); 
% title('Navigation message'); 
% grid on 
end