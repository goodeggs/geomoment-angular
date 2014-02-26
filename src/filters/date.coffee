app = angular.module 'geomoment'

app.filter 'date', ->
  -> throw Error 'Please use `formatDate` instead of `date`.'

