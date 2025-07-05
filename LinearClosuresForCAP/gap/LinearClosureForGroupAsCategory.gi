# SPDX-License-Identifier: GPL-2.0-or-later
# LinearClosuresForCAP: Linear closures
#
# Implementations
#

##
InstallMethod( LinearClosure,
               [ IsCategoryOfRows, IsGroupAsCategory ],
  function( rows, group_as_category )
    local compare_func;
    
    compare_func := function( g, h ) return UnderlyingGroupElement( g ) < UnderlyingGroupElement( h ); end;;
    
    return LinearClosure( rows, group_as_category, compare_func );
    
end );

##
InstallMethod( TwistedLinearClosure,
               [ IsCategoryOfRows, IsGroupAsCategory, IsFunction ],
  function( rows, category, cocycle )
    local compare_func;
    
    compare_func := function( g, h ) return UnderlyingGroupElement( g ) < UnderlyingGroupElement( h ); end;;
    
    return LINEAR_CLOSURE_CONSTRUCTOR_USING_CategoryOfRows( rows, category, cocycle, true, compare_func );
    
end );

##
InstallMethod( LinearClosure,
               [ IsHomalgRing, IsGroupAsCategory ],
  function( ring, group_as_category )
    local compare_func;
    
    compare_func := function( g, h ) return UnderlyingGroupElement( g ) < UnderlyingGroupElement( h ); end;;
    
    return LinearClosure( ring, group_as_category, compare_func );
    
end );

##
InstallMethod( TwistedLinearClosure,
               [ IsHomalgRing, IsGroupAsCategory, IsFunction ],
  function( ring, category, cocycle )
    local compare_func;
    
    compare_func := function( g, h ) return UnderlyingGroupElement( g ) < UnderlyingGroupElement( h ); end;;
    
    return LINEAR_CLOSURE_CONSTRUCTOR( ring, category, cocycle, true, compare_func );
    
end );
