app = angular.module 'geomoment'

app.filter 'subtractTime', ['geomoment', (geomoment) ->
  (timestamp, key, amount) ->
    geomoment(timestamp).subtract(key, amount).toDate()
]

