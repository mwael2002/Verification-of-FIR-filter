# Verification-of-FIR-filter
## Abstract
### Build a Matlab FIR Lowpass filter Golden Model and Generate 4 input signals 3 of them are sine waves with different frequencies and the fourth is an audio signal obtained from (can_recording.wav) audio recording.
### Add additive white gaussian noise to all the signals.
### Build full UVM environment that has 4 sequence items each one takes one generated signal from Matlab
### Compare the output with the output from the Golden Model in the Scoreboard along with code & functional coverage.
## Notes
### The three signals have frequencies 500 Hz, 1KHz and 3KHz.
### The filter cutoff frequency is 1 KHz.
### Matlab converts both the output golden & DUT audios into wav audio file in order to can hear them.  
### Scoreboard & Coverage collector wotks on the MSB 16 bits of the filtered signal.
## Project running Steps
### 1- Run (run_script.py) script, It will open Matlab and run Matlab script that will generate the golden inputs and outputs values in a txt files in addition to (filtered_audio.wav) file.
### 2- After you close Matlab window, the python script will automatically open Questasim and run tcl script to run the project.
### 3- When Questa project finish running and Questa is closed, the script will automatically run second Matlab script to convert the DUT output audio txt file that was produced by Questa into wav file.
## Matlab plots
### Impulse response
![Alt_text](https://github.com/mwael2002/Verification-of-FIR-filter/blob/main/Screenshot%202024-12-22%20201622.png)
### Frequency response
![Alt text](https://github.com/mwael2002/Verification-of-FIR-filter/blob/main/Screenshot%202024-12-22%20161016.png)
### Z plane
![Alt text](https://github.com/mwael2002/Verification-of-FIR-filter/blob/main/Screenshot%202024-12-22%20015657.png)
### 500 Hz input & output
![Alt text](https://github.com/mwael2002/Verification-of-FIR-filter/blob/main/Screenshot%202024-12-25%20005708.png)
![Alt text](https://github.com/mwael2002/Verification-of-FIR-filter/blob/main/Screenshot%202024-12-22%20015813.png)
![Alt text](https://github.com/mwael2002/Verification-of-FIR-filter/blob/main/Screenshot%202024-12-22%20015842.png)
### 1 KHz input & output
![Alt text](https://github.com/mwael2002/Verification-of-FIR-filter/blob/main/Screenshot%202024-12-25%20005755.png)
![Alt text](https://github.com/mwael2002/Verification-of-FIR-filter/blob/main/Screenshot%202024-12-22%20015823.png)
![Alt text](https://github.com/mwael2002/Verification-of-FIR-filter/blob/main/Screenshot%202024-12-22%20161414.png)
### 3 KHz input & output
![Alt text](https://github.com/mwael2002/Verification-of-FIR-filter/blob/main/Screenshot%202024-12-25%20005946.png)
![Alt text](https://github.com/mwael2002/Verification-of-FIR-filter/blob/main/Screenshot%202024-12-22%20024424.png)
![Alt text](https://github.com/mwael2002/Verification-of-FIR-filter/blob/main/Screenshot%202024-12-22%20015859.png)
### Audio input & output
![Alt text](https://github.com/mwael2002/Verification-of-FIR-filter/blob/main/Screenshot%202024-12-22%20015706.png)
![Alt text](https://github.com/mwael2002/Verification-of-FIR-filter/blob/main/Screenshot%202024-12-22%20015757.png)
![Alt text](https://github.com/mwael2002/Verification-of-FIR-filter/blob/main/Screenshot%202024-12-22%20015804.png)
## Questasim results
### Sine wave signals
![Alt text](https://github.com/mwael2002/Verification-of-FIR-filter/blob/main/Screenshot%202024-12-22%20023656.png)
### Audio signal
![Alt text](https://github.com/mwael2002/Verification-of-FIR-filter/blob/main/Screenshot%202024-12-22%20023823.png)
### Transcript output
![Alt text](https://github.com/mwael2002/Verification-of-FIR-filter/blob/main/Screenshot%202024-12-24%20005448.png)
### Code Coverage
![Alt text](https://github.com/mwael2002/Verification-of-FIR-filter/blob/main/Screenshot%202024-12-24%20005916.png)
### Functional coverage
![Alt text](https://github.com/mwael2002/Verification-of-FIR-filter/blob/main/Screenshot%202024-12-24%20005409.png)
