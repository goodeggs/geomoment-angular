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

  it 'formats a date given an isostring', ->
    expect(formatDate '2014-03-05T00:15:00.000Z', 'America/Los_Angeles', 'h:mm a').to.equal '4:15 pm'

  describe 'with Date object', ->
    {dateObject} = {}

    beforeEach ->
      dateObject = new Date(2011, 10, 13, 14, 15)

    it 'formats a date given a timezone', ->
      # Note that Date month starts at 0.
      expect(formatDate(dateObject, 'America/Los_Angeles', 'YYYY-MM-DD')).to.equal '2011-11-13'

  describe 'with a moment object', ->
    {momentObject} = {}

    beforeEach ->
      inject (geomoment) ->
        momentObject = geomoment('1999-12-13T14:15:00Z', 'YYYY-MM-DD HH:mm')

    it 'formats a date given a timezone', ->
      expect(formatDate(momentObject, 'America/New_York', 'YYYY-MM-DD')).to.equal '1999-12-13'

    it 'formats a time given a timezone', ->
      expect(formatDate(momentObject, 'America/New_York', 'time')).to.equal '17:15'
