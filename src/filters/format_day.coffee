app = angular.module 'geomoment'

app.filter 'formatDay', ['geomoment', (geomoment) ->
  (day, outFormat) ->
    outFormat = geomoment.formats[outFormat] if outFormat in Object.keys geomoment.formats
    geomoment.day(day, geomoment.pacific.tzid).format(outFormat)
]

