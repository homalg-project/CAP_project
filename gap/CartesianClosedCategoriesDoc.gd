#
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

AddCategoricalProperty( [ "IsCartesianClosedCategory" ] );

InstallTrueMethod( IsCartesianCategory, IsCartesianClosedCategory );
