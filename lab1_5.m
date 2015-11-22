clear all
close all
clc

%% Loading A
[a, fSampa] = audioread('A.wav'); % extract data and sampling frequency

%% Looking at data A

nSamp_a = size(a,1);            % number of samples
t_a = (0:nSamp_a-1)/fSampa;     % time vector in seconds

figure(1);
plot(t_a,a)                     % plot signal
xlabel('time in seconds')
ylabel('recorded signal') 

sig_a = a(32001:1:48000);       % Extraction of two best seconds

%% Model estimation

a_etfe = etfe(sig_a);           
bode(a_etfe)
hold on
a_ar10 = ar(sig_a,10);
bode(a_ar10)


%% Loading O
% [o, fSampo] = audioread('O.wav'); % extract data and sampling frequency
% 
% %% Looking at data O
% 
% nSampo = size(o,1); % number of samples
% to = (0:nSampo-1)/fSampo; % time vector in seconds
% 
% figure(1);clf();
% plot(to,o)
% xlabel('time in seconds')
% ylabel('recorded signal') % axis description is important!

%% blaha
% osig = o(28000:1:44000);
% 
% oetfe = etfe(osig);
% bode(oetfe)
% hold on
% oar6 = ar(osig,6);
% bode(oar6)
% predo = predict(oar6, osig, 1);
% sound(predo, 8000)

