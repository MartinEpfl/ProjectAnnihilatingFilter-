clc;
clear all;

% this analysis is made to be sure that algorithm works fine
fs= 500; % hz (sampling freqs)
numSamples=100;
t= 0:1/fs:(numSamples-1)/fs;

% creating signal with 2 sinus values to test the fnc.
f1=120; x1=sin(2*pi*f1*t);
f2=160; x2=sin(2*pi*f2*t);
x=x1+x2;

my_tfplot(x,fs,'s','Sum of 2 Sinus');
[freqs, amplitudes ]= annihiliatingFilterSimple(x(1:20),fs);







