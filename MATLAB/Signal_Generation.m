clc;
clear all;
close all;

%Signals frequencies
f_half_1_3_KHz=[500,1000,3000];                
                
sampling_rate = 48000;         % Sampling rate of sine waves in Hz
[audio_sig]=audioread('can_recording.wav');
% multiplying audio signal by a factor of 6
audio_sig=audio_sig*7;

% Time vector
t = 0:1/sampling_rate:0.005;
t_audio=0:1/sampling_rate:(length(audio_sig)-1)*1/sampling_rate;

%noise
%noise = (0.5*sin(2*pi*30000*t)).*(0.8*cos(2*pi*40000*t));
noise = normrnd(0, sqrt(0.09), 1, length(t)); % Generate AWGN with variance 0.09

% Generate signals
%noise_audio = (0.5*sin(2*pi*30000*t_audio)).*(0.8*cos(2*pi*40000*t_audio));
noise_audio = normrnd(0, sqrt(0.09), 1, length(t_audio));
audio_noisy=transpose(audio_sig)+noise_audio;

signal_500 = (sin(2*pi*f_half_1_3_KHz(1)*t));
noisy_signal_500 = noise + signal_500;
fixed_noisy_signal_500=fi(noisy_signal_500,true,16,14);
write_to_file("input_sig_half_KHz.txt",fixed_noisy_signal_500,1);

signal_1000 = (sin(2*pi*f_half_1_3_KHz(2)*t));
noisy_signal_1000 = noise + signal_1000;
fixed_noisy_signal_1000=fi(noisy_signal_1000,true,16,14);
write_to_file("input_sig_1_KHz.txt",fixed_noisy_signal_1000,1);

signal_3000 = (sin(2*pi*f_half_1_3_KHz(3)*t));
noisy_signal_3000 =  noise+signal_3000;
fixed_noisy_signal_3000=fi(noisy_signal_3000,true,16,14);
write_to_file("input_sig_3_KHz.txt",fixed_noisy_signal_3000,1);

%Writing audio signal
fixed_audio_signal=fi(audio_noisy,true,16,14);
write_to_file("input_audio.txt",fixed_audio_signal,1);


% Filter Specifications
order = 50;                   % Filter order
cutoff_frequency = 1e3;       % Cutoff frequency in Hz


% Design the FIR filter using Hamming window
fir_coefficients = fir1(order, cutoff_frequency/(sampling_rate/2),'low',hamming(order+1));

[h,n]=impz(fir_coefficients,1);
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
fixed_fir_coefficients=fi(fir_coefficients,true,16,15);
write_to_file('fir_coeff.txt',fixed_fir_coefficients,0);


filtered_noisy_signal_500 = filter(fir_coefficients, 1, noisy_signal_500);
csvwrite("output_sig_half_KHz.txt",transpose(filtered_noisy_signal_500));

filtered_noisy_signal_1000 = filter(fir_coefficients, 1, noisy_signal_1000);
csvwrite("output_sig_1_KHz.txt",transpose(filtered_noisy_signal_1000));

filtered_noisy_signal_3000 = filter(fir_coefficients, 1, noisy_signal_3000);
csvwrite("output_sig_3_KHz.txt",transpose(filtered_noisy_signal_3000));

filtered_audio_signal=filter(fir_coefficients, 1, audio_noisy);
csvwrite('output_audio.txt',transpose(filtered_audio_signal));

%Write filtered audio in wav form to can hear it
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
         

 




