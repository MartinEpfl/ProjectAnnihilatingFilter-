function [s_freqs,s_amps] = takeGreatest (freqs,amps,sortParameter)
% this function sorts both frequencies and amplitudes according to 
% sort parameter 0 -> sort the amplitudes first the greatest 
%1-> sort frequencies first the smallest
if sortParameter==0
    [~,i]=sort(abs(amps));
    i=flip(i);
    s_amps=amps(i);
    s_freqs=freqs(i);
elseif sortParameter==1
    [~,i]=sort(freqs);
    s_amps=amps(i);
    s_freqs=freqs(i);
else
    error("Sort Parameter should be 1 or 0");
end

end