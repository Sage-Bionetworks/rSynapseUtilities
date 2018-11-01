pushDf2Synapse <- function(df,
                           fileName,
                           synapseFolderId,
                           annos,
                           comment,
                           usedVector,
                           executedVector,
                           activityName1,
                           activityDescription1,
                           login=TRUE){
  if(login){
    synapser::synLogin()
  }

  #write the file to a csv file
  write.csv(df,
            file=fileName,
            quote=F,
            row.names=F)

  foo <- synapser::File(fileName,
                        parentId=synapseFolderId,
                        versionComment=comment,
                        annotations=as.list(annos))

  foo = synapser::synStore(foo,
                           used = as.list(usedVector),
                           executed = as.list(executedVector),
                           activityName = activityName1,
                           activityDescription = activityDescription1)

  return(foo)

}
