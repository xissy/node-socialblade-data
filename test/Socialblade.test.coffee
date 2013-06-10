should = require 'should'

Socialblade = require '../lib/Socialblade'


describe 'Socialblade', ->
  channelId = 'sment'

  describe '.loadChannelData(...)', ->
    it 'should be done', (done) ->
      Socialblade.loadChannelData channelId, (err, data) ->
        should.not.exist err
        should.exist data

        data.dailySubscribersGained.should.not.be.empty
        data.totalSubscribers.should.not.be.empty
        data.dailyVideoViews.should.not.be.empty
        data.totalVideoViews.should.not.be.empty
        data.dailyChannelViews.should.not.be.empty
        data.totalChannelViews.should.not.be.empty
        data.avarageViewsPerDayPerMonth.should.not.be.empty
        data.totalViewsPerDayPerMonth.should.not.be.empty
        Object.keys(data.byDate).length.should.equal data.totalSubscribers.length
        
        done()
        
  describe '.getPartnerIdByVideoId(...)', ->
    it 'should be done', (done) ->
      videoId = 'vqsthBOE1Dc'
      Socialblade.getPartnerIdByVideoId videoId, (err, data) ->
        should.not.exist err
        should.exist data
        
        done()

    it 'should be done', (done) ->
      videoId = 'hEQNz3Rdst0'
      Socialblade.getPartnerIdByVideoId videoId, (err, data) ->
        should.not.exist err
        should.not.exist data
        
        done()
        