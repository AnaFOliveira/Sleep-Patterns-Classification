function outliers=remove_outliers_wavelets(wavelet,labels)
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
        mean_awake=mean(awake);
        std_awake=std(awake);
        mean_rem=mean(rem);
        std_rem=std(rem);
        mean_n1=mean(n1);
        std_n1=std(n1);
        mean_n2=mean(n2);
        std_n2=std(n2);
        mean_n3=mean(n3);
        std_n3=std(n3);
        values_awake=find((awake<mean_awake-3*std_awake) | (awake>(mean_awake+3*std_awake)));
        values_rem=find((rem<(mean_rem-3*std_rem)) | (rem>(mean_rem+3*std_rem)));
        values_n1=find((n1<(mean_n1-3*std_n1)) | (n1>(mean_n1+3*std_n3)));
        values_n2=find((n2<(mean_n2-3*std_n2)) | (n2>(mean_n2+3*std_n2)));
        values_n3=find((n3<(mean_n3-3*std_n3)) | (n3>(mean_n3+3*std_n3)));
        
        values_awake_new=find((awake>=mean_awake-3*std_awake) & (awake<=(mean_awake+3*std_awake)));
        values_rem_new=find((rem>=(mean_rem-3*std_rem)) & (rem<=(mean_rem+3*std_rem)));
        values_n1_new=find((n1>=(mean_n1-3*std_n1)) & (n1<=(mean_n1+3*std_n3)));
        values_n2_new=find((n2>=(mean_n2-3*std_n2)) & (n2<=(mean_n2+3*std_n2)));
        values_n3_new=find((n3>=(mean_n3-3*std_n3)) & (n3<=(mean_n3+3*std_n3)));
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