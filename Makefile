LIBNAME = xab

all: $(LIBNAME)

$(LIBNAME):
	gprbuild -p $(LIBNAME).gpr

# -----------------------------------
# Maintenance targets
# -----------------------------------
#
clean:
	gprclean $(LIBNAME).gpr
install:
	gprinstall -f -p -P $(LIBNAME).gpr
uninstall:
	gprinstall --uninstall  -P $(LIBNAME).gpr

.PHONY: install uninstall clean
