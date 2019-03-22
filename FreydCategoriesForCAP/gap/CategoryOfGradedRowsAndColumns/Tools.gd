#############################################################################
##
## FreydCategoriesForCAP package
##
## Copyright 2019, Martin Bies,       ULB Brussels
##
#! @Chapter Category of graded rows and category of graded columns
##
#############################################################################



############################################
##
#! @Section Tools to simplify code
##
############################################

#! @Description
#! The argument is a homalg_matrix <A>m</A> and a graded row <A>R</A>. We then consider the module map 
#! induced from <A>m</A> with range <A>R</A>. This operation then deduces the source of this map and returns
#! the map in the category of graded rows.
#! @Returns a morphism
#! @Arguments m, R
DeclareOperation( "DeduceMapFromMatrixAndRangeForGradedRows",
                  [ IsHomalgMatrix, IsGradedRow ] );

#! @Description
#! The argument is a homalg_matrix <A>m</A> and a graded row <A>S</A>. We then consider the module map 
#! induced from <A>m</A> with source <A>S</A>. This operation then deduces the range of this map and returns
#! the map in the category of graded rows.
#! @Returns a morphism
#! @Arguments m, S
DeclareOperation( "DeduceMapFromMatrixAndSourceForGradedRows",
                  [ IsHomalgMatrix, IsGradedRow ] );

#! @Description
#! The argument is a homalg_matrix <A>m</A> and a graded column <A>R</A>. We then consider the module map 
#! induced from <A>m</A> with range <A>R</A>. This operation then deduces the source of this map and returns
#! the map in the category of graded columns.
#! @Returns a morphism
#! @Arguments m, R
DeclareOperation( "DeduceMapFromMatrixAndRangeForGradedCols",
                  [ IsHomalgMatrix, IsGradedColumn ] );

#! @Description
#! The argument is a homalg_matrix <A>m</A> and a graded column <A>S</A>. We then consider the module map 
#! induced from <A>m</A> with source <A>S</A>. This operation then deduces the range of this map and returns
#! the map in the category of graded columns.
#! @Returns a morphism
#! @Arguments m, S
DeclareOperation( "DeduceMapFromMatrixAndSourceForGradedCols",
                  [ IsHomalgMatrix, IsGradedColumn ] );

#! @Description
#! Given a graded row or column <A>S</A>, the degrees are stored in compact form. For example, the degrees [ 1, 1, 1, 1 ] #! is stored internally as [ 1, 4 ]. The second argument is thus the multipicity with which three degree 1 
#! appears. Still, it can be useful at times to also go in the opposite direction, i.e. to take the compact form [ #! 1, 4 ] and turn it into [ 1, 1, 1, 1 ]. This is performed by this operation and the obtained extended degree #! list is returned.
#! @Returns a list
#! @Arguments S
DeclareOperation( "UnzipDegreeList",
                  [ IsGradedRowOrColumn ] );
