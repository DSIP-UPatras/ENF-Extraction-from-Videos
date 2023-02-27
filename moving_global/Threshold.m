function [mi] = Threshold(vid)

%read static background frame
videoFrame=read(vid,200); %change here 
vf=rgb2gray(videoFrame); %convert to grayscale
[L,M] = superpixels(vf,20,"compactness",5); %create superpixels
idx = label2idx(L);
k=1;
for labelVal = 1:M 
    redIdx = idx{labelVal};
    sp(k) = mean(vf(redIdx)); %find the mean for each superpixel
    k=k+1;
end  

mi=median(sp); %find the median of the means
mi=mi/3; %define threshold


end

