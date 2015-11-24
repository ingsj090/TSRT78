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

% Comparison real spectrum and model spectrum
n_vala = length(a_val);


%OBS OBS FIXA FIXA SAMMA SAMMA

% 5.2.3 Simulate
%define pulse train

Da = 45;%1/a_base*length(a_est);
a_cov=sum(diag(getcov(a_ar10)));
pulset=zeros(size(a_val));
pulset(1:Da:end)=1;

sim_a=filter(1,a_ar10.a,a_cov*pulset);
%plot(sim_a)
sound(sim_a)

figure(7)
loglog(fSampa*(0:n_vala-1)/n_vala, abs(fft(a_val))); hold on;
loglog(fSampa*(0:n_vala-1)/n_vala, 10*abs(fft(sim_a)));
hold off;
title('Validation of model, vowel A')

%% O
% Loading O
[o, fSampo] = audioread('O.wav'); % extract data and sampling frequency
 
%% Looking at data O
 
nSamp_o = size(o,1);            % number of samples
t_o = (0:nSamp_o-1)/fSampa;     % time vector in seconds

figure(1);
plot(t_o,o)                     % plot signal
xlabel('time in seconds')
ylabel('recorded signal') 
 
sig_o = o(40001:1:56000);       % Extraction of two best seconds

 %% Model estimation
figure(4)
O = fft(sig_o);           
plot(w,abs(O))
o_est = sig_o(1:ceil(2*N/3));
o_val = sig_o(ceil(2*N/3)+1:end);
 
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
compare(o_val,o_ar6, 1);        %% BEST! (good enough)
compare(o_val,o_ar8, 1);
compare(o_val,o_ar20, 1);
 
% Comparison real spectrum and model spectrum
figure(3)
plot(w,abs(O));  % Real spectrum

o_base=336;   %ocular inpection of spectrum

%OBS OBS FIXA FIXA SAMMA SAMMA

%% 5.2.3 Simulate
%define pulse train

Do=24; %1/o_base*length(o_est);
o_cov=sum(diag(getcov(o_ar6)));
pulset=zeros(size(o_val));
pulset(1:Do:end)=1;

sim_o=filter(1,o_ar6.a,o_cov*35*pulset);
n_val0 = length(o_val);
figure(4)
loglog(fSampo*(0:n_val0-1)/n_val0, abs(fft(o_val))); hold on;
loglog(fSampo*(0:n_val0-1)/n_val0, abs(fft(sim_o)));
hold off;
title('Validation of model, vowel O')
