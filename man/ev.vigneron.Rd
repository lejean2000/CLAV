% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ev.vigneron.R
\name{ev.vigneron}
\alias{ev.vigneron}
\title{Computes the Vigneron-Bergman Measure}
\usage{
ev.vigneron(x, y)
}
\arguments{
\item{x}{A vector with cluster assignments.}

\item{y}{A vector with cluster assignments.}
}
\value{
A positive number.
}
\description{
Vigneron-Bergman is a Bergman divergence measure, which can be used for cluster external validation. It is a positive number and higher values indicate less divergence, hence better clustering results.
}
\examples{
d<-vegan::vegdist (iris[,3:4], method = "euclidean")
c<-cluster::pam (d, 3, diss = TRUE)
ev.vigneron (c$clustering, unclass(iris$Species))
}
\references{
\url{https://hal.archives-ouvertes.fr/file/index/docid/203354/filename/es2006-148.pdf}
}
