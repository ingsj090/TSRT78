close all; clear all; clc
%% Load sound file 
[y, fSamp] = audioread('livetssymfoni.wav'); % extract data and sampling frequency

fSamp % check if 8000Hz
size(y)

% sound(y,fSamp); % make sure that the quality of the recording is okay

nSamp = size(y,1); % number of samples
t = (0:nSamp-1)/fSamp; % time vector in seconds


figure(1);
plot(t, y)                  % Plot of signal
title('Recorded whistling');
xlabel('Time in seconds [s]');

%% 4.2 implement and present
% Extraction of the two seconds with best quality
sig=y(42401 : 1 : 58400);

%Definition of constants
T=1/8000;
N=length(sig);
SIG=fft(sig);           %DFT of the signal
w=(0:N-1)'/(N*T);

%Finding dominant frequency
figure(2)
plot(w, abs(SIG));
title('FFT of the signal');
xlabel('Frequency, [Hz]');
%% 4.2.1 Calculation of energies in time domain
[b,a]=butter(2, [1190*2*T, 1220*2*T]);  %butterworth filter of order 2
                                        %to select the dominant frequency
dom_freq=filtfilt(b,a,sig);        %Filtering signal without phase delay

edom = sum(abs(dom_freq).^2);     %dominant freq
etot = sum(abs(sig).^2);     % full signal

%% 4.2.2 Calculation of energies in frequency domain
DOM_FREQ=SIG(1190*N*T:1220*N*T);

Edom = 1/N*sum(abs(DOM_FREQ).^2)*2;     %dominant freq
Etot = 1/N*sum(abs(SIG).^2);     %full signal

%% 4.2.3 Harmonic distortion
thd = (etot-edom)/etot; %Total harmonic distortion in time domain
THD = (Etot-Edom)/Etot; %THD in freq domain

%% 4.2.4 AR2 model
est=sig(1:1:N/2);
val=sig(N/2+1:1:end);
Ne=length(est);
Nv=length(val);

%Choice of model
ar1=ar(est,1);
ar2=ar(est,2);
ar3=ar(est,3);

lossest(1)=1/Ne*sum(pe(est,ar1).^2);
lossest(2)=1/Ne*sum(pe(est,ar2).^2);
lossest(3)=1/Ne*sum(pe(est,ar3).^2);

lossval(1)=1/Nv*sum(pe(val,ar1).^2);
lossval(2)=1/Nv*sum(pe(val,ar2).^2);
lossval(3)=1/Nv*sum(pe(val,ar3).^2);

figure(3)
plot(1:3,lossest, '-', 1:3, lossval, '--');
title('Prediction error variance versus model order', 'FontSize', 16);
xlabel('n')

% Purity estimate based on AR(2)-model
figure(4)
pzmap(ar2)
pole_w=roots(ar2.a);
dist=1-abs(pole_w);

%% 4.2.5 Spectrum
% Spectrum of the whistle, non-parametric
% Section 4.2 gives:
figure(5)
plot(w, 10*log(abs(T*SIG).^2));
title ('Estimated spectrum, non-parametric method', 'FontSize', 16)
xlabel('Frequency, [Hz] '); ylabel('Absolut value of FFT of the signal, squared')

% Spectrum of the whistle, parametric
figure(6)
pyulear(sig, 10,[], fSamp); 
title ('Estimated spectrum, parametric method', 'FontSize', 16)
xlabel('Frequency in log scale')