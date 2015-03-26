all: doc test

doc: doc/manual.six

doc/manual.six: makedoc.g \
		PackageInfo.g \
		doc/Intros.autodoc \
		gap/*.gd gap/*.gi examples/*.g*
	        gap makedoc.g

clean:
	(cd doc ; ./clean)

test:	doc
	gap maketest.g

archive: test
	(mkdir -p ../tar; cd ..; tar czvf tar/CAP.tar.gz --exclude ".DS_Store" --exclude "*~" CAP/doc/*.* CAP/doc/clean CAP/gap/*.{gi,gd} CAP/{PackageInfo.g,README,COPYING,VERSION,init.g,read.g,makedoc.g,makefile,maketest.g} CAP/examples/*.g CAP/examples/doc/*.g)

#WEBPOS=public_html
#WEBPOS_FINAL=~/Sites/homalg-project/CAP

towww: archive
	echo '<?xml version="1.0" encoding="UTF-8"?>' >${WEBPOS}.version
	echo '<mixer>' >>${WEBPOS}.version
	cat VERSION >>${WEBPOS}.version
	echo '</mixer>' >>${WEBPOS}.version
	cp PackageInfo.g ${WEBPOS}
	cp README ${WEBPOS}/README.CAP
	cp doc/manual.pdf ${WEBPOS}/CAP.pdf
	cp doc/*.{css,html} ${WEBPOS}
	rm -f ${WEBPOS}/*.tar.gz
	mv ../tar/CAP.tar.gz ${WEBPOS}/CAP-`cat VERSION`.tar.gz
	rm -f ${WEBPOS_FINAL}/*.tar.gz
	cp ${WEBPOS}/* ${WEBPOS_FINAL}
	ln -s CAP-`cat VERSION`.tar.gz ${WEBPOS_FINAL}/CAP.tar.gz

