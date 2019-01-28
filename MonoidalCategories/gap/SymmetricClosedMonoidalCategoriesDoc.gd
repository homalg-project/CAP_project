####################################
##
#! @Chapter Monoidal Categories
##
#! @Section Symmetric Closed Monoidal Categories
##
####################################

#! A monoidal category $\mathbf{C}$
#! which is symmetric and closed
#! is called a <Emph>symmetric closed monoidal category</Emph>.

#! The corresponding GAP property is given by
#! <C>IsSymmetricClosedMonoidalCategory</C>.

AddCategoricalProperty( [ "IsSymmetricClosedMonoidalCategory" ] );

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsSymmetricClosedMonoidalCategory  := Concatenation( [
], CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsSymmetricMonoidalCategory,
   CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsClosedMonoidalCategory );

InstallTrueMethod( IsClosedMonoidalCategory, IsSymmetricClosedMonoidalCategory );

InstallTrueMethod( IsSymmetricMonoidalCategory, IsSymmetricClosedMonoidalCategory );
