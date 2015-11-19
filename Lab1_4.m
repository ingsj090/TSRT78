%% Load sound file
alternativeTwo_readWavFile

%% 4.2 implement and present
%Selection of the two seconds with best quality
sig=y(42400 : 1 : 58400);
%Definition of constants and filters
T=1/8000;
N=length(sig);
SIG=fft(sig);           %DFT of the signal
w=(0:N-1)'/(N*T);
[b,a]=butter(2, [1200*2*T, 1210*2*T]);  %butterworth filter of order 2
                                        %to select the dominant frequency
dom=filtfilt(b,a,sig);              %Filtering signal without phase delay
DOM=fft(dom);                       
plot(w, abs(SIG), '-', w, abs(DOM), '--');

%% 4.2.1 Calculation of energies in time domain
edom = sum(dom.^2);     %dominant freq
etot = sum(sig.^2);     % full signal
%Calculating measurement of purity
pur=1-edom/etot

%% 4.2.2 Calculation of energies in frequency domain
Edom = sum(DOM.^2);     %dominant freq
Etot = sum(SIG.^2);     %full signal
%Measurement och purity
Pur=1-Edom/Etot
