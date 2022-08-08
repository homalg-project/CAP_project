# SPDX-License-Identifier: GPL-2.0-or-later
# Toposes: Elementary toposes
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
#!  The &GAP; type of a initial category.
#! @Arguments T
DeclareCategory( "IsInitialCapCategory",
        IsCapCategory );

AddCategoricalProperty( [ "IsInitialCategory", "IsInitialCategory" ] );

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
