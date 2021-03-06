% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ev.mi.R
\name{ev.mi}
\alias{ev.mi}
\title{Computes the Mutual Information Measure}
\usage{
ev.mi(x, y)
}
\arguments{
\item{x}{A vector with cluster assignments.}

\item{y}{A vector with cluster assignments.}
}
\value{
A positive number.
}
\description{
Mutual information is a Kullback-Leibler type of measure for directed divergence. It is a positive number varying from 0 to log2(C), where C is the number of clusters. Higher values indicate less divergence, hence better clustering results. Please note that MI is a not suitable for k-means clustering validation in highly imbalanced datasets because it cannot capture the inbalance. MI is equivalent to the entropy measure.
}
\examples{
d<-vegan::vegdist (iris[,3:4], method = "euclidean")
c<-cluster::pam (d, 3, diss = TRUE)
ev.mi (c$clustering, unclass(iris$Species))
}
