function antijam = anti_jam()

% STEP a: Simulating the Narrowband Sources %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
p = 1; % Number of time snapshots
fc = 1575.42*10^6;
M = 20; % Number of array elements, i.e., sensors or antennas
q = 1; % Number of jamming signals

cSpeed = 3*10^8 ; % Speed of light
dist = 0.2; % Sensors (i.e., antennas) spacing in meters
t = 0:(1/3069000):1;                   

%Jamming

jamm = get_jamming();
rs = get_signal();
x = awgn(rs+jamm,5);
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
plot(t, antijam);
hold on;
plot(t, rs);
hold off;

end
