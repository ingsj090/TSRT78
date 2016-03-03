%% removed from lab1_4

est=sig(1:1:N/2);
val=sig(N/2+1:1:end);
Ne=length(est);
Nv=length(val);

Choice of model
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
%% removed from lab1_5

%% removed from lab1_6