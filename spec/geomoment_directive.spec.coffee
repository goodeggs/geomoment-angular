describe 'geomoment_directive', ->
  {element, scope} = {}

  beforeEach ->
    module('geomoment')

    inject ($compile, $rootScope) ->
      scope = $rootScope.$new true
      scope.dateTime = new Date '2014-03-01T10:00:00-08:00'
      scope.tzid = "America/Los_Angeles"

      form = $compile('<form name="testform"><input type="text" geomoment="h:mma" masks="hours,minutes" tzid="tzid" ng-model="dateTime"></input></form>')(scope)

      element = angular.element(form.contents()[0])
      scope.$digest()

  it 'is initialized with model', ->
    expect(element.val()).to.equal '10:00am'

  it 'updates model', ->
    element.val('3:04pm').triggerHandler('input')
    expect(scope.dateTime).to.deep.equal new Date '2014-03-01T15:04:00-08:00'

  it 'leaves model alone when cleared', ->
    element.val('').triggerHandler('input')
    expect(scope.dateTime).to.deep.equal new Date '2014-03-01T10:00:00-08:00'

  it 'leaves form field empty after cleared', ->
    element.val('').triggerHandler('input')
    expect(element.val()).to.equal ''

  it 'does not display validation errors when cleared', ->
    element.val('').triggerHandler('input')
    expect(scope.testform.$valid).to.be.true
