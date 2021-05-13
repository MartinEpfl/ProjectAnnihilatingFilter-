%simple analysis

clc;
clear all;

% this analysis is made to be sure that algorithm works fine
fs= 400; % hz (sampling freqs)
numSamples=800;
t= (0:1/fs:(numSamples-1)/fs).';

f1=120;
f2=160;

x1=sin(2*pi*f1*t);
x2=sin(2*pi*f2*t);
x=x1+x2;
noise=10*randn(length(x),1);
x=x+noise;

[freqs,b,i,j]=annihiliatingFilterImproved(x(1:8),fs,0.1);
figure;
plot(x(1:8),'*');
hold on;
plot(b,'.-');
