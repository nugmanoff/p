PREFIX?= /usr/local
INSTALL?= install
INSTALLDIR= ${INSTALL} -d
INSTALLBIN= ${INSTALL} -m 755

uninstall:
	rm -f ${PREFIX}/bin/p
	rm -rf ${PREFIX}/libexec/p

install:
	install -d ${PREFIX}/bin
	install -d ${PREFIX}/libexec/p
	install -m 755 bin/p ${PREFIX}/bin
	install libexec/* ${PREFIX}/libexec/p

.PHONY: install uninstall
