.PHONY: install uninstall
install:
	@for i in *; do \
	  [ $$i != "Makefile" ] && ln -sr $$i ~/.$$i; \
	done

uninstall:
	@for i in *; do \
	  [ ~/.$$i -ef $$i ] && rm -f ~/.$$i; \
	done
