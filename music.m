% Direction of Arrival Estimation, i.e., Spatial Spectrum Estimation

% MUSIC: Multiple Signal Classification
clc;
clear;
delete(findall(0, 'Type', 'figure'));

% STEP a: Simulating the Narrowband Sources %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
p = 100; % Number of time snapshots
fs = 10^7; % Sampling frequency
% fc = 10^6; % Center frequency of narrowband sources
fc = 1575.42*10^6;
M = 20; % Number of array elements, i.e., sensors or antennas
N = 5; % Number of sources
sVar = 1; % Variance of the amplitude of the sources

% p snapshots of N narrowband sources with random amplitude of mean zero
% and covariance 1
s = sqrt(sVar)*randn(N, p).*exp(1i*(2*pi*fc*repmat([1:p]/fs, N, 1)));
% STEP a: Simulating the Narrowband Sources %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% STEP b: Mixing the sources and getting the sensor signals %%%%%%%%%%%%%%
doa = [20; 50; 85; 110; 145]; %DOAs
cSpeed = 3*10^8 ; % Speed of light
dist = 150; % Sensors (i.e., antennas) spacing in meters

% Constructing the Steering matrix
% A = zeros(M, N);
% for k = 1:N
%     A(:, k) = exp(-1i*2*pi*fc*dist*cosd(doa(k))*(1/cSpeed)*[0:M-1]'); 
% end

noiseCoeff = 1; % Variance of added noise
% x = A*s + sqrt(noiseCoeff)*randn(M, p); % Sensor signals
x = get_signal();
% STEP b: Mixing the sources and getting the sensor signals %%%%%%%%%%%%%%


% STEP c: Estimating the covariance matrix of the sensor array %%%%%%%%%%%
R = (x*x')/p; % Empirical covariance of the antenna data
% STEP c: Estimating the covariance matrix of the sensor array %%%%%%%%%%%


% STEP d: Finding the noise subspace and estimating the DOAs %%%%%%%%%%%%%
[V, D] = eig(R);
noiseSub = V(:, 1:M-N); % Noise subspace of R

theta = 0:1:180; %Peak search
a = zeros(M, length(theta));
res = zeros(length(theta), 1);
for i = 1:length(theta)
    a(:, i) = exp(-1i*2*pi*fc*dist*cosd(i)*(1/cSpeed)*[0:M-1]');
    res(i, 1) = 1/(norm(a(:, i)'*noiseSub).^2);
end

[resSorted, orgInd] = sort(res, 'descend');
DOAs = orgInd(1:N, 1);
% STEP d: Finding the noise subspace and estimating the DOAs %%%%%%%%%%%%%

%%
clc;
clear;
delete(findall(0, 'Type', 'figure'));

% STEP e: Repeating the experiment for different parameters %%%%%%%%%%%%%%
DOAs1 = [];
DOAs2 = [];
DOAs3 = [];
p = 100; % Number of time snapshots
fs = 10^7; % Sampling frequency
% fc = 10^6 ; % Center frequency of narrowband sources
fc = 1575.42*10^6;
M = 20; % Number of array elements, i.e., sensors or antennas
N = 8; % Number of sources
doa = [20; 50; 85; 110; 145]; %DOAs
cSpeed = 3*10^8 ; % Speed of light

%%% PART 1, repeating for different noise variances
dist = 150;
sVar = 1;

% s = sqrt(sVar)*randn(N, p).*exp(1i*(2*pi*fc*repmat([1:p]/fs, N, 1)));
s = get_signal();

% A = zeros(M, N);
% for k = 1:N
%     A(:, k) = exp(-1i*2*pi*fc*dist*cosd(doa(k))*(1/cSpeed)*[0:M-1]'); 
% end

noiseV = [1, 5, 10, 20, 35, 50];
for i = 1:size(noiseV, 2)
    noiseCoeff = noiseV(i); % Variance of added noise
    
    x = s; % Sensor signals
    R = (x*x')/p; % Empirical covariance of the antenna data
    
    [V, D] = eig(R);
    noiseSub = V(:, 1:M-N); % Noise subspace of R
    
    theta = 0:1:180; %Peak search
    a = zeros(M, length(theta));
    res = zeros(length(theta), 1);
    for j = 1:length(theta)
        a(:, j) = exp(-1i*2*pi*fc*dist*cosd(j)*(1/cSpeed)*[0:M-1]');
        res(j, 1) = 1/(norm(a(:, j)'*noiseSub).^2);
    end
    [resSorted, orgInd] = sort(res, 'descend');
    DOAs1 = [DOAs1, orgInd(1:N, 1)]; 
    
    figure;
    plot(res);
    xlabel('Angle (deg)');
    ylabel('1/Norm^2');
    title ('Estimation of DOAs over the different noise variances')
    grid;
    
    % According to the results, we can infer that there is a negative correlation
    % between the noise variance and the accuracy of estimation, i.e., the latter
    % decreases as we increase the former. This is because the peaks are became
    % less sharp and some fake peaks are generated in some cases.
    
    % If we start from the largest eigen value to the smallest one in the 
    % corresponding diagonal matrix and calculate the difference between
    % i-th and (i-1)-th eigen values, we observe that for low noise cases,  
    % there are approximately M-N larger eigen values which among them, the  
    % difference between i-th and (i-1)-th one is much greater than the
    % corresponding figure for the remaining eigen values. Hence we can
    % conclude that M-N is the number of sources.
    
    % This function can give an estimation of the number of sources
    disp (['Estimated number of sources (noise variance = ', ...
        num2str(noiseCoeff),'): ', num2str(numSources(D))]);
    
end