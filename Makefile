PROJECT = imagemagick-scripts

PREFIX ?= /usr/local

SRCS = $(shell ls *.sh)

install: install-$(PROJECT)

chmod-755-$(PROJECT):
	@(for f in $(SRCS);  \
		do chmod +x $$f; \
	done)

chmod-644-$(PROJECT):
	@(for f in $(SRCS);  \
		do chmod -x $$f; \
	done)

install-$(PROJECT): chmod-755-$(PROJECT)
	mkdir -p $(PREFIX)/bin
	@(for f in $(SRCS); \
		do  cp $$f $(PREFIX)/bin/imagemagick-$${f%.sh};  \
	done)

clean: chmod-644-$(PROJECT)
	@(for f in $(SRCS); \
		do  rm $(PREFIX)/bin/imagemagick-$${f%.sh};  \
	done)
