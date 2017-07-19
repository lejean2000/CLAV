#' @title Computes the Mutual Information Measure
#' 
#' @description Mutual information is a Kullback-Leibler type of measure for directed divergence. It is a positive number varying from 0 to log2(C), where C is the number of clusters. Higher values indicate less divergence, hence better clustering results. Please note that MI is a not suitable for k-means clustering validation in highly imbalanced datasets because it cannot capture the inbalance. MI is equivalent to the entropy measure.
#' 
#' @param x A vector with cluster assignments.
#' @param y A vector with cluster assignments.
#' @return A positive number.
#' @export
#' @examples
#' d<-vegan::vegdist (iris[,3:4], method = "euclidean")
#' c<-cluster::pam (d, 3, diss = TRUE)
#' ev.mi (c$clustering, unclass(iris$Species))
ev.mi<-function(x, y){
  
  #Try to coerce x and y to vectors
  x=as.vector(x)
  y=as.vector(y)
  
  #check if x and y are vectors of equal length
  if (!is.vector(x)||!is.vector(y)||length(x)!=length(y)) {
    stop("ev.entropy() needs two vectors of equal length")
  }
  
  Kx = length(unique(x))
  Ky = length(unique(y))
  
  #build the contingency table
  ctab = ftable(x, y)
  
  #append row/col sums
  ctab2 = addmargins(ctab,FUN=c(total=sum), quiet=T)
  
  #total number of objects in all clusters
  n = ctab2['total','total']
  
  #convert contingency table to proportions
  p = ctab2/n
  
  #start calculation. Take care of NaN caused by zeros.
  q = log2(t(t(p[1:Kx,1:Ky]/p[1:Kx,'total'])/p['total',1:Ky]))
  q[is.infinite(q)]<-0
  
  return (sum(p[1:Kx,1:Ky]*q))
}