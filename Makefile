LIBNAME = xab
DEPS = $(LIBNAME)_deps

.POSIX:
GNATPREPFLAGS = -c -r
GCCFLAGS = -O2
GNATMAKE=gnatmake
RANLIB = ranlib
CC = gcc
INSTALL = /usr/bin/install -c
PREFIX = /usr/lib

all: $(LIBNAME)

# ------------------------------------
# compilation of xab packages
# ------------------------------------
#
# "xab_deps.adb" is a dummy main program, with dependencies
# that should force compilation of all xab packages;
#
$(DEPS):
	$(GNATMAKE) -g -c -Pxab_build $@

# -----------------------------------
# Create a xab library for objects
# -----------------------------------
# 
xab: $(DEPS)
	@if [ -d $(LIBNAME) ]; then rm -rf $(LIBNAME); fi
	mkdir $(LIBNAME)
	cp -p *.ads $(LIBNAME)
	cp -p *.adb $(LIBNAME)
	(tar cpf - *.o *.ali) | (cd $(LIBNAME); tar xpf -)
	rm -f $(LIBNAME)/$(DEPS).o $(LIBNAME)/$(DEPS).ali
	ar -r $(LIBNAME)/$(LIBNAME).a $(LIBNAME)/*.o
	-$(RANLIB) $(LIBNAME)/$(LIBNAME).a
	chmod 444 $(LIBNAME)/*.ali
	rm -f $(LIBNAME)/*.o
	rm -f *.o
	rm -f *.ali

# -----------------------------------
# Maintenance targets
# -----------------------------------
#
# remove editor and compiler generated files
clean:
	rm -rf $(LIBNAME)
	rm -f *.o *.ali a.out *# *~ $(EXECUTABLES) b_*.c b~* *.dSYM

# remove all generated files, including configuration history
distclean:
	rm -rf $(LIBNAME)
	rm -f *.o *.ali a.out *# *~ $(EXECUTABLES) b_*.c b~*
# install xab
install:
	# make needed dirs
	mkdir -p /usr/share/ada/adainclude/$(LIBNAME)/
	mkdir -p /usr/lib/ada/adalib/$(LIBNAME)/

	# copy library files
	cp -pr $(LIBNAME)/*.ali /usr/lib/ada/adalib/$(LIBNAME)/
	cp -pr $(LIBNAME)/$(LIBNAME).a /usr/lib/lib$(LIBNAME).a
	# copy includes
	cp -pr $(LIBNAME)/*.ads /usr/share/ada/adainclude/$(LIBNAME)/
	cp -pr $(LIBNAME)/*.adb /usr/share/ada/adainclude/$(LIBNAME)/
	# copy project file
	cp -p $(LIBNAME).gpr /usr/share/ada/adainclude/

	# fix permissions
	/bin/chmod 755 /usr/share/ada/ -R
	/bin/chmod 755 /usr/lib/ada/ -R

uninstall:
	rm -rf /usr/share/ada/adainclude/$(LIBNAME)/
	rm -rf /usr/share/ada/adainclude/$(LIBNAME).gpr
	rm -rf /usr/lib/ada/adalib/$(LIBNAME)/

.PHONY: install clean distclean
