clear all
close all
clc

%% Loading A
[a, fSampa] = audioread('A.wav'); % extract data and sampling frequency

%% Looking at data A

nSampa = size(a,1); % number of samples
ta = (0:nSampa-1)/fSampa; % time vector in seconds

figure(1);clf();
plot(ta,a)
xlabel('time in seconds')
ylabel('recorded signal') % axis description is important!

%% Blä
asig = a(32001:1:48000);

aetfe = etfe(asig);
bode(aetfe)

aar10 = ar(asig,10);
bode(aar10)
preda = predict(aar10, asig, 1);
sound(preda, 8000)

%% Loading O
[o, fSampo] = audioread('O.wav'); % extract data and sampling frequency

%% Looking at data O

nSampo = size(o,1); % number of samples
to = (0:nSampo-1)/fSampo; % time vector in seconds

figure(1);clf();
plot(to,o)
xlabel('time in seconds')
ylabel('recorded signal') % axis description is important!

%% blaha
osig = o(28000:1:44000);

oetfe = etfe(osig);
bode(oetfe)
oar6 = ar(osig,6);
predo = predict(oar6, osig, 1);
sound(predo, 8000)

