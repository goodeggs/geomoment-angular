describe 'geomoment factory', ->
  {injected} = {}

  beforeEach ->
    module('geomoment')
    inject (geomoment) ->
      injected = geomoment

  it 'can be injected', ->
    expect(injected).to.be.a 'function'
    expect(injected).to.include.keys 'formats'
    expect(injected.day('20130101', 'America/Los_Angeles').format(injected.formats.shortDay)).to.equal 'Tuesday, Jan 1'
