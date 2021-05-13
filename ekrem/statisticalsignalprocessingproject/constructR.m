function R = constructR(b)
%k is the number of observed freq.
%b is a column vector
k=length(b)-1;
R=toeplitz([b(k+1) zeros(1,k-1)],[flip(b(1:k+1))' zeros(1,k-1)]);
end
