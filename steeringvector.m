function A = steeringvector(dist, fc, M, N, doa)
    cSpeed = 3*10^8;
    A = zeros(M,N);
    for k = 1:N
        A(:, k) = exp(-1i*2*pi*fc*dist*cosd(doa(k))*(1/cSpeed)*[0:M-1]'); 
    end
end

