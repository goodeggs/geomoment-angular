describe 'geomoment_directive', ->
  {element, scope} = {}

  beforeEach ->
    module('geomoment')

  describe 'basic field', ->
    beforeEach ->
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

    it 'fixes text to conform to geomoment format on blur', ->
      element.val('21:00').triggerHandler('input')
      element.triggerHandler('blur')
      expect(element.val()).to.equal '9:00pm'

    it 'clears model when cleared', ->
      element.val('').triggerHandler('input')
      expect(scope.dateTime).to.not.be.ok

    it 'leaves form field empty after cleared', ->
      element.val('').triggerHandler('input')
      expect(element.val()).to.equal ''

    it 'does not display validation errors when cleared', ->
      element.val('').triggerHandler('input')
      expect(scope.testform.$valid).to.be.true

  describe 'boundary validation', ->
    beforeEach ->
      inject ($compile, $rootScope) ->
        scope = $rootScope.$new true
        scope.lowerBound = new Date '2014-03-01T09:00:00-08:00'
        scope.dateTime = new Date '2014-03-01T10:00:00-08:00'
        scope.upperBound = new Date '2014-03-01T12:00:00-08:00'

        scope.tzid = "America/Los_Angeles"

        form = $compile('<form name="testform"><input type="text" geomoment="h:mma" before="upperBound" after="lowerBound" masks="hours,minutes" tzid="tzid" ng-model="dateTime"></input></form>')(scope)

        element = angular.element(form.contents()[0])
        scope.$digest()

    it 'is initialized with model', ->
      expect(element.val()).to.equal '10:00am'

    it 'displays validation error when before lower bound', ->
      element.val('8:00am').triggerHandler('input')
      expect(scope.testform.$error.afterGeomoment).to.be.ok

    it 'displays validation error when after upper bound', ->
      element.val('1:00pm').triggerHandler('input')
      expect(scope.testform.$error.beforeGeomoment).to.be.ok

    it 'clears model when cleared', ->
      element.val('').triggerHandler('input')
      expect(scope.dateTime).to.not.be.ok

    it 'leaves form field empty after cleared', ->
      element.val('').triggerHandler('input')
      expect(element.val()).to.equal ''

    it 'does not display validation errors when cleared', ->
      element.val('').triggerHandler('input')
      expect(scope.testform.$valid).to.be.true

