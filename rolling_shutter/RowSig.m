function [meanGrayVid] = RowSig(vidWidth,first,last,m,vid)

%Horizontal rolling shutter  
%find mean value for each row
meanGrayVid = zeros((last-first+1) * vidHeight, 1);

    b = 0;
        for frame=first:last
            thisFrame = read(vid, frame);%read each frame
            grayImage=double(rgb2gray(thisFrame))-m;%convert to grayscale 
             % and remove the visual component 
            for height = 1 : vidHeight %calculate sample for each row
                row=grayImage(height, :);
                meanGrayVid(b + height) = mean(row);
            end
            b = b + vidHeight; 
        end
        
figure;  
plot(meanGrayVid);
title('Row Signal');
xlabel('Number of Frames');
end

