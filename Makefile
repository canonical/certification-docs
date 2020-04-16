SHELL = /bin/sh
RST2PDF=rst2pdf
RST2HTML=rst2html
DOC_NAMES=Test_Case_Guide-20.04 Test_Case_Guide-18.04 Programme_Guide Coverage_Guide-20.04 Coverage_Guide-18.04 Self-Test_Guide MAAS_Advanced_Network_Installation_And_Configuration_Scripted Policy_Guide
HTML_NAMES=$(DOC_NAMES:=.html)
PDF_NAMES=$(DOC_NAMES:=.pdf)

all:	html pdf

html:	$(HTML_NAMES)

pdf:	$(PDF_NAMES)

%.pdf: %.rst
	$(RST2PDF) --smart-quotes 1 -s styles/cert-doc.style $< -o $@

%.html: %.rst
	$(RST2HTML) --smart-quotes=yes $< $@

maniacs: MAAS_Advanced_Network_Installation_And_Configuration_Scripted.pdf

stg: Self-Test_Guide.pdf Self-Test_Guide.pdf

coverage: Coverage_Guide-18.04.pdf Coverage_Guide-20.04.pdf

policy: Policy_Guide.pdf

programme: Programme_Guide.pdf

testcase: Test_Case_Guide-20.04.pdf Test_Case_Guide-18.04.pdf

maniacsh: MAAS_Advanced_Network_Installation_And_Configuration_Scripted.html

stgh: Self-Test_Guide.html Self-Test_Guide.html

coverageh: Coverage_Guide-18.04.html Coverage_Guide-20.04.html

policyh: Policy_Guide.html

programmeh: Programme_Guide.html

testcaseh: Test_Case_Guide-20.04.html Test_Case_Guide-18.04.html

clean:
	rm -rf *.pdf *.html debian/files debian/certification-docs* 

# dependencies

*.pdf: styles/cert-doc.style
MAAS_Advanced_Network_Installation_And_Configuration_Scripted.*: images/logo-ubuntu_su-white_orange-hex.png
MAAS_Advanced_Network_Installation_And_Configuration_Scripted.*: images/logo-canonical_no-tm-white-hex.png
MAAS_Advanced_Network_Installation_And_Configuration_Scripted.*: images/maniac-network.png
MAAS_Advanced_Network_Installation_And_Configuration_Scripted.*: images/clusters-page.png
Self-Test_Guide-16.04.*: images/logo-ubuntu_su-white_orange-hex.png
Self-Test_Guide-16.04.*: images/logo-canonical_no-tm-white-hex.png
Self-Test_Guide-16.04.*: images/certification-process-flowchart-portrait.png
Self-Test_Guide-16.04.*: images/secure_id.png
Self-Test_Guide-16.04.*: images/hardware-creation-flowchart-landscape.png
Self-Test_Guide-16.04.*: images/cert-pretest.png
Self-Test_Guide-16.04.*: images/suite-selection-xenial.png
Self-Test_Guide-16.04.*: images/test-selection-xenial.png
Self-Test_Guide-18.04.*: images/logo-ubuntu_su-white_orange-hex.png
Self-Test_Guide-18.04.*: images/logo-canonical_no-tm-white-hex.png
Self-Test_Guide-18.04.*: images/certification-process-flowchart-portrait.png
Self-Test_Guide.*: images/secure_id.png
Self-Test_Guide.*: images/hardware-creation-flowchart-landscape.png
Self-Test_Guide.*: images/cert-pretest.png
Self-Test_Guide.*: images/suite-selection-xenial.png
Self-Test_Guide.*: images/test-selection-xenial.png
