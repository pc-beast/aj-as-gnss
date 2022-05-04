function antispoof = Anti_spoof()

% STEP a: Simulating the Narrowband Sources %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
p = 1; % Number of time snapshots

M = 20; % Number of array elements, i.e., sensors or antennas
s = 1; % Number of jamming signals

t = 0:(1/3069000):1;                   

%Jamming

x = Anti_jam();
% STEP b: Mixing the sources and getting the sensor signals %%%%%%%%%%%%%%

% STEP c: Estimating the covariance matrix of the sensor array %%%%%%%%%%%
R = (x*x')/p; % Empirical covariance of the antenna data
% STEP c: Estimating the covariance matrix of the sensor array %%%%%%%%%%%

  
% STEP d: Finding the noise subspace and estimating the DOAs %%%%%%%%%%%%%
[V, D] = eig(R);
noiseSub = V(:, 1:M-s); % Noise subspace of R
spoofsubspace=D(:,1:s);
I=eye(M);
orth_proj=I-(spoofsubspace*(conj(spoofsubspace))')/det((noiseSub*(conj(noiseSub))'));
herm=(conj(orth_proj))';

antispoof=herm*x;
figure(4)
subplot(2,1,1)
disp(size(antispoof));
plot(t, antispoof,'g-');
xlim([0 0.00001])
subplot(2,1,2)

end
