x <- matrix(c(2,5,-3,-1,-2,0,2,1,0,-5,-4,-3,1,5,-1,-3,-3,-5),nrow=6)
rownames(x)<- letters[1:6]
colnames(x)<- c("V1","V2","V3")
x

#trasform to distance matrix and use Euclidean
D1 <- as.matrix(dist(x,method="euclidean"))
D1

#Squared Euclidean
D2<- D1 * D1
D2
#Manhattan
D3<- as.matrix(dist(x,method="manhattan"))
D3

#Single/complete/average lineage
h<- hclust(as.dist(D3),"single")
h
plot(as.dendrogram(h))

h1<- hclust(as.dist(D3),"complete")
h1
plot(as.dendrogram(h1))

h2<- hclust(as.dist(D3),"average")
h2
plot(as.dendrogram(h2))


U<- c("a","b")
V <- c("c","d","e","f")
u<- colMeans(x[U,])
u
v<- colMeans(x[V,])
v

dist(rbind(u,v))
