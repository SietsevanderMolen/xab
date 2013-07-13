LIBNAME = xab

.POSIX:
INSTALL = /usr/bin/install -c
PREFIX = /usr

all: $(LIBNAME)

# -----------------------------------
# Create a xab library for objects
# -----------------------------------
# 
xab:
	gprbuild -p xab.gpr

# -----------------------------------
# Maintenance targets
# -----------------------------------
#
# remove editor and compiler generated files
clean:
	gprclean xab.gpr

# install xcbada
install:
	gprinstall -f -p -P xab.gpr

uninstall:
	gprinstall --uninstall  -P xab.gpr

.PHONY: install uninstall clean
