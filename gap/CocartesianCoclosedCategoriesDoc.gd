#
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

AddCategoricalProperty( [ "IsCocartesianCoclosedCategory" ] );

InstallTrueMethod( IsCocartesianCategory, IsCocartesianCoclosedCategory );
