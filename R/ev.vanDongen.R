#' Computes the van Dongen criterion
#'
#' @param x A vector with cluster assignments.
#' @param y A vector with cluster assignments.
#' @return The value of van Dongen criterion. An integer between 0 and 1. Lower values indicate better cluster similarity.
#' @examples
#' d<-vegan::vegdist (iris[,3:4], method = "euclidean")
#' c<-cluster::pam (d, 3, diss = TRUE)
#' ev.vanDongen(c$clustering, unclass(iris$Species))
ev.vanDongen<-function(x, y){

	#Try to coerce x and y to vectors
	x=as.vector(x)
	y=as.vector(y)

	#check if x and y are vectors of equal length
	if (!is.vector(x)||!is.vector(y)||length(x)!=length(y)) {
		stop("clav.vanDongen needs two vectors of equal length")
	}
	
	Kx = length(unique(x))
	Ky = length(unique(y))
	#build the contingency table
	ctab = ftable(x, y)

	#append row min, max and sum
	ctmp=cbind(ctab, 
				max=apply(ctab, 1, max), 
				min=apply(ctab, 1, min),
				total=apply(ctab, 1, sum)
		)
	
	#append col min, max and sum
	ctab2=rbind(
			ctmp, 
			max=apply(ctmp, 2, max), 
			min=apply(ctmp, 2, min),
			total=apply(ctmp, 2, sum)
		)
	
	#clean up temp variable
	rm(ctmp)
	
	#total number of objects in all clusters
	n=ctab2['total','total']
	
	#ctab2['total','max']=sum(ctab2[1:4,'max'])
	#ctab2['max','total']=sum(ctab2['max',1:4])
	
	return ((2*n-sum(ctab2[1:Kx,'max'])-sum(ctab2['max',1:Ky]))/(2*n))
}