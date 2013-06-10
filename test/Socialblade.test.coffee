should = require 'should'

Socialblade = require '../lib/Socialblade'


describe 'Socialblade', ->
  user = 'sment'

  describe '.loadUserData(...)', ->
    it 'should be done', (done) ->
      Socialblade.loadUserData user, (err, data) ->
        should.not.exist err
        should.exist data

        data.dailySubscribersGained.should.not.be.empty
        data.totalSubscribers.should.not.be.empty
        data.dailyVideoViews.should.not.be.empty
        data.totalVideoViews.should.not.be.empty
        data.dailyChannelViews.should.not.be.empty
        data.avarageViewsPerDayPerMonth.should.not.be.empty
        data.totalViewsPerDayPerMonth.should.not.be.empty
        
        done()
        