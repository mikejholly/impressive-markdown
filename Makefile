BIN = ./bin/impressivemd

all: clean bin

bin:
	mkdir ./bin
	echo "#!/usr/bin/env node" > $(BIN)
	coffee -p -c convert.coffee >> $(BIN)
	chmod 755 $(BIN)

clean:
	rm -rf ./bin

.PHONY: clean
