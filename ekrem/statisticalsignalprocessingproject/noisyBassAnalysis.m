%Improved bass analysis

clc;
clear all;

[dataC,fs]=audioread("data/Clean Bass.wav"); % clean data
[dataN,fs]=audioread("data/Noisy Bass.wav"); %noisy data

dataC=dataC(:,1); %% stereo signal is unnecessary one component is enough
dataN=dataN(:,1);
dataN=dataN(1:6*fs);
dataC=dataC(1:6*fs);

downsamp=12;  % a lot of redundancy, downsample to analyze it better
dataC=downsample(dataC,downsamp);
dataN=downsample(dataN,downsamp);
fs=fs/downsamp;
my_tfplot(dataC,fs,'y(f)','Clean Bass FFT Signal',3);

%% observe signal differences between noisy and clean
% epsilon square is found here
numFullS=length(dataC);  t= 0:1/fs:(numFullS-1)/fs;
figure; plot(t,dataN,'r'); hold on; plot(t,dataC,'b');
legend('Noisy Signal','Clean Signal');
ylabel(strcat('s(t)')); xlabel('t[s]'); title('Noisy and Clean Signal Diff.');
diff=dataC-dataN;
epsilon2= diff'*diff / numFullS;

%% now we take portions of data
timeInterval=0.11; %s (this value is important if too small, no freq is observed)
beginTime=1.46;
numFreqs=70;
errorTolerance=1;
% we start to take portions of the data
beginSample=round(beginTime*fs);
numSamples=round(timeInterval*fs); % number of samples for the selected data

chunkC=dataC(beginSample:beginSample+numSamples);
chunkN=dataN(beginSample:beginSample+numSamples);

chunkC=chunkC-mean(chunkC);
chunkN=chunkN-mean(chunkN);

% running the algorithm

[freqs,amplitudes,estSignal,i,j,success] = annihiliatingFilterImproved(chunkN,fs,numFreqs,errorTolerance*numSamples*epsilon2);

% this lime is for estimation of clean signal,do not uncomment if not
% necessary
%[freqs,amplitudes,estSignal,i,j,success] = annihiliatingFilterImproved(chunkC,fs,numFreqs,errorTolerance*numSamples*epsilon2);


t= 0:1/fs:(numSamples)/fs;
figure; plot(t,chunkN,'r'); hold on; plot(t,chunkC,'m'); 
plot(t,estSignal,'b');
legend('Noisy Signal','Clean Signal','Estimated Clean Signal');
ylabel('s(t)'); xlabel('t[s]'); title('Time Evolution of the Signals');

%fft of clean signal
my_tfplot(chunkC,fs,'y(f)','Clean Bass FFT Full Signal',3);

plotLineSpectraM(freqs,amplitudes,fs,numFreqs);
title("Estimated Line Spectra");


%% Full Analysis

%below, different portions of the signal is taken and 
% improved annihiliating filter method is applied, 
% algorithm works best if we take cuts inside the vibration bands

%this value can be changed 
% Decreasing it too much decreases freq resolution but works much faster
%0.06-0.14 interval is fine.
timeInterval=0.1;


numFreqs=24;
numSamples=round(timeInterval*fs);
errorTolerance=1.3;
wholeFreqs=[];
wholeAmps=[];
numSuccess=0;

for beginTime=(0.05:0.2:5.79)
    
    beginSample=floor(beginTime*fs);
    chunkN=dataN(beginSample:beginSample+numSamples);
    chunkN=chunkN-mean(chunkN);
    [freqs,amplitudes,estSignal,i,j,success] = annihiliatingFilterImproved(chunkN,fs,numFreqs,errorTolerance*numSamples*epsilon2);
    if(success)
        wholeFreqs=[wholeFreqs ; freqs(1:12)];
        wholeAmps=[wholeAmps; amplitudes(1:12)];
        numSuccess=numSuccess+1;
    end
end

[wholeFreqs,wholeAmps]=takeGreatest(wholeFreqs,wholeAmps,0);

plotLineSpectraM(wholeFreqs,wholeAmps,fs,length(wholeFreqs));
title("Estimated Line Spectra of the Whole Signal");

my_tfplot(dataC,fs,'y(f)','Clean Bass FFT Signal',3);
        







