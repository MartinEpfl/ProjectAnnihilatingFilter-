
function [freqs,amplitudes,rcondAmp,b_n,i,j]=annihiliatingFilterImproved(signal,fs,k,noisepower)
% implements improved annihiliating filter approach with constrained
% optimization
% in the algorithm signal is the sparse signal samples, but we do here as uniform
% samples of sinusoidal sum
%a is given as column vector
%k is the number of estimated frequencies
    m=length(signal)-1;   
    
    
    % we need to find mapping from b to a, but we use the same samples 
    % Gb -> a , we have G = I here so there is no need
    
    % Beta becomes a
    maxInitialization=5;
    maxIteration=100;
    c_n=zeros;
    b_n=zeros;
    
    
    for i=1:maxInitialization
        %random initialization with c random
        c_0=randn(k+1,1);
        c_0=c_0/(norm(c_0));
        c_n1=c_0; %c(n-1)
        for j=1:maxIteration
            % constructing augmented matrix for updating c_n
            
            aug_matrix =[zeros(k+1,k+1), constructT(signal,k)' , zeros(k+1,m+1) ,   c_0;...
                         constructT(signal,k)   zeros(m-k+1,m-k+1)     -1*constructR(c_n1,m) zeros(m-k+1,1);...
                         zeros(m+1,k+1) -1*constructR(c_n1,m)'   eye(m+1)    zeros(m+1,1);...
                         c_0'            zeros(1,2*m-k+3)];
            
            res= aug_matrix\[zeros(2*m+3,1) ; 1];
            c_n=res(1:k+1);
            
            % constructing mat soln for finding b_n
            
           aug_matrix2= [eye(m+1) constructR(c_n,m)';
                         constructR(c_n,m) zeros(m-k+1,m-k+1)];
                     
           res2=aug_matrix2\[signal ; zeros(m-k+1,1)];
           b_n=res2(1:m+1);
           
           if((signal-b_n)'*(signal-b_n)< noisepower)
               break;
           end
           
           c_n1=c_n;
        end
        
        % zero finding operation
        zeroes=roots(c_n);
    
        % angles
        ang_freqs=angle(zeroes); % normalized angular freqs
        freqs=ang_freqs/(2*pi)*fs; % normal frequencies
    
        A = exp ((0:k-1)' * (-1j * ang_freqs.'));
        rcondAmp=rcond(A);
   
        amplitudes= A\b_n(1:k);
        
        if((signal-b_n)'*(signal-b_n)< noisepower &...
                rcondAmp>1e-5)
               break;
        end
    end
    
    
   
    [freqs,amplitudes]=takeGreatest(freqs,amplitudes,0);
    
    
    
    
end
