all: doc test

doc: doc/manual.six

doc/manual.six: makedoc.g \
		PackageInfo.g \
		doc/Intros.autodoc \
		doc/CategoriesForHomalg.bib \
		gap/*.gd gap/*.gi examples/*.g examples/doc/*.g
	        gap makedoc.g

clean:
	(cd doc ; ./clean)

test:	doc
	gap maketest.g

archive: test
	(mkdir -p ../tar; cd ..; tar czvf tar/CategoriesForHomalg.tar.gz --exclude ".DS_Store" --exclude "*~" CategoriesForHomalg/doc/*.* CategoriesForHomalg/doc/clean CategoriesForHomalg/gap/*.{gi,gd} CategoriesForHomalg/{PackageInfo.g,README,COPYING,VERSION,init.g,read.g,makedoc.g,makefile,maketest.g} CategoriesForHomalg/examples/*.g CategoriesForHomalg/examples/doc/*.g)

#WEBPOS=public_html
#WEBPOS_FINAL=~/Sites/homalg-project/CategoriesForHomalg

towww: archive
	echo '<?xml version="1.0" encoding="UTF-8"?>' >${WEBPOS}.version
	echo '<mixer>' >>${WEBPOS}.version
	cat VERSION >>${WEBPOS}.version
	echo '</mixer>' >>${WEBPOS}.version
	cp PackageInfo.g ${WEBPOS}
	cp README ${WEBPOS}/README.CategoriesForHomalg
	cp doc/manual.pdf ${WEBPOS}/CategoriesForHomalg.pdf
	cp doc/*.{css,html} ${WEBPOS}
	rm -f ${WEBPOS}/*.tar.gz
	mv ../tar/CategoriesForHomalg.tar.gz ${WEBPOS}/CategoriesForHomalg-`cat VERSION`.tar.gz
	rm -f ${WEBPOS_FINAL}/*.tar.gz
	cp ${WEBPOS}/* ${WEBPOS_FINAL}
	ln -s CategoriesForHomalg-`cat VERSION`.tar.gz ${WEBPOS_FINAL}/CategoriesForHomalg.tar.gz

