function save_data(doa_authentic, doa_jamming, doa_spoofed, amplitudes_authentic, r_s, r_t, x_t, i)
    doa_authentic_path = 'D:/dataset/doa_authentic/' + string(i) + '.mat';
    doa_jamming_path = 'D:/dataset/doa_jamming/' + string(i) + '.mat';
    doa_spoofed_path = 'D:/dataset/doa_spoofed/' + string(i) + '.mat';
    amplitudes_authentic_path = 'D:/dataset/amplitudes_authentic/' + string(i) + '.mat';
    r_s_path = 'D:/dataset/r_s/' + string(i) + '.mat';
    r_t_path = 'D:/dataset/r_t/' + string(i) + '.mat';
    x_t_path = 'D:/dataset/x_t/' + string(i) + '.mat';

    save(doa_authentic_path, 'doa_authentic');
    save(doa_jamming_path, 'doa_jamming');
    save(doa_spoofed_path, 'doa_spoofed');
    save(amplitudes_authentic_path, 'amplitudes_authentic');
    save(r_s_path, 'r_s');
    save(r_t_path, 'r_t');
    save(x_t_path, 'x_t');
end