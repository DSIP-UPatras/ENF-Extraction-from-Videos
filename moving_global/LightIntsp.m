function [meanGrayVid] = LightIntsp(first,last,vid,mi)

%find the row signal 
for j=first:last
    videoFrame=read(vid,j); %read each frame
    vf=rgb2gray(videoFrame); %convert to grayscale
    [L,M] = superpixels(vf,20,"compactness",5);%generate 100 superpixels 
    k=1;
    idx=0;
    idx = label2idx(L); %convert the label matrix 
    %to cell array of linear indices
    
for labelVal = 1:M %Number of superpixels in the image 
    redIdx = idx{labelVal};
    sp(k) = mean(vf(redIdx)); %find the mean for each superpixel
    k=k+1;
end    
numofsp=0;
sum=0;
for f=1:length(sp) %calculate the mean light intensity signal 
    if sp(f)>mi
        sum=sum+sp(f);
        numofsp=numofsp+1;
    end
end

meanGrayVid(j)=sum/numofsp;   
end
end

