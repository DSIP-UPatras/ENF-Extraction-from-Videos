%GLOBAL SHUTTER VIDEOS 
clear all;
clc;
close all;

%open the video
vid=VideoReader('MVI_9131.avi') %change here 

fps = get(vid, 'FrameRate');
first=1; %first frame
last=8294; %last frame

%calculate the light intensity signal
L=LightInt(first,last,vid);
%remove the DC component (highpass filtering) 
mo=mean(L);
L=L-mo;

figure; 
plot(L);
title('Light Intensity Signal after Visual Part Removal');
xlabel('Number of Frames');

l = length(L);    
fvec=fps*(0:(l/2))/l;
M=abs(fft(L)/l);
figure; 
plot(fvec(1:l/2),M(1:l/2));
xlim([-2 15]);
title('FFT of the Light Intensity Signal after Visual Part Removal');
xlabel('Frequency(Hz)');
ylabel('Normalized Amplitude');

%bandpass filtering 
[b, a] = butter(2, [9.8/15 10.2/15]); %change here 
x = filter(b, a, L);

M=abs(fft(x)/l);
figure; 
plot(fvec(1:l/2),M(1:l/2));
xlim([-2 15]);
title('FFT of the Filtered Light Intensity Signal');
xlabel('Frequency(Hz)');
ylabel('Normalized Amplitude');

N=2^12; %FFT points 
segm=20*round(fps); %20 second segmentation 
enf=ENFext(N,segm,fps,x); %ENF calculation 

a=TimeVer(enf); %video timestamping 
fprintf('The video was recorded at \n');
disp(a);