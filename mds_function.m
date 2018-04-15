function result_mds=mds_function(wavelet,dim,criterion,dist_metric)
    dissimilarities = pdist(wavelet,dist_metric);
    dist = squareform(dissimilarities);
    result_mds=mdscale(dist,dim,'Criterion',criterion);
end

