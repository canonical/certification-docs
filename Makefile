SHELL = /bin/sh
RST2PDF=rst2pdf
RST2HTML=rst2html
DOC_NAMES=Test_Case_Guide-16.04 Test_Case_Guide-18.04 Programme_Guide-16.04 Programme_Guide-18.04 Coverage_Guide-18.04 Coverage_Guide-16.04 Self-Test_Guide-18.04 Self-Test_Guide-16.04 MAAS_Advanced_NUC_Installation_And_Configuration MAAS_Advanced_NUC_Installation_And_Configuration_Scripted Policy_Guide-16.04 Policy_Guide-18.04
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

stg: Self-Test_Guide-16.04.pdf Self-Test_Guide-18.04.pdf

coverage: Coverage_Guide-16.04.pdf Coverage_Guide-18.04.pdf

policy: Policy_Guide-16.04.pdf Policy_Guide-18.04.pdf

programme: Programme_Guide-16.04.pdf Programme_Guide-18.04.pdf

testcase: Test_Case_Guide-16.04.pdf Test_Case_Guide-18.04.pdf

maniach: MAAS_Advanced_NUC_Installation_And_Configuration.html

maniacsh: MAAS_Advanced_NUC_Installation_And_Configuration_Scripted.html

stgh: Self-Test_Guide-16.04.html Self-Test_Guide-18.04.html

coverageh: Coverage_Guide-16.04.html Coverage_Guide-18.04.html

policyh: Policy_Guide-16.04.html Policy_Guide-18.04.html

programmeh: Programme_Guide-16.04.html Programme_Guide-18.04.html

testcaseh: Test_Case_Guide-16.04.html Test_Case_guide-18.04.html

clean:
	rm -rf *.pdf *.html debian/files debian/certification-docs* drafts/*.pdf drafts/*.html

# dependencies

*.pdf: styles/cert-doc.style
MAAS_Advanced_NUC_Installation_And_Configuration.*: images/logo-ubuntu_su-white_orange-hex.png
MAAS_Advanced_NUC_Installation_And_Configuration.*: images/logo-canonical_no-tm-white-hex.png
MAAS_Advanced_NUC_Installation_And_Configuration.*: images/maniac-network.png
MAAS_Advanced_NUC_Installation_And_Configuration.*: images/maas-dropdown.png
MAAS_Advanced_NUC_Installation_And_Configuration.*: images/clusters-page.png
MAAS_Advanced_NUC_Installation_And_Configuration_Scripted.*: images/logo-ubuntu_su-white_orange-hex.png
MAAS_Advanced_NUC_Installation_And_Configuration_Scripted.*: images/logo-canonical_no-tm-white-hex.png
MAAS_Advanced_NUC_Installation_And_Configuration_Scripted.*: images/maniac-network.png
MAAS_Advanced_NUC_Installation_And_Configuration_Scripted.*: images/clusters-page.png
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
Self-Test_Guide-18.04.*: images/secure_id.png
Self-Test_Guide-18.04.*: images/hardware-creation-flowchart-landscape.png
Self-Test_Guide-18.04.*: images/cert-pretest.png
Self-Test_Guide-18.04.*: images/suite-selection-xenial.png
Self-Test_Guide-18.04.*: images/test-selection-xenial.png
