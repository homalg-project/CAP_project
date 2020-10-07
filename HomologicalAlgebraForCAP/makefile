doc: doc/manual.six

doc/manual.six: makedoc.g \
		PackageInfo.g \
		$(wildcard doc/*.autodoc gap/*.gd gap/*.gi examples/*.g examples/*/*.g)
			gap makedoc.g
