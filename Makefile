# Makefile for RFC

XML2RFC=xml2rfc
XML2HTML=xml2html

SOURCES= \
	*.xml

all:: banner $(SOURCES)
	@echo "  * All Done."
	@echo
	 
clean:
	@rm -f draft-*.txt draft-*.html err.txt log.txt

$(SOURCES)::
	@echo ; \
	echo "  * Compiling: $@" ; \
	out=`echo $@ | sed "s|.xml|.txt|"` ; \
	out=`cat "$@" | grep docName | head -n 1 | sed "s|.*docName\=\"||" | sed "s|\".*||"`; \
	echo -n "    - [TXT] format ... " && \
	$(XML2RFC) $@ -u -o "$$out.txt" 2>err.txt >log.txt && \
	echo "Ok." || echo "ERROR (check the err file)."; \
	out=`echo $@ | sed "s|.xml|.html|"` ; \
	out=`cat "$@" | grep docName | head -n 1 | sed "s|.*docName\=\"||" | sed "s|\".*||"`; \
	echo -n "    - [HTML] format ... " && \
	$(XML2RFC) $@ --html -u -o "$$out.html" 2>>err.txt >>log.txt && \
	echo "Ok." || echo "ERROR (check the err file)."; \
	echo

banner::
	@echo
	@echo "IETF RFC and I-D Compiler Makefile"
	@echo "(c) 2017 by Massimiliano Pala and OpenCA Labs"
	@echo "All Rights Reserved"
	@echo
