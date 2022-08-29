clear
clc
close all

load data.mat;

% use space to show diffenrnt results
% first is the recoverd data
% second is sine input singal inversion
% third is square input singal inversion
% last one is triangle input singal inversion

sin_y=Sin(:,1);
sin_x=linspace(0,60,length(sin_y));

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


square_y=square(:,1);
square_x=linspace(0,60,length(square_y));

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

tri_yo=triangle_out(:,1);tri_yi=triangle_in(:,1);
tri_xo=linspace(0,60,length(tri_yo));
tri_xi=linspace(0,60,length(tri_yi));

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
subplot(3,1,1);
plot(resin_x,resin_y);title('Sine recovered signal');
ylim([0.035,0.052]);
subplot(3,1,2);
plot(square_x,resquare);title('Square recovered signal');
ylim([0,1.05]);
subplot(3,1,3);
plot(retri_x,retri_y);title('Triangle recovered signal');
ylim([0.042,0.075]);

pause;

realfft=fft(sin_y);
abs_realfft=abs(realfft);
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
stem(abs_realfft(1:70));title('first 70 FFT of the real input');
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

pause;

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
realsquare=makesquare/2*9+4.5;
realfft=fft(realsquare);
abs_realfft=abs(realfft);
realfft=fft(square_y);
abs_makefft=abs(makefft);
figure;
subplot(2,1,1);
stem(abs_realfft(1:30));title('first 30 FFT of the real input');
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

pause;

refft=fft(retri_y);
abs_refft=abs(refft);
realfft=fft(tri_yi); 
abs_realfft=abs(realfft);
makefft=zeros(72,1);
for i=1:length(refft)
        if abs_refft(i) > 0.049
            makefft(i)=refft(i);
        end
end
abs_makefft=abs(makefft);
figure;
subplot(2,1,1);
stem(abs_realfft(1:30));title('first 30 FFT of the real input');
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
