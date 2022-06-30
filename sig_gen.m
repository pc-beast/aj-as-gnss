function x_t, r_t = sig_gen(doa_authentic, doa_spoofed, doa_jamming, amplitudes_authentic, num_antennas)
  fc = 1575.42*10^6; % frequency
  M = num_antennas; % number of antennas
  q = 1; %number of jammers
  c = 3*10^8; % speed of light
  dist = 0.2; % distance between antennas
  jamm = get_jamming(amplitudes_authentic, doa_jamming, dist, M, q);
  rs, sigma_first_term = get_signal(fc, d, doa_authentic, doa_spoofed);
  x_t = sigma_first_term;
  r_t = awgn(rs+jamm,5);
end