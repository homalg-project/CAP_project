#############################################################################
##
##                                               CategoriesForHomalg package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#############################################################################

DeclareRepresentation( "IsZFunctorObjectRep",
                       IsHomalgCategoryObjectRep and IsZFunctorObject,
                       [ ] );

BindGlobal( "TheTypeOfZFunctorObject",
        NewType( TheFamilyOfHomalgCategoryObjects,
                IsZFunctorObjectRep ) );

DeclareRepresentation( "IsZFunctorMorphismRep",
                       IsHomalgCategoryMorphismRep and IsZFunctorMorphism,
                       [ ] );

BindGlobal( "TheTypeOfZFunctorMorphism",
        NewType( TheFamilyOfHomalgCategoryMorphisms,
                IsZFunctorMorphismRep ) );

#############################
##
## Attributes
##
#############################

InstallMethod( ZFunctorCategory,
               [ IsHomalgCategory ],
               
  function( category )
    local name, z_functor_category;
    
    name := Name( category );
    
    name := Concatenation( "Functors from integers into ", name );
    
    z_functor_category := CreateHomalgCategory( name );
    
    SetUnderlyingHonestCategory( z_functor_category, category );
    
    return z_functor_category;
    
end );

#############################
##
## Setter & Getter
##
############################

InstallMethod( \[\],
               [ IsZFunctorObject, IsInt ],
               
  function( object, index )
    local part;
    
    if IsBoundElmWPObj( object!.objects, index ) then
        
        return ElmWPObj( object!.objects, index );
        
    fi;
    
    part := object!.object_func( index );
    
    SetElmWPObj( object!.objects, index, part );
    
    return part;
    
end );

InstallMethod( \[\]\:\=,
               [ IsZFunctorObject, IsInt, IsObject ],
               
  function( object, index, value )
    
    SetElmWPObj( object!.objects, index, value );
    
end );

InstallMethod( Differential,
               [ IsZFunctorObject, IsInt ],
               
  function( object, index )
    local part;
    
    if IsBoundElmWPObj( object!.differentials, index ) then
        
        return ElmWPObj( object!.differentials, index );
        
    fi;
    
    part := object!.differential_func( index );
    
    SetElmWPObj( object!.differentials, index, part );
    
    return part;
    
end );

InstallMethod( SetDifferential,
               [ IsZFunctorObject, IsInt, IsObject ],
               
  function( object, index, value )
    
    SetElmWPObj( object!.differentials, index, value );
    
end );

InstallMethod( \[\],
               [ IsZFunctorMorphism, IsInt ],
               
  function( morphism, index )
    local part;
    
    if IsBoundElmWPObj( morphism!.morphisms, index ) then
        
        return ElmWPObj( morphism!.morphisms, index );
        
    fi;
    
    part := morphism!.morphism_func( index );
    
    SetElmWPObj( morphism!.morphisms, index, part );
    
    return part;
    
end );

InstallMethod( \[\]\:\=,
               [ IsZFunctorMorphism, IsInt, IsObject ],
               
  function( morphism, index, value )
    
    SetElmWPObj( morphism!.morphisms, index, value );
    
end );

#############################
##
## Add functions
##
#############################

BindGlobal( "ADD_ZERO_OBJECT_IN_Z_FUNCTORS",
            
  function( category )
    local object_func, differential_func, zero_object;
    
    AddZeroObject( ZFunctorCategory( category ),
      
      function( )
        
        object_func := function( arg ) return ZeroObject( category ); end;
        
        differential_func := function( arg ) return IdentityMorphism( ZeroObject( category ) ); end;
        
        zero_object := ZFunctorObject( object_func, differential_func, category );
        
        return zero_object;
        
    end );
    
end );
# 
# AddToToDoList( ToDoListEntry( [ [ category, CanComputeZeroObject ],
#                                 [ category, ZFunctorCategory ] ], [ ADD_ZERO_OBJECT_IN_Z_FUNCTORS, category ] ) ); 

#############################
##
## Constructors
##
#############################

InstallMethod( ZFunctorObject,
               [ IsFunction, IsFunction, IsHomalgCategory ],
               
  function( object_func, differential_func, category )
    local object;
    
    object := rec( objects := WeakPointerObj( [ ] ),
                   differentials := WeakPointerObj( [ ] ),
                   object_func := object_func,
                   differential_func := differential_func );
    
    ObjectifyWithAttributes( object, TheTypeOfZFunctorObject );
    
    Add( ZFunctorCategory( category ), object );
    
    return object;
    
end );

InstallMethod( ZFunctorMorphism,
               [ IsZFunctorObject, IsFunction, IsZFunctorObject ],
               
  function( source, func, range )
    local morphism;
    
    morphism := rec( morphisms := WeakPointerObj( [ ] ),
                     morphism_func := func );
    
    ObjectifyWithAttributes( morphism, TheTypeOfZFunctorMorphism,
                             Source, source,
                             Range, range );
    
    Add( HomalgCategory( source ), morphism );
    
    return morphism;
    
end );
