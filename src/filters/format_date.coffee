app = angular.module 'geomoment'

app.filter 'formatDate', ['geomoment', (geomoment) ->
  (date, tzid, outFormat) ->
    return '' if !date?
    throw Error 'tzid required' unless tzid
    outFormat = geomoment.formats[outFormat] if outFormat in Object.keys geomoment.formats
    geomoment(date, (format for name, format of geomoment.formats)).tz(tzid).format(outFormat)
]

