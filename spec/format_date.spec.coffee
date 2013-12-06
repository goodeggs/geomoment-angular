describe 'formatDate', ->
  {formatDate} = {}

  beforeEach ->
    module('geomoment')
    inject ($filter) ->
      formatDate = $filter('formatDate')

  it 'formats a date given a timezone and a moment format spec', ->
    expect(formatDate('Fri Dec 06 2013 14:54:06', 'America/Los_Angeles', 'YYYY-MM-DD')).to.equal '2013-12-06'

  it 'throws an exception if no timezone is supplied', ->
    expect(-> formatDate('Fri Dec 06 2013 14:54:06')).to.throw(/tzid required/)

  it 'formats a date given a geomoment format', ->
    expect(formatDate('Fri Dec 06 2013 14:54:06', 'America/Los_Angeles', 'shortDay')).to.equal 'Friday, Dec 6'
