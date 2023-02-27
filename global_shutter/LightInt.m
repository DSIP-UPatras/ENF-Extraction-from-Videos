function [L] = LightInt(first,last,vid)

for j=first:last
    videoFrame=readFrame(vid); %read each frame
    videoFrame=rgb2gray(videoFrame); %convert  to grayscale
    L(j)=mean(videoFrame(:)); %find the mean light intensity for each frame
end

figure; 
plot(L);
title('Light Intensity Signal');
xlabel('Number of Frames');
ylabel('Mean Pixel Value');


end

