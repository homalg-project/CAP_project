# SPDX-License-Identifier: GPL-2.0-or-later
# GeneralizedMorphismsForCAP: Implementations of generalized morphisms for the CAP project
#
# Declarations
#

#! @Chapter Serre Quotients Subcategory

#!  This is an implementation of a convenience object for Serre quotients.
#!  The Subcategory implemented in this file is not a CAP category at all,
#!  but only a handler for the serre quotient construction.
#!  It does not contain objects or anything useful, it is just a wrapper for the
#!  function the Serre quotient is based upon.

#! @Section implementation

DeclareCategory( "IsSerreQuotientSubcategoryFunctionHandler",
                 IsObject );

#! @Description
#!  Creates an object which handles the function to create a Serre quotient category.
#!  It can be used instead of the function for Serre quotients.
#!  Note that the result is *NOT A CATEGORY* and can not be seen as one.
#! @Returns a function handler
#! @Arguments C,func
DeclareOperation( "FullSubcategoryByMembershipFunction",
                  [ IsCapCategory, IsFunction ] );

DeclareAttribute( "MembershipFunction",
                  IsSerreQuotientSubcategoryFunctionHandler );

DeclareAttribute( "ContainingCategory",
                  IsSerreQuotientSubcategoryFunctionHandler );

DeclareOperation( "SerreQuotientCategory",
                  [ IsCapCategory, IsSerreQuotientSubcategoryFunctionHandler ] );

DeclareOperation( "SerreQuotientCategoryByCospans",
                  [ IsCapCategory, IsSerreQuotientSubcategoryFunctionHandler ] );

DeclareOperation( "SerreQuotientCategoryBySpans",
                  [ IsCapCategory, IsSerreQuotientSubcategoryFunctionHandler ] );

DeclareOperation( "SerreQuotientCategoryByThreeArrows",
                  [ IsCapCategory, IsSerreQuotientSubcategoryFunctionHandler ] );

DeclareOperation( "\/",
                  [ IsCapCategory, IsSerreQuotientSubcategoryFunctionHandler ] );
