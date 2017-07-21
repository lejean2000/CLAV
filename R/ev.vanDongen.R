#' @title Computes the van Dongen criterion
#' 
#' @description The van Dongen criterion is an external validation measure of the representativeness of the majority objects in each class and each cluster. It is an number between 0 and 1 and lower values indicate better cluster similarity. Even though the van Dongen measure is normalized, this is achieved by deleting by 2*n which is an absolute upper bound that is not tight. Hence, a special normalization with a tighter upper bound is also provided (by using \code{normalized=T}).
#' 
#' @param x A vector with cluster assignments.
#' @param y A vector with cluster assignments.
#' @param normalized T or F(default). Indicate whether to normalize the measure or not.
#' @return A number between 0 and 1.
#' @references 
#' \url{http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.26.9783&rep=rep1&type=pdf}
#' @export
#' @examples
#' d<-vegan::vegdist (iris[,3:4], method = "euclidean")
#' c<-cluster::pam (d, 3, diss = TRUE)
#' ev.vanDongen(c$clustering, unclass(iris$Species))
ev.vanDongen<-function(x, y, normalized=F){

	#Try to coerce x and y to vectors
	x=as.vector(x)
	y=as.vector(y)

	#check if x and y are vectors of equal length
	if (!is.vector(x)||!is.vector(y)||length(x)!=length(y)) {
		stop("ev.vanDongen needs two vectors of equal length")
	}
	
	n = length(x)
	Kx = length(unique(x))
	Ky = length(unique(y))
	
	#build the contingency table
	ctab = ftable(x, y)

	#append row min, max and sum
	ctmp=cbind(ctab, 
				max=apply(ctab, 1, max), 
				total=apply(ctab, 1, sum)
		)
	
	#append col min, max and sum
	ctab2=rbind(
			ctmp, 
			max=apply(ctmp, 2, max), 
			total=apply(ctmp, 2, sum)
		)
	
	#clean up temp variable
	rm(ctmp)
	
	vd = 2*n-sum(ctab2[1:Kx,'max'])-sum(ctab2['max',1:Ky])
	
	if (normalized)
	  return (vd/( 2*n - max(ctab2[1:Kx,'max']) - max(ctab2['max',1:Ky]) ))
	else 
	  return (vd/( 2*n ))
}