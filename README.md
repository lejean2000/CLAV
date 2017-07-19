# CLAV
An R package for Cluster Validation

## Description
Clustering is the task of partitioning a set of objects into clusters of similar objects, while at the same time maximizing the difference between objects in different clusters. In order to be successful, clustering needs quantifiable measures, which evalute how good the clusters are.

The two main groups of measures will be implemented - external and internal validation measures. External validation makes use of information not present in the data to assess whether the formed clusters match some external structre (e.g. pre-existing object labels). On the other hand, internal validation measures evaluate the goodness of a clustering structure without respect to any external information.

External measures which will be implemented include: mutual linformation, F-measure, information variation, Fowlkes & Mallows index, Hubert Γ statistics, Goodman-Kruskal coeficient, etc.

Internal measures which will be implemented include: Root-mean-square standard deviation, Dunn’s index, Silhouette index, CVNN index, Calinski-Harabasz index, etc.

## Current Status
This package has just been created. It has very few external cluster validation measures implemented. 

The ev.vanDongen() function computes the value of the van Dongen crietrion. More about it [can be read here]( http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.26.9783&rep=rep1&type=pdf)

The ev.mi() function calculates the mutual information measure.