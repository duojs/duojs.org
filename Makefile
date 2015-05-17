
#
# Executables.
#

BIN := node_modules/.bin
DUO := $(BIN)/duo
METALSMITH := $(BIN)/metalsmith
MYTH = $(BIN)/myth

#
# Source wildcards.
#

SRC = $(wildcard src/*)
TEMPLATES = $(wildcard templates/*.html)
JS = index.js $(wildcard lib/*/*.js)
CSS = index.css $(wildcard lib/*/*.css)
JSON = $(wildcard lib/*/*.json)
HTML = $(wildcard lib/*/*.html)

#
# Default.
#

all: index.html build/index.js build/index.css

#
# Targets.
#

# Build the Metalsmith source.
index.html: node_modules $(SRC) $(TEMPLATES)
	@$(METALSMITH)

# Create the build directory.
build:
	@mkdir -p $@

# Build the JavaScript source with Duo.
build/index.js: $(JS) $(HTML) $(JSON) node_modules build
	@$(DUO) --type js < $< > $@

# Build the CSS source with Duo and Myth.
build/index.css: $(CSS) node_modules build
	@$(DUO) --type css < $< | $(MYTH) > $@

# Install npm dependencies and ensure mtime is updated.
node_modules: package.json
	@npm install
	@touch $@

#
# Phony targets/tasks.
#

# Cleanup previous build.
clean:
	rm -rf index.html build components

# Run the server.
server: bin/server node_modules
	@node --harmony $<

.PHONY: all clean server
