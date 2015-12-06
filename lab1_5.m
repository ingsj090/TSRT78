clear all
close all
clc

%% Loading A
[a, fSampa] = audioread('A.wav'); % extract data and sampling frequency

%% Looking at data A

nSamp_a = size(a,1);            % number of samples
t_a = (0:nSamp_a-1)/fSampa;     % time vector in seconds

figure(1);
plot(t_a,a); title('Recording, A')                     % plot signal
xlabel('Time in seconds [s]')
axis tight

sig_a = a(32001:1:48000);       % Extraction of two best seconds

%% definition of constants
N = length(sig_a);
T = 1/8000;
w = (0:N-1)'/(N*T);

%% Model estimation
ahat=detrend(sig_a);    %Removing the trend of the data
A = fft(ahat); 
figure(2)
plot(w,abs(A)); title('FFT of vowel A')
xlabel('Frequency [Hz]')

a_base=163.5;  %Given by ocular inspection of spectrum

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

%% 5.2.3 Simulate
% Comparison real spectrum and model spectrum
n_vala = length(a_val);

%define pulse train
Da = 45;   % almost 1/a_base*length(a_est);
a_cov=sum(diag(getcov(a_ar10)));
pulset=zeros(size(a_val));
pulset(1:Da:end)=1;

% simulating 
sim_a=filter(1,a_ar10.a,a_cov*pulset);
sound(sim_a)

% validating the models
figure(7)
loglog(fSampa*(0:n_vala-1)/n_vala, abs(fft(a_val))); hold on;
loglog(fSampa*(0:n_vala-1)/n_vala, 10*abs(fft(sim_a)));
hold off;
title('Validation of model, vowel A'); legend('Validation data','Simulated data');

%% O
% Loading O
[o, fSampo] = audioread('O.wav'); % extract data and sampling frequency
 
%% Looking at data O
 
nSamp_o = size(o,1);            % number of samples
t_o = (0:nSamp_o-1)/fSampa;     % time vector in seconds

figure(8);
plot(t_o,o); title('Recording, O')                   % plot signal
xlabel('Time in seconds [s]')
 
sig_o = o(40001:1:56000);       % Extraction of two best seconds

 %% Model estimation
ohat=detrend(sig_o); %Removing the trend of the data
O = fft(ohat);   
figure(9)        
plot(w,abs(O)); title('FFT of vowel O')           % plotting the fft   
xlabel('Frequency [Hz]')

o_est = ohat(1:ceil(2*N/3));
o_val = ohat(ceil(2*N/3)+1:end);
 
%%Model declarations and validation
o_ar2 = ar(o_est,2);
o_ar4 = ar(o_est,4);
o_ar6 = ar(o_est,6);
o_ar8 = ar(o_est,8);
o_ar10 = ar(o_est,10);
o_ar20 = ar(o_est,20);
% Comparison between estimated signal and measured validation data
compare(o_val,o_ar2, 1);
compare(o_val,o_ar4, 1);
compare(o_val,o_ar6, 1);        %% BEST! 
compare(o_val,o_ar8, 1);
compare(o_val,o_ar10,1);
compare(o_val,o_ar20, 1);
 
%define pulse train
o_base=336;         %ocular inspection of spectrum

Do=24;      %almost 1/o_base*length(o_est);
pulset=zeros(size(o_val));
pulset(1:Do:end)=1;
o_cov=sum(diag(getcov(o_ar6)));

%% 5.2.3 Simulating the sound
sim_o=filter(1,o_ar6.a,o_cov*35*pulset);
n_val0 = length(o_val);
sound(sim_o);

% Comparison real spectrum and model spectrum

figure(3) 
loglog(fSampo*(0:n_val0-1)/n_val0, abs(fft(o_val))); hold on;
loglog(fSampo*(0:n_val0-1)/n_val0, abs(fft(sim_o)));
hold off;
title('Validation of model, vowel O'); legend('Validation data','Simulated data');
