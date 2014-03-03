describe 'addTime', ->
  {addTime} = {}

  beforeEach ->
    module('geomoment')
    inject ($filter) ->
      addTime = $filter('addTime')

  it 'adds time', ->
    expect(addTime('2013-04-01 13:00', 'hours', 1).valueOf()).to.equal Date.parse("2013-04-01 14:00")
