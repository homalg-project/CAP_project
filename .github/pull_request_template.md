Thanks for your contribution! To make sure everything is in place, please check the instructions below.
If anything is unclear or does not work, don't hesitate to submit the PR as is.

1. If the changes warrant a release (if in doubt, assume yes), bump the version numbers of the affected packages.
   The version number is of the format `YYYY.MM-NN`, where `YYYY` and `MM` are the current year and month, and `NN` is a two digit number counting upwards, starting from `01` each month.
2. Look for warnings of the following format when loading packages:
   ```
   WARNING: The file <file> in package <package> differs from the automatically generated one.
   You can view the automatically generated file at the following path: <tmp_path>
   ```
   If such a warning appears, copy the file at `<tmp_path>` to `<file>` in package `<package>`.
3. Run `FreydCategoriesForCAP/examples/generate_documentation.g` to update the documentation.
4. Execute `make test` in `CompilerForCAP` to update the precompiled code.
5. Add and commit all files changed by the steps above.
