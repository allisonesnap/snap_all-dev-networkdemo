SNAP_NAME := hello-web

.PHONY: all build clean install uninstall logs status

all: build

build:
	snapcraft pack

clean:
	rm -rf parts prime stage
	rm -f *.snap

install: build
	sudo snap install ./$(SNAP_NAME)_*.snap --dangerous

uninstall:
	sudo snap remove $(SNAP_NAME)

status:
	snap services $(SNAP_NAME)

logs:
	sudo snap logs $(SNAP_NAME)

restart:
	sudo snap restart $(SNAP_NAME)

get:
	snap get $(SNAP_NAME)

set-port:
	sudo snap set $(SNAP_NAME) port=$(PORT)

set-bind:
	sudo snap set $(SNAP_NAME) bind=$(BIND)