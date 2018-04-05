%% Open/Save Files
fname_5='C:\Users\G_N17\Documents\Faculdade\4º\2ºSemestre\ADAR\Projeto\subject5.edf';
fname_6='C:\Users\G_N17\Documents\Faculdade\4º\2ºSemestre\ADAR\Projeto\subject6.edf';

[hdr_5, record_5]= edfread(fname_5);
[hdr_6, record_6]= edfread(fname_6);

save("hdr_5.mat",'hdr_5')
save("record_5.mat",'record_5')
save("hdr_6.mat",'hdr_6')
save("record_6.mat",'record_6')

%% Applying ICA
load('record_5.mat')
channels = record_5([2,3,16,17,18,19],:); %signals corresponding to EEG
signals=fastica(channels); %ICA
save("signals.mat",'signals')
% for i=1:6
%     figure(i)
%     t=0:0.005:31289.995;
%     plot(t,signals(i,:))
%     
% end

%% Filters
load('signals.mat')
Signal_19=signals(6,:);
Signal_18=signals(5,:);
Signal_17=signals(4,:);
fs=200;
t = 0:(length(Signal_19)-1);
n1=30;
n2=6;
high_value = 0.5;
low_value = 45;
[b,a] = butter(n1,low_value*2/fs, 'low'); %low filter
[b1,a1] = butter(n2,high_value*2/fs, 'high'); %high filter
for i=1:3
    if i==1
        low = filter(b, a, Signal_19);
        high = filter(b1, a1, low);
        Signal_fft1 = fft(high);
        Signal_fft2 = fftshift(Signal_fft1);
        f=-fs/2:fs/(length(Signal_fft2)-1):fs/2;
        Magnitude=abs(Signal_fft2);
        Phase=angle(Signal_fft2);
        filter_signal_19=high;
        save("filter_signal_19.mat",'filter_signal_19');
        figure(1)
        plot(f,Magnitude)
% subplot(3,1,1)
% plot(t,Signal_fft)
% title('Original Signal')
% ys = [-25;25];
% ylim(ys)
% 
% subplot(3,1,2)
% plot(t,outhi)
% title('Bandpass Filtered Signal')
% xlabel('Time (s)')
% ylim(ys)

% subplot(4,1,3)
% plot(t, Signal_fft,'b',t,outhi_pre, 'r')
% title('Sobreposição com o low')
% xlabel('Time (s)')
% ylim(ys)
% figure(1)
% subplot(4,1,1)
% plot(t, Signal,'b')
% title('Original')
% xlabel('Time (s)')
% ylim(ys)
% 
% subplot(4,1,2)
% plot(t, high,'r')
% title('Filtrado')
% xlabel('Time (s)')
% ylim(ys)
% 
% subplot(4,1,3)
% plot(t, Signal,'b',t,high, 'r')
% title('Sobreposição')
% xlabel('Time (s)')
% ylim(ys)
% 
% subplot(4,1,4)
% plot(f,Magnitude)     
    end
    if i==2
        low = filter(b, a, Signal_18);
        high = filter(b1, a1, low);
        Signal_fft1 = fft(high);
        Signal_fft2 = fftshift(Signal_fft1);
        f=-fs/2:fs/(length(Signal_fft2)-1):fs/2;
        Magnitude=abs(Signal_fft2);
        Phase=angle(Signal_fft2);
        filter_signal_18=high;
        save("filter_signal_18.mat",'filter_signal_18');
        figure(2)
        plot(f,Magnitude)
     end
     if i==3
        low = filter(b, a, Signal_17);
        high = filter(b1, a1, low);
        Signal_fft1 = fft(high);
        Signal_fft2 = fftshift(Signal_fft1);
        f=-fs/2:fs/(length(Signal_fft2)-1):fs/2;
        Magnitude=abs(Signal_fft2);
        Phase=angle(Signal_fft2);
        filter_signal_17=high;
        save("filter_signal_17.mat",'filter_signal_17');
        figure(3)
        plot(f,Magnitude)
     end
end
%% Wavelets
load('filter_signal_19.mat');
load('filter_signal_18.mat');
load('filter_signal_17.mat');

fs=200;
window=5*fs;
wavelet_19=[];
wavelet_18=[];
wavelet_17=[];
for i=1:window:length(filter_signal_19)-window
    wavelet_19=[wavelet_19;wav_coef(filter_signal_19(i:i+window),'db4',6)];
    wavelet_18=[wavelet_18;wav_coef(filter_signal_18(i:i+window),'db4',6)];
    wavelet_17=[wavelet_17;wav_coef(filter_signal_17(i:i+window),'db4',6)];
end

plot((1:length(wavelet_19(:,5)))/720,wavelet_19(:,5))
    























%%
channels = record_5([2,3,16,17,18,19],:);
signals=fastica(channels);
for i=1:6
    figure(i)
    t=0:0.005:31289.995;
    plot(t,signals(i,:))
    
end


lista_plots=[1,4,5,6,7,8,9,10,11,12,13,14,15,20,21,22,23];
for j=1:length(lista_plots)
    figure(j+6)
    t=0:0.005:31289.995;
    plot(t,record_5(lista_plots(j),:))
    
end
close all;
R={};
for i=1:6
    for j=1:length(lista_plots)
        R(i,j)={corrcoef(signals(i,:),record_5(lista_plots(j),:))};
    end
end
    


%os dois ultimos são os melhores, e o antepenultimo tem qu eser visto antes
%da filtragem
%o 6 tem uma maior correlação com o 3, CZAI
%o 5 e 6 tem a maior correlação com o 13, Continuous Positive Airway
%Pressure (CPAP)--provavelmente a pessoa tem apneia
% filtro ir e fir 
