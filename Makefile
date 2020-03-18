PREFIX?= /usr/local
BINDIR?= ${PREFIX}/bin
INSTALL?= install
INSTALLDIR= ${INSTALL} -d
INSTALLBIN= ${INSTALL} -m 755

uninstall:
	rm -f ${DESTDIR}${BINDIR}/p

install:
	${INSTALLDIR} ${DESTDIR}${BINDIR}
	${INSTALLBIN} p ${DESTDIR}${BINDIR}

.PHONY: install uninstall
