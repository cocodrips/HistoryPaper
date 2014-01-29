# Singleton
class @SelectTopFromCluster
  constructor: ()->
    @pickedUpDomain = []

  # Todo: Naming
  getTopHistoryFromHistories: (histories)->

    if histories.length < 1
      return ''

    articles = []
    i = 0
    for history in histories
      articles[i++] = new Article(history, @calcScore(history))
    articles.sort (a, b)->
      return -1 if a.score > b.score
      return 1 if a.score < b.score
      return 0

    for article in articles
      domainType = article.history.url.split("/")[2]
      if domainType && !_.include(@pickedUpDomain, domainType)
        @pickedUpDomain.push(domainType)
        return article.history
    return ''

  calcScore:(history)->
    return history.visitCount


class Article
  constructor: (@history, @socre)->
