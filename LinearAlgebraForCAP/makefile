# make sure gap --quitonbreak fails even if it is part of a pipe
SHELL=/bin/bash -o pipefail

all: doc test

doc: doc/manual.six

doc/manual.six: makedoc.g \
		PackageInfo.g \
		$(wildcard doc/*.autodoc gap/*.gd gap/*.gi examples/*.g examples/*/*.g)
			gap --quitonbreak makedoc.g

clean:
	(cd doc ; ./clean)

test: doc
	gap tst/testall.g

test-basic-spacing:
	# exit code 1 means no match, which is what we want here (exit code 2 signals an error)
	grep -RPl "\t" examples/ gap/; test $$? -eq 1 || (echo "Tabs found" && exit 1)
	grep -RPl "\r" examples/ gap/; test $$? -eq 1 || (echo "Windows line-endings found" && exit 1)
	grep -RPzL "\n\z" examples/ gap/ | grep ""; test $$? -eq 1 || (echo "File with no newline at end of file found" && exit 1)

test-doc: doc
	cp -aT doc/ doc_tmp/
	cd doc_tmp && ./clean
	gap --quitonbreak makedoc_with_overfull_hbox_warnings.g | perl -pe 'END { exit $$status } $$status=1 if /#W/;'

test-with-coverage: doc
	gap --quitonbreak --cover stats tst/testall.g
	gap --quitonbreak --norepl -c 'LoadPackage("profiling"); OutputJsonCoverage("stats", "coverage.json");'

test-spacing:
	# exit code 1 means no match, which is what we want here (exit code 2 signals an error)
	grep -R "[^ [\"]  " gap/*.gi; test $$? -eq 1 || (echo "Duplicate spaces found" && exit 1)
	grep -RE '[^ ] +$$' gap/*; test $$? -eq 1 || (echo "Trailing whitespace found" && exit 1)
	for filename in gap/*; do \
		echo $$filename; \
		gap --quitonbreak --norepl --banner -c "LoadPackage(\"LinearAlgebraForCAP\"); SizeScreen([4096]); func := ReadAsFunction(\"$$filename\"); FileString(\"gap_spacing\", DisplayString(func));"; \
		# In a perfect world, the DisplayString of a function would exactly match our code. However, our line breaks and indentation might differ from the GAP ones, \
		# so we remove all indentation, line breaks, and empty lines, and afterwards insert line breaks at semicolons again for better readability. \
		cat "gap_spacing" | tail -n +2 | head -n -2 | sed 's/\[  \]/[ ]/g' | sed 's/(  )/( )/g' | sed 's/(  :/( :/g' | sed 's/ *$$//' | sed 's/^ *//' | grep -v "^$$" | tr "\n" " " | sed 's/;/;\n/g' > modified_gap_spacing; \
		cat "$$filename" | grep -v "^ *[#]" | sed 's/^ *//' | grep -v "^$$" | tr "\n" " " | sed "s/;/;\n/g" > modified_custom_spacing; \
		# Our code might still differ from the GAP code, for example because of additional brackets. \
		# Thus, we diff the code once as expected and once ignoring all space. Diffing the two diffs then shows lines which only differ by spacing. \
		diff modified_gap_spacing modified_custom_spacing > spacing_diff; \
		diff modified_gap_spacing modified_custom_spacing --ignore-all-space --ignore-space-change --ignore-trailing-space --ignore-blank-lines > spacing_diff_no_blanks; \
		diff spacing_diff_no_blanks spacing_diff || exit; \
	done
	rm gap_spacing
	rm modified_gap_spacing
	rm modified_custom_spacing
	rm spacing_diff
	rm spacing_diff_no_blanks

ci-test: test-basic-spacing test-with-coverage
