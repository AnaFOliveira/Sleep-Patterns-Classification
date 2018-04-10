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

%% Filters Parte 2
load('signals.mat')
Signal_19=signals(6,:);
Signal_18=signals(5,:);
Signal_17=signals(4,:);
fs=200;
t = 0:(length(Signal_19)-1);
high_value = 0.5;
low_value = 45;

[b,a] = cheby2(50,120,low_value*2/fs,'low');
[b1,a1] = cheby2(6,120,high_value*2/fs,'high');
low = filter(b, a, Signal_19);
high = filter(b1, a1, low);
Signal_fft1 = fft(high);
Signal_fft2 = fftshift(Signal_fft1);
f=-fs/2:fs/(length(Signal_fft2)-1):fs/2;
Magnitude=abs(Signal_fft2);
Phase=angle(Signal_fft2);
filter_signal_19=high;
save("filter_signal_19_cheby2.mat",'filter_signal_19'); 
figure(1)
subplot(2,1,1)
plot(f,Magnitude)
subplot(2,1,2)
plot(t, Signal_19,'b',t,filter_signal_19, 'r')
% figure(2)
% pxx=pwelch(filter_signal_19);


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
load('filter_signal_19_cheby2.mat');
load('filter_signal_18_cheby2.mat');
load('filter_signal_17_cheby2.mat');

fs=200;
window=5*fs;
wavelet_19=[];
wavelet_18=[];
wavelet_17=[];
for i=1:window:length(filter_signal_19)
    wavelet_19=[wavelet_19;wav_coef(filter_signal_19(i:i+window-1),'db4',6)];
    wavelet_18=[wavelet_18;wav_coef(filter_signal_18(i:i+window-1),'db4',6)];
    wavelet_17=[wavelet_17;wav_coef(filter_signal_17(i:i+window-1),'db4',6)];
end
save("wavelet_19.mat",'wavelet_19');
save("wavelet_18.mat",'wavelet_18');
save("wavelet_17.mat",'wavelet_17');

figure(1)
plot((1:length(wavelet_18(:,5)))/720,wavelet_18(:,1))
figure(2)
plot((1:length(wavelet_18(:,5)))/720,wavelet_18(:,2))
figure(3)
plot((1:length(wavelet_18(:,5)))/720,wavelet_18(:,3))
figure(4)
plot((1:length(wavelet_18(:,5)))/720,wavelet_18(:,4))
figure(5)
plot((1:length(wavelet_18(:,5)))/720,wavelet_18(:,5))
figure(6)
plot((1:length(wavelet_18(:,5)))/720,wavelet_18(:,6))
    
%% PCA
load('wavelet_19.mat')
load('wavelet_18.mat')
load('wavelet_17.mat')
Wavelets_final=[wavelet_19 wavelet_18 wavelet_17];
pca_2=pca(Wavelets_final,2);
pca_3=pca(Wavelets_final,3);
save("Wavelets_final.mat",'Wavelets_final');
save("pca_2.mat",'pca_2');
save("pca_3.mat",'pca_3'); 
%% MDS
load('Wavelets_final.mat')
dissimilarities = pdist(Wavelets_final);
dist = squareform(dissimilarities);
Y2=mdscale(dist,2,'Criterion','sstress');
Y3=mds(dist,3,'Criterion','sstress');
save("Y2.mat",'Y2')
save("Y3.mat",'Y3')

%% Plots PCA & MDS
load('pca_2.mat')
load('pca_3.mat')
%5=wake
%4=REM stage
%3=sleep stage N1
%2=sleep stage N2
%1=sleep stage N3
pca_2_2=pca_2.W;
pca_3_3=pca_3.W;
sleep_5 = dlmread('HypnogramAASM_subject5.txt',' ',1,0);
awake=find(sleep_5==5);
REM=find(sleep_5==4);
NREM_1=find(sleep_5==3);
NREM_2=find(sleep_5==2);
NREM_3=find(sleep_5==1);
pca_2_awake=pca_2_2(awake,:);
pca_2_REM=pca_2_2(REM,:);
pca_2_NREM_1=pca_2_2(NREM_1,:);
pca_2_NREM_2=pca_2_2(NREM_2,:);
pca_2_NREM_3=pca_2_2(NREM_3,:);
pca_3_awake=pca_3_3(awake,:);
pca_3_REM=pca_3_3(REM,:);
pca_3_NREM_1=pca_3_3(NREM_1,:);
pca_3_NREM_2=pca_3_3(NREM_2,:);
pca_3_NREM_3=pca_3_3(NREM_3,:);
%%
figure(1)
%plot 2D pca
plot(pca_2_awake(:,1),pca_2_awake(:,2),'bo',pca_2_REM(:,1),pca_2_REM(:,2)...
    ,'ro',pca_2_NREM_1(:,1),pca_2_NREM_1(:,2),'go',pca_2_NREM_2(:,1),...
    pca_2_NREM_2(:,2),'mo',pca_2_NREM_3(:,1),pca_2_NREM_3(:,2),'yo')
figure(2)
plot(pca_2_awake(:,1),pca_2_awake(:,2),'bo',pca_2_REM(:,1),pca_2_REM(:,2)...
    ,'ro',pca_2_NREM_1(:,1),pca_2_NREM_1(:,2),'ro',pca_2_NREM_2(:,1),...
    pca_2_NREM_2(:,2),'ro',pca_2_NREM_3(:,1),pca_2_NREM_3(:,2),'ro')
figure(3)
%plot 3D pca
plot3(pca_3_awake(:,1),pca_3_awake(:,2),pca_3_awake(:,3),'bo',pca_3_REM(:,1)...
    ,pca_3_REM(:,2),pca_3_REM(:,3),'ro',pca_3_NREM_1(:,1),pca_3_NREM_1(:,2),...
    pca_3_NREM_1(:,3),'go',pca_3_NREM_2(:,1),pca_3_NREM_2(:,2),...
    pca_3_NREM_2(:,3),'mo',pca_3_NREM_3(:,1),pca_3_NREM_3(:,2),pca_3_NREM_3(:,3),'yo')
figure(4)
%plot 3D pca
plot3(pca_3_awake(:,1),pca_3_awake(:,2),pca_3_awake(:,3),'bo',pca_3_REM(:,1)...
    ,pca_3_REM(:,2),pca_3_REM(:,3),'ro',pca_3_NREM_1(:,1),pca_3_NREM_1(:,2),...
    pca_3_NREM_1(:,3),'ro',pca_3_NREM_2(:,1),pca_3_NREM_2(:,2),...
    pca_3_NREM_2(:,3),'ro',pca_3_NREM_3(:,1),pca_3_NREM_3(:,2),pca_3_NREM_3(:,3),'ro')

%% Clustering
load('pca_2.mat')
load('pca_3.mat')
pca_2_2=pca_2.W;
pca_3_3=pca_3.W;

%2D K-Means
k_means_pca_2_2=kmeans(pca_2_2,2);
k_2_1=find(k_means_pca_2_2==1);
k_2_2=find(k_means_pca_2_2==2);

k_means_pca_2_5=kmeans(pca_2_2,5);
k_2_5_1=find(k_means_pca_2_5==1);
k_2_5_2=find(k_means_pca_2_5==2);
k_2_5_3=find(k_means_pca_2_5==3);
k_2_5_4=find(k_means_pca_2_5==4);
k_2_5_5=find(k_means_pca_2_5==5);

%3D K-Means
k_means_pca_3_2=kmeans(pca_3_3,2);
k_3_1=find(k_means_pca_3_2==1);
k_3_2=find(k_means_pca_3_2==2);

k_means_pca_3_5=kmeans(pca_3_3,5);
k_3_5_1=find(k_means_pca_3_5==1);
k_3_5_2=find(k_means_pca_3_5==2);
k_3_5_3=find(k_means_pca_3_5==3);
k_3_5_4=find(k_means_pca_3_5==4);
k_3_5_5=find(k_means_pca_3_5==5);


%Hierarquico 2D
hierq_2=linkage(pca_2_2,'ward','euclidean');
hierq_cluster_2=cluster(hierq_2,'maxclust',2);
h_2_1=find(hierq_cluster_2==1);
h_2_2=find(hierq_cluster_2==2);

hierq_2_5=linkage(pca_2_2,'ward','euclidean');
hierq_cluster_2_5=cluster(hierq_2_5,'maxclust',5);
h_2_5_1=find(hierq_cluster_2_5==1);
h_2_5_2=find(hierq_cluster_2_5==2);
h_2_5_3=find(hierq_cluster_2_5==3);
h_2_5_4=find(hierq_cluster_2_5==4);
h_2_5_5=find(hierq_cluster_2_5==5);

%Hierarquico 3D
hierq_3=linkage(pca_3_3,'ward','euclidean');
hierq_cluster_3=cluster(hierq_3,'maxclust',2);
h_3_1=find(hierq_cluster_3==1);
h_3_2=find(hierq_cluster_3==2);

hierq_3_5=linkage(pca_3_3,'ward','euclidean');
hierq_cluster_3_5=cluster(hierq_3_5,'maxclust',5);
h_3_5_1=find(hierq_cluster_3_5==1);
h_3_5_2=find(hierq_cluster_3_5==2);
h_3_5_3=find(hierq_cluster_3_5==3);
h_3_5_4=find(hierq_cluster_3_5==4);
h_3_5_5=find(hierq_cluster_3_5==5);



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