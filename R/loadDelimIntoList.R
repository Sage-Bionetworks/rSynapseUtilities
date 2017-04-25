loadDelimIntoList <- function(synIds){
  foo <- lapply(synIds,synapseClient::synGet)
  fileLocations <- lapply(foo,synapseClient::getFileLocation)
  bar <- lapply(fileLocations,data.table::fread,data.table=FALSE)
  names(bar) <- synIds
  return(bar)
}
