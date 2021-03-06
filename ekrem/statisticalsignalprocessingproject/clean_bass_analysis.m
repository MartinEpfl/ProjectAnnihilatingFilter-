clc;
clear all;

[data,fs]=audioread("data/Clean Bass.wav");

data=data(:,1); %% stereo signal is unnecessary one component is enough
data=data(1:6*fs);
data=data.'; % make it row vector
my_tfplot(data,fs,'y(f)','Clean Bass Fourier Full Signal',1);
downsamp=40;  % a lot of redundancy, downsample to analyze it better
data=downsample(data,downsamp);
fs=fs/downsamp;

my_tfplot(data,fs,'y(f)','Clean Bass Fourier Full Signal',3);

% working with this much sample is impossible

%% First Interval correct retrieval

% let us take a small portion
timeInterval=0.3; %s (this value is important if too small, no freq is observed)
beginTime=4.15;
% this value should be somewhere in beginning of a vibration
%  4.15 is one of them

%timeInterval is analysis duration
%they should be inside one musical note
%duration. If we are between 2 musical notes, discrete spectrum features
%are getting distorted.annihilating filter solution assumptions are the
%signal in sum of complex sinusoids
% sometimes the rcond of amplitude matrix is too low, then the observations
%does not mean anything because we are finding too many spectral lines
% and if we can not sort them we do not have a valuable information
% when that happens, giving less samples to the algorithm works,
%so first start with timrInterval=0.3 s. because the frequency precision
%is the best in this value. if the amplitude matrix is too low,
% then decrease the time interval, for example to 0.1. We have worse
% results in terms of precision of frequencies, but we have the amplitudes

beginSample=round(beginTime*fs);
numSamples=round(timeInterval*fs); % number of samples for the selected data

chunkData=data(beginSample:beginSample+numSamples);
chunkData=chunkData-mean(chunkData);

% plotting the new data
my_tfplot(chunkData,fs,'y(f)'...
    ,sprintf('Clean Bass %.2f to %.2f s',beginTime,beginTime+timeInterval),1);
% result
[freqs,amplitudes,rcondF,rcondA] = annihiliatingFilterSimple(chunkData,fs);

%sometimes frequencies are retrieved but the amplitude matrix is almost
%singular that we can not find the 

if(rcondA<1e-3)
    plotLineSpectraF(freqs,fs,28);
    title("Estimated Frequencies")
else
    plotLineSpectraM(freqs,amplitudes,fs,28);
    title("Estimated Line Spectra")

end

% pathological states


% by trial and error(in the second segment of the code)
% 0.3 s time interval is the best if we take the beginning of the vibration
% sometimes Amplitude can not be estimated or poorly estimated or can not
%be estimated, then decreasing the interval sometimes work

%% Full Analysis

%below, different portions of the signal is taken and 
% annihiliating filter method is applied, if the cond number if
% amplitude matrix is not good enough, number of given samples is changed


wholeFreqs=[];
wholeAmps=[];

for beginTime=[0.01:0.2:5.69]
    
    beginSample=floor(beginTime*fs);
    chunkData=data(beginSample:beginSample+numSamples);
    chunkData=chunkData-mean(chunkData);
    [freqs,amplitudes,rcondF,rcondA] = annihiliatingFilterSimple(chunkData,fs);
    if(rcondA>1e-3)
        wholeFreqs=[wholeFreqs;freqs(1:40)];
        wholeAmps = [wholeAmps ; abs(amplitudes(1:40))];
        
        
    else
        chunkData=data(beginSample:beginSample+floor(numSamples/3));
        chunkData=chunkData-mean(chunkData);
        [freqs,amplitudes,rcondF,rcondA] = annihiliatingFilterSimple(chunkData,fs);
        if(rcondA>1e-3)
            wholeFreqs=[wholeFreqs;freqs(1:40)];
            wholeAmps = [wholeAmps ; abs(amplitudes(1:40))];
        else
            chunkData=data(beginSample:beginSample+floor(numSamples/6));
            chunkData=chunkData-mean(chunkData);
            [freqs,amplitudes,rcondF,rcondA] = annihiliatingFilterSimple(chunkData,fs);
            if(rcondA>1e-3)
                wholeFreqs=[wholeFreqs;freqs(1:28)];
                wholeAmps = [wholeAmps ; abs(amplitudes(1:28))];
            end
            
        end
    end
    
    

end

% printing all observations

[sWholeFreqs, sWholeAmps]=takeGreatest(wholeFreqs,wholeAmps,0);
plotLineSpectraM(sWholeFreqs,sWholeAmps,fs,length(wholeAmps));




