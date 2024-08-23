# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Declarations
#

#! @Chapter Dummy implementations

####################################
#
#! @Section Dummy homalg rings
#
####################################

#! The operations in this section require
#! `MatricesForHomalg` to be loaded.

####################################
#
# GAP filters
#
####################################

#! @Description
#!  The &GAP; filter of dummy homalg rings.
DeclareFilter( "IsDummyHomalgRing",
        IsHomalgRing );

#! @Description
#!  The &GAP; filter of elements of a dummy homalg ring.
DeclareFilter( "IsDummyHomalgRingElement",
        IsHomalgRingElement );

#! @Description
#!  The &GAP; filter of dummy commutative homalg rings.
DeclareFilter( "IsDummyCommutativeHomalgRing",
        IsDummyHomalgRing );

#! @Description
#!  The &GAP; filter of elements of a dummy commutative homalg ring.
DeclareFilter( "IsDummyCommutativeHomalgRingElement",
        IsDummyHomalgRingElement );

#! @Description
#!  The &GAP; filter of dummy homalg fields.
DeclareFilter( "IsDummyHomalgField",
        IsDummyCommutativeHomalgRing );

#! @Description
#!  The &GAP; filter of elements of a dummy homalg field.
DeclareFilter( "IsDummyHomalgFieldElement",
        IsDummyCommutativeHomalgRingElement );

####################################
#
# Constructors
#
####################################

#! @Description
#! @Arguments
#! @Returns a dummy homalg ring
DeclareGlobalFunction( "DummyHomalgRing" );

#! @Description
#! @Arguments
#! @Returns a dummy commutative homalg ring
DeclareGlobalFunction( "DummyCommutativeHomalgRing" );

#! @Description
#! @Arguments
#! @Returns a dummy homalg field
DeclareGlobalFunction( "DummyHomalgField" );

