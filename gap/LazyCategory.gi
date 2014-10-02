#############################################################################
##
##                                               CategoriesForHomalg package
##
##  Copyright 2014, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#############################################################################

DeclareRepresentation( "IsLazyCategoryObjectRep",
                       IsHomalgCategoryObjectRep and IsLazyCategoryObject,
                       [ ] );

BindGlobal( "TheTypeOfLazyCategoryObject",
        NewType( TheFamilyOfHomalgCategoryObjects,
                IsLazyCategoryObjectRep ) );

DeclareRepresentation( "IsLazyCategoryMorphismRep",
                       IsHomalgCategoryMorphismRep and IsLazyCategoryMorphism,
                       [ ] );

BindGlobal( "TheTypeOfLazyCategoryMorphism",
        NewType( TheFamilyOfHomalgCategoryMorphisms,
                IsLazyCategoryMorphismRep ) );

#################################
##
## Category constructor
##
#################################

BindGlobal( "ADDS_FOR_LAZY_CATEGORY",
            
  function( lazy_category, category )
    
    AddPreCompose( lazy_category,
                   
      function( left_morphism, right_morphism )
        local func;
        
        func := function( ) return PreCompose( Eval( left_morphism ), Eval( right_morphism ) ); end;
        
        return LazyMorphism( Source( left_morphism ), func, Range( right_morphism ) );
        
    end );
    
    AddIdentityMorphism( lazy_category,
                         
      function( object )
        local func;
        
        func := function( ) return IdentityMorphism( Eval( object ) ); end;
        
        return LazyMorphism( object, func, object );
        
    end );
    
    AddInverse( lazy_category,
                
      function( morphism )
        local func;
        
        func := function( ) return Inverse( Eval( morphism ) ); end;
        
        return LazyMorphism( Range( morphism ), func, Source( morphism ) );
        
    end );
    
    AddMonoAsKernelLift( lazy_category,
                         
      function( monomorphism, test_morphism )
        local func;
        
        func := function( ) return MonoAsKernelLift( Eval( monomorphism ), Eval( test_morphism ) ); end;
        
        return LazyMorphism( Source( test_morphism ), func, Source( monomorphism ) );
        
    end );
    
    AddEpiAsCokernelColift( lazy_category,
                            
      function( epimorphism, test_morphism )
        local func;
        
        func := function( ) return EpiAsCokernelColift( Eval( epimorphism ), Eval( test_morphism ) ); end;
        
        return LazyMorphism( Range( epimorphism ), func, Range( test_morphism ) );
        
    end );
    
    AddIsMonomorphism( lazy_category,
                       
      function( morphism )
        
        return IsMonomorphism( Eval( morphism ) );
        
    end );
    
    AddIsEpimorphism( lazy_category,
                       
      function( morphism )
        
        return IsEpimorphism( Eval( morphism ) );
        
    end );
    
    AddIsIsomorphism( lazy_category,
                       
      function( morphism )
        
        return IsIsomorphism( Eval( morphism ) );
        
    end );
    
    AddDominates( lazy_category,
                  
      function( subobject1, subobject2 )
        
        return Dominates( Eval( subobject1 ), Eval( subobject2 ) );
        
    end );
    
    AddCodominates( lazy_category,
                  
      function( factorobject1, factorobject2 )
        
        return Codominates( Eval( factorobject1 ), Eval( factorobject2 ) );
        
    end );
    
    AddEqualityOfMorphisms( lazy_category,
                           
      function( morphism1, morphism2 )
        
        return EqualityOfMorphisms( Eval( morphism1 ), Eval( morphism2 ) );
        
    end );
    
    AddIsZeroForMorphisms( lazy_category,
                           
      function( morphism )
        
        return IsZero( Eval( morphism ) );
        
    end );
    
    AddAdditionForMorphisms( lazy_category,
                             
      function( morphism1, morphism2 )
        local func;
        
        func := function( ) return Eval( morphism1 ) + Eval( morphism2 ); end;
        
        return LazyMorphism( Source( morphism1 ), func, Range( morphism2 ) );
        
    end );
    
    AddAdditiveInverseForMorphisms( lazy_category,
                                   
      function( morphism )
        local func;
        
        func := function( ) return AdditiveInverse( Eval( morphism ) ); end;
        
        return LazyMorphism( Source( morphism ), func, Range( morphism ) );
        
    end );
    
    AddZeroMorphism( lazy_category,
                     
      function( source, range )
        local func;
        
        func := function( ) return ZeroMorphism( Eval( source ), Eval( range ) ); end;
        
        return LazyMorphism( source, func, range );
        
    end );
    
    AddIsWellDefinedForMorphisms( lazy_category,
                                  
      function( morphism )
        
        return IsWellDefined( Eval( morphism ) );
        
    end );
    
    AddKernel( lazy_category,
      
      function( morphism )
        local func;
        
        func := function( ) return KernelObject( Eval( morphism ) ); end;
        
        return LazyObject( func );
        
      end );
      
    AddKernelEmb( lazy_category,
                  
      function( morphism )
        local func;
        
        func := function( ) return KernelEmb( Eval( morphism ) ); end;
        
        return LazyMorphismWithoutSource( func, Source( morphism ) );
        
    end );
    
    AddKernelEmbWithGivenKernel( lazy_category,
      
      function( morphism, kernel )
        local func;
        
        func := function( ) return KernelEmbWithGivenKernel( Eval( morphism ), Eval( kernel ) ); end;
        
        return LazyMorphism( kernel, func, Source( morphism ) );
        
    end );
    
    AddKernelLift( lazy_category,
      
      function( morphism, test_morphism )
        local func;
        
        func := function( ) return KernelLift( Eval( morphism ), Eval( test_morphism ) ); end;
        
        return LazyMorphismWithoutRange( Source( test_morphism ), func );
        
    end );
    
    AddKernelLiftWithGivenKernel( lazy_category,
      
      function( morphism, test_morphism, kernel )
        local func;
        
        func := function( ) return KernelLiftWithGivenKernel( Eval( morphism ), Eval( test_morphism ), Eval( kernel ) ); end;
        
        return LazyMorphism( Source( test_morphism ), func, kernel );
        
    end );
    
    AddCokernel( lazy_category,
      
      function( morphism )
        local func;
        
        func := function( ) return Cokernel( Eval( morphism ) ); end;
        
        return LazyObject( func );
        
    end );
    
    AddCokernelProj( lazy_category,
      
      function( morphism )
        local func;
        
        func := function( ) return CokernelProj( Eval( morphism ) ); end;
        
        return LazyMorphismWithoutRange( Range( morphism ), func );
        
    end );
    
    AddCokernelProjWithGivenCokernel( lazy_category,
      
      function( morphism, cokernel )
        local func;
        
        func := function( ) return CokernelProjWithGivenCokernel( Eval( morphism ), Eval( cokernel ) ); end;
        
        return LazyMorphism( Range( morphism ), func, cokernel );
        
    end );
    
    AddCokernelColift( lazy_category,
      
      function( morphism, test_morphism )
        local func;
        
        func := function( ) return CokernelColift( Eval( morphism ), Eval( test_morphism ) ); end;
        
        return LazyMorphismWithoutSource( func, Range( test_morphism ) );
        
    end );
    
    AddCokernelColiftWithGivenCokernel( lazy_category,
      
      function( morphism, test_morphism, cokernel )
        local func;
        
        func := function( ) return CokernelColiftWithGivenCokernel( Eval( morphism ), Eval( test_morphism ), Eval( cokernel ) ); end;
        
        return LazyMorphism( cokernel, func, Range( test_morphism ) );
        
    end );
    
    AddZeroObject( lazy_category,
      
      function( )
        local func;
        
        func := function( ) return ZeroObject( UnderlyingBusyCategory( lazy_category ) ); end;
        
        return LazyObject( func );
        
    end );
    
end );

InstallMethod( LazyCategory,
               [ IsHomalgCategory ],
               
  function( category )
    local lazy_category;
    
    lazy_category := CreateHomalgCategory( Concatenation( "Lazy category of ", Name( category ) ) );
    
    SetUnderlyingBusyCategory( lazy_category, category );
    
    ADDS_FOR_LAZY_CATEGORY( lazy_category, category );
    
    return lazy_category;
    
end );

InstallMethod( Lazy,
               [ IsHomalgCategoryObject ],
               
  function( cell )
    local lazy_cell;
    
    lazy_cell := rec( );
    
    ObjectifyWithAttributes( lazy_cell, TheTypeOfLazyCategoryObject );
    
    SetEval( lazy_cell, cell );
    
    Add( LazyCategory( HomalgCategory( cell ) ), lazy_cell );
    
    return lazy_cell;
    
end );

InstallMethod( Lazy,
               [ IsHomalgCategoryMorphism ],
               
  function( morphism )
    local lazy_morphism;
    
    lazy_morphism := rec( );
    
    ObjectifyWithAttributes( lazy_morphism, TheTypeOfLazyCategoryMorphism );
    
    SetEval( lazy_morphism, morphism );
    
    SetSource( lazy_morphism, Lazy( Source( morphism ) ) );
    
    SetRange( lazy_morphism, Lazy( Range( morphism ) ) );
    
    Add( LazyCategory( HomalgCategory( morphism ) ), lazy_morphism );
    
    return lazy_morphism;
    
end );

InstallGlobalFunction( LazyObject,
                       
  function( evaluate_function )
    local lazy_object;
    
    lazy_object := rec( evaluate_function := evaluate_function );
    
    ObjectifyWithAttributes( lazy_object, TheTypeOfLazyCategoryObject );
    
    return lazy_object;
    
end );

InstallGlobalFunction( LazyMorphism,
                       
  function( source, evaluate_function, range )
    local lazy_morphism, entry;
    
    lazy_morphism := rec( evaluate_function := evaluate_function );
    
    ObjectifyWithAttributes( lazy_morphism, TheTypeOfLazyCategoryMorphism );
    
    SetSource( lazy_morphism, source );
    
    SetRange( lazy_morphism, range );
    
    entry := ToDoListEntry( [ [ lazy_morphism, "Eval" ] ], source, "Eval", function( arg ) return Source( Eval( lazy_morphism ) ); end );
    
    AddToToDoList( entry );
    
    entry := ToDoListEntry( [ [ lazy_morphism, "Eval" ] ], range, "Eval", function( arg ) return Range( Eval( lazy_morphism ) ); end );
    
    AddToToDoList( entry );
    
    return lazy_morphism;
    
end );

InstallGlobalFunction( LazyMorphismWithoutSourceAndRange,
                       
  function( evaluate_function )
    local lazy_morphism, source, range, entry;
    
    lazy_morphism := rec( evaluate_function := evaluate_function );
    
    ObjectifyWithAttributes( lazy_morphism, TheTypeOfLazyCategoryMorphism );
    
    source := LazyObject( function( ) return Source( Eval( lazy_morphism ) ); end );
    
    SetSource( lazy_morphism, source );
    
    range := LazyObject( function( ) return Range( Eval( lazy_morphism ) ); end );
    
    SetRange( lazy_morphism, range );
    
    entry := ToDoListEntry( [ [ lazy_morphism, "Eval" ] ], source, "Eval", function( arg ) return Source( Eval( lazy_morphism ) ); end );
    
    AddToToDoList( entry );
    
    entry := ToDoListEntry( [ [ lazy_morphism, "Eval" ] ], range, "Eval", function( arg ) return Range( Eval( lazy_morphism ) ); end );
    
    AddToToDoList( entry );
    
    return lazy_morphism;
    
end );

InstallGlobalFunction( LazyMorphismWithoutSource,
                       
  function( evaluate_function, range )
    local lazy_morphism, source, entry;
    
    lazy_morphism := rec( evaluate_function := evaluate_function );
    
    ObjectifyWithAttributes( lazy_morphism, TheTypeOfLazyCategoryMorphism );
    
    source := LazyObject( function( ) return Source( Eval( lazy_morphism ) ); end );
    
    SetSource( lazy_morphism, source );
    
    SetRange( lazy_morphism, range );
    
    entry := ToDoListEntry( [ [ lazy_morphism, "Eval" ] ], source, "Eval", function( arg ) return Source( Eval( lazy_morphism ) ); end );
    
    AddToToDoList( entry );
    
    entry := ToDoListEntry( [ [ lazy_morphism, "Eval" ] ], range, "Eval", function( arg ) return Range( Eval( lazy_morphism ) ); end );
    
    AddToToDoList( entry );
    
    return lazy_morphism;
    
end );

InstallGlobalFunction( LazyMorphismWithoutRange,
                       
  function( source, evaluate_function )
    local lazy_morphism, range, entry;
    
    lazy_morphism := rec( evaluate_function := evaluate_function );
    
    ObjectifyWithAttributes( lazy_morphism, TheTypeOfLazyCategoryMorphism );
    
    SetSource( lazy_morphism, source );
    
    range := LazyObject( function( ) return Range( Eval( lazy_morphism ) ); end );
    
    SetRange( lazy_morphism, range );
    
    entry := ToDoListEntry( [ [ lazy_morphism, "Eval" ] ], source, "Eval", function( arg ) return Source( Eval( lazy_morphism ) ); end );
    
    AddToToDoList( entry );
    
    entry := ToDoListEntry( [ [ lazy_morphism, "Eval" ] ], range, "Eval", function( arg ) return Range( Eval( lazy_morphism ) ); end );
    
    AddToToDoList( entry );
    
    return lazy_morphism;
    
end );

#################################
##
## Dummy Constructors
##
#################################

##
InstallMethod( Object,
               [ IsHomalgCategory ],
               
  function( category )
    local object;
    
    object := rec( );
    
    ObjectifyWithAttributes( object, TheTypeOfLazyCategoryObject );
    
    Add( LazyCategory( category ), object );
    
    return object;
    
end );

##
InstallMethod( Object,
               [ IsHomalgCategoryCell ],
               
  function( cell )
    
    return Object( HomalgCategory( cell ) );
    
end );

##
InstallMethod( Morphism,
               [ IsHomalgCategoryObject, IsHomalgCategory, IsHomalgCategoryObject ],
               
  function( source, category, range )
    local lazy_category, morphism, entry;
    
    lazy_category := LazyCategory( category );
    
    if not ObjectFilter( lazy_category )( source ) then
        
        Error( "source must lie in lazy category" );
        
    fi;
    
    if not ObjectFilter( lazy_category )( source ) then
        
        Error( "range must lie in lazy category" );
        
    fi;
    
    morphism := rec( );
    
    ObjectifyWithAttributes( morphism, TheTypeOfLazyCategoryMorphism,
                             Source, source,
                             Range, range );
    
    entry := ToDoListEntry( [ [ morphism, "Eval" ] ], source, "Eval", function( arg ) return Source( Eval( morphism ) ); end );
    
    AddToToDoList( entry );
    
    entry := ToDoListEntry( [ [ morphism, "Eval" ] ], range, "Eval", function( arg ) return Range( Eval( morphism ) ); end );
    
    AddToToDoList( entry );
    
    Add( lazy_category, morphism );
    
    return morphism;
    
end );

InstallMethod( Morphism,
               [ IsHomalgCategoryObject, IsHomalgCategoryCell, IsHomalgCategoryObject ],
               
  function( source, cell, range )
    
    return Morphism( source, HomalgCategory( cell ), range );
    
end );

InstallMethod( Morphism,
               [ IsHomalgCategory ],
               
  function( category )
    local lazy_category, source, range, morphism, entry;
    
    lazy_category := LazyCategory( category );
    
    morphism := rec( );
    
    ObjectifyWithAttributes( morphism, TheTypeOfLazyCategoryMorphism );
    
    source := LazyObject( function( ) return Source( Eval( morphism ) ); end );
    
    SetSource( morphism, source );
    
    entry := ToDoListEntry( [ [ morphism, "Eval" ] ], source, "Eval", function( arg ) return Source( Eval( morphism ) ); end );
    
    AddToToDoList( entry );
    
    range := LazyObject( function( ) return Range( Eval( morphism ) ); end );
    
    SetRange( morphism, range );
    
    entry := ToDoListEntry( [ [ morphism, "Eval" ] ], range, "Eval", function( arg ) return Range( Eval( morphism ) ); end );
    
    AddToToDoList( entry );
    
    Add( lazy_category, morphism );
    
    return morphism;
    
end );

InstallMethod( Morphism,
               [ IsHomalgCategoryCell ],
               
  function( cell )
    
    return Morphism( HomalgCategory( cell ) );
    
end );

#################################
##
## Cell attributes
##
#################################

InstallMethod( Eval,
               [ IsLazyCategoryCell ],
               
  function( cell )
    
    return cell!.evaluate_function( );
    
end );

#################################
##
## View
##
#################################

InstallMethod( ViewObj,
               [ IsLazyCategoryObject ],
               
  function( cell )
    
    Print( "<An unevaluated object in " );
    
    Print( Name( HomalgCategory( cell ) ) );
    
    Print( ">" );
    
end );

InstallMethod( ViewObj,
               [ IsLazyCategoryMorphism ],
               
  function( cell )
    
    Print( "<An unevaluated morphism in " );
    
    Print( Name( HomalgCategory( cell ) ) );
    
    Print( ">" );
    
end );

InstallMethod( ViewObj,
               [ IsLazyCategoryCell and HasEval ],
               100000000000000, ##FIXME!!!!
               
  function( cell )
    
    Print( "Lazy hull of:\n" );
    
    ViewObj( Eval( cell ) );
    
end );
