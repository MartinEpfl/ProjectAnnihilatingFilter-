

function my_tfplot(s,fs,name,plottitle,plotTF)
%takes s and fs, where s is input signal and fs is the sampling
%frequency. Plots the signal and magnitude spectrum.
% plotTF =1 both time and frequency
% plotTF =2 only time;
% plotTF =3 only freq
    
    n=length(s);
    if (plotTF==1 | plotTF==2)
    t= 0:1/fs:(n-1)/fs;
    figure;
    plot(t,s);  title(plottitle);
    ylabel(strcat(name,'(t)'));
    xlabel('t[s]');
    title('Time Evolution Of the Signal')
    end
    
    if(plotTF ==1 | plotTF==3)
    X=fft(s);
    f=-fs/2:fs/n:fs/2-fs/n;
    figure;
    plot(f,abs(fftshift(X)));
    ylabel(strcat('|',name,'_F(f)|'));
    xlabel('f[Hz]');
    title('FFT of The Signal');
    end
    
end