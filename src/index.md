
Duo is a next-generation package manager that blends the best ideas from [Component](https://github.com/component/component), [Browserify](https://github.com/substack/node-browserify) and [Go](http://golang.org/) to make organizing and writing front-end code quick and painless.


## Install It

Install Duo straight from `npm` with:

```
$ npm install -g duo
```

Duo requires you to authenticate with GitHub to increase your rate limit and allow you to pull from private repositories. To do that, add the following entry to your `~/.netrc` file:

    machine api.github.com
      login <username>
      password <token>

You can quickly create a new GitHub `token` [here](https://github.com/settings/tokens/new).


## Getting Started

To get started just write normal Javascript, requiring dependencies straight from the file system or from GitHub as you need them:

```js
var uid = require('matthewmueller/uid');
var fmt = require('yields/fmt');

var msg = fmt('Your unique ID is %s!', uid());
window.alert(msg);
```

That `matthewmueller/uid` will pull the dependency [straight from GitHub](https://github.com/matthewmueller/uid), without you needing to edit any package manifest file!

You can also require modules straight from your filesystem:

```js
var modal = require('./modal/index.js');
```

Then use `duo` to install your dependencies and build your file:

```
$ duo index.js > build.js
```

Finally, drop a single `<script>` onto your page and you're done!

```html
<script src="build.js"></script>
```

Same goes for CSS! You can require dependencies and assets from the file system or straight from GitHub:

```css
@import 'necolas/normalize.css';
@import './layout/layout.css';

body {
  color: teal;
  background: url('./background-image.jpg');
}
```

Then bundle up your CSS with `duo`:

```
$ duo index.css > build.css
```

And add your bundled-up stylesheet to your page!

```html
<link rel="stylesheet" href="build.css">
```

## Features

  1. has first-class support for Javascript, HTML and CSS
  2. exposes a unix-y command line interface
  3. pulls source directly from GitHub with semantic versioning
  4. supports source transforms, like Coffeescript or Sass
  5. does not require a manifest

## Philosophy

Duo was designed from the ground up to grow alongside your application, making your three main workflows incredibly simple:

  1. creating quick proofs of concept
  2. writing modular components
  3. building large web applications


## I. Proofs of Concept

As developers, we often need to test out an idea or isolate a bug. One of the big issues with existing package managers is that you cannot use your package manager without a lot of boilerplate files like `package.json` or `component.json`.

Duo removes this boilerplate, letting you `require` packages straight from your source code:

```js
var events = require('component/events');
var uid = require('matthewmueller/uid');
```

You can also include versions, branches or paths:

```js
var reactive = require('component/reactive@0.14.x');
var tip = require('component/tip@master');
var shortcuts = require('yields/shortcuts@0.0.1:/index.js');
```

And the same goes for CSS with `import`:

```css
@import 'necolas/normalize.css';
@import 'twbs/bootstrap@v3.2.0:dist/css/bootstrap.css';
```

You can even directly require `.html` or `.json` files:

```js
var template = require('./menu.html');
var schema = require('./schema.json');
```

Duo will take care of the rest, transforming the `.html` into a Javascript string, and `.json` into a Javascript object.

When you're ready to build your files, just run:

```
$ duo in.js > out.js
$ duo in.css > out.css
```


## II. Components

A successful package manager needs to have a strong component ecosystem. Duo supports all of the existing [Component packages](https://github.com/component/component/wiki/Components) out of the box. And, since Duo can load from paths, it supports most [Bower packages](http://bower.io/search/) too. _There are even plans to support [Browserify packages](https://www.npmjs.org/browse/keyword/browser) as well._

We're hoping to bridge the gap between all the different package managers and come up with a solution that works for everyone.

To create your own public component, just add a `component.json` to your repository:

```json
{
  "name": "duo-component",
  "version": "0.0.1",
  "main": "index.js",
  "dependencies": {
    "component/tip": "1.x",
    "jkroso/computed-style": "0.1.0"
  }
}
```

And then publish your component on GitHub, so that others can install it by simply requiring it into their application:

```js
var thing = require('your/duo-component');
```

If you're coming from the Component community, you'll notice that we no longer need to add `scripts`, `styles` or `templates`. Duo handles all of this for you, walking the dependency tree like Browserify and including everything you need automatically, for both Javascript and CSS!


## III. Web Applications

In order for a package manager to be truly useful, it needs to scale to accommodate building entire web applications. Once again, Duo makes this process seamless.

Duo allows for building multiple pages at once, so that you can split up your application into different bundles and keep your page assets slim. To build from multiple entry files, just pass more than one entry into `duo`:

```
$ duo app/home.js app/about.js app/admin.js
```

You can even use brace expansion:

```
$ duo app/{home,about,admin}/index.{js,css}
```

If Duo discovers an asset like an image or font along the way, it will automatically include it in your `build/` directory. Say we have the following image in our CSS file:

```css
@import 'necolas/normalize.css';

body {
  background: url('./images/duo.png');
}
```

Duo will symlink `duo.png` to `build/images/duo.png`, so that you can serve the entire `build/` directory from your web server.


## Examples

To see some more complex examples of Duo in the wild, check out any of these repositories on GitHub:

  - [duojs/duojs.org](https://github.com/duojs/duojs.org)
  - [duojs/logo](https://github.com/duojs/logo)
  - [segmentio/analytics.js](https://github.com/segmentio/analytics.js)


## Community

For more information, read through some of the resources put together by the folks in the Duo community:

  - [GitHub Repository](https://github.com/duojs/duo)
  - [Command Line Usage](https://github.com/duojs/duo/blob/master/docs/cli.md)
  - [Javascript API](https://github.com/duojs/duo/blob/master/docs/api.md)
  - [FAQ](https://github.com/duojs/duo/blob/master/docs/faq.md)
  - [Mailing List](https://groups.google.com/forum/#!forum/duojs)
  - `#duojs` on freenode
