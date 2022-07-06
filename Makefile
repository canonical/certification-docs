
# Sphinx related setup
SPHINXOPTS    ?=
SPHINXBUILD   ?= sphinx-build
SOURCEDIR     = .
BUILDDIR      = _build
VENV          = env/bin/activate
PORT = 8001

# Cert documentation options
SHELL = /bin/sh
RST2PDF=rst2pdf
RST2HTML=rst2html
DOC_NAMES=Test_Case_Guide-20.04 Test_Case_Guide-18.04 Programme_Guide Coverage_Guide Self-Test_Guide MAAS_Advanced_Network_Installation_And_Configuration_Scripted Policy_Guide Coverage_Guide_IoT-22.04
HTML_NAMES=$(DOC_NAMES:=.html)
PDF_NAMES=$(DOC_NAMES:=.pdf)

# Put it first so that "make" without argument is like "make help".
help:
	@$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

.PHONY: help Makefile

# Catch-all target: route all unknown targets to Sphinx using the new
# "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
%: Makefile
	@$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

all:	html pdf

html:
	. $(VENV); $(SPHINXBUILD) -b dirhtml . _build/html

autobuild:
	. $(VENV); sphinx-autobuild $(ALLSPHINXOPTS) --ignore ".git/*" --ignore "*.scss" . -b dirhtml -a _build/html --host 0.0.0.0 --port $(PORT)

spelling:
	sphinx-build -b spelling "$(SOURCEDIR)" "$(BUILDDIR)"

install:
	@echo "... setting up virtualenv"
	python3 -m venv env
	. $(VENV); pip install --upgrade -r requirements.txt
	@echo "\n" \
	  "--------------------------------------------------------------- \n" \
      "* watch, build and serve the documentation on port 8000: make run \n" \
	  "* check spelling: make spelling \n" \
	  "\n" \
      "enchant must be installed in order for pyenchant (and therefore \n" \
	  "spelling checks) to work. \n" \
	  "--------------------------------------------------------------- \n"

pdf:	$(PDF_NAMES)

%.pdf: %.rst
	$(RST2PDF) --smart-quotes 1 -s styles/cert-doc.style $< -o $@

maniacs: MAAS_Advanced_Network_Installation_And_Configuration_Scripted.pdf

stg: Self-Test_Guide.pdf Self-Test_Guide.pdf

coverage: Coverage_Guide.pdf

iot_coverage: Coverage_Guide_IoT-22.04.pdf

policy: Policy_Guide.pdf

programme: Programme_Guide.pdf

testcase: Test_Case_Guide-20.04.pdf Test_Case_Guide-18.04.pdf

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
