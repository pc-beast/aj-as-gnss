function save_data(doa_authentic, doa_jamming, doa_spoofed, amplitudes_authentic, r_s, r_t, x_t, i)
    doa_authentic_path = './dataset/doa_authentic/' + str(i) + '.mat';
    doa_jamming_path = './dataset/doa_jamming/' + str(i) + '.mat';
    doa_spoofed_path = './dataset/doa_spoofed/' + str(i) + '.mat';
    amplitudes_authentic = './dataset/amplitudes_authentic/' + str(i) + '.mat';
    r_s_path = './dataset/r_s/' + str(i) + '.mat';
    r_t_path = './dataset/r_t/' + str(i) + '.mat';
    x_t_path = './dataset/x_t/' + str(i) + '.mat';

    save(doa_authentic_path, 'doa_authentic');
    save(doa_jamming_path, 'doa_jamming');
    save(doa_spoofed_path, 'doa_spoofed');
    save(amplitudes_authentic, 'amplitudes_authentic');
    save(r_s_path, 'r_s');
    save(r_t_path, 'r_t');
    save(x_t_path, 'x_t');
end