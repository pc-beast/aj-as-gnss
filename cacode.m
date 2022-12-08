function x = cacode(svnum)
n=3; 
b = importdata('codes_L1CA.mat');
I = b(:,svnum).';
S = [];
for i = 1:10
    S = [S,I];
end
bitrate = 1023e2/2;
T = (length(S)/bitrate);
N = n*length(S);  %total number of samples
dt = T/N;
%disp(dt);
%dt = 1/306900;
%t = 0:dt:T/4;
t = 0:(2/306900):0.25;
x = zeros(1,length(t));
for i=1:length(S)
  if S(i)==1
    x((i-1)*n+1:i*n) = 1;
  else
    x((i-1)*n+1:i*n) = -1;
  end
end
% figure(1)
% plot(t,x);
% xlabel('Time axis'); 
% ylabel('Amplitude'); 
% title('C/A Code');
% xlim([0 1]);
end