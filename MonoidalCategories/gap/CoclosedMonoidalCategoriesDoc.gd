####################################
##
#! @Chapter Monoidal Categories
##
#! @Section Coclosed Monoidal Categories
##
####################################

#! A monoidal category $\mathbf{C}$
#! which has for each functor $b \otimes -: \mathbf{C} \rightarrow \mathbf{C}$
#! a left adjoint (denoted by $\mathrm{\underline{coHom}}(-,b)$)
#! is called a <Emph>coclosed monoidal category</Emph>.

#! The corresponding GAP property is called
#! <C>IsCoclosedMonoidalCategory</C>.

AddCategoricalProperty( [ "IsCoclosedMonoidalCategory", fail ] );

InstallTrueMethod( IsMonoidalCategory, IsCoclosedMonoidalCategory );
