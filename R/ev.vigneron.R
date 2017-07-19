#' @title Computes the Vigneron-Bergman Measure
#' 
#' @description Vigneron-Bergman is a Bergman divergence measure, which can be used for cluster external validation. It is a positive number and higher values indicate less divergence, hence better clustering results.
#' 
#' @param x A vector with cluster assignments.
#' @param y A vector with cluster assignments.
#' @return A positive number.
#' @references
#' \url{https://hal.archives-ouvertes.fr/file/index/docid/203354/filename/es2006-148.pdf}
#' @export
#' @examples
#' d<-vegan::vegdist (iris[,3:4], method = "euclidean")
#' c<-cluster::pam (d, 3, diss = TRUE)
#' ev.vigneron (c$clustering, unclass(iris$Species))
ev.vigneron<-function(x, y){
  
  #Try to coerce x and y to vectors
  x=as.vector(x)
  y=as.vector(y)
  
  #check if x and y are vectors of equal length
  if (!is.vector(x)||!is.vector(y)||length(x)!=length(y)) {
    stop("ev.vigneron() needs two vectors of equal length")
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
  q = p[1:Kx,1:Ky]*q-p[1:Kx,1:Ky]+p[1:Kx,'total']%*%t(p['total',1:Ky])
  q[is.nan(q)]<-0
  
  return (sum(q))
  
}