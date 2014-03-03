app = angular.module 'geomoment'

app.filter 'addTime', ['geomoment', (geomoment) ->
  (timestamp, key, amount) ->
    geomoment(timestamp).add(key, amount).toDate()
]

