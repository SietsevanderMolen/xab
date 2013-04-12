LIBNAME = xab

.POSIX:
INSTALL = /usr/bin/install -c
PREFIX = /usr/lib

all: $(LIBNAME)

# -----------------------------------
# Create a xab library for objects
# -----------------------------------
# 
xab:
	gprbuild -p xab_build.gpr

# -----------------------------------
# Maintenance targets
# -----------------------------------
#
# remove editor and compiler generated files
clean:
	gprclean xab_build.gpr

# install xab
install:
	# make needed dirs
	mkdir -p /usr/share/ada/adainclude/$(LIBNAME)/
	mkdir -p /usr/lib/ada/adalib/$(LIBNAME)/

	# copy library files
	cp -pr lib/*.ali /usr/lib/ada/adalib/$(LIBNAME)/
	cp -pr lib/lib$(LIBNAME).a /usr/lib/lib$(LIBNAME).a
	# copy includes
	cp -pr src/*.ads /usr/share/ada/adainclude/$(LIBNAME)/
	cp -pr src/*.adb /usr/share/ada/adainclude/$(LIBNAME)/
	# copy project file
	cp -p $(LIBNAME).gpr /usr/share/ada/adainclude/

	# fix permissions
	/bin/chmod 755 /usr/share/ada/ -R
	/bin/chmod 755 /usr/lib/ada/ -R

uninstall:
	rm -rf /usr/share/ada/adainclude/$(LIBNAME)/
	rm -rf /usr/share/ada/adainclude/$(LIBNAME).gpr
	rm -rf /usr/lib/ada/adalib/$(LIBNAME)/
	rm -rf /usr/lib/lib$(LIBNAME).a

.PHONY: install clean
