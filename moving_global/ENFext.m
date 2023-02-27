function [enf] = ENFext(N,segm,fps,x)
%FFT METHOD 
%MAXIMUM ENERGY 

NumUniquePts = ceil((N+1)/2);
k=1;
for i = 1:round(fps):length(x)-segm
    %isolate a segment of the signal 
    X=x(i:i+segm-1);   
    % calculate magnitude FFT spectrum
    FX = abs(fft(X,N));
    FX = 20*log10(FX(1:NumUniquePts));
    
   [maxim ind]=max(FX); %find the maximum in the spectrum 
   %quadratic interpolation
   a=ind-1;
   b=ind;
   c=ind+1;
   
   A=FX(a);
   B=FX(b);
   C=FX(c);
  
   p=(0.5*A-0.5*C)/(A-2*B+C);
   ind=ind+p;
   ind=fps*((ind-1)/N);  
   
   enf(k)=ind;
   k=k+1;
end 

figure; 
plot(enf,'LineWidth',2);
title("ENF Signal Extracted from Video");
xlabel('Time(sec)'); 
ylabel('Frequency(Hz)');



end

