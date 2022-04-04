# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up computations in CAP categories
#
# make sure that compilation does not slow down with larger function IDs
# e.g. one must not use function IDs as list indices
gap> CAP_JIT_INTERNAL_FUNCTION_ID := 10^9;;
