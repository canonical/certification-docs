SHELL = /bin/sh
RST2PDF=rst2pdf
RST2HTML=rst2html
DOC_NAMES=Self-Test_Guide-14.04 Self-Test_Guide-16.04 MAAS_Advanced_NUC_Installation_And_Configuration MAAS_Advanced_NUC_Installation_And_Configuration_Scripted
HTML_NAMES=$(DOC_NAMES:=.html)
PDF_NAMES=$(DOC_NAMES:=.pdf)

all:	html pdf

html:	$(HTML_NAMES)

pdf:	$(PDF_NAMES)

%.pdf: %.rst
	$(RST2PDF) --smart-quotes 1 -s styles/cert-doc.style $< -o $@

%.html: %.rst
	$(RST2HTML) --smart-quotes=yes $< $@

maniac: MAAS_Advanced_NUC_Installation_And_Configuration.pdf

maniacs: MAAS_Advanced_NUC_Installation_And_Configuration_Scripted.pdf

stg: Self-Test_Guide-14.04.pdf Self-Test_Guide-16.04.pdf

maniach: MAAS_Advanced_NUC_Installation_And_Configuration.html

maniacsh: MAAS_Advanced_NUC_Installation_And_Configuration_Scripted.html

stgh: Self-Test_Guide-14.04.html Self-Test_Guide-16.04.html

clean:
	rm -f *.pdf *.html
