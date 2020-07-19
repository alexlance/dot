EXCLUDES := Makefile .git
DOTFILES := $(filter-out $(EXCLUDES), $(wildcard *))
DEST := ~

.PHONY: $(DOTFILES)
all: $(DOTFILES)

$(DOTFILES):
	@if [ ${DEST}/.$@ -ef $@ ]; then \
	  rm -fv ${DEST}/.$@; \
	elif [ ! -e ${DEST}/.$@ ]; then \
	  ln -srv $@ ${DEST}/.$@; \
	fi

