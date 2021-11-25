# THIS FILE WAS AUTOMATICALLY GENERATED FROM MonoidalCategories v2021.11-04

# SPDX-License-Identifier: GPL-2.0-or-later
# Toposes: Elementary toposes
#
# Declarations
#

####################################
##
#! @Chapter Cocartesian Categories
##
#! @Section Cocartesian Coclosed Categories
##
####################################

#! A cocartesian category $\mathbf{C}$
#! which has for each functor $b \sqcup -: \mathbf{C} \rightarrow \mathbf{C}$
#! a left adjoint (denoted by $\mathrm{Coexponential}(-,b)$)
#! is called a <Emph>coclosed cocartesian category</Emph>.

#! The corresponding GAP property is called
#! <C>IsCocartesianCoclosedCategory</C>.

InstallTrueMethod( IsCocartesianCategory, IsCocartesianCoclosedCategory );
