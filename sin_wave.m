clear all;
close all;
clc
load data.mat;
% Sin=load('sin_wave_2.txt');
sin_y=Sin(:,1);
sin_x=linspace(0,60,length(sin_y));
% figure;
% plot(sin_x,sin_y);title('data from the detector');

detect=[];
for i=1:length(sin_y)-1
    change=sin_y(i+1)-sin_y(i);
    if change ~= 0
        detect(end+1) =i;
    end
end

interval=[];
for i=1:length(detect)-1
    interval(end+1)=detect(i+1)-detect(i);
end
interval2=[];
for i=1:(length(interval+1)-1)/2
    interval2(i)=interval(2*i-1);
end
realsin=sin(0.3*sin_x)+172;
realsinplot = (realsin-172)*4.5+4.5;
resin_x=linspace(0,60,length(interval2));
resin_y=1./interval2;
figure;
plot(resin_x,resin_y);title('recovered signal');
realfft=fft(sin_y);
abs_realfft=abs(realfft);
figure;
subplot(2,1,1);
stem(abs_realfft);title('absolute FFT of the real input');
subplot(2,1,2);
stem(abs_realfft(1:70));title('first 70 FFT of the real input');
refft = fft(resin_y);
abs_refft=abs(refft);

makefft=zeros(70,1);
for i=1:length(refft)
    if abs_refft(i) > 0.1
        makefft(i)=refft(i);
    end
end

abs_makefft=abs(makefft);
figure;
subplot(2,1,1);
stem(abs_refft);
title('absolute FFT of the recovered input');
subplot(2,1,2);
stem(abs_makefft);
title('absolute FFT of the made input');

makefft_i=ifft(makefft);
makefft_i = (makefft_i-0.044)*1000+4.5;
figure;
subplot(2,1,1);
plot(sin_x,realsinplot);title('real input sin wave');
ylim([-0.2,9.2]);
subplot(2,1,2);
plot(resin_x,makefft_i);
ylim([-0.2,9.2]);
title('signal from inverse FFT');

% makesin=sin(0.3*sin_x+0.11);
% makefft=fft(makesin);
% abs_makefft=abs(makefft);
% figure;
% subplot(2,1,1);
% stem(abs_makefft);
% title('absolute FFT of the made input');
% subplot(2,1,2);
% stem(abs_makefft(1:30));
% title('first 30 absolute FFT of the made input');
% makefft_i=ifft(makefft);
% figure;
% plot(sin_x,makefft_i);
% title('signal from inverse FFT');
