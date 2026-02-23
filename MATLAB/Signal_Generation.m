clc;
clear all;
close all;

% Signals frequencies
f_half_1_3_KHz = double([500,1000,3000]);                
                
sampling_rate = double(48000);         % Sampling rate of sine waves in Hz
[audio_sig] = audioread('can_recording.wav');
audio_sig = double(audio_sig);

% multiplying audio signal
audio_sig = double(audio_sig * 7);

% Time vector
t = double(0:1/sampling_rate:0.005);
t_audio = double(0:1/sampling_rate:(length(audio_sig)-1)*1/sampling_rate);

% noise
noise = double(normrnd(0, sqrt(0.09), 1, length(t))); % AWGN

% Generate signals
noise_audio = double(normrnd(0, sqrt(0.09), 1, length(t_audio)));
audio_noisy = double(transpose(audio_sig) + noise_audio);

signal_500  = double(sin(2*pi*f_half_1_3_KHz(1)*t));
noisy_signal_500 = double(noise + signal_500);
fixed_noisy_signal_500 = fi(noisy_signal_500,true,16,14);
write_to_file("input_sig_half_KHz.txt",fixed_noisy_signal_500,1);

signal_1000 = double(sin(2*pi*f_half_1_3_KHz(2)*t));
noisy_signal_1000 = double(noise + signal_1000);
fixed_noisy_signal_1000 = fi(noisy_signal_1000,true,16,14);
write_to_file("input_sig_1_KHz.txt",fixed_noisy_signal_1000,1);

signal_3000 = double(sin(2*pi*f_half_1_3_KHz(3)*t));
noisy_signal_3000 = double(noise + signal_3000);
fixed_noisy_signal_3000 = fi(noisy_signal_3000,true,16,14);
write_to_file("input_sig_3_KHz.txt",fixed_noisy_signal_3000,1);

% Writing audio signal
fixed_audio_signal = fi(double(audio_noisy),true,16,14);
write_to_file("input_audio.txt",fixed_audio_signal,1);

% Filter Specifications
order = double(50);                   
cutoff_frequency = double(1e3);       

% Design the FIR filter using Hamming window
fir_coefficients = double(fir1(order, cutoff_frequency/(sampling_rate/2),'low',hamming(order+1)));

[h,n] = impz(fir_coefficients,1);

figure
stem(n,h);
xlabel('sample number')
ylabel('Amplitude')
title('Impulse response')

figure
freqz(fir_coefficients, 1,[],sampling_rate);
title('Frequency Magnitude & Phase Response')

figure
zplane(fir_coefficients,1)

% Apply filter to the inputs
fixed_fir_coefficients = fi(double(fir_coefficients),true,16,15);
write_to_file('fir_coeff.txt',fixed_fir_coefficients,0);

filtered_noisy_signal_500  = double(filter(fir_coefficients, 1, noisy_signal_500));
csvwrite("output_sig_half_KHz.txt",transpose(filtered_noisy_signal_500));

filtered_noisy_signal_1000 = double(filter(fir_coefficients, 1, noisy_signal_1000));
csvwrite("output_sig_1_KHz.txt",transpose(filtered_noisy_signal_1000));

filtered_noisy_signal_3000 = double(filter(fir_coefficients, 1, noisy_signal_3000));
csvwrite("output_sig_3_KHz.txt",transpose(filtered_noisy_signal_3000));

filtered_audio_signal = double(filter(fir_coefficients, 1, audio_noisy));
csvwrite('output_audio.txt',transpose(filtered_audio_signal));

% Write filtered audio
audiowrite('filtered_audio.wav',filtered_audio_signal,sampling_rate);

figure
plot(t_audio,audio_sig);
xlabel('time (s)')
ylabel('Amplitude')
title('Audio signal without noise')

figure
plot(t_audio,audio_noisy)
xlabel('time (s)')
ylabel('Amplitude')
title('Audio signal with noise')

figure
plot(t_audio,filtered_audio_signal)
xlabel('time (s)')
ylabel('Amplitude')
title('Filtered Audio signal')

figure
plot(t*1000,signal_500)
xlabel('time (ms)')
ylabel('Amplitude')
title('500 Hz signal without noise')

figure
plot(t*1000,signal_1000)
xlabel('time (ms)')
ylabel('Amplitude')
title('1 KHz signal without noise')

figure
plot(t*1000,signal_3000)
xlabel('time (ms)')
ylabel('Amplitude')
title('3 KHz signal without noise')

figure
plot(t*1000,noisy_signal_500)
xlabel('time (ms)')
ylabel('Amplitude')
title('500 Hz signal with noise')

figure
plot(t*1000,noisy_signal_1000)
xlabel('time (ms)')
ylabel('Amplitude')
title('1 KHz signal with noise')

figure
plot(t*1000,noisy_signal_3000)
xlabel('time (ms)')
ylabel('Amplitude')
title('3 KHz signal with noise')

figure
plot(t*1000,filtered_noisy_signal_500)
xlabel('time (ms)')
ylabel('Amplitude')
title('Filtered 500 Hz signal')

figure
plot(t*1000,filtered_noisy_signal_1000)
xlabel('time (ms)')
ylabel('Amplitude')
title('Filtered 1 KHz signal')

figure
plot(t*1000,filtered_noisy_signal_3000)
xlabel('time (ms)')
ylabel('Amplitude')
title('Filtered 3 KHz signal')
