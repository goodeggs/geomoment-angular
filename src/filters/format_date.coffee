app = angular.module 'geomoment'

iso8601Regexp = /^(\d{4})-(\d{2})-(\d{2})[ T](\d{2})\:(\d{2})\:(\d{2})/

app.filter 'formatDate', ['geomoment', (geomoment) ->
  (date, tzid, outFormat) ->
    return '' if !date?
    throw Error 'tzid required' unless tzid
    parsedDate = null
    if typeof date is 'string'
      # Moment has difficulty parsing an ISO string given a list of
      # formats (also, it's very slow).  Try to detect an ISO 8601
      # date and see if that works.
      if iso8601Regexp.test(date)
        parsedDate = geomoment date
      unless parsedDate?.isValid()
        parsedDate = geomoment(date, (format for name, format of geomoment.formats))
    else
      parsedDate = geomoment(date)

    outFormat = geomoment.formats[outFormat] if outFormat in Object.keys geomoment.formats
    parsedDate.tz(tzid).format(outFormat)
]
