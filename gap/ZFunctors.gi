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
    
    INSTALL_TODO_LIST_ENTRIES_FOR_ZFUNCTOR_CATEGORY( category );
    
    return z_functor_category;
    
end );

#############################
##
## Getter
##
############################
##
## No setter are installed:
## All differentials and objects of a ZFunctor are determined
## after its construction. Thus, they should behave
## like an infinite family of attributes. But the user is not supposed to
## set attributes manually in order to construct an object.
## For example: Z := ZeroObject( ZFunctorCategory( ) ) must not be
## seen as a "dummy" object for which I can set Z[i] arbitrarily,
## for Z already knows that it is a zero object.

InstallMethod( \[\],
               [ IsZFunctorObject, IsInt ],
               
  function( object, index )
    local object_weak_pointer_list, list_index, part;
    
    if index > 0 then
        
        object_weak_pointer_list := object!.objects_positive;
        
        list_index := index;
        
    else
        
        object_weak_pointer_list := object!.objects_nonpositive;
        
        list_index := -index + 1;
        
    fi;
      
    if IsBoundElmWPObj( object_weak_pointer_list, list_index ) then
        
        return ElmWPObj( object_weak_pointer_list, list_index );
        
    fi;
  
    part := object!.object_func( index );
    
    SetElmWPObj( object_weak_pointer_list, list_index, part );
    
    return part;
    
end );

InstallMethod( Differential,
               [ IsZFunctorObject, IsInt ],
               
  function( object, index )
    local differential_weak_pointer_list, list_index, part;
    
    if index > 0 then
        
        differential_weak_pointer_list := object!.differentials_positive;
        
        list_index := index;
        
    else
        
        differential_weak_pointer_list := object!.differentials_nonpositive;
        
        list_index := -index + 1;
        
    fi;
      
    if IsBoundElmWPObj( differential_weak_pointer_list, list_index ) then
        
        return ElmWPObj( differential_weak_pointer_list, list_index );
        
    fi;
  
    part := object!.differential_func( index );
    
    SetElmWPObj( differential_weak_pointer_list, list_index, part );
    
    return part;
    
end );

InstallMethod( \[\],
               [ IsZFunctorMorphism, IsInt ],
               
  function( morphism, index )
    local morphisms_weak_pointer_list, list_index, part;
    
    if index > 0 then
        
        morphisms_weak_pointer_list := morphism!.morphisms_positive;
        
        list_index := index;
        
    else
        
        morphisms_weak_pointer_list := morphism!.morphisms_nonpositive;
        
        list_index := -index + 1;
        
    fi;
      
    if IsBoundElmWPObj( morphisms_weak_pointer_list, list_index ) then
        
        return ElmWPObj( morphisms_weak_pointer_list, list_index );
        
    fi;
  
    part := morphism!.morphism_func( index );
    
    SetElmWPObj( morphisms_weak_pointer_list, list_index, part );
    
    return part;
    
end );

#############################
##
## Add functions
##
#############################

## Kernel
##
BindGlobal( "ADD_KERNEL_OBJECT_IN_Z_FUNCTORS",
          
  function( category )
      local object_func, differential_func, kernel_object;
      
      AddKernelObject( ZFunctorCategory( category ),
        
        function( morphism )
          
          object_func := function( index )
              
              return KernelObject( morphism[ index ] );
              
          end;
          
          differential_func := function( index )
              local cohomological_index, morphism_part, kernel_embedding_range, differential_part, kernel_embedding_source;
              
              cohomological_index := index + 1;
              
              morphism_part := morphism[ cohomological_index ];
              
              kernel_embedding_range := KernelEmb( morphism_part );
              
              differential_part := Source( morphism )[ index ];
              
              kernel_embedding_source := KernelEmb( morphism[ index ] );
              
              return KernelLift(
                PreCompose( kernel_embedding_range, morphism_part ),
                PreCompose( kernel_embedding_source, differential_part )
              );
              
          end;
          
          kernel_object := ZFunctorObject( object_func, differential_func, category );
          
          return kernel_object;
          
      end );
      
end );

## Zero Object
##
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

##
InstallGlobalFunction( INSTALL_TODO_LIST_ENTRIES_FOR_ZFUNCTOR_CATEGORY,
            
  function( category )
    local entry;
    
    entry := ToDoListEntry( [ [ category, "CanComputeZeroObject" ], [ category, "ZFunctorCategory" ] ],
                            function( ) ADD_ZERO_OBJECT_IN_Z_FUNCTORS( category ); end );
    
    AddToToDoList( entry );
    
    entry := ToDoListEntry( [ [ category, "CanComputeKernelObject" ], [ category, "CanComputeKernelEmb" ],
                              [ category, "CanComputeKernelLift" ], [ category, "ZFunctorCategory" ] ],
                            function( ) ADD_ZERO_OBJECT_IN_Z_FUNCTORS( category ); end );
    
    AddToToDoList( entry );
    
end );

#############################
##
## Constructors
##
#############################

InstallMethod( ZFunctorObject,
               [ IsFunction, IsFunction, IsHomalgCategory ],
               
  function( object_func, differential_func, category )
    local object;
    
    object := rec( objects_positive := WeakPointerObj( [ ] ),
                   objects_nonpositive := WeakPointerObj( [ ] ),
                   differentials_positive := WeakPointerObj( [ ] ),
                   differentials_nonpositive := WeakPointerObj( [ ] ),
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
    
    morphism := rec( morphisms_positive := WeakPointerObj( [ ] ),
                     morphisms_nonpositive := WeakPointerObj( [ ] ),
                     morphism_func := func );
    
    ObjectifyWithAttributes( morphism, TheTypeOfZFunctorMorphism,
                             Source, source,
                             Range, range );
    
    Add( HomalgCategory( source ), morphism );
    
    return morphism;
    
end );
