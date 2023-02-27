function [a] = TimeVer(enf)
%open the file with the stored enf 
f=readtable('2022_12_14_23.csv'); %change here 

a=table2array(f(:,2));    
for i=1:length(a)
   if a(i)>100
       a(i)=a(i)/10;
   end 
end

d=length(enf)-1;

%calculate the NCCs
for j=1:length(a)-d
    e(j)=corr(a(j:d+j),enf');
end
 
figure;
plot(e);
ylabel('Normalised Correlation Coefficients');
xlabel('Time(sec)');

[maxim ind]=max(e); %find the maximum NCC
fprintf("The maximum NCC is: %d\n",maxim); 
figure; 
plot(e);
fprintf("The length of ENF is: %d \n",length(enf)); 

subplot(2,1,1);
plot(a(ind:ind+d),'r','LineWidth',2);
title("ENF Ground-Truth Signal");
xlabel('Time(sec)');
ylabel('Frequency(Hz)');

subplot(2,1,2);
plot(enf,'LineWidth',2);
title("ENF Signal Extracted from Video"); 
xlabel('Time(sec)');
ylabel('Frequency(Hz)');

f=readtable('2022_12_14_23_a.csv');
a=f(ind,3);

end

