request = require 'request'
cheerio = require 'cheerio'
moment = require 'moment'


class Socialblade


getDateCountPairsFromScript = (script) ->
  dateCountStrings = script.match /"[0-9]*,.?[0-9]*\\n"/g
  
  result = []
  return result  if not dateCountStrings?
  
  for dateCountString in dateCountStrings
    dateCountString = dateCountString.replace /"/g, ''
    dateCountString = dateCountString.replace /\\n/g, ''
    dateCountPair = dateCountString.split ','

    result.push
      date: moment(dateCountPair[0], 'YYYYMMDD').toDate()
      count: parseInt dateCountPair[1]

  result


Socialblade.loadChannelData = (channelId, options, callback) ->
  callback = options  if typeof options is 'function'

  result = {}

  request
    url: "http://socialblade.com/youtube/user/#{channelId}"
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
        if /graphdivtotalchanviews/.test script
          result.totalChannelViews = getDateCountPairsFromScript script
        if /graphavgviewsperdaypermo/.test script
          result.avarageViewsPerDayPerMonth = getDateCountPairsFromScript script
        if /graphtotalviewsperdaypermo/.test script
          result.totalViewsPerDayPerMonth = getDateCountPairsFromScript script

      return callback null, null  if not result.totalSubscribers?

      result.byDate = {}
      for totalSubscriber, index in result.totalSubscribers
        date = totalSubscriber.date
        result.byDate[date] =
          totalSubscribers: totalSubscriber.count
          totalVideoViews: result.totalVideoViews[index].count
          totalChannelViews: result.totalChannelViews[index].count

      callback null, result


Socialblade.getPartnerIdByVideoId = (videoId, callback) ->
  request
    url: "http://www.youtube.com/watch?v=#{videoId}"
  ,
    (err, res, body) ->
      return callback err  if err?

      $ = cheerio.load body
      partnerIdImageTag = $('img[src^="//www.youtube-nocookie.com/gen_204?attributionpartner="]')
      return callback null, null  if partnerIdImageTag.length is 0

      partnerId = partnerIdImageTag.attr('src').split('=')[1]
      partnerId = decodeURIComponent partnerId
      callback null, partnerId



module.exports = Socialblade
