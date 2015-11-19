%% Load sound file
alternativeTwo_readWavFile

%% 4.2 implement and present
%Selection of the two seconds with best quality
sig=y(42401 : 1 : 58400);
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
edom = sum(abs(dom.^2));     %dominant freq
etot = sum(abs(sig.^2));     % full signal

%% 4.2.2 Calculation of energies in frequency domain
Edom = 1/N*sum(abs(DOM.^2));     %dominant freq
Etot = 1/N*sum(abs(SIG.^2));     %full signal

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

plot(1:3,lossest, '-', 1:3, lossval, '--');


% Purity measure
wistmod = ar(sig,2);
wistp = predict(wistmod, sig, 1);

wistdom = filtfilt(b,a,wistp);
ewdom = sum(abs(wistdom).^2);
ewtot = sum(abs(wistp).^2);

purew= 1-ewdom/ewtot;

%% 4.2.5 Spectrum
nonpar=etfe(sig);
figure(1)
bode(nonpar)
figure (2)
bode(wistmod)
