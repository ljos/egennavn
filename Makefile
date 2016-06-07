# Build script for mtag
#
# Copyright (C) 2015 Bjarte Johansen
#
# Users are granted the rights to distribute and use this software as
# governed by the terms of the GPLv3 License.

APP_NAME = egennavn
VERSION  = 0.0.1
OS := $(shell uname)

all: bin/mtag res/bm_morf-prestat.cg

bin/mtag:
ifeq ($(OS), Darwin)
	curl "http://www.tekstlab.uio.no/mtag/osx64/mtag-osx64" > $@
	chmod +x $@
else
	curl "http://www.tekstlab.uio.no/mtag/linux64/mtag" > $@
	chmod +x $@
endif

res/bm_morf-prestat.cg: lib
	iconv --from-code=latin1					\
	      --to-code=utf-8						\
	      lib/OBT/cg/bm_morf-prestat.cg > $@

lib:
	git submodule update --init --recursive


.PHONY: all lib
