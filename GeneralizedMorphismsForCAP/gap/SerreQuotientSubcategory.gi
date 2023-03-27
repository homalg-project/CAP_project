# SPDX-License-Identifier: GPL-2.0-or-later
# GeneralizedMorphismsForCAP: Implementations of generalized morphisms for the CAP project
#
# Implementations
#

## @Chapter Serre Quotients Subcategory

DeclareRepresentation( "IsSerreQuotientSubcategoryFunctionHandlerRep",
                       IsSerreQuotientSubcategoryFunctionHandler and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfSerreQuotientSubcategoryFunctionHandler",
        NewFamily( "TheFamilyOfSerreQuotientSubcategoryFunctionHandler" ) );

BindGlobal( "TheTypeOfSerreQuotientSubcategoryFunctionHandler",
        NewType( TheFamilyOfSerreQuotientSubcategoryFunctionHandler,
                IsSerreQuotientSubcategoryFunctionHandlerRep ) );

InstallMethod( FullSubcategoryByMembershipFunction,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    return ObjectifyWithAttributes( rec( ), TheTypeOfSerreQuotientSubcategoryFunctionHandler,
                                    MembershipFunction, func,
                                    ContainingCategory, category );
    
end );

InstallMethod( SerreQuotientCategory,
               [ IsCapCategory, IsSerreQuotientSubcategoryFunctionHandler ],
               
  function( category, handler )
    
    if not IsIdenticalObj( category, ContainingCategory( handler ) ) then
        Error( "containing category is not the same as category" );
    fi;
    
    return SerreQuotientCategory( category, MembershipFunction( handler ) );
    
end );

InstallMethod( SerreQuotientCategoryByCospans,
               [ IsCapCategory, IsSerreQuotientSubcategoryFunctionHandler ],
               
  function( category, handler )
    
    if not IsIdenticalObj( category, ContainingCategory( handler ) ) then
        Error( "containing category is not the same as category" );
    fi;
    
    return SerreQuotientCategoryByCospans( category, MembershipFunction( handler ) );
    
end );

InstallMethod( SerreQuotientCategoryBySpans,
               [ IsCapCategory, IsSerreQuotientSubcategoryFunctionHandler ],
               
  function( category, handler )
    
    if not IsIdenticalObj( category, ContainingCategory( handler ) ) then
        Error( "containing category is not the same as category" );
    fi;
    
    return SerreQuotientCategoryBySpans( category, MembershipFunction( handler ) );
    
end );

InstallMethod( SerreQuotientCategoryByThreeArrows,
               [ IsCapCategory, IsSerreQuotientSubcategoryFunctionHandler ],
               
  function( category, handler )
    
    if not IsIdenticalObj( category, ContainingCategory( handler ) ) then
        Error( "containing category is not the same as category" );
    fi;
    
    return SerreQuotientCategoryByThreeArrows( category, MembershipFunction( handler ) );
    
end );

InstallMethod( \/,
               [ IsCapCategory, IsSerreQuotientSubcategoryFunctionHandler ],
               
  SerreQuotientCategory );

InstallMethod( ViewString,
               [ IsSerreQuotientSubcategoryFunctionHandler ],
               
  function( handler )
    
    return Concatenation( "<Subcategory of ", Name( ContainingCategory( handler ) ), " by ", NameFunction( MembershipFunction( handler ) ), ">" );
    
end );

InstallMethod( DisplayString,
               [ IsSerreQuotientSubcategoryFunctionHandler ],
               
  function( handler )
    
    return Concatenation( "Subcategory of ", Name( ContainingCategory( handler ) ), " by ", NameFunction( MembershipFunction( handler ) ), ".\n" );
    
end );
