function r_t = get_signal()
    k = 8; % k : number of signals
    % k = 8 since 4 original signals and 4 spoofed signals\
    rng(2); % for reproducability
    % 4 angles are 0 since they are from spoofers
    f = 1575.42*10^6; % frequency of gps signal
    d = 0.2; % distance between antennas
    aoa_authentic = [35 40 45 67];
    A_theta = steeringvector(d, f, 20, 4, aoa_authentic);
    
    A_a = [60 20 50 35];
    phi_a = (pi/45)*rand(4, 1);
    t = 0:(1/3069000):1;                   
    %prn = mod((nav_message()+cacode(1)),2);
    sigma_first_term = zeros(1, 3069001);     % authentic gps signal
    for i =1:4  % m=4
        signal = nav_message().*cacode(i);
        s_a = A_a(i)*(signal.*sin(2*pi*f*t + phi_a(i)));
        as = A_theta(:,i)*s_a;
        sigma_first_term = sigma_first_term + as;
    end
    %sigma_first_term = sum(first_term);
%     disp(size(sigma_first_term));
    
    %Spoofing
    %-------------------------------------------------------------------------
    A_s = [90 90 90 90];
    phi_s = phi_a - pi/8;
    sigma_second_term = zeros(1, 3069001);   % spoofed element 
    aoa_spoofed = [5 5 5 5];
%     A_phi = steervec(pos/lambda, ang_spoofed);
    A_phi = steeringvector(d, f, 20, 4, aoa_spoofed);
    
    for i =1:4 % n=4
        signal = nav_message().*cacode(i);
        s_s = A_s(i)*(signal.*sin(2*pi*f*t + phi_s(i)));
        ass = A_phi(:,i)*s_s;
        sigma_second_term = sigma_second_term + ass;
    end
    
    disp(size(sigma_second_term));
    
    r_t = sigma_first_term + sigma_second_term;  % authentic signal + spoofed signal
    
%     disp(size(signal));
%     
%     figure(3)
%     plot(t,r_t(1,:));
%     xlabel('Time axis'); 
%     ylabel('Amplitude'); 
%     title('Received Signal'); 
%     grid on 
