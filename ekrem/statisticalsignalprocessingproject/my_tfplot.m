

function my_tfplot(s,fs,name,plottitle)
%takes s and fs, where s is input signal and fs is the sampling
%frequency. Plots the signal and magnitude spectrum.
    n=length(s);
    t= 0:1/fs:(n-1)/fs;
    X=fft(s);
    f=-fs/2+fs/n:fs/n:fs/2;
    
    figure;
    subplot(2,1,1);
    plot(t,s);  title(plottitle);
    ylabel(strcat(name,'(t)'));
    xlabel('t[s]');
    
    subplot(2,1,2);
    plot(f,fftshift(abs(X)));
    ylabel(strcat('|',name,'_F(f)|'));
    xlabel('f[Hz]');
    
end