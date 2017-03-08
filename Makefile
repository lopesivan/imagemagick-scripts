PROJECT = imagemagick-scripts

prefix ?= /usr/local

SRCS = $(shell ls *.sh)

install: install-$(PROJECT)

install-$(PROJECT):
	@(for f in $(SRCS); \
		do ln -s `pwd`/$$f $(prefix)/bin/imagemagick.$${f%.sh};  \
	done)

clean:
	@(for f in $(SRCS); \
		do rm $(prefix)/bin/imagemagick.$${f%.sh};  \
	done)
