geomoment = require 'geomoment/lib/client'
module.exports = app = angular.module 'geomoment', []

app.filter 'date', ->
  -> throw Error 'Please use `formatDate` instead of `date`.'

app.filter 'formatDate', ->
  (date, tzid, outFormat) ->
    return '' if !date?
    throw Error 'tzid required' unless tzid
    outFormat = geomoment.formats[outFormat] if outFormat in Object.keys geomoment.formats
    geomoment(date).tz(tzid).format(outFormat)

app.filter 'formatDay', ->
  (day, outFormat) ->
    throw Error "Unknown format identifier '#{outFormat}'" unless outFormat in Object.keys geomoment.formats
    geomoment.day(day, moment.pacific.tzid).format geomoment.formats[outFormat]

app.factory 'geomoment', -> geomoment

app
