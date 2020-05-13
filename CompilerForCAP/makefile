all: doc test

doc: doc/manual.six

doc/manual.six: makedoc.g \
		PackageInfo.g \
		doc/Doc.autodoc \
		gap/*.gd gap/*.gi examples/*.g
			gap makedoc.g

clean:
	(cd doc ; ./clean)

test: doc
	gap tst/testall.g

test-tabs:
	! grep -RP "\t" examples/ gap/

# broken by the arguments of CapJitIterateOverTree, which we cannot influence
test-overfull-hboxes:
	gap makedoc_with_overfull_box_warnings.g | perl -pe 'END { exit $$status } $$status=1 if /Overfull \\hbox/;'

test-with-coverage: doc
	gap --quitonbreak --cover stats tst/testall.g
	echo 'LoadPackage("profiling"); OutputJsonCoverage("stats", "coverage.json");' | gap

ci-test: test-tabs test-with-coverage
