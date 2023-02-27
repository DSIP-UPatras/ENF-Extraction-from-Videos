%ROLLING SHUTTER VIDEOS
clear all;
clc;
close all;
format short; 

%open video file
vid=VideoReader('rolling_1.mp4') %change here 

fr=get(vid,'FrameRate');
first=1; %first frame 
last=8290; %last frame

vidWidth = vid.Width;
vidHeight = vid.Height;
fps=fr*vidWidth; %new sampling frequency
%fps=fr*vidHeight; %use of horizontal shutter 

%find the "average" frame  
sum=zeros(vid.Height,vid.Width,'double');

for i=first:last
    thisFrame = read(vid, i);
    gr1 = double(rgb2gray(thisFrame));
    sum = sum + gr1;    
end
m=sum/(last-first+1);  

meanGrayVid=ColSig(vidWidth,first,last,m,vid);% create the column signal 
% meanGrayVid=RowSig(vidWidth,first,last,m,vid); %create the row signal

l = length(meanGrayVid);
fvec=fps*(0:(l/2))/l;
x=meanGrayVid;

M=abs(fft(x)/l);
figure; 
plot(fvec(1:l/2),M(1:l/2));
xlim([-2 102]);
title('FFT of the Column Signal');
%title ('FFT of the Row Signal'); %use of horizontal shutter
xlabel('Frequency(Hz)');
ylabel('Normalized Amplitude');

%create a spectrogram
M=floor(16*(fps)); 
g=hamming(M); %apply the window 
k=floor(15*(fps)); 

N=2^20; 
figure;
spectrogram(x,g,k,N,fps,'yaxis');

%bandpass filtering 
[b, a] = butter(2, [9.8/(fps/2) 10.2/(fps/2)]); %change here 
x = filter(b, a, x);

M=abs(fft(x)/l);
figure; 
plot(fvec(1:l/2),M(1:l/2));
xlim([-2 102]);
title('FFT of the Filtered Column Signal');
%title('FFT of the Filtered Row Signal'); %use of horizontal shutter
xlabel('Frequency(Hz)');
ylabel('Normalized Amplitude');

segm=20*round(fps); %20 second segmentation
enf=ENFext(N,segm,fps,x); %ENF calculation 

a=TimeVer(enf); %find the time of recording 
fprintf('The video was recorded at \n');
disp(a);

        