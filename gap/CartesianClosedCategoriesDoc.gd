# THIS FILE WAS AUTOMATICALLY GENERATED
# FROM MonoidalCategories v2021.12-01
# USING CategoryConstructor v2021.11-08

# SPDX-License-Identifier: GPL-2.0-or-later
# Toposes: Elementary toposes
#
# Declarations
#

####################################
##
#! @Chapter Cartesian Categories
##
#! @Section Cartesian Closed Categories
##
####################################

#! A cartesian category $\mathbf{C}$
#! which has for each functor $- \times b: \mathbf{C} \rightarrow \mathbf{C}$
#! a right adjoint (denoted by $\mathrm{Exponential}(b,-)$)
#! is called a <Emph>closed cartesian category</Emph>.

#! The corresponding GAP property is called
#! <C>IsCartesianClosedCategory</C>.

InstallTrueMethod( IsCartesianCategory, IsCartesianClosedCategory );
