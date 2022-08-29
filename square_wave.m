clear all;
close all;
clc
load data.mat;
% square=load('square_wave.txt');
square_y=square(:,1);
square_x=linspace(0,60,length(square_y));
% figure;
% plot(square_x,square_y);title('data from the detector');
% 
% load square.mat
realsquare=makesquare/2*9+4.5;
realfft=fft(realsquare);
abs_realfft=abs(realfft);
realfft=fft(square_y);
figure;
subplot(2,1,1);
stem(abs_realfft);title('absolute FFT of the real input');
subplot(2,1,2);
stem(abs_realfft(1:30));title('first 30 FFT of the real input');

detect=[];
for i=1:length(square_y)-1
    change=square_y(i+1)-square_y(i);
    if change ~= 0
        detect(end+1) =i;
    end
end

interval=[];
for i=1:length(detect)-1
    interval(end+1)=detect(i+1)-detect(i);
end
resquare=zeros(length(square_y),1);
for i=1:length(interval)
    if interval(i)<500
        resquare(detect(i):detect(i+1))=1;
    end
end
figure;
plot(square_x,resquare);title('recovered signal');

refft=fft(resquare);
abs_refft=abs(refft);

makefft=zeros(19862,1);
for i=1:length(refft)
    k = fix(i/30)+1;
    if k*30-i>10
        if abs_refft(i) >1000
            makefft(i)=refft(i);
        end
    else
        if abs_refft(i) >800
            makefft(i)=refft(i);
        end
    end
end

abs_makefft=abs(makefft);
figure;
subplot(2,1,1);
stem(abs_refft(1:30));
title('first 30 absolute FFT of the recovered input');
subplot(2,1,2);
stem(abs_makefft(1:30));
title('first 30 absolute FFT of the made input');

makefft_i=ifft(refft);
makefft_i = makefft_i*9;
figure;
subplot(2,1,1);
plot(square_x,realsquare);
ylim([-0.2,9.2]);
title('real input square wave');
subplot(2,1,2);
plot(square_x,makefft_i);
ylim([-0.2,9.2]);
title('signal from inverse FFT');        
     
% square_x=linspace(0,60,19862);
% makesquare= square(0.6*square_x+1);
% load square.mat
% makesquare=makesquare/2+0.5;
% makefft=fft(makesquare);
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
% plot(square_x,makefft_i);
% title('signal from inverse FFT');


