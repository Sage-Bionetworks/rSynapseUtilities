loadFullTable <- function(synId){
  str <- paste0("select * from ",synId)
  synapseClient::synapseLogin()
  foobar <- synapseClient::synTableQuery(str)@values
  return(foobar)
}
