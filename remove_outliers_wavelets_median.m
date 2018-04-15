function outliers=remove_outliers_wavelets_median(wavelet,labels)
    label_awake=find(labels==5);
    label_rem=find(labels==4);
    label_n1=find(labels==3);
    label_n2=find(labels==2);
    label_n3=find(labels==1);
    wavelets={};
    for i=1:size(wavelet,2)
        awake=wavelet(label_awake,i);
        rem=wavelet(label_rem,i);
        n1=wavelet(label_n1,i);
        n2=wavelet(label_n2,i);
        n3=wavelet(label_n3,i);
        median_awake=median(awake);
        mad_awake=mad(awake);
        median_rem=median(rem);
        mad_rem=mad(rem);
        median_n1=median(n1);
        mad_n1=mad(n1);
        median_n2=median(n2);
        mad_n2=mad(n2);
        median_n3=median(n3);
        mad_n3=mad(n3);
        values_awake=find((awake<median_awake-3*mad_awake) | (awake>(median_awake+3*mad_awake)));
        values_rem=find((rem<(median_rem-3*mad_rem)) | (rem>(median_rem+3*mad_rem)));
        values_n1=find((n1<(median_n1-3*mad_n1)) | (n1>(median_n1+3*mad_n3)));
        values_n2=find((n2<(median_n2-3*mad_n2)) | (n2>(median_n2+3*mad_n2)));
        values_n3=find((n3<(median_n3-3*mad_n3)) | (n3>(median_n3+3*mad_n3)));
        
        
        values_awake_new=find((awake>=median_awake-3*mad_awake) & (awake<=(median_awake+3*mad_awake)));
        values_rem_new=find((rem>=(median_rem-3*mad_rem)) & (rem<=(median_rem+3*mad_rem)));
        values_n1_new=find((n1>=(median_n1-3*mad_n1)) & (n1<=(median_n1+3*mad_n3)));
        values_n2_new=find((n2>=(median_n2-3*mad_n2)) & (n2<=(median_n2+3*mad_n2)));
        values_n3_new=find((n3>=(median_n3-3*mad_n3)) & (n3<=(median_n3+3*mad_n3)));
        awake_new=awake(values_awake_new);
        rem_new=rem(values_rem_new);
        n1_new=n1(values_n1_new);
        n2_new=n2(values_n2_new);
        n3_new=n3(values_n3_new);
        wavelet_final=wavelet(:,i);
        wavelet_final(label_awake(values_awake))=mean(awake_new);
        wavelet_final(label_rem(values_rem))=mean(rem_new);
        wavelet_final(label_n1(values_n1))=mean(n1_new);
        wavelet_final(label_n2(values_n2))=mean(n2_new);
        wavelet_final(label_n3(values_n3))=mean(n3_new);
        wavelets(i)={wavelet_final};
    end
    outliers=[cell2mat(wavelets(1)) cell2mat(wavelets(2)) cell2mat(wavelets(3))...
        cell2mat(wavelets(4)) cell2mat(wavelets(5)) cell2mat(wavelets(6))];
end