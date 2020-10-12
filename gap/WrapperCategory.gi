# SPDX-License-Identifier: GPL-2.0-or-later
# WrapperCategories: Construct an equivalent wrapper category out of a CAP category
#
# Implementations
#

##
SetInfoLevel( InfoWrapperCategory, 1 );

##
InstallMethodWithCache( AsObjectInWrapperCategory,
        "for a wrapper CAP category and a CAP object",
        [ IsWrapperCapCategory, IsCapCategoryObject ],
        
  function( D, object )
    local o;
    
    if not IsIdenticalObj( CapCategory( object ), UnderlyingCategory( D ) ) then
        
        Error( "the given object should belong to the underlying category: ", Name( UnderlyingCategory( D ) ), "\n" );
        
    fi;
    
    o := rec( );
    
    ObjectifyObjectForCAPWithAttributes( o, D,
            UnderlyingCell, object );
    
    return o;
    
end );

##
InstallMethod( AsMorphismInWrapperCategory,
        "for two CAP objects in a wrapper category and a CAP morphism",
        [ IsWrapperCapCategoryObject, IsCapCategoryMorphism, IsWrapperCapCategoryObject ],
        
  function( source, morphism, range )
    local D, m;
    
    D := CapCategory( source );
    
    if not IsIdenticalObj( CapCategory( morphism ), UnderlyingCategory( D ) ) then
        
        Error( "the given morphism should belong to the underlying category: ", Name( UnderlyingCategory( D ) ), "\n" );
        
    fi;
    
    m := rec( );
    
    ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( m, D,
            source,
            range,
            UnderlyingCell, morphism );
    
    return m;
    
end );

##
InstallMethodWithCache( AsMorphismInWrapperCategory,
        "for a wrapper CAP category and a CAP morphism",
        [ IsWrapperCapCategory, IsCapCategoryMorphism ],
        
  function( D, morphism )
    
    return AsMorphismInWrapperCategory(
                   AsObjectInWrapperCategory( D, Source( morphism ) ),
                   morphism,
                   AsObjectInWrapperCategory( D, Range( morphism ) )
                   );
    
end );

##
InstallOtherMethod( \/,
        "for an object and a wrapper CAP category",
        [ IsObject, IsWrapperCapCategory ],
        
  function( data, C )
    
    return ( data / UnderlyingCategory( C ) ) / C;
    
end );

##
InstallMethod( \/,
        "for a CAP category object and a wrapper CAP category",
         [ IsCapCategoryObject, IsWrapperCapCategory ],
        
  function( object, cat )
    
    if not IsIdenticalObj( CapCategory( object ), UnderlyingCategory( cat ) ) then
        TryNextMethod( );
    fi;
    
    return AsObjectInWrapperCategory( cat, object );
    
end );

##
InstallMethod( \/,
        "for a CAP category morphism and a wrapper CAP category",
        [ IsCapCategoryMorphism, IsWrapperCapCategory ],
        
  function( morphism, cat )
    
    if not IsIdenticalObj( CapCategory( morphism ), UnderlyingCategory( cat ) ) then
        TryNextMethod( );
    fi;
    
    return AsMorphismInWrapperCategory( cat, morphism );
    
end );

##
InstallMethod( WrapperCategory,
        "for a CAP category",
        [ IsCapCategory ],
        
  function( C )
    local name, create_func_bool, create_func_object0, create_func_morphism0,
          create_func_object, create_func_morphism, create_func_universal_morphism,
          primitive_operations, list_of_operations_to_install, skip, func, pos,
          commutative_ring, properties, D,
          cache, print, list, wrap_range_of_hom_structure, HC, finalize;
    
    name := ValueOption( "name" );
    
    if not IsString( name ) then
        if HasName( C ) then
            name := Concatenation( "WrapperCategory( ", Name( C ), " )" );
        else
            name := "wrapper category";
        fi;
    fi;
    
    ## e.g., IsSplitEpimorphism
    create_func_bool :=
      function( name, D )
        local oper;
        
        oper := ValueGlobal( name );
        
        return
          function( arg )
            
            return CallFuncList( oper, List( arg, UnderlyingCell ) );
            
        end;
        
    end;
    
    ## e.g., ZeroObject
    create_func_object0 :=
      function( name, D )
        local oper;
        
        oper := ValueGlobal( name );
        
        return
          function( )
            
            return AsObjectInWrapperCategory( D, oper( UnderlyingCategory( D ) ) );
            
          end;
          
      end;
    
    ## e.g., ZeroObjectFunctorial
    create_func_morphism0 :=
      function( name, D )
        local oper;
        
        oper := ValueGlobal( name );
        
        return
          function( D )
            
            return AsMorphismInWrapperCategory( D, oper( UnderlyingCategory( D ) ) );
            
          end;
          
      end;
    
    ## e.g., DirectSum
    create_func_object :=
      function( name, D )
        local oper;
        
        oper := ValueGlobal( name );
        
        return ## a constructor for universal objects
          function( arg )
            
            return AsObjectInWrapperCategory( D, CallFuncList( oper, List( arg, UnderlyingCell ) ) );
            
          end;
          
      end;
    
    ## e.g., IdentityMorphism, PreCompose
    create_func_morphism :=
      function( name, D )
        local type, oper;
        
        type := CAP_INTERNAL_METHOD_NAME_RECORD.(name).io_type;
        
        oper := ValueGlobal( name );
        
        return
          function( arg )
            local src_trg, S, T;
            
            src_trg := CAP_INTERNAL_GET_CORRESPONDING_OUTPUT_OBJECTS( type, arg );
            S := src_trg[1];
            T := src_trg[2];
            
            return AsMorphismInWrapperCategory( S, CallFuncList( oper, List( arg, UnderlyingCell ) ), T );
            
          end;
          
      end;
    
    ## e.g., ProjectionInFactorOfDirectSumWithGivenDirectSum
    create_func_universal_morphism :=
      function( name, D )
        local info, type, oper;
        
        info := CAP_INTERNAL_METHOD_NAME_RECORD.(name);
        
        if not info.with_given_without_given_name_pair[2] = name then
            Error( name, " is not the constructor of a universal morphism with a given universal object\n" );
        fi;
        
        type := CAP_INTERNAL_METHOD_NAME_RECORD.(name).io_type;
        
        oper := ValueGlobal( name );
        
        return
          function( arg )
            local src_trg, S, T;
            
            src_trg := CAP_INTERNAL_GET_CORRESPONDING_OUTPUT_OBJECTS( type, arg );
            S := src_trg[1];
            T := src_trg[2];
            
            return AsMorphismInWrapperCategory( S, CallFuncList( oper, List( arg, UnderlyingCell ) ), T );
            
          end;
        
    end;
    
    primitive_operations := not IsIdenticalObj( ValueOption( "primitive_operations" ), false );
    
    if primitive_operations then
        list_of_operations_to_install := ListPrimitivelyInstalledOperationsOfCategory( C );
    else
        list_of_operations_to_install := ListInstalledOperationsOfCategory( C );
    fi;
    
    list_of_operations_to_install := ShallowCopy( list_of_operations_to_install );
    
    skip := [ "MultiplyWithElementOfCommutativeRingForMorphisms",
              "FiberProductEmbeddingInDirectSum", ## TODO: CAP_INTERNAL_GET_CORRESPONDING_OUTPUT_OBJECTS in create_func_morphism cannot deal with it yet
              ];
    
    for func in skip do
        
        pos := Position( list_of_operations_to_install, func );
        if not pos = fail then
            Remove( list_of_operations_to_install, pos );
        fi;
        
    od;
    
    if HasCommutativeRingOfLinearCategory( C ) then
        commutative_ring := CommutativeRingOfLinearCategory( C );
    else
        commutative_ring := fail;
    fi;
    
    properties := ListKnownCategoricalProperties( C );
    
    properties := List( properties, p -> [ p, ValueGlobal( p )( C ) ] );
    
    D := CategoryConstructor( :
                 name := name,
                 category_filter := IsWrapperCapCategory,
                 category_object_filter := IsWrapperCapCategoryObject,
                 category_morphism_filter := IsWrapperCapCategoryMorphism,
                 commutative_ring := commutative_ring,
                 properties := properties,
                 is_monoidal := HasIsMonoidalCategory( C ) and IsMonoidalCategory( C ),
                 list_of_operations_to_install := list_of_operations_to_install,
                 create_func_bool := create_func_bool,
                 create_func_object0 := create_func_object0,
                 create_func_morphism0 := create_func_morphism0,
                 create_func_object := create_func_object,
                 create_func_morphism := create_func_morphism,
                 create_func_universal_morphism := create_func_universal_morphism
                 );
    
    SetUnderlyingCategory( D, C );
    
    cache := CAP_INTERNAL_RETURN_OPTION_OR_DEFAULT( "cache", true );
    
    if IsIdenticalObj( cache, false ) then
        DeactivateCachingOfCategory( C );
        DeactivateCachingOfCategory( D );
    fi;
    
    print := IsIdenticalObj( CAP_INTERNAL_RETURN_OPTION_OR_DEFAULT( "print", false ), true );
    
    if CanCompute( C, "MultiplyWithElementOfCommutativeRingForMorphisms" ) then
        
        if print then
            Display( "MultiplyWithElementOfCommutativeRingForMorphisms" );
        fi;
        
        ##
        AddMultiplyWithElementOfCommutativeRingForMorphisms( D,
          function( r, phi )
            
            return AsMorphismInWrapperCategory( Source( phi ), MultiplyWithElementOfCommutativeRingForMorphisms( r, phi ), Range( phi ) );
            
        end );
        
    fi;
    
    if HasRangeCategoryOfHomomorphismStructure( C ) then
        
        if print then
            list := [
                     "BasisOfExternalHom",
                     "CoefficientsOfMorphismWithGivenBasisOfExternalHom",
                     "DistinguishedObjectOfHomomorphismStructure",
                     "HomomorphismStructureOnObjects",
                     "HomomorphismStructureOnMorphismsWithGivenObjects",
                     "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure",
                     "InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism",
                     ];
            
            for func in list do
                if CanCompute( C, func ) then
                    Display( func );
                fi;
            od;
            Display( "" );
        fi;
        
        if CanCompute( C, "BasisOfExternalHom" ) then
            AddBasisOfExternalHom( D,
              function( a, b )
                
                return List( BasisOfExternalHom( UnderlyingCell( a ), UnderlyingCell( b ) ),
                             mor -> AsMorphismInWrapperCategory( a, mor, b ) );
                
            end );
        fi;
        
        if CanCompute( C, "CoefficientsOfMorphismWithGivenBasisOfExternalHom" ) then
            AddCoefficientsOfMorphismWithGivenBasisOfExternalHom( D,
              function( alpha, L )
                
                return CoefficientsOfMorphismWithGivenBasisOfExternalHom(
                               UnderlyingCell( alpha ),
                               List( L, UnderlyingCell ) );
                
            end );
        fi;
        
        wrap_range_of_hom_structure := IsIdenticalObj( CAP_INTERNAL_RETURN_OPTION_OR_DEFAULT( "wrap_range_of_hom_structure", true ), true );
        
        HC := RangeCategoryOfHomomorphismStructure( C );
        
        if IsIdenticalObj( cache, false ) then
            DeactivateCachingOfCategory( HC );
        fi;
        
        if wrap_range_of_hom_structure and not IsWrapperCapCategory( HC ) then
            
            HC := WrapperCategory( HC : wrap_range_of_hom_structure := false );
            
            if CanCompute( C, "DistinguishedObjectOfHomomorphismStructure" ) then
                AddDistinguishedObjectOfHomomorphismStructure( D,
                  function( )
                    
                    return AsObjectInWrapperCategory( HC, DistinguishedObjectOfHomomorphismStructure( C ) );
                    
                end );
            fi;
            
            if CanCompute( C, "HomomorphismStructureOnObjects" ) then
                AddHomomorphismStructureOnObjects( D,
                  function( a, b )
                    
                    return AsObjectInWrapperCategory( HC, HomomorphismStructureOnObjects( a, b ) );
                    
                end );
            fi;
            
            if CanCompute( C, "HomomorphismStructureOnMorphismsWithGivenObjects" ) then
                AddHomomorphismStructureOnMorphismsWithGivenObjects( D,
                  function( s, alpha, beta, r )
                    
                    return AsMorphismInWrapperCategory( s, HomomorphismStructureOnMorphismsWithGivenObjects( s, alpha, beta, r ), r );
                    
                end );
            fi;
            
            if CanCompute( C, "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure" ) then
                AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( D,
                  function( alpha )
                    
                    return AsMorphismInWrapperCategory( DistinguishedObjectOfHomomorphismStructure( CapCategory( alpha ) ), InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( alpha ), HomomorphismStructureOnObjects( Source( alpha ), Range( alpha ) ) );
                    
                end );
            fi;
            
            if CanCompute( C, "InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism" ) then
                AddInterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( D,
                  function( a, b, iota )
                    
                    return AsMorphismInWrapperCategory( a, InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( a, b, iota ), b );
                    
                end );
            fi;
            
        else
            
            if CanCompute( C, "DistinguishedObjectOfHomomorphismStructure" ) then
                AddDistinguishedObjectOfHomomorphismStructure( D,
                  function( )
                    
                    return DistinguishedObjectOfHomomorphismStructure( C );
                    
                end );
            fi;
            
            if CanCompute( C, "HomomorphismStructureOnObjects" ) then
                AddHomomorphismStructureOnObjects( D,
                  function( a, b )
                    
                    return HomomorphismStructureOnObjects( UnderlyingCell( a ), UnderlyingCell( b ) );
                    
                end );
            fi;
            
            if CanCompute( C, "HomomorphismStructureOnMorphismsWithGivenObjects" ) then
                AddHomomorphismStructureOnMorphismsWithGivenObjects( D,
                  function( s, alpha, beta, r )
                    
                    return HomomorphismStructureOnMorphismsWithGivenObjects( s, UnderlyingCell( alpha ), UnderlyingCell( beta ), r );
                    
                end );
            fi;
            
            if CanCompute( C, "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure" ) then
                AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( D,
                  function( alpha )
                    
                    return InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( UnderlyingCell( alpha ) );
                    
                end );
            fi;
            
            if CanCompute( C, "InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism" ) then
                AddInterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( D,
                  function( a, b, iota )
                    
                    return AsMorphismInWrapperCategory( CapCategory( a ), InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( UnderlyingCell( a ), UnderlyingCell( b ), iota ) );
                    
                end );
            fi;
            
        fi;
        
        SetRangeCategoryOfHomomorphismStructure( D, HC );
        
    fi;
    
    finalize := ValueOption( "FinalizeCategory" );
    
    if finalize = false then
      
      return D;
      
    fi;
    
    Finalize( D );
    
    return D;
    
end );

##################################
##
## View & Display
##
##################################

##
InstallMethod( ViewObj,
        "for an object in a wrapper CAP category",
        [ IsWrapperCapCategoryObject ],
        
  function( a )
    
    Print( "<An object in ", Name( CapCategory( a ) ), ">" );
    
end );

##
InstallMethod( ViewObj,
        "for a morphism in a wrapper CAP category",
        [ IsWrapperCapCategoryMorphism ],
        
  function( phi )
    
    Print( "<A morphism in ", Name( CapCategory( phi ) ), ">" );
    
end );

##
InstallMethod( Display,
        "for an object in a wrapper CAP category",
        [ IsWrapperCapCategoryObject ],
        
  function( a )
    
    Display( UnderlyingCell( a ) );
    
    Display( "\nAn object given by the above data" );
    
end );

##
InstallMethod( Display,
        "for a morphism in a wrapper CAP category",
        [ IsWrapperCapCategoryMorphism ],
        
  function( phi )
    
    Display( UnderlyingCell( phi ) );
    
    Display( "\nA morphism given by the above data" );
    
end );
