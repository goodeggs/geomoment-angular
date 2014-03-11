describe 'geomoment_directive', ->
  {directive, scope} = {}

  describe 'with mask', ->
    beforeEach ->
      module('geomoment')

      inject ($compile, $rootScope) ->
        directive = $compile('<input type="text" geomoment="h:mma" masks="hours,minutes" tzid="tzid" ng-model="dateTime"></input>')($rootScope)
        scope = $rootScope
        scope.dateTime = new Date '2014-03-01T10:00:00-08:00'
        scope.tzid = "America/Los_Angeles"
        scope.$digest()

    describe 'form', ->

      it 'is initialized with model', ->
        expect(directive.val()).to.equal '10:00am'

      it 'updates model', ->
        directive.val('3:04pm').triggerHandler('input')
        expect(scope.dateTime).to.deep.equal new Date '2014-03-01T15:04:00-08:00'
