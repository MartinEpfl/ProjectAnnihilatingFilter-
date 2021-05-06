clc;
clear all;

[data,fs]=audioread("data/Clean Bass.wav");
data=data(:,1); %% stereo signal is unnecessary one component is enough
data=data.'; % make it row vector
downsamp=50;  % a lot of redundancy, downsample to analyze it better
data=downsample(data,downsamp);
fs=fs/downsamp;

my_tfplot(data,fs,'y(f)','Clean Bass Fourier Full Signal');

% working with this much sample is impossible

%% First Interval
close all;
% let us take a small portion
timeInterval=0.2; %s (this value is important if too small, no freq is observed)
%( taking a chunk means multiplying with rect, which means convolving with sinc in freq
%domain, sinc should be sharp!! so we need large chunks)
% (if too large then algorithm can not find anything, or diverges)

numSamples=round(timeInterval*fs); % number of samples for the selected data
n=18; % which portion of the real data is taken

chunkData=data((n-1)*numSamples+1:n*numSamples);



% plotting the new data
my_tfplot(chunkData,fs,'y(f)'...
    ,sprintf('Clean Bass %.2f to %.2f s',(n-1)*timeInterval,n*timeInterval));

% result
[freqs,amplitudes] = annihiliatingFilterSimple(chunkData,fs);


%% full analysis

resolution=1; 













