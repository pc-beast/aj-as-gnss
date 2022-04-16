function x = cacode(svnum)
n=3; 
b = importdata('codes_L1CA.mat');
I = b(:,svnum).';
S = [];
for i = 1:1000
    S = [S,I];
end
bitrate = 1023e3;
disp(bitrate);
T = length(S)/bitrate;
N = n*length(S);  %total number of samples
dt = T/N;
t = 0:dt:T;
x = zeros(1,length(t));
for i=1:length(S)
  if S(i)==1
    x((i-1)*n+1:i*n) = 1;
  else
    x((i-1)*n+1:i*n) = -1;
  end
end
figure(1)
plot(t,x);
xlabel('Time axis'); 
ylabel('Amplitude'); 
title('C/A Code');
xlim([0 1]);
end