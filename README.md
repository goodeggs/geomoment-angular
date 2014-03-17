# geomoment-angular

[![NPM](https://nodei.co/npm/geomoment-angular.png)](https://nodei.co/npm/geomoment-angular/)

An [angular.js](http://angularjs.org/) module for date formatting with explicit timezones; wraps [geomoment](https://github.com/goodeggs/geomoment).
For use with [browserify](https://github.com/substack/node-browserify).

Assumes that `angular` is in the global scope (part of `window`).

## examples

**setup:**
```javascript
// somewhere in your client side code that gets processed by browserify:
require('geomoment-angular');
```

**factory:**
```javascript
function myController($scope, geomoment) {
  geomoment.day('2013-02-08');
}
```

**filters:**

<table>
<tr><th>Filter example</th><th>Result</th>
<tr><td><code>{{'2013-02-08T09:30' | formatDate:'America/Los_Angeles':'h:mm:ssa'}}</code></td><td>9:30:00am</td></tr>
<tr><td><code>{{'2013-02-08' | formatDay:'weekday'}}</code></td><td>Friday</td></tr>
<tr><td><code>{{'2013-02-08T09:30' | addTime:'days':1 | formatDay:'MMM Do YYYY h:mma'}}</code></td><td>Feb 9th 2013 9:30am</td></tr>
<tr><td><code>{{'2013-02-08T09:30' | subtractTime:'hours':9 | formatDay:'MMM Do YYYY h:mma'}}</code></td><td>Feb 8th 2013 12:30am</td></tr>
</table>
