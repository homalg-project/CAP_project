# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Declarations
#

#! @Chapter The initial category

####################################
#
#! @Section &GAP; Categories
#
####################################

#! @Description
#!  The &GAP; type of an initial category.
#! @Arguments T
DeclareCategory( "IsInitialCapCategory",
        IsCapCategory );

#! @Description
#!  The &GAP; type of a cell in an initial category.
#! @Arguments T
DeclareCategory( "IsCellInInitialCategory",
        IsCapCategoryCell );

#! @Description
#!  The &GAP; type of an object in an initial category.
#! @Arguments T
DeclareCategory( "IsObjectInInitialCategory",
        IsCellInInitialCategory and
        IsCapCategoryObjectRep );

#! @Description
#!  The &GAP; type of a morphism in an initial category.
#! @Arguments T
DeclareCategory( "IsMorphismInInitialCategory",
        IsCellInInitialCategory and
        IsCapCategoryMorphismRep );

####################################
#
#! @Section Constructor
#
####################################

#! @Description
#!  Construct a initial category.
#! @Arguments
DeclareGlobalFunction( "InitialCategory" );
#! @InsertChunk InitialCategory
