.setUp <-
  function()
  {
    # Crawl
    synObj <- crawlSynapseObject('syn3157162')
    synObj <- makeHeadFolder(synObj,'syn3157162')
    populateNewDirectory2('syn3157160',synObj,topId = 'syn3157160')
  }

.tearDown <-
  function()
  {

  }

