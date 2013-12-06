describe 'date', ->
  {date} = {}

  beforeEach ->
    module('geomoment')
    inject ($filter) ->
      date = $filter('date')

  it 'throws an exception (asking you to use formatDate instead)', ->
    expect(-> date()).to.throw(/formatDate/)
