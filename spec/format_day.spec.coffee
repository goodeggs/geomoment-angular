describe 'formatDay', ->
  {formatDay} = {}

  beforeEach ->
    module('geomoment')
    inject ($filter) ->
      formatDay = $filter('formatDay')

  it 'formats with abbreviation', ->
    expect(formatDay '2013-04-01', 'abbrvDay').to.equal 'Mon Apr 1'
