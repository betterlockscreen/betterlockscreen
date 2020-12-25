.POSIX:

SHELL = /bin/sh

EXEC      = betterlockscreen
DEFAULTRC = betterlockscreenrc
PREFIX    = /usr/local
BINPREFIX = $(PREFIX)/bin
CONFDIR   = /etc/betterlockscreen
MANPREFIX = $(PREFIX)/share/man/man1

default: help

install:
# Install binary
	@echo "Installing binary..."
	mkdir -p $(DESTDIR)$(BINPREFIX)
	cp $(EXEC) $(DESTDIR)$(BINPREFIX)
	chmod 755 $(DESTDIR)$(BINPREFIX)/$(EXEC)
# Install default config
	@echo "Installing default config..."
	mkdir -p $(DESTDIR)$(CONFDIR)
	cp $(DEFAULTRC) $(DESTDIR)$(CONFDIR)
	chmod 644 $(DESTDIR)$(CONFDIR)/$(DEFAULTRC)
# Install man page
	@echo "Installing man page..."
	mkdir -p $(MANPREFIX)
	cp $(MAN) $(DESTDIR)$(MANPREFIX)
	chmod 644 $(DESTDIR)$(MANPREFIX)/$(EXEC).1
	@echo "Done"

uninstall:
# Uninstall binary
	@echo "Uninstalling binary..."
	rm -f $(DESTDIR)$(BINPREFIX)/$(EXEC)
# Uninstall default config
	@echo "Uninstalling default config..."
	rm -rf $(DESTDIR)$(CONFDIR)
# Uninstall man page
	@echo "Uninstalling man page..."
	rm -f $(DESTDIR)$(MANPREFIX)/$(EXEC).1
	@echo "Done"

help:
	@echo "Please give either the install or uninstall option"

.PHONY: default install uninstall help
