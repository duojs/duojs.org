/**
 * Module Dependencies
 */

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

/**
 * Analytics
 *
 * TODO: use segment.io ;-)
 */

(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','//www.google-analytics.com/analytics.js','ga');

ga('create', 'UA-10351690-12', 'auto');
ga('send', 'pageview');
