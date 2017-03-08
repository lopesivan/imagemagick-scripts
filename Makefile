PROJECT = imagemagick-scripts

prefix ?= /usr/local

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
	@(for f in $(SRCS); \
		do ln -s `pwd`/$$f $(prefix)/bin/imagemagick.$${f%.sh};  \
	done)

clean: chmod-644-$(PROJECT)
	@(for f in $(SRCS); \
		do rm $(prefix)/bin/imagemagick.$${f%.sh};  \
	done)
