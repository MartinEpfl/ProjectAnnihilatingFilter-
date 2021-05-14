%simple analysis

clc;
clear all;

% this analysis is made to be sure that algorithm works fine
fs= 400; % hz (sampling freqs)
numSamples=200;
t= (0:1/fs:(numSamples-1)/fs).';
f1=120;
f2=160;

plotLineSpectraM([f1,f2,-f1,-f2],0.5*ones(1,4),fs,4);
% line spectra of the generated signal
title(' Magnidute Line Spectra of the Generated Signal');

x1=sin(2*pi*f1*t);
x2=sin(2*pi*f2*t);
x=x1+x2;
noisefactor=0.3;
k=16;  % number of frequencies we want to find
noise=noisefactor*randn(length(x),1);
x_noisy=x+noise;

errorTolerance=1;
[freqs,amplitudes,estSignal,i,j,success]=annihiliatingFilterImproved(x_noisy,fs,k,errorTolerance * noisefactor^2*length(x_noisy));
figure;
plot(x_noisy(1:20),'g.-'); hold on;
plot(x(1:20),'b*-'); plot(estSignal(1:20),'r*-');
legend('Noisy signal','Noiseless Signal','Est. Noiseless Signal');
title('Time Evolution of The Signals');

plotLineSpectraM(freqs,amplitudes,fs,length(freqs));
title('Estimated Line Spectra');

