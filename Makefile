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
	mkdir -p $(PREFIX)/share/ada/adainclude/$(LIBNAME)/
	mkdir -p $(PREFIX)/lib/ada/adalib/$(LIBNAME)/

	# copy library files
	cp -pr lib/*.ali $(PREFIX)/lib/ada/adalib/$(LIBNAME)/
	cp -pr lib/lib$(LIBNAME).a $(PREFIX)/lib/lib$(LIBNAME).a
	# copy includes
	cp -pr src/*.ads $(PREFIX)/share/ada/adainclude/$(LIBNAME)/
	cp -pr src/*.adb $(PREFIX)/share/ada/adainclude/$(LIBNAME)/
	# copy project file
	cp -p $(LIBNAME).gpr $(PREFIX)/share/ada/adainclude/$(LIBNAME).gpr

	# fix permissions
	/bin/chmod 755 $(PREFIX)/share/ada/ -R
	/bin/chmod 755 $(PREFIX)/lib/ada/ -R

uninstall:
	rm -rf $(PREFIX)/share/ada/adainclude/$(LIBNAME)/
	rm -rf $(PREFIX)/share/ada/adainclude/$(LIBNAME).gpr
	rm -rf $(PREFIX)/lib/ada/adalib/$(LIBNAME)/
	rm -rf $(PREFIX)/lib/lib$(LIBNAME).a

.PHONY: install uninstall clean
