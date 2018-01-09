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