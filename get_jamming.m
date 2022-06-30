function jamm = get_jamming(amplitudes_authentic, doa_jamming, dist, fc, M, q)

A_a=sum(amplitudes_authentic)/length(amplitudes_authentic);
A_j = sqrt(A_a*A_a + 10);  %asssuming 10dB more power of jamming signal
sigma_third_term = zeros(1, 3069001);   % jamming element 
A_phi = steeringvector(dist,fc,M,q,doa_jamming);

t = 0:(1/3069000):1;                   
for i =1:q
    s_j = A_j.*sin(200*pi*fc*t)+5*rand;
    aj = A_phi(:,i)*s_j;
    sigma_third_term = sigma_third_term + aj;
end

jamm = sigma_third_term;

end