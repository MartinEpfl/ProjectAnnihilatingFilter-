[y,Fs] = audioread("Clean bass.wav");
ySampled = downsample(y, 370);
numberOfSample = size(ySampled,1);
k = numberOfSample/2;
A = zeros(k,1);
h = zeros(k,1);
c = ySampled(k:k*2-1);
r = flip(ySampled(1:k));
T = toeplitz(c,r);
b = transpose(-ySampled((k+1):(k*2)));
hresult = linsolve(T,b);
temp = zeros(k+1,1);
temp(1) = 1;
temp(2:k+1)=hresult;
temp = flip(temp);
finalResult = roots(temp);
%plot(hresult);
%number of samples = k


%frequencies =  abs(fft(ySampled));
%plot(frequencies)