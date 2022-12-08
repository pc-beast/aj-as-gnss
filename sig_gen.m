function [x_t, r_t, rs] = sig_gen(doa_authentic, doa_spoofed, doa_jamming, amplitudes_authentic, num_antennas)
  fc = 1575.42*10^6; % frequency
  M = 10; % number of antennas
  q = 1; %number of jammers
  c = 3*10^8; % speed of light
  dist = 0.2; % distance between antennas d=lambda/2
  jamm = get_jamming(amplitudes_authentic, doa_jamming, dist,fc, M, q);
  [rs, sigma_first_term] = get_signal(fc, dist, doa_authentic, doa_spoofed);
  x_t = sigma_first_term;
  %r_t = awgn(rs+jamm,5);
  r_t = awgn(rs+jamm,5);    
end