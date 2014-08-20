
duo = ./node_modules/.bin/duo
metalsmith = ./node_modules/.bin/metalsmith
myth = ./node_modules/.bin/myth

#
# Source wildcards.
#

css = $(shell find lib -name '*.css')
html = $(shell find lib -name '*.html')
js = $(shell find lib -name '*.js')
json = $(shell find lib -name '*.json')
src = $(shell find src)

#
# Default.
#

default: build

#
# Tasks.
#

# Run the server.
server: node_modules bin/server
	@node --harmony bin/server

#
# Targets.
#

# Build with Metalsmith, then build Duo-specific source.
build: build-metalsmith build/index.js build/index.css

# Build the Metalsmith source.
build-metalsmith: node_modules $(src)
	@mkdir -p build
	@$(metalsmith)
	@$(MAKE) build/index.js
	@$(MAKE) build/index.css

# Build the Javascript source with Duo.
build/index.js: node_modules index.js $(js) $(html) $(json)
	@$(duo) index.js > build/index.js

# Build the CSS source with Duo and Myth.
build/index.css: node_modules index.css $(css)
	@$(duo) -c index.css | $(myth) > build/index.css

node_modules: package.json
	@npm install
	@touch node_modules # make sure mtime is set after installing

#
# Phony targets.
#

clean:
	rm -rf build components

.PHONY: server clean
