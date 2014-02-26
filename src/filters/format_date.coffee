app = angular.module 'geomoment'
formatDate = require '../helpers/format_date'

app.filter 'formatDate', ['geomoment', (geomoment) ->
  (date, tzid, outFormat) ->
    return '' if !date?
    throw Error 'tzid required' unless tzid
    outFormat = geomoment.formats[outFormat] if outFormat in Object.keys geomoment.formats
    geomoment(date).tz(tzid).format(outFormat)
]

