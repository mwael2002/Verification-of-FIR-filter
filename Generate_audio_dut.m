filtered_audio_dut=csvread("output_dut_audio.txt");
audiowrite('output_dut_audio.wav', filtered_audio_dut, 48000);