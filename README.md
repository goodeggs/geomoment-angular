# geomoment-angular

An [angular.js](http://angularjs.org/) module for date formatting with explicit timezones; wraps [geomoment](https://github.com/goodeggs/geomoment).

## examples

**setup:**
```javascript
angular.module('my-module', ['geomoment']);
```

**service:**
```javascript
injectedFunction = ['geomoment', function(geomoment) {
  geomoment.day('2013-02-08');
}];
```

**filters:**

<table>
<tr><th>Filter example</th><th>Result</th>
<tr><td><code>{{'2013-02-08T09:30' | formatDate:tzid:'h:mm:ssa'}}</code></td><td>9:30:00am</td></tr>
<tr><td><code>{{'2013-02-08' | formatDay:'weekday'}}</code></td><td>Friday</td></tr>
<tr><td><code>{{'2013-02-08T09:30' | addTime:'days':1 | formatDay:'MMM Do YYYY'}}</code></td><td>Feb 9th 2013</td></tr>
<tr><td><code>{{'2013-02-08T09:30' | subtractTime:'hours':9 | formatDate:tzid:'h:mma'}}</code></td><td>12:30am</td></tr>
</table>

**directive:**

```html
<form name='dateForm'>
  <input ngModel='date' geomoment='YYYY-MM-DD h:mm a' tzid='America/Los_Angeles'>
</form>
```

The `geomoment` directive will convert a string representation of a date (expressed in the `geomoment` attr) into a javascript `Date` object.
It uses the geomoment library to parse input dates, so it does a pretty good job of interpolating human input.

## License

The MIT License (MIT)

Copyright (c) 2014 Good Eggs Inc.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.