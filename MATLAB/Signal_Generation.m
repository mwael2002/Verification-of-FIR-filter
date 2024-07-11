%Signals frequencies
f_half_1_3_KHz=[500,1000,3000];                
                
% Time vector
t = 0:1/sampling_rate:0.005;

%noise
noise = (0.5*sin(2*pi*11000*t)).*(0.8*cos(2*pi*9000*t));

% Generate signals

signal_500 = (sin(2*pi*f_half_1_3_KHz(1)*t));
noisy_signal_500 = noise + signal_500;
csvwrite("input_sig_half_KHz.txt",transpose(fraction_to_fixed(noisy_signal_500)));

signal_1000 = (sin(2*pi*f_half_1_3_KHz(2)*t));
noisy_signal_1000 = noise + signal_1000;
csvwrite("input_sig_1_KHz.txt",transpose(fraction_to_fixed(noisy_signal_1000)));

signal_3000 = (sin(2*pi*f_half_1_3_KHz(3)*t));
noisy_signal_3000 = noise + signal_3000;
csvwrite("input_sig_3_KHz.txt",transpose(fraction_to_fixed(noisy_signal_3000)));



% Specifications
order = 50;                     % Filter order
cutoff_frequency = 1e3;       % Cutoff frequency in Hz
sampling_rate = 44.1e3;         % Sampling rate in Hz

% Design the FIR filter using Hamming window
fir_coefficients = fir1(order, cutoff_frequency/(sampling_rate/2), ...
                    'low', hamming(order + 1));

filtered_noisy_signal_500 = filter(fir_coefficients, 1, noisy_signal_500);
filtered_noisy_signal_1000 = filter(fir_coefficients, 1, noisy_signal_1000);
filtered_noisy_signal_3000 = filter(fir_coefficients, 1, noisy_signal_3000);

t = 0:1/sampling_rate:0.005;

plot(t,noisy_signal_500)
figure
plot(t,noisy_signal_1000)
figure
plot(t,noisy_signal_3000)

figure
plot(t,filtered_noisy_signal_500)
figure
plot(t,filtered_noisy_signal_1000)
figure
plot(t,filtered_noisy_signal_3000)


% Scale the signal to fit within the range of a 16-bit integer
scaled_signal = int16(choice * 2^15);
scaled_output = int16(filtered_noisy_signal *(2^15 -1));


