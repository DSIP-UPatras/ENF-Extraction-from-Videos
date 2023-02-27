function [meanGrayVid] = ColSig(vidWidth,first,last,m,vid)
%Vertical rolling shutter  
%find mean value for each column
meanGrayVid = zeros((last-first+1) * vidWidth, 1);
   b = 0;
        for frame = 1 : last
            thisFrame = read(vid, frame); %read each frame
            grayImage=double(rgb2gray(thisFrame))-m; %convert to grayscale 
            % and remove the visual component 
            for width = 1 : vidWidth %calculate sample for each column 
                column= grayImage(:, width);
                meanGrayVid(b + width) = mean(column);
            end
            b = b + vidWidth;
            
        end     
figure;  
plot(meanGrayVid);
title('Column Signal');
xlabel('Number of Frames');

end

