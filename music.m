% Direction of Arrival Estimation, i.e., Spatial Spectrum Estimation

% MUSIC: Multiple Signal Classification

% STEP a: Simulating the Narrowband Sources %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
p = 1; % Number of time snapshots
fs = 10^7; % Sampling frequency
% fc = 10^6; % Center frequency of narrowband sources
fc = 1575.42*10^6;
M = 20; % Number of array elements, i.e., sensors or antennas
N = 5; % Number of sources
sVar = 1; % Variance of the amplitude of the sources

% STEP b: Mixing the sources and getting the sensor signals %%%%%%%%%%%%%%
cSpeed = 3*10^8 ; % Speed of light
dist = 0.2; % Sensors (i.e., antennas) spacing in meters

% Constructing the Steering matrix
% A = zeros(M, N);
% for k = 1:N
%     A(:, k) = exp(-1i*2*pi*fc*dist*cosd(doa(k))(1/cSpeed)[0:M-1]'); 
% end

noiseCoeff = 1; % Variance of added noise
% x = A*s + sqrt(noiseCoeff)*randn(M, p); % Sensor signals
% x = awgn(get_signal(), 5);
x = antijam;
% STEP b: Mixing the sources and getting the sensor signals %%%%%%%%%%%%%%


% STEP c: Estimating the covariance matrix of the sensor array %%%%%%%%%%%
R = (x*x')/p; % Empirical covariance of the antenna data
% STEP c: Estimating the covariance matrix of the sensor array %%%%%%%%%%%

  
% STEP d: Finding the noise subspace and estimating the DOAs %%%%%%%%%%%%%
[V, D] = eig(R);
noiseSub = V(:, 1:M-N); % Noise subspace of R

theta = 0:1:82; %Peak search
a = zeros(M, length(theta));
res = zeros(length(theta), 1);
for i = 1:length(theta)
    a(:, i) = exp(-1i*2*pi*fc*dist*cosd(i)(1/cSpeed)[0:M-1]');
    res(i, 1) = 1/(norm(a(:, i)'*noiseSub).^2);
end

[resSorted, orgInd] = sort(res, 'descend');
DOAs = orgInd(1:N, 1);

figure;
plot(res);
xlabel('Angle (deg)');
ylabel('1/Norm^2');
title ('Estimated DOAs')
grid;