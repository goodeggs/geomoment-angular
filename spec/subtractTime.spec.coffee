describe 'subtractTime', ->
  {subtractTime} = {}

  beforeEach ->
    module('geomoment')
    inject ($filter) ->
      subtractTime = $filter('subtractTime')

  it 'subtracts time', ->
    expect(subtractTime('2013-04-01 13:00', 'hours', 1).valueOf()).to.equal Date.parse("2013-04-01 12:00")
