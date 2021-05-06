clc;
clear all;

% this analysis is made to be sure that algorithm works fine
fs= 400; % hz (sampling freqs)
numSamples=200;
t= 0:1/fs:(numSamples-1)/fs;

% creating signal with 2 sinus values to test the fnc.
f1=110; x1=sin(2*pi*f1*t);
f2=160; x2=sin(2*pi*f2*t);
f3=180; x3=sin(2*pi*f3*t);
f4=20; x4=sin(2*pi*f4*t);
x=x1+x2+x3+x4;

my_tfplot(x,fs,'s','Sum of 2 Sinus');
[freqs, amplitudes ]= annihiliatingFilterSimple(x(1:16),fs);









