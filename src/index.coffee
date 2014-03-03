app = angular.module 'geomoment', []

require './factories/geomoment'

require './filters/date'

require './filters/format_date'
require './filters/format_day'

require './filters/add_time'
require './filters/subtract_time'

require './directives/geomoment'

app
