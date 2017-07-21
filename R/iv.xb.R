#' @title Computes the Xie-Beni index
#' 
#' @description The Xie-Beni index is an internal cluster validation index. It deﬁnes the intercluster separation as the minimum square distance between cluster centers, and the intraclus ter compactness as the mean square distance between each data object and its cluster center. It can be used for fuzzy clustering as well. The weighted variant (default is usually the better option.
#' 
#' @param clustering A vector with cluster assignments or a membership matrix.
#' @param centers A vector with cluster center IDs.
#' @param diss A distance matrix.
#' @param variant Weighted (XB*) or normal (XB) formula. Check the reference for more detail.
#' @return A number.
#' @references 
#' \url{https://www.researchgate.net/profile/Minho_Kim7/publication/222750120_New_indices_for_cluster_validity_assessment/links/02e7e53c567697580d000000.pdf}
#' @export
#' @examples
#' d<-vegan::vegdist (iris[,3:4], method = "euclidean")
#' models = list()
#' 
#' for (k in 3:5) 
#'   models[[length(models)+1]] = fclust::FKM.med(as.matrix(d), k)
#' 
#' for (v in c('normal','weighted'))
#'   for (f in models)
#'     print(paste (ncol(f$U),'clusters -', v, '-', iv.xb(f$U, f$medoid, d, variant=v)))
iv.xb<-function(clustering, centers, diss, variant='weighted'){

	#Try to coerce diss to matrix
  diss=as.matrix(diss)
  
  if (!is.matrix(diss)) {
    stop("invalid input parameters to iv.xb()")
  }
  
  #check more than one cluster
  if (length(centers)<2) {
    print(centers)
    stop("Xie-Beni index needs more than 1 cluster to work")
  }
  
  if (is.vector(clustering)){
    nc = length(unique(clustering))
    n = length(clustering)
    
    #transform cluster names into consecutive numbers
    map = setNames(seq(1:nc), unique(clustering))
    clustering = sapply(clustering, function(x) map[as.character(x)])
    
    #transform vector clustering into membership matrix
    m = matrix(nrow = n, ncol = nc)
    for(i in 1:nc) m[which(clustering==i),i]=1
    m[is.na(m)]<-0
    
  } else if (is.matrix(clustering)){
    nc = ncol(clustering)
    n = nrow(clustering)
    
    m = clustering
    colnames(m)<-seq(1:nc)
  }

	x = 0
	
	for(i in 1:length(centers)) {
	  
	  if (variant == 'normal') {
	    weight = n
	  } else {
	    weight = sum(m[,i]) 
	  }
	  x=x+sum( diss[centers[i],]^2 * t(m[,i])^2 )/weight
	}
	
	dc = diss[centers,centers]^2
	
	return (x/min(dc[row(dc)!=col(dc)]))
}