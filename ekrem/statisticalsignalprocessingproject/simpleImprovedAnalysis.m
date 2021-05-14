%simple analysis

clc;
clear all;

% this analysis is made to be sure that algorithm works fine
fs= 400; % hz (sampling freqs)
numSamples=200;
t= (0:1/fs:(numSamples-1)/fs).';
f1=120;
f2=160;

x1=sin(2*pi*f1*t);
x2=sin(2*pi*f2*t);
x=x1+x2;
noisefactor=0.5;
noise=noisefactor*randn(length(x),1);
x_noisy=x+noise;

[freqs,b,i,j]=annihiliatingFilterImproved(x_noisy,fs,4,noisefactor^2*length(x));
figure;
plot(x_noisy(1:20),'g.-');
hold on;
plot(x(1:20),'b*-');
plot(b(1:20),'r*-');
legend('Noisy signal','Noiseless Signal','Estimated Signal');

