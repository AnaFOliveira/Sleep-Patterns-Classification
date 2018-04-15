load ('wavelet_17.mat')
load ('wavelet_18.mat')
load ('wavelet_19.mat')
load ('labels_5')
load ('labels_6')

wavelet_estimativa_4_outliers = remove_outliers_wavelets(wavelet_17,labels_6);
wavelet_estimativa_5_outliers = remove_outliers_wavelets(wavelet_18,labels_6);
wavelet_estimativa_6_outliers = remove_outliers_wavelets(wavelet_19,labels_6);

wavelet_estimativa_4_outliers2 = remove_outliers_wavelets_median(wavelet_estimativa_4_outliers,labels_6);
wavelet_estimativa_5_outliers2 = remove_outliers_wavelets_median(wavelet_estimativa_5_outliers,labels_6);
wavelet_estimativa_6_outliers2 = remove_outliers_wavelets_median(wavelet_estimativa_6_outliers,labels_6);

save("wavelet_estimativa_4_outliers",'wavelet_estimativa_4_outliers')
save("wavelet_estimativa_5_outliers",'wavelet_estimativa_5_outliers')
save("wavelet_estimativa_6_outliers",'wavelet_estimativa_6_outliers')
save("wavelet_estimativa_4_outliers2",'wavelet_estimativa_4_outliers2')
save("wavelet_estimativa_5_outliers2",'wavelet_estimativa_5_outliers2')
save("wavelet_estimativa_6_outliers2",'wavelet_estimativa_6_outliers2')

%%
load('wavelet_17.mat')
load('wavelet_18.mat')
load('wavelet_19.mat')

wavelet_final=[wavelet_17 wavelet_18 wavelet_19];

mds_2_6_eucli=mds_function(wavelet_final,2,'sstress','euclidean');
save("mds_2_6_eucli.mat",'mds_2_6_eucli')
clear all
%%
load('wavelet_17.mat')
load('wavelet_18.mat')
load('wavelet_19.mat')

wavelet_final=[wavelet_17 wavelet_18 wavelet_19];
mds_3_6_eucli=mds_function(wavelet_final,3,'sstress','euclidean');
save("mds_3_6_eucli.mat",'mds_3_6_eucli')
clear all 
%%
load('wavelet_17.mat')
load('wavelet_18.mat')
load('wavelet_19.mat')

wavelet_final=[wavelet_17 wavelet_18 wavelet_19];
mds_2_6_mahalo=mds_function(wavelet_final,2,'sstress','mahalanobis');
save("mds_2_6_mahalo.mat",'mds_2_6_mahalo')
clear all 
%%
load('wavelet_17.mat')
load('wavelet_18.mat')
load('wavelet_19.mat')

wavelet_final=[wavelet_17 wavelet_18 wavelet_19];
mds_3_6_mahalo=mds_function(wavelet_final,3,'sstress','mahalanobis');
save("mds_3_6_mahalo.mat",'mds_3_6_mahalo')
clear all 
%%
load('wavelet_estimativa_4_outliers')
load('wavelet_estimativa_5_outliers')
load('wavelet_estimativa_6_outliers')

wavelet_final_outliers=[wavelet_estimativa_5_outliers wavelet_estimativa_5_outliers wavelet_estimativa_6_outliers];
mds_2_6_eucli_outliers=mds_function(wavelet_final_outliers,2,'sstress','euclidean');
save("mds_2_6_eucli_outliers.mat",'mds_2_6_eucli_outliers')
clear all 
%%
load('wavelet_estimativa_4_outliers')
load('wavelet_estimativa_5_outliers')
load('wavelet_estimativa_6_outliers')

wavelet_final_outliers=[wavelet_estimativa_5_outliers wavelet_estimativa_5_outliers wavelet_estimativa_6_outliers];
mds_3_6_eucli_outliers=mds_function(wavelet_final_outliers,3,'sstress','euclidean');
save("mds_3_6_eucli_outliers.mat",'mds_3_6_eucli_outliers')
clear all 
%%
load('wavelet_estimativa_4_outliers')
load('wavelet_estimativa_5_outliers')
load('wavelet_estimativa_6_outliers')

wavelet_final_outliers=[wavelet_estimativa_5_outliers wavelet_estimativa_5_outliers wavelet_estimativa_6_outliers];
mds_2_6_mahalo_outliers=mds_function(wavelet_final_outliers,2,'sstress','mahalanobis');
save("mds_2_6_mahalo_outliers.mat",'mds_2_6_mahalo_outliers')
clear all 
%%
load('wavelet_estimativa_4_outliers')
load('wavelet_estimativa_5_outliers')
load('wavelet_estimativa_6_outliers')

wavelet_final=[wavelet_17 wavelet_18 wavelet_19];
mds_3_6_mahalo_outliers=mds_function(wavelet_final_outliers,2,'sstress','mahalanobis');
save("mds_3_6_mahalo_outliers.mat",'mds_3_6_mahalo_outliers')
clear all 
%%
load('wavelet_estimativa_4_outliers2')
load('wavelet_estimativa_5_outliers2')
load('wavelet_estimativa_6_outliers2')

wavelet_final_outliers2=[wavelet_estimativa_4_outliers2 wavelet_estimativa_5_outliers2 wavelet_estimativa_6_outliers2];
mds_2_6_eucli_outliers2=mds_function(wavelet_final_outliers2,2,'sstress','euclidean');
save("mds_2_6_eucli_outliers2.mat",'mds_2_6_eucli_outliers2')
clear all 
%% 
load('wavelet_estimativa_4_outliers2')
load('wavelet_estimativa_5_outliers2')
load('wavelet_estimativa_6_outliers2')

wavelet_final_outliers2=[wavelet_estimativa_4_outliers2 wavelet_estimativa_5_outliers2 wavelet_estimativa_6_outliers2];
mds_3_6_eucli_outliers2=mds_function(wavelet_final_outliers2,3,'sstress','euclidean');
save("mds_3_6_eucli_outliers2.mat",'mds_3_6_eucli_outliers2')
clear all 
%%
load('wavelet_estimativa_4_outliers2')
load('wavelet_estimativa_5_outliers2')
load('wavelet_estimativa_6_outliers2')

wavelet_final_outliers2=[wavelet_estimativa_4_outliers2 wavelet_estimativa_5_outliers2 wavelet_estimativa_6_outliers2];
mds_2_6_mahalo_outliers2=mds_function(wavelet_final_outliers2,2,'sstress','mahalanobis');
save("mds_2_6_mahalo_outliers2.mat",'mds_2_6_mahalo_outliers2')
clear all 
%%
load('wavelet_estimativa_4_outliers2')
load('wavelet_estimativa_5_outliers2')
load('wavelet_estimativa_6_outliers2')


wavelet_final_outliers2=[wavelet_estimativa_4_outliers2 wavelet_estimativa_5_outliers2 wavelet_estimativa_6_outliers2];
mds_3_6_mahalo_outliers2=mds_function(wavelet_final_outliers2,3,'sstress','mahalanobis');
save("mds_3_6_mahalo_outliers2.mat",'mds_3_6_mahalo_outliers2')
clear all 