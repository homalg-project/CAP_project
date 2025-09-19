# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Implementations
#

#######################################
##
## Technical implications
##
#######################################

Add( PROPAGATION_LIST_FOR_EQUAL_OBJECTS, "IsTerminal" );
Add( PROPAGATION_LIST_FOR_EQUAL_OBJECTS, "IsInitial" );
Add( PROPAGATION_LIST_FOR_EQUAL_OBJECTS, "IsProjective" );
Add( PROPAGATION_LIST_FOR_EQUAL_OBJECTS, "IsInjective" );
Add( PROPAGATION_LIST_FOR_EQUAL_OBJECTS, "IsZeroForObjects" );

###################################
##
## Constructive Object-sets
##
###################################

# This method should not be selected when the two objects belong to the same category and the category can compute IsEqualForObjects.
InstallOtherMethod( IsEqualForObjects,
                    [ IsCapCategory, IsCapCategoryObject, IsCapCategoryObject ],

  function( cat, object_1, object_2 )
    
    if not HasCapCategory( object_1 ) then
        
        Error( Concatenation( "the object \"", String( object_1 ), "\" has no CAP category" ) );
        
    fi;
    
    if not HasCapCategory( object_2 ) then
        
        Error( Concatenation( "the object \"", String( object_2 ), "\" has no CAP category" ) );
        
    fi;
    
    if not IsIdenticalObj( CapCategory( object_1 ), cat ) then
        
        Error( Concatenation( "the object \"", String( object_1 ), "\" does not belong to the CAP category <cat>" ) );
        
    elif not IsIdenticalObj( CapCategory( object_2 ), cat ) then
        
        Error( Concatenation( "the object \"", String( object_2 ), "\" does not belong to the CAP category <cat>" ) );
        
    else
        
        # convenience: as long as the objects are identical, everything "just works"
        if IsIdenticalObj( object_1, object_2 ) then
            
            return true;
            
        else
            
            Error( "Cannot decide whether the object \"", String( object_1 ), "\" and the object \"", String( object_2 ), "\" are equal. You can fix this error by installing `IsEqualForObjects` in <cat> or possibly avoid it by enabling strict caching\n" );
            
        fi;
        
    fi;
    
end );

##
InstallMethod( \=,
               [ IsCapCategoryObject, IsCapCategoryObject ],
  function( object_1, object_2 )

    if CapCategory( object_1 )!.input_sanity_check_level > 0 or CapCategory( object_2 )!.input_sanity_check_level > 0  then
        if not IsIdenticalObj( CapCategory( object_1 ), CapCategory( object_2 ) ) then
            Error( Concatenation( "the object \"", String( object_1 ), "\" and the object \"", String( object_2 ), "\" do not belong to the same CAP category" ) );
        fi;
    fi;
               
  return IsEqualForObjects( object_1, object_2 );
end );

#######################################
##
## Operations
##
#######################################

##
InstallMethod( \/,
               [ IsObject, IsCapCategory ],
               
  function( object_datum, cat )
    
    if not CanCompute( cat, "ObjectConstructor" ) then
        
        Error( "You are calling the generic \"/\" method, but <cat> does not have an object constructor. Please add one or install a special version of \"/\"." );
        
    fi;
    
    return ObjectConstructor( cat, object_datum );
    
end );

##
InstallMethod( IsWellDefined,
               [ IsCapCategoryObject ],
  IsWellDefinedForObjects
);

##
InstallMethod( IsZero,
               [ IsCapCategoryObject ],
                  
IsZeroForObjects );

##
InstallMethod( IsEqualForCache,
               [ IsCapCategoryObject, IsCapCategoryObject ],
               
  { obj1, obj2 } -> IsEqualForCacheForObjects( CapCategory( obj1 ), obj1, obj2 ) );

##
# generic fallback to IsIdenticalObj
InstallOtherMethod( IsEqualForCacheForObjects,
               [ IsCapCategory, IsCapCategoryObject, IsCapCategoryObject ],
               
  { cat, obj1, obj2 } -> IsIdenticalObj( obj1, obj2 ) );

##
InstallMethod( SetOfObjectsAsUnresolvableAttribute,
        [ IsCapCategory ],
        
  SetOfObjectsOfCategory );

#= comment for Julia
##
InstallMethodForCompilerForCAP( SetOfObjects,
        [ IsCapCategory and HasOppositeCategory ],
        
  function( cat_op )
    
    return List( SetOfObjects( OppositeCategory( cat_op ) ), obj -> ObjectConstructor( cat_op, obj ) );
    
end );
# =#

##
InstallMethod( RandomObject, [ IsCapCategory, IsInt ], RandomObjectByInteger );

##
InstallMethod( RandomObject, [ IsCapCategory, IsList ], RandomObjectByList );

##
InstallMethod( Simplify,
               [ IsCapCategoryObject ],
  function( object )
    
    return SimplifyObject( object, infinity );
    
end );
