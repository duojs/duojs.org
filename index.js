
var Highlight = require('segmentio/highlight');

/**
 * Code highlighting.
 */

new Highlight()
  .use(require('segmentio/highlight-javascript'))
  .use(require('segmentio/highlight-xml'))
  .use(require('segmentio/highlight-css'))
  .use(require('segmentio/highlight-json'))
  .all();