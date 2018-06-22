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
KEYS = res/2015-11-19.svm.keys
EXES = bin/keys_map.py


all: $(EXES) $(GRAMMARS)

bin/keys_map.py:
	python3 -B res/make_key_file.py $(KEYS) > "$@"

res/%.cg: lib/OBT/cg/%.cg
	iconv --from-code=latin1					\
	      --to-code=utf-8						\
          "$<" > "$@"

lib/OBT/cg/%.cg: lib

lib:
	git submodule update --init --recursive

clean:
	-rm -f res/*.cg
	-rm -f bin/keys_map.py

.PHONY: all lib clean
