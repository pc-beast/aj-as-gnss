function jamm = get_jamming()

A_a=50;
A_j = sqrt(A_a*A_a + 10);  %asssuming 10dB more power of jamming signal
sigma_third_term = zeros(1, 3069001);   % jamming element 
doa_jamming=5;
dist=0.2;
fc=1575.42*10^6;
M=20;
q=1;
A_phi = steeringvector(dist,fc,M,q,doa_jamming);

t = 0:(1/3069000):1;                   
for i =1:q
    s_j = A_j.*sin(200*pi*fc*t);
    aj = A_phi(:,i)*s_j;
    sigma_third_term = sigma_third_term + aj;
end

jamm = sigma_third_term;

end