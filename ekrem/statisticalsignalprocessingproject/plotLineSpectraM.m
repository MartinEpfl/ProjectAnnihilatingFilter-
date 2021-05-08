function plotLineSpectraM(freqs,amplitudes,fs,numLine)   

% this function plots the line spectra with magnitude values
    if numLine>length(freqs)
        error('Number of Lines can not be more than observed frequencies.')
    end
        
%this function visualizes the first 10 entry of given line spectra
    f=-fs/2+fs/1000:fs/1000:fs/2;
    amps=abs(amplitudes);
    
    figure;
    for i=1:numLine
    line([freqs(i) freqs(i)],[0 amps(i)]);
    end
    
    grid on;
    xlabel('f (Hz)'); ylabel('|S(f)|');
end



