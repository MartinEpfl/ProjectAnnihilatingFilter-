function R = constructR(c,m)
% m is the number of samples of uniform sinusoid samples -1
%c is a column vector
k=length(c)-1;
%k is the number of observed freq.
R=toeplitz([c(k+1) zeros(1,m-k)],[flip(c(1:k+1)).' zeros(1,m-k)]);
end
