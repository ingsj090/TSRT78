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

%% definition of constants
N = length(sig_a);
T = 1/8000;
w = (0:N-1)'/(N*T);

%% Model estimation
figure(2)
A = fft(sig_a);           
plot(w,abs(A))
hold on
a_est = sig_a(1:ceil(2*N/3));
a_val = sig_a(ceil(2*N/3)+1:end);

%%Model declarations and validation
a_ar6 = ar(a_est,6);
a_ar8 = ar(a_est,8);
a_ar10 = ar(a_est,10);
a_ar12 = ar(a_est,12);
a_ar22 = ar(a_est,22);
% Comparison between estimated signal and measured validation data
compare(a_val,a_ar6, 1);
compare(a_val,a_ar8, 1);
compare(a_val,a_ar10, 1);
compare(a_val,a_ar12, 1);
compare(a_val,a_ar22, 1);

% Comparison real spectrum and model spectrum
figure(3)
plot(w,abs(A));  % Real spectrum
hold on
%OBS OBS FIXA FIXA SAMMA SAMMA

%% 5.2.3 Simulate
%define pulse train
t = 0:T:2;
d = 
pulst = pulstran(t,d, 'gauspuls'); 
%Simulate
sim_a = predict(a_ar10, pulst, 1);

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

