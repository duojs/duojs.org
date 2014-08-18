
![duo](https://i.cloudup.com/uRfFwp-i4T.png)

Duo is a next-generation package manager for your frontend code base.


## Philosophy

Duo was designed from the ground up to grow alongside your application, making your three main workflows incredibly simple:

  1. creating quick proofs of concept
  2. writing modular components
  3. building large web applications

Duo blends the very best ideas from the [Component](https://github.com/component/component), [Browserify](https://github.com/substack/node-browserify) and [Go](http://go-lang.com/) communities, to end up with a simple system that:

  - has first-class support for Javascript, HTML and CSS
  - exposes a unix-y command line interface
  - pulls source directly from GitHub with semantic versioning
  - supports source transforms, like Coffeescript or Sass
  - does not require JSON manifests


## I. Proofs of concept

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
@import "necolas/normalize.css";
@import "twbs/bootstrap@v3.2.0:dist/css/bootstrap.css";
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

For any package manager to be successful, it needs to have a strong component ecosystem. Duo supports nearly all of the existing [Component packages](https://github.com/search?l=json&p=10&q=path%3A%2Fcomponent.json+component&ref=searchresults&type=Code) out of the box. And, since Duo can load from paths, it supports nearly all of the [Bower packages](http://bower.io/search/) too. There are plans in the future to support Browserify packages as well.

We're hoping to bridge the gap between all the different package managers and come up with a solution that works for everyone.

To create a public Duo component, add a `component.json`:

```json
{
  "name": "duo-component",
  "version": "0.0.1",
  "main": {
    "js": "index.js",
    "css": "index.css"
  }
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

Duo allows for building multiple pages at once, so that you can split up your application into different bundles and take advantage of browser caching. To build from multiple entry files, just pass more than one entry into `duo`:

```
$ duo app/libraries.js app/common.js app/home.js app/admin.js
```

You can even use brace expansion:

```
$ duo app/{home,about,admin}/index.{js,css}
```

If Duo discovers an asset like an image or font along the way, it will automatically include it in your `build/` directory. Say we have the following image in our CSS file:

```css
@import "necolas/normalize";

body {
  background: url('./images/duo.png');
}
```

Duo will transform this file to:

```css
@import "necolas/normalize";

body {
  background: url('/images/duo.png');
}
```

And symlink `duo.png` to `build/images/duo.png`, so that you can serve the entire `build/` directory from your web server.

