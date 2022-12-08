function [r_t, sigma_first_term] = get_signal(fc, d, aoa_authentic, aoa_spoofed)
    % 4 angles are 0 since they are from spoofers
    f = fc; % frequency of gps signal
    A_theta = steeringvector(d, f, 10, 4, aoa_authentic);
    
    A_a = [80 80 80 80];
    phi_a = (pi/45)*rand(4, 1);
    t = 0:(2/306900):0.25;                   
    %prn = mod((nav_message()+cacode(1)),2);
    sigma_first_term = zeros(1, 38363);     % authentic gps signal
    for i =1:4  % m=4
        signal = nav_message().*cacode(i);
        %display(length(t));
        s_a = A_a(i)*(signal.*sin(2*pi*f*t + phi_a(i)));
        as = A_theta(:,i)*s_a;
        sigma_first_term = sigma_first_term + as;
    end
    %sigma_first_term = sum(first_term);
%     disp(size(sigma_first_term));
    
    %Spoofing
    %-------------------------------------------------------------------------
    A_s = [120 120 120 120];
    phi_s = phi_a - pi/8;
    sigma_second_term = zeros(1, 38363);   % spoofed element 
    A_phi = steeringvector(d, f, 10, 4, aoa_spoofed);
    
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