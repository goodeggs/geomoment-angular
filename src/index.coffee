geomoment = require 'geomoment/lib/client'
app = angular.module 'geomoment', []

formatDate = (dateMoment, outFormat) ->
  outFormat = geomoment.formats[outFormat] if outFormat in Object.keys geomoment.formats
  dateMoment.format(outFormat)


app.filter 'date', ->
  -> throw Error 'Please use `formatDate` instead of `date`.'

app.filter 'formatDate', ->
  (date, tzid, outFormat) ->
    return '' if !date?
    throw Error 'tzid required' unless tzid
    formatDate geomoment(date).tz(tzid), outFormat

app.filter 'formatDay', ->
  (day, outFormat) ->
    formatDate geomoment.day(day, geomoment.pacific.tzid), outFormat

app.factory 'geomoment', -> geomoment

app
