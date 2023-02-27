%GLOBAL SHUTTER VIDEOS with OBJECT MOVEMENT
clear all;
clc;
close all;
%open the video
vid=VideoReader('MVI_9138.avi')%change here  

fps = get(vid, 'FrameRate');
first=1; %first frame
last=6300; %last frame

mi=Threshold(vid);%calculate the threshold

r=LightIntsp(first,last,vid,mi); %create the light intensity signal
figure; 
plot(r);
title('Light Intensity Signal');
xlabel('Number of Frames');
ylabel('Mean Pixel Value');


%remove the DC component
mo=mean(r);
r=r-mo;
figure; 
plot(r);
title('Light Intensity Signal after Visual Part Removal');
xlabel('Number of Frames');

l = length(r);    
fvec = 0:fps/l:fps-1/l;

M=abs(fft(r)/l);
figure; 
plot(fvec(1:l/2),M(1:l/2));
xlim([-2 15]);
title('FFT of the Light Intensity Signal after Visual Part Removal');
xlabel('Frequency(Hz)');
ylabel('Normalized Amplitude');

%bandpass filtering around frequency of interest
[b, a] = butter(2, [9.8/15 10.2/15]);% change here
x = filter(b, a, r);

M=abs(fft(x)/l);
figure; 
plot(fvec(1:l/2),M(1:l/2));
xlim([-2 15]);
title('FFT of the Filtered Light Intensity Signal');
xlabel('Frequency(Hz)');
ylabel('Normalized Amplitude');

N=2^12; %define fft points
segm=20*round(fps);
enf = ENFext(N,segm,fps,x);

a=TimeVer(enf);
fprintf('The video was recorded at \n');
disp(a);
