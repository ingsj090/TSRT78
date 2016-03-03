close all; clear all; clc
%% Load sound file 
[y, fSamp] = audioread('livetssymfoni.wav'); % extract data and sampling frequency

fSamp; % check if 8000Hz
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
Ts=1/8000;
N=length(sig);
SIG=fft(sig);           %DFT of the signal
w=(0:N-1)'/(N*Ts);

%Finding dominant frequency
figure(2)
plot(w, abs(SIG));
title('FFT of the signal');
xlabel('Frequency, [Hz]');
%% 4.2.1 Calculation of energies in time domain
[b,a]=butter(2, [1190*2*Ts, 1220*2*Ts]);  %butterworth filter of order 2
                                          %to select the dominant frequency
dom_freq=filtfilt(b,a,sig);     %Filtering signal without phase delay

T = 2;      % 2 seconds long sequence
edom = T*sum(abs(dom_freq).^2); %dominant freq
etot = T*sum(abs(sig).^2);     % full signal

%% 4.2.2 Calculation of energies in frequency domain
DOM_FREQ = zeros(length(sig),1);
DOM_FREQ(1190*N*Ts:1220*N*Ts)=SIG(1190*N*Ts:1220*N*Ts);

Edom = T/N*sum(abs(DOM_FREQ).^2)*2;     %dominant freq
Etot = T/N*sum(abs(SIG).^2);            %full signal

%% 4.2.3 Harmonic distortion
thd = (etot-edom)/etot; %Total harmonic distortion in time domain
THD = (Etot-Edom)/Etot; %THD in freq domain

%% 4.2.4 AR2 model
ar2 = ar(sig,2);

% Purity estimate based on AR(2)-model
figure(4)
pzmap(ar2)
pole_w=roots(ar2.a);
dist=1-abs(pole_w);

%% 4.2.5 Spectrum
% Spectrum of the whistle, non-parametric
% Section 4.2 gives:
figure(5)
plot(w, 10*log(abs(Ts*SIG).^2));
title ('Estimated spectrum, non-parametric method', 'FontSize', 16)
xlabel('Frequency, [Hz] '); ylabel('Absolut value of FFT of the signal, squared')

% Spectrum of the whistle, parametric
figure(6)
pyulear(sig, 10,[], fSamp); 
title ('Estimated spectrum, parametric method', 'FontSize', 16)
xlabel('Frequency in log scale')