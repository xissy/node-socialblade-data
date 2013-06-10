# node-socialblade-data

A node.js module for getting socialblade youtube statistics data.

## Features

- Gets logged youtube statistics data like subscribers, channel view count and videos view count by a channel id.
- Gets partner id by a video id.

## Installation

Via [npm](https://npmjs.org):

  $ npm install socialblade-data
  

## Quick Start

### Load in the module

  var socialblade = require('socialblade-data');

### Getting statistics data by a channel id
```javascript
  socialblade.loadChannelData('channelId', function(err, data) {
    ...
  });
```

### Getting partner id by a video id
```javascript
  socialblade.getPartnerIdByVideoId('videoId', function(err, partnerId)) {
    ...
  });
```

## License

Released under the MIT License

Copyright (c) 2013 Taeho Kim <xissysnd@gmail.com>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
