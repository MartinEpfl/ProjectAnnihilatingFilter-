
function [freqs,amplitudes]=annihiliatingFilterSimple(signal,fs)
% implements annihiliating filter approach

    if(mod(length(signal),2)==1)
        signal=signal(1:end-1);
    end
    
    n=length(signal);
    
% constructing toeplitz matrix
    K=n/2;
    sig_mat= toeplitz( flip(signal(1:K)),signal(K:2*K-1));
    b=-1*signal(K+1:2*K);
    
    %resulting annihiliating filter
    h=sig_mat\b.';
    
    % zero finding operation
    zeros=roots([1 h.']);
    
    % angles
    ang_freqs=angle(zeros); % normalized angular freqs
    freqs=ang_freqs/(2*pi)*fs; % normal frequencies
    
    % constructing the matrix for calculation of amplitudes
    
   A = exp ((0:K-1)' * (-1j * ang_freqs.'));
   s=(signal(1:K)).';
   
   amplitudes= A\s;
   
   [freqs,amplitudes]=takeGreatest(freqs,amplitudes);
   
   
end