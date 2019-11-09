.PHONY: install uninstall
install:
	@for i in *; do \
	  [ $$i != "Makefile" ] && ln -sr $$i ~/.$$i; \
	done
	mkdir -p /home/alla/bin
	git clone git@github.com:alexlance/paw /home/alla/bin/paw.git || cd (/home/alla/bin/paw.git && git pull)
	cd /home/alla/bin/ && ln -sf paw.git/paw .

uninstall:
	@for i in *; do \
	  [ ~/.$$i -ef $$i ] && rm -f ~/.$$i; \
	done
	rm -rf /home/alla/bin/paw
	rm -rf /home/alla/bin/paw.git
