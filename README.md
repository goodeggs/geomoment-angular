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
```html
<strong>{{'2013-02-08T09:30' | formatDate:'America/Los_Angeles':'h:mm:ssa'}}</strong> becomes <strong>9:30:00am</strong>
<strong>{{'2013-02-08' | formatDay:'weekday'}}</strong> becomes <strong>Friday</strong>
```
