%% x_t: original signal
%% r_s: signal with spoofing only
%% r_t: signal with spoofing and jamming

for i = 1:5
  doa_authentic = randi(79, 1, 4) + 11; %random number between 11 to 90
  doa_spoofed = randi(10, 1, 4) %random number between 1 to 10
  doa_jamming = randi(10);
  num_antennas = 10; % fixing number of antennas
  amplitudes_authentic = randi(50, 1, 4);
  x_t, r_t, r_s = sig_gen(doa_authentic, doa_spoofed, doa_jamming, amplitudes_authentic, num_antennas);
  save_data(doa_authentic, doa_jamming, doa_spoofed, amplitudes_authentic, r_s, r_t, x_t, i);
end