function [amplitudes] = amplitudeEstimation(signal,freqs,fs,downS)
k=length(freqs);
fsNew=fs/downS;
signal=downsample(signal,downS);
ang_freqs=freqs/(2*pi*fsNew);
A = exp ((0:length(signal)-1)' * (-1j * ang_freqs.'));
amplitudes= A\signal;

end