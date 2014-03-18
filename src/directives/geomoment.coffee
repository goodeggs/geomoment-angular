app = angular.module 'geomoment'

directions =
  before: 'isBefore'
  after: 'isAfter'

app.directive 'geomoment', ($parse, geomoment) ->
  require: 'ngModel',

  link: (scope, elm, attrs, model) ->

    # load information from the scope based on attributes
    getters = {}
    for attr, name of {geomoment: 'formats', 'tzid', 'masks', 'before', 'after'}
      do (attr, name) ->
        getters[name] = try
          $parse(attrs[attr])
        catch
          -> attrs[attr]

    # set up validation and conversion from time string to Date object
    model.$parsers.unshift (value) ->
      parameters = getParameters scope

      if not value? or value.trim().length is 0
        model.$setValidity 'invalidGeomoment', yes
        model.$setValidity 'beforeGeomoment', yes
        model.$setValidity 'afterGeomoment', yes
        return null

      moment = momentFromString value, parameters
      unless moment.isValid()
        model.$setValidity 'invalidGeomoment', no
        return model.$modelValue
      model.$setValidity 'invalidGeomoment', yes

      moment = maskTime(moment, parameters)

      for direction, checker of directions
        if parameters[direction]?
          validator = "#{direction}Geomoment"
          if moment[checker] maskTime(geomoment(parameters[direction]), parameters)
            model.$setValidity validator, yes
          else
            model.$setValidity validator, no

      return moment.toDate()

    # Convert Date object into a time string formatted appropriately
    model.$formatters.unshift (value) ->
      return unless value?
      parameters = getParameters(scope)
      moment = geomoment value
      moment = moment.tz(parameters.tzid) if parameters.tzid?
      moment.format [].concat(parameters.formats)[0]

    # watch the placeholder string, in case it changes
    unless attrs.placeholder?
      scope.$watch getters.formats, (formats) ->
        attrs.$set 'placeholder', [].concat(formats)[0]

    # if there is a validator that the time needs to be before or after another time,
    # set up watchers on the other time so that we can revalidate if that time changes
    for direction, checker of directions
      if attrs[direction]?
        do (direction, checker) ->
          validator = "#{direction}Geomoment"
          scope.$watch getters[direction], (value) ->
            return unless value and model.$modelValue
            result = geomoment(model.$modelValue)[checker] value
            if result
              model.$setValidity validator, yes
            else
              model.$setValidity validator, no

    # make the element display the time cleanly when it is blurred
    # (that way the user knows that the system registered their intent.)
    elm.on 'blur', ->
      return unless model.$viewValue?.trim().length
      parameters = getParameters scope
      moment = momentFromString model.$viewValue, parameters
      moment = moment.tz(parameters.tzid) if parameters.tzid?
      formattedTime = moment.format [].concat(parameters.formats)[0]
      if moment.isValid() and model.$viewValue isnt formattedTime
        elm.val formattedTime

    ## helpers for all of the hooks defined above
    #####################

    getParameters = (scope) ->
      parameters = {}
      parameters[attr] = getter(scope) for attr, getter of getters
      parameters

    momentFromString = (timeString, {formats, tzid}) ->
      if tzid?
        geomoment.tz(timeString, formats, tzid)
      else
        geomoment(timeString, formats)

    # only apply the parts of the timestamp that we explicitly call out
    maskTime = (inMoment, {masks, tzid}) ->
      return inMoment unless masks?
      masks = masks.split(',') unless typeof masks is 'array'
      outMoment = geomoment(model.$modelValue).tz(tzid)
      outMoment[mask](inMoment[mask]()) for mask in masks
      outMoment
