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
while(ind <= length(phrase) - 160)
    segments(i,:)=phrase(ind:ind+159);
    i=i+1;
    ind=ind+160;
end
%% Estimate model AR(8) for each segment
[rows, columns] = size(segments);


