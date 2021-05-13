function T = constructT(b)
% k is the number of observed freq.
k=length(b)/2;
T = toeplitz(b(k+1:2*k),flip(b(1:k+1)));
end