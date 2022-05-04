clc;
clear;
delete(findall(0, 'Type', 'figure'));

% STEP a: Simulating the Narrowband Sources %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
p = 1; % Number of time snapshots
fc = 1575.42*10^6;
M = 20; % Number of array elements, i.e., sensors or antennas
q = 1; % Number of jamming signals

cSpeed = 3*10^8 ; % Speed of light
dist = 0.2; % Sensors (i.e., antennas) spacing in meters
t = 0:(1/3069000):1;                   

%Jamming

A_a=50;
A_j = sqrt(A_a*A_a + 10);  %asssuming 10dB more power of jamming signal
sigma_third_term = zeros(1, 3069001);   % jamming element 
doa_jamming=5;
A_phi = steeringvector(dist,fc,M,q,doa_jamming);

for i =1:q % q = 2
    s_j = A_j.*sin(200*pi*fc*t);
    aj = A_phi(:,i)*s_j;
    sigma_third_term = sigma_third_term + aj;
end

x = awgn(get_signal()+sigma_third_term,5);
% STEP b: Mixing the sources and getting the sensor signals %%%%%%%%%%%%%%

% STEP c: Estimating the covariance matrix of the sensor array %%%%%%%%%%%
R = (x*x')/p; % Empirical covariance of the antenna data
% STEP c: Estimating the covariance matrix of the sensor array %%%%%%%%%%%

  
% STEP d: Finding the noise subspace and estimating the DOAs %%%%%%%%%%%%%
[V, D] = eig(R);
noiseSub = V(:, 1:M-q); % Noise subspace of R
jamsubspace=D(:,1:q);
I=eye(M);
orth_proj=I-(jamsubspace*(conj(jamsubspace))')/det((noiseSub*(conj(noiseSub))'));
herm=(conj(orth_proj))';

antijam=herm*x;
  


% theta = 0:1:180; %Peak search
% a = zeros(M, length(theta));
% res = zeros(length(theta), 1);
% for i = 1:length(theta)
%     a(:, i) = exp(-1i*2*pi*fc*dist*cosd(i)*(1/cSpeed)*[0:M-1]');
%     res(i, 1) = 1/(norm(a(:, i)'*noiseSub).^2);
% end
% 
% [resSorted, orgInd] = sort(res, 'descend');
% DOAs = orgInd(1:q, 1);
% 
figure;
plot(t,antijam);
% xlabel('Angle (deg)');
% ylabel('1/Norm^2');
% title ('Estimation of DOAs over the different noise variances')
grid;