ifneq ($(wildcard IHP/.*),)
IHP = IHP/lib/IHP
else
IHP = $(shell dirname $$(which RunDevServer))/../lib/IHP
endif

CSS_FILES += ${IHP}/static/vendor/flatpickr.min.css
CSS_FILES += static/app.css

JS_FILES += ${IHP}/static/vendor/jquery-3.6.0.slim.min.js
JS_FILES += ${IHP}/static/vendor/timeago.js
JS_FILES += ${IHP}/static/vendor/flatpickr.js
JS_FILES += ${IHP}/static/helpers.js
JS_FILES += ${IHP}/static/vendor/morphdom-umd.min.js
JS_FILES += ${IHP}/static/vendor/turbolinks.js
JS_FILES += ${IHP}/static/vendor/turbolinksInstantClick.js
JS_FILES += ${IHP}/static/vendor/turbolinksMorphdom.js

include ${IHP}/Makefile.dist

tailwind-dev:
	ls tailwind/*.css|NODE_ENV=development entr npx tailwindcss build -i tailwind/app.css -o static/app.css -c tailwind/tailwind.config.js

static/app.css:
	# tailwindcss build
	# NODE_ENV=production npm ci
	# NODE_ENV=production npx tailwindcss build -i tailwind/app.css -o static/app.css -c tailwind/tailwind.config.js --minify
	tailwindcss build -i tailwind/app.css -o static/app.css -c tailwind/tailwind.config.js --minify

