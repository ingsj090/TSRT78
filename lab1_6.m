clear all
close all
clc

%% Speech encoding as GSM

[y, fSamp] = audioread('timewarp.wav');

nSamp= size(y,1);
t = (0:nSamp-1)/fSamp;

figure(1);
plot(t, y)                  % Plot of signal
xlabel('time in seconds')
ylabel('recorded signal')

phrase = y(0.7*8000:3.3*8000-1);     %extraction of sentence

N=length(phrase);

%% Divide the signal into segments of 160 samples each
i=1;
ind=1;
segments=zeros(ceil(N/160), 160);
while(ind-1 <= length(phrase) - 160)
    segments(i,:)=phrase(ind:ind+159);
    i=i+1;
    ind=ind+160;
end
%% Estimate model AR(8) for each segment
[rows, columns] = size(segments);

phrase_2=[];
for i=1:rows
   % Preprocessing: detrend 
   detr=detrend(segments(i,:));
   
   % model each segment with AR(8) 
   mod=ar(detr,8);
   
   % Pulse train 
   e=filter(mod.a,1,detr);
   r=covf(e',100);
   [A,D]=max(r(19:end));
   ehat=zeros(columns,1);
   ehat(1:D:end)=sqrt(A);
   
   % Dealing with unstable poles
   b=fstab(mod.a,1/fSamp);
   
   yhat=filter(1,b,ehat');
   
   phrase_2 = [phrase_2 yhat];
end
  
sound(phrase_2)
a=1

