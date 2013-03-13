.POSIX:
GNATPREPFLAGS = -c -r
GCCFLAGS = -O2
GNATMAKE=gnatmake

RANLIB = ranlib

CC = gcc
DEPS = libxab_deps
PREFIX = /usr/lib

all: libxab

# ------------------------------------
# compilation of libxab packages
# ------------------------------------
#
# "deps.adb" is a dummy main program, with dependencies
# that should force compilation of all libxab packages;
#
libxab_deps:
	$(GNATMAKE) -c -Plibxab_build $@

# -----------------------------------
# Create a libxab library for objects
# -----------------------------------
# 
libxab: $(DEPS)
	@echo "Creating libxab.a in directory libxab"
	@if [ -d libxab ]; then rm -rf libxab; fi
	mkdir libxab
	cp -p *.ads libxab
	cp -p *.adb libxab
	(tar cpf - *.o *.ali) | (cd libxab; tar xpf -)
	rm -f libxab/$(DEPS).o libxab/$(DEPS).ali
	ar -r libxab/libxab.a libxab/*.o
	-$(RANLIB) libxab/libxab.a
	chmod 444 libxab/*.ali
	rm -f libxab/*.o

# -----------------------------------
# Maintenance targets
# -----------------------------------
#
# remove editor and compiler generated files
clean:
	rm -rf libxab
	rm -f *.o *.ali a.out *# *~ $(EXECUTABLES) b_*.c b~* *.dSYM

# remove all generated files, including configuration history
distclean:
	rm -rf libxab
	rm -f *.o *.ali a.out *# *~ $(EXECUTABLES) b_*.c b~*
# install libxab
install:
	mkdir -p $(PREFIX)/gnat
	cp -pr libxab $(PREFIX)/
	cp -p libxab.gpr $(PREFIX)/gnat
uninstall:
	rm -rf $(PREFIX)/libxab/
	rm -rf $(PREFIX)/lib/gnat/libxab.gpr

.PHONY: install clean distclean
