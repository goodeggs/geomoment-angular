geomoment = require 'geomoment/lib/client'
module.exports = app = angular.module 'geomoment', []

formats =
  dashes: 'YYYY-MM-DD'
  abbrv: 'ddd, MMM Do'
  long: 'dddd, MMMM Do'
  short: 'MMM D'
  weekday: 'dddd'

app.filter 'date', ->
  -> throw Error 'Please use `formatDate` instead of `date`.'

app.filter 'formatDate', ->
  (date, tzid, outFormat) ->
    return '' if !date?
    throw Error 'tzid required' unless tzid
    outformat = formats[outformat] if outformat in Object.keys formats
    geomoment(date).tz(tzid).format(outFormat)

app.filter 'formatDay', ->
  (day, outFormat) ->
    throw Error "Unknown format identifier '#{outFormat}'" unless outFormat in Object.keys formats
    geomoment.day(day, moment.pacific.tzid).format formats[outFormat]

app.factory 'geomoment', -> geomoment

app
