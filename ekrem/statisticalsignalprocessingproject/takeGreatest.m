function [s_freqs,s_amps] = takeGreatest (freqs,amps)
% this function sorts both frequencies and amplitudes according to 
% the greatest of abs value of amplitudes
[~,i]=sort(abs(amps));
i=flip(i);
s_amps=amps(i);
s_freqs=freqs(i);
end