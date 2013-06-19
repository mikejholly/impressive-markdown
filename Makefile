all:
	coffee -c convert.coffee
	echo "#!/usr/bin/env node \n`cat convert.js`" > convert
	chmod a+rx convert
