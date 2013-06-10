request = require 'request'
cheerio = require 'cheerio'
moment = require 'moment'


class Socialblade


getDateCountPairsFromScript = (script) ->
  dateCountStrings = script.match /"[0-9]*,.?[0-9]*\\n"/g
  
  result = []
  
  for dateCountString in dateCountStrings
    dateCountString = dateCountString.replace /"/g, ''
    dateCountString = dateCountString.replace /\\n/g, ''
    dateCountPair = dateCountString.split ','

    result.push
      date: moment(dateCountPair[0], 'YYYYMMDD').toDate()
      count: parseInt dateCountPair[1]

  result


Socialblade.loadUserData = (user, options, callback) ->
  callback = options  if typeof options is 'function'

  result = {}

  request
    url: "http://socialblade.com/youtube/user/#{user}"
  ,
    (err, res, body) ->
      return callback err  if err?

      $ = cheerio.load body
      $('script').each (index, element) ->
        script = $(this).text()

        if /graphdivdailysub/.test script
          result.dailySubscribersGained = getDateCountPairsFromScript script
        if /graphdivtotalsubs/.test script
          result.totalSubscribers = getDateCountPairsFromScript script
        if /graphdivdailyviews/.test script
          result.dailyVideoViews = getDateCountPairsFromScript script
        if /graphdivtotalviews/.test script
          result.totalVideoViews = getDateCountPairsFromScript script
        if /graphdivdailychanviews/.test script
          result.dailyChannelViews = getDateCountPairsFromScript script
        if /graphavgviewsperdaypermo/.test script
          result.avarageViewsPerDayPerMonth = getDateCountPairsFromScript script
        if /graphtotalviewsperdaypermo/.test script
          result.totalViewsPerDayPerMonth = getDateCountPairsFromScript script

      callback null, result



module.exports = Socialblade
