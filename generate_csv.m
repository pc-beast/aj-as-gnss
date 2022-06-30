for i = 1:5
  doa_authentic = randi(79, 1, 4) + 11; %random number between 11 to 90
  doa_spoofed = randi(10, 1, 4) %random number between 1 to 10
  doa_jamming = randi(10);
  num_antennas = 10
  amplitudes_authentic = randi(50, 1, 4);
  x_t, r_t = sig_gen(doa_authentic, doa_spoofed, doa_jamming, amplitudes_authentic, num_antennas);
end