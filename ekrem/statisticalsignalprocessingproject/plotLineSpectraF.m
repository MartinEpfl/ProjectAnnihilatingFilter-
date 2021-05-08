function plotLineSpectraF(freqs,fs,numLine)   

% this function plots the line spectra without magnitude values
% sometimes it is impossible to find the magnitudes because of the
% condition number of the amplitude generation matrix
    if numLine>length(freqs)
        error('Number of Lines can not be more than observed frequencies.')
    end
        
%this function visualizes the first 10 entry of given line spectra
    f=-fs/2+fs/1000:fs/1000:fs/2;
    
    figure;
    for i=1:numLine
    line([freqs(i) freqs(i)],[0 1]);
    end
    
    grid on;
    xlabel('f (Hz)'); ylabel('|S(f)|');
end

