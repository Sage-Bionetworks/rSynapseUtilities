makeTablesynapser <- function(df,
                      tableName,
                      projectId,
                      annos=NULL,
                      proven=NULL){
  ####df: data frame
  ####tableName: name of the table
  ####projectId: project where table will go
  ####annos: optional named vector of key value pairs for annoations
  ####proven: a list with slots 'used' and 'executed' that are named list of used or executed character strings
  ####returns table object

  synapser::synLogin()
  schema <- synapser::Schema(name=tableName, parent=projectId)
  fileName<-tempfile(pattern = "file", tmpdir = tempdir(),fileext='.csv')
  write.csv(df,file=fileName,quote=F,row.names=F)
  table<-synapser::Table(schema,fileName)
  table<-synapser::synStore(table,retrieveData=TRUE)
  return(table)
}
