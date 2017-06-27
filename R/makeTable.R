makeTable <- function(df,
                      tableName,
                      projectId,
                      annos=NULL,
                      proven=NULL){

  ####df: data frame
  ####tableName: name of the table
  ####projectId: project where table will go
  ####annos: optional named list of key value pairs for annoations
  ####proven: a list with slots 'used' and 'executed' that are named list of used or executed character strings

  ####returns table object

  synapseClient::synapseLogin()
  tcresult<-synapseClient::as.tableColumns(df)
  cols<-tcresult$tableColumns
  fileHandleId<-tcresult$fileHandleId
  project<-synapseClient::synGet(projectId)
  schema<-synapseClient::TableSchema(name=tableName,
                                     parent=project,
                                     columns=cols)
  table<-synapseClient::Table(schema,
                              fileHandleId)
  if(!is.null(annos)){
    synapseClient::synSetAnnotation(table)<-annos
  }
  if(!is.null(proven)){
    table<-synapseClient::synStore(table,
                                   retrieveData=TRUE,
                                   used=proven$used,
                                   executed=proven$executed)
  }else{
    table<-synapseClient::synStore(table,
                                   retrieveData=TRUE)
  }
  return(table)
}
