describe 'geomoment_directive', ->
  {geomoment, element, scope} = {}

  beforeEach ->
    module('geomoment')
    inject ($injector) ->
      geomoment = $injector.get 'geomoment'

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

    it 'updates if model changes', ->
      scope.dateTime = new Date '2014-03-01T19:00:00-08:00'
      scope.$digest()
      expect(element.val()).to.equal '7:00pm'

  describe 'basic field (starting empty)', ->
    beforeEach ->
      inject ($compile, $rootScope) ->
        scope = $rootScope.$new true
        scope.values = {}
        scope.tzid = "America/Los_Angeles"

        form = $compile('<form name="testform"><input type="text" geomoment="h:mma" masks="hours,minutes" tzid="tzid" ng-model="values.dateTime"></input></form>')(scope)

        element = angular.element(form.contents()[0])
        scope.$digest()

    it 'does nothing on blur if value is still unset', ->
      element.triggerHandler('blur')
      expect(element.val()).to.equal ''

    it 'can set a partial time', ->
      element.val('8:08am').triggerHandler('input')
      expect(geomoment(scope.values.dateTime).format('h:mma', scope.tzid)).to.equal '8:08am'

    it 'sets invalid dates', ->
      element.val('99:gz').triggerHandler('input')
      expect(scope.values.dateTime).to.not.be.ok

  describe 'basic field with a set maskDefault', ->

    beforeEach ->
      inject ($compile, $rootScope) ->
        scope = $rootScope.$new true
        scope.values = {}
        scope.tzid = "America/Los_Angeles"
        form = $compile('<form name="testform"><input type="text" geomoment="h:mma" masks="hours,minutes" mask-default="2014-03-01T10:00:00-08:00" tzid="tzid" ng-model="values.dateTime"></input></form>')(scope)

        element = angular.element(form.contents()[0])
        scope.$digest()

    it 'does not set model value initially', ->
      expect(scope.values.dateTime).to.be.undefined

    it 'masks the model value properly', ->
      element.val('12:25am').triggerHandler('input')
      expect(geomoment(scope.values.dateTime).format('YYYY-MM-DD h:mma')).to.equal '2014-03-01 12:25am'

  describe 'basic field with a maskDefault on the scope', ->

    beforeEach ->
      inject ($compile, $rootScope) ->
        scope = $rootScope.$new true
        scope.values = {}
        scope.tzid = "America/Los_Angeles"
        scope.maskDefault = "2014-03-01T10:00:00-08:00"
        form = $compile('<form name="testform"><input type="text" geomoment="h:mma" masks="hours,minutes" mask-default="maskDefault" tzid="tzid" ng-model="values.dateTime"></input></form>')(scope)

        element = angular.element(form.contents()[0])
        scope.$digest()

    it 'does not set model value initially', ->
      expect(scope.values.dateTime).to.be.undefined

    it 'masks the model value properly', ->
      element.val('12:25am').triggerHandler('input')
      expect(geomoment(scope.values.dateTime).format('YYYY-MM-DD h:mma')).to.equal '2014-03-01 12:25am'

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

    it 'displays validation errors when boundary condition changes', ->
      scope.lowerBound = new Date '2014-03-01T12:00:00-08:00'
      scope.$digest()
      expect(scope.testform.$error.afterGeomoment).to.be.ok

  describe 'boundary validation with masks', ->
    beforeEach ->
      inject ($compile, $rootScope) ->
        scope = $rootScope.$new true
        scope.lowerBound = new Date '2014-04-02T09:00:00-08:00'

        scope.tzid = "America/Los_Angeles"
        scope.dateTime = new Date '2014-04-02T11:00:00-08:00'

        form = $compile('<form name="testform"><input type="text" geomoment="h:mma" after="lowerBound" masks="hours,minutes" tzid="tzid" ng-model="dateTime"></input></form>')(scope)

        element = angular.element(form.contents()[0])
        scope.$digest()

    it 'leaves form valid if masks are within boundary conditions', ->
      element.val('10:00pm').triggerHandler('input')
      expect(scope.testform.$valid).to.be.true

    it 'displays validation error if masks are outside of boundary conditions', ->
      element.val('8:00am').triggerHandler('input')
      expect(scope.testform.$error.afterGeomoment).to.be.ok

  describe 'boundary validation with masks and initially empty input', ->
    beforeEach ->
      inject ($compile, $rootScope) ->
        scope = $rootScope.$new true
        scope.lowerBound = new Date '2014-04-02T09:00:00-08:00'

        scope.tzid = "America/Los_Angeles"

        form = $compile('<form name="testform"><input type="text" geomoment="h:mma" after="lowerBound" masks="hours,minutes" tzid="tzid" ng-model="dateTime"></input></form>')(scope)

        element = angular.element(form.contents()[0])
        scope.$digest()

    it 'starts form off as valid', ->
      expect(scope.testform.$valid).to.be.true

    it 'leaves form as valid when the boundary changes', ->
      scope.lowerBound = new Date '2014-04-02T09:05:00-08:00'
      scope.$digest()
      expect(scope.testform.$valid).to.be.true

    it 'displays validation error when model is changed to be outside the boundary conditions', ->
      element.val('8:00am').triggerHandler('input')
      expect(scope.testform.$error.afterGeomoment).to.be.ok
