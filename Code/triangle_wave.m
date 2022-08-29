clear all;
close all;
clc
load data.mat;
% triangle_out=load('triangle_wave.txt');
% triangle_in=load('triangle_wave_input.txt');
tri_yo=triangle_out(:,1);tri_yi=triangle_in(:,1);
tri_xo=linspace(0,60,length(tri_yo));
tri_xi=linspace(0,60,length(tri_yi));

% figure;
% plot(tri_xo,tri_yo);title('triangle wave output');
realfft=fft(tri_yi);
abs_realfft=abs(realfft);
figure;
subplot(2,1,1);
stem(abs_realfft);title('absolute FFT of the real input');
subplot(2,1,2);
stem(abs_realfft(1:30));title('first 30 FFT of the real input');

detect=[];
for i=1:length(tri_yo)-1
    change=tri_yo(i+1)-tri_yo(i);
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
    interval2(i)=interval(2*i);
end
retri_x=linspace(0,60,length(interval2));
retri_y=1./interval2;
figure;
plot(retri_x,retri_y);title('recovered signal');


refft=fft(retri_y);
abs_refft=abs(refft);

makefft=zeros(72,1);
for i=1:length(refft)
        if abs_refft(i) > 0.049
            makefft(i)=refft(i);
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

makefft_i=ifft(makefft);
figure;
subplot(2,1,1);
tri_yiplot = (tri_yi-90)/18.3;
plot(tri_xi,tri_yiplot);title('triangle wave input');
ylim([-0.2,9.2]);
subplot(2,1,2);
makefft_iplot = (makefft_i-0.047)*345;
plot(retri_x,makefft_iplot);
ylim([-0.2,9.2]);
title('signal from inverse FFT');

% maketri=sawtooth(0.376*tri_xi,0.5);
% makefft=fft(maketri);
% abs_makefft=abs(makefft);
% figure;
% subplot(2,1,1);
% plot(abs_makefft);
% title('absolute FFT of the made input');
% subplot(2,1,2);
% plot(abs_makefft(1:30));
% title('first 30 absolute FFT of the made input');

