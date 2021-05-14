function T = constructT(b,k)
% k is the number of estimated freq.
m=length(b)-1;
T = toeplitz(b(k+1:m+1),flip(b(1:k+1)));
end