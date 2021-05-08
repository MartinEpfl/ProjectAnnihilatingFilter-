clc;
clear all;

% this analysis is made to be sure that algorithm works fine
fs= 400; % hz (sampling freqs)
numSamples=800;
t= 0:1/fs:(numSamples-1)/fs;

numSin=8; %numberOfSinusFunctions to be generated

sinFreqs = rand(numSin,1);
% 0.9 factor is to be sure that we are not at Nyquist limit
sinFreqs = (sinFreqs  * fs/2) *0.9;
data=sin(2*pi*sinFreqs*t);

% defininng random amplitude for each sinus in interval (0.5-1.5)
randomAmps=rand(numSin,1)+0.5;

plotLineSpectra([sinFreqs;-1*sinFreqs],0.5*repmat(randomAmps,2,1),fs,2*numSin);
% line spectra of the generated signal
title(' Magnidute Line Spectra of the Generated Signal');

data=sum(data .* repmat(randomAmps,1,numSamples));
%my_tfplot(data,fs,'s','Sum of Sinus Functions',2);
% normal signal fft

[freqs, amplitudes,rcondF,rcondA]= annihiliatingFilterSimple(data(1:numSin*4),fs);

plotLineSpectra(freqs,amplitudes,fs,2*numSin);
title('Estimated Magnitude Line Spectra');

%% what happens if we give more samples to the algorithm
excessRate=11;
[freqs, amplitudes,rcondF,rcondA]= annihiliatingFilterSimple(data(1:4*numSin*excessRate),fs);

plotLineSpectra(freqs,amplitudes,fs,2*numSin*excessRate);
title('Estimated Magnitude Line Spectra with Excessive Samples');

%excessRate=3 -> rcondf ->9.97e-18 --> figure estimexcess1.eps
%excessRate=11 -> rcondf ->9.97e-19

%% Limitations
% we work with 2 sinus fnc now;
% we try to find the best precision that we can achieve

%difference in normalized freq
diffNorm=1e-6;
diffFreq= diffNorm * 2*fs;
f1=120;
f=[f1 f1+diffFreq]; %Hz
amps=[1 1]; %amplitudes of 2 sinus fnc
x1=amps(1)*sin(2*pi*f(1)*t);
x2=amps(2)*sin(2*pi*f(2)*t);
x=x1+x2;

plotLineSpectra([f -f],0.5*[amps amps],fs,4);
% line spectra of the generated signal
title(' Magnidute Line Spectra of the Generated Signal');

% eight samples are enough
[freqs, amplitudes,rcondF,rcondA]= annihiliatingFilterSimple(x(1:8),fs);

plotLineSpectra(freqs,amplitudes,fs,4);
% line spectra of the generated signal
title(' Estimated Magnidute Line Spectra');

% diffNorm = 1e-6 -> 









