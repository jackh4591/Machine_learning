pokemon <- read.csv("pokemon.csv", sep = ",")
head(pokemon)


#first just plot the speed vs defence to have a general look at the data

library(ggplot2)
ggplot(pokemon, aes(x = Speed, y = Defense)) +
  geom_point() +
  ggtitle("Pokemon Species, Speed vs Defense") +
  xlab("Speed") +
  ylab("Defense")


#In order to determine the number of clusters we use an elbow plot, this will allow us to visualize where the increase in clusters causes the most effective kmeans results.

#The optimal clustering assignment will have the lowest total within sum of squares (twss) value. This is defined as the sum of the distance of every point to their assigned cluster center (centroid). Thinking about this visually, a dataset with a low twss value will have their datapoints clumped together in obvious clusters, whereas not so obvious clusters will have a high twss value.

#A K-means function with a k value of 1 would only have 1 centroid, so the twss value of this function would be extremely high considering the sum of the distances of each point on the edge of the plot to the centroid would significantly increase the twss value. But if the k value is 2, the sum of the distances of these points to their respective centroids decreases markedly, thus decreasing the twss value. This trend continues as k increases until twss ceases to decrease substantially.

twss <- 0
for (i in 1:15) {
    km.out <- kmeans(pokemon_speed_defense, centers = i, nstart = 20, iter.max = 50)
    twss[i] <- km.out$tot.withinss
}

elbow <- data.frame(c(1:15), twss)
ggplot(elbow, aes(x = c.1.15., y = twss)) +
  geom_point() + 
  geom_line() + 
  ggtitle("Pokemon Species TWSS Elbow Plot") + 
  xlab("K value") +
  ylab("TWSS")


#So now we can cluster these in order to classify these into their own groups, and from looking at the elbow plot above we determine to use k=4 clusters

k <- 4
pokemon_speed_defense <- pokemon[,c(11,8)]
km.out <- kmeans(pokemon_speed_defense, centers = k, nstart = 20, iter.max = 50)

ggplot(pokemon_speed_defense, aes(x = Speed, y = Defense, color = factor(km.out$cluster))) +
  geom_point() +
  labs(color = "Cluster") +
  ggtitle("Pokemon Species Speed vs Defense")



#to break down the algorithm we look at its steps 

# Algorithm steps: 
# 1. Randomly assign each point to one of the k clusters 
# 2. Calculate the centers (or centroids) of each of the clusters
# 3. Each point in the dataset is assigned to the cluster of the nearest centroid 
# 4. Recalculate coordinates of centroid again with new dataset cluster assignments 
# 5. Repeat until dataset cluster assignments do not change (error = 0)



