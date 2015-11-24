clear all
close all
clc

%% Speech encoding as GSM

%Loading the sound file
[y, fSamp] = audioread('timewarp.wav');

% Declaration of sequence length and period time
nSamp= size(y,1);
t = (0:nSamp-1)/fSamp;

% Plotting the signal in time domain
figure(1);
plot(t, y)
axis tight
title('Recorded signal')
xlabel('time in seconds')
ylabel('recorded signal')


% Extraction of the sentence (removal of excess samples)
phrase = y(0.7*8000:3.3*8000-1);    
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
%% Simulation of the sound
[rows, columns] = size(segments);

phrase_2=[];    %array for the simulated signal
phrase_3=[];    %Array for the simulated signal using A=1 for all 
for i=1:rows
   % Preprocessing: detrend 
   detr=detrend(segments(i,:));
   
   % model each segment
   mod=ar(detr,18);             % Found AR(18) gave best result
   
   % Pulse train 
   e=filter(mod.a,1,detr);     
   r=covf(e',100);              % covariance of residuals
   [A,D]=max(r(19:end));        % A=amplitude, D=period
   ehat=zeros(columns,1);       % array for pulsetrain 
   ehat(1:D:end)=20*sqrt(A);    % times 20 gives better result
   
   % Test amplitude = 1 for all segments
   ehat1=zeros(columns,1);
   ehat1(1:D:end)=1;
   
   % Removing unstable poles
   b=fstab(mod.a,1/fSamp);
   
   % Simulation of signal
   yhat=filter(1,b,ehat');
   yhat1=filter(1,b,ehat1');    %for amplitude=1
   
   % Gathering all segments in one array 
   phrase_2 = [phrase_2 yhat];
   phrase_3 = [phrase_2 yhat1]; %for amplitude=1
end

% Play the simulated sound
sound(phrase_2)
sound(phrase_3)
