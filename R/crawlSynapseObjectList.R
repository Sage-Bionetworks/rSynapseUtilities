###function to crawl directory structure and return the structure
#' @export
crawlSynapseObjectList <- function(synId,G=NULL){
  #depth first search
  #source('adjacentEdges.R')
  
  result <- adjacentEdges(synId);
  while(!is.null(result)){
    #add new nodes to graph if necessary
    #b <- setdiff(result$entity.name,G$name)
    #d <- setdiff(result$entity.type,G$type)
    if(is.null(G)){ 
        G <- list()
        #G$adj <- c()
        id1 <- c(synId,result$entity.id);
        name1 <- c('head',result$entity.name);
        type1 <- c('head',result$entity.concreteType);
        G$id <- id1
        G$name <- name1
        G$type <- type1
        G$adjList <- vector('list',length(G$id))
        names(G$adjList) <- G$id
        #G$adj <- matrix(0,length(G$id),length(G$id))
        #rownames(G$adj) <- G$id
        #colnames(G$adj) <- G$id
        #print(G)
      }else{
        a <- which(!result$entity.id%in%G$id);
        id1 <- result$entity.id[a];
        #print(id1)
        name1 <- result$entity.name[a];
        #print(name1)
        type1 <- result$entity.concreteType[a];
        #print(type1)
        if(length(a)>0){
          #print(G$adj)
          #print(G$id)
          #print(a)
          #G$adj <- cbind(G$adj,matrix(0,length(G$id),length(a)));
          G$adjList <- c(G$adjList,vector('list',length(id1)))
          #G$adj <- rbind(G$adj,matrix(0,length(a),length(G$id)+length(a)));
          G$id <- c(G$id,id1);
          G$name <- c(G$name,name1);
          G$type <- c(G$type,type1);
          names(G$adjList) <- G$id;
          
        }
      }
    for (i in 1:length(result$entity.id)){
      #if(G$adj[as.character(synId),as.character(result$entity.id[i])]==0){
      if(!as.character(result$entity.id[i])%in%G$adjList[[as.character(synId)]]){
        #G$adj[as.character(synId),as.character(result$entity.id[i])] <- 1;
        G$adjList[[as.character(synId)]] <- c(G$adjList[[as.character(synId)]],
                                              as.character(result$entity.id[i]))
        #print(result$entity.id)
        #print('a')
        cat('Crawling',result$entity.id[i],'\n')
        cat('Number of branches:',length(c(unlist(G$adjList))),'\n')
        cat('Number of nodes:',length(G$adjList),'\n')
        G <- crawlSynapseObjectList(result$entity.id[i],G) 
      }else{
        return(G)
      }
    }
  }
  return(G)
}