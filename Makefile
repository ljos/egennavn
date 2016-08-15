# Build script for egennavn
#
# Copyright (C) 2015 Bjarte Johansen
#
# Users are granted the rights to distribute and use this software as
# governed by the terms of the GPLv3 License.

APP_NAME = egennavn
VERSION  = 1.0.0
OS := $(shell uname)
GRAMMARS = res/bm_morf-prestat.cg res/bm_morf.cg
EXES = bin/mtag bin/keys_map.py


all: $(EXES) $(GRAMMARS)

bin/mtag:
ifeq ($(OS), Darwin)
	curl "http://www.tekstlab.uio.no/mtag/osx64/mtag-osx64" > $@
	chmod +x $@
else
	curl "http://www.tekstlab.uio.no/mtag/linux64/mtag" > $@
	chmod +x $@
endif

bin/keys_map.py:
	python3 -B res/make_key_file.py > "$@"

res/%.cg: lib/OBT/cg/%.cg | lib
	iconv --from-code=latin1					\
	      --to-code=utf-8						\
          "$<" > "$@"

lib:
	git submodule update --init --recursive

clean:
	-rm -f res/*.cg

.PHONY: all lib clean
