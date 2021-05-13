
function [freqs,b_n,i,j]=annihiliatingFilterImproved(signal,fs,noisepower)
% implements improved annihiliating filter approach with constrained
% optimization
% normally a is the sparse signal samples, but we do here as uniform
% samples of sinusoidal sum
%a is given as column vector
    if(mod(length(signal),2)==1)
        signal=signal(1:end-1);
    end
    n=length(signal);   
    K=n/2;
    
    % we need to find mapping from b to a, but we use the same samples 
    % Gb -> a , we have G = I here so there is no need
    
    % Beta becomes a
    maxInitialization=5;
    maxIteration=100;
    c_n=zeros(1,1);
    b_n=zeros;
    
    
    for i=1:maxInitialization
        %random initialization with c random
        c_0=randn(K+1,1);
        c_0=c_0/(norm(c_0));
        c_n1=c_0; %c(n-1)
        for j=1:maxIteration
            % constructing augmented matrix for updating c_n
            
            aug_matrix =[zeros(K+1,K+1), constructT(signal)' , zeros(K+1,2*K) ,   c_0;...
                         constructT(signal)   zeros(K,K)     -1*constructR(c_n1) zeros(K,1);...
                         zeros(2*K,K+1) -1*constructR(c_n1)'   eye(2*K)    zeros(2*K,1);...
                         c_0'            zeros(1,3*K+1)];
            
            res= aug_matrix\[zeros(4*K+1,1) ; 1];
            c_n=res(1:K+1);
            
            % constructing mat soln for finding b_n
            
           aug_matrix2= [eye(2*K) constructR(c_n)';
                         constructR(c_n) zeros(K,K)];
                     
           res2=aug_matrix2\[signal ; zeros(K,1)];
           b_n=res2(1:2*K);
           
           if((signal-b_n)'*(signal-b_n)< noisepower)
               break;
           end
           
           c_n1=c_n;
        end
        
        if((signal-b_n)'*(signal-b_n)< noisepower)
               break;
        end
    end
    
    % zero finding operation
    zeroes=roots(c_n);
    
    % angles
    ang_freqs=angle(zeroes); % normalized angular freqs
    freqs=ang_freqs/(2*pi)*fs; % normal frequencies
    
    
end