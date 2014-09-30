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
        
        func := function( ) return PreCompose( EvalUnderlyingObject( left_morphism ), EvalUnderlyingObject( right_morphism ) ); end;
        
        return DummyLazyMorphism( Source( left_morphism ), func, Range( right_morphism ) );
        
    end );
    
    AddIdentityMorphism( lazy_category,
                         
      function( object )
        local func;
        
        func := function( ) return IdentityMorphism( EvalUnderlyingObject( object ) ); end;
        
        return DummyLazyMorphism( object, func, object );
        
    end );
    
    AddInverse( lazy_category,
                
      function( morphism )
        local func;
        
        func := function( ) return Inverse( EvalUnderlyingObject( morphism ) ); end;
        
        return DummyLazyMorphism( Range( morphism ), func, Source( morphism ) );
        
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
    
    SetEvalUnderlyingObject( lazy_cell, cell );
    
    Add( LazyCategory( HomalgCategory( cell ) ), lazy_cell );
    
    return lazy_cell;
    
end );

InstallMethod( Lazy,
               [ IsHomalgCategoryMorphism ],
               
  function( morphism )
    local lazy_morphism;
    
    lazy_morphism := rec( );
    
    ObjectifyWithAttributes( lazy_morphism, TheTypeOfLazyCategoryMorphism );
    
    SetEvalUnderlyingObject( lazy_morphism, morphism );
    
    SetSource( lazy_morphism, Lazy( Source( morphism ) ) );
    
    SetRange( lazy_morphism, Lazy( Range( morphism ) ) );
    
    Add( LazyCategory( HomalgCategory( morphism ) ), lazy_morphism );
    
    return lazy_morphism;
    
end );

InstallGlobalFunction( DummyLazyObject,
                       
  function( evaluate_function )
    local lazy_object;
    
    lazy_object := rec( evaluate_function := evaluate_function );
    
    ObjectifyWithAttributes( lazy_object, TheTypeOfLazyCategoryObject );
    
    return lazy_object;
    
end );

InstallGlobalFunction( DummyLazyMorphism,
                       
  function( source, evaluate_function, range )
    local lazy_morphism;
    
    lazy_morphism := rec( evaluate_function := evaluate_function );
    
    ObjectifyWithAttributes( lazy_morphism, TheTypeOfLazyCategoryMorphism );
    
    SetSource( lazy_morphism, source );
    
    SetRange( lazy_morphism, range );
    
    return lazy_morphism;
    
end );

#################################
##
## Cell attributes
##
#################################

InstallMethod( EvalUnderlyingObject,
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
               [ IsLazyCategoryCell and HasEvalUnderlyingObject ],
               100000000000000, ##FIXME!!!!
               
  function( cell )
    
    ViewObj( EvalUnderlyingObject( cell ) );
    
end );
