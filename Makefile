EXCLUDES := Makefile README.md .git
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

.vim:
	rm -rf ~/.vim
	mkdir -p ~/.vim/{tmp,bundle,undo,autoload}
	curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
	cd ~/.vim/bundle && git clone https://github.com/ap/vim-buftabline
	cd ~/.vim/bundle && git clone https://github.com/airblade/vim-gitgutter
	cd ~/.vim/bundle && git clone https://github.com/hashivim/vim-terraform
	cd ~/.vim/bundle && git clone https://github.com/nvie/vim-flake8
	cd ~/.vim/bundle && git clone https://github.com/fatih/vim-go
