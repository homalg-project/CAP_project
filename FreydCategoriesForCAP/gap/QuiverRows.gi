#############################################################################
##
##     FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
##
##  Copyright 2019, Sebastian Posur, University of Siegen
##
#############################################################################

####################################
##
## Constructors
##
####################################

##
InstallMethod( QuiverRows,
               [ IsQuiverAlgebra ],
               
  function( underlying_quiver_algebra )
    
    return QuiverRows( underlying_quiver_algebra, false );
    
end );

##
InstallMethod( QuiverRowsDescentToZDefinedByBasisPaths,
               [ IsQuiverAlgebra ],
               
  function( underlying_quiver_algebra )
    
    return QuiverRows( underlying_quiver_algebra, true );
    
end );

##
InstallMethod( QuiverRowsDescentToZDefinedByBasisPaths,
               [ IsQuiverRowsCategory ],
               
  function( quiver_rows )
    local underlying_quiver_algebra;
    
    underlying_quiver_algebra := UnderlyingQuiverAlgebra( quiver_rows );
    
    return QuiverRows( underlying_quiver_algebra, true );
    
end );

##
InstallMethod( QuiverRows,
               [ IsQuiverAlgebra, IsBool ],
               
  function( underlying_quiver_algebra, over_Z )
    local underlying_quiver, category, ring, paths, p, q, category_name;
    
    if not IsFiniteDimensional( underlying_quiver_algebra ) then
        
        Error( "the given quiver has to be finite dimensional\n" );
        
    fi;
    
    ring := LeftActingDomain( underlying_quiver_algebra );
    
    if over_Z then
        
        if IsIdenticalObj( ring, Rationals )
           or
           ( HasIsRationalsForHomalg( ring ) and IsRationalsForHomalg( ring )
             and not IsHomalgExternalRingRep( ring ) )
        then
            
            ## Test if the multiplication table which is induced by the basis of the quiver algebra
            ## (computed by the Groebner basis) only has integral coefficients.
            paths := BasisPaths( CanonicalBasis( underlying_quiver_algebra ) );
            
            for p in paths do
                
                for q in paths do
                    
                    if not ForAll( Coefficients( PathAsAlgebraElement( underlying_quiver_algebra, p ) * PathAsAlgebraElement( underlying_quiver_algebra, q ) ), IsInt ) then
                        
                        Error( "the basis of the given quiver algebra does give rise to a well-defined algebroid over Z\n");
                        
                    fi;
                    
                od;
                
            od;
            
        else
            
            Error( "the left acting domain of the given quiver algebra is not supported for constructing an algebroid of the integers\n");
            
        fi;
        
        ring := HomalgRingOfIntegers();
        
        category_name := Concatenation( "QuiverRows( ", String( underlying_quiver_algebra )," ) descended to Z" );
        
    else
        
        category_name := Concatenation( "QuiverRows( ", String( underlying_quiver_algebra )," )" );
        
    fi;
    
    underlying_quiver := QuiverOfAlgebra( underlying_quiver_algebra );
    
    category := CreateCapCategory( category_name );
    
    DeactivateCachingOfCategory( category );
    
    CapCategorySwitchLogicOff( category );
    
    SetFilterObj( category, IsQuiverRowsCategory );
    
    SetIsAdditiveCategory( category, true );
    
    SetIsLinearCategoryOverCommutativeRing( category, true );
    
    SetCommutativeRingOfLinearCategory( category, ring );
    
    SetUnderlyingQuiverAlgebra( category, underlying_quiver_algebra );
    
    SetUnderlyingQuiver( category, underlying_quiver );
    
    AddObjectRepresentation( category, IsQuiverRowsObject );
    
    AddMorphismRepresentation( category, IsQuiverRowsMorphism );
    
    INSTALL_FUNCTIONS_FOR_QUIVER_ROWS( category, over_Z );
    
    Finalize( category );
    
    return category;
    
end );

##
InstallMethod( QuiverRowsObject,
               [ IsList, IsQuiverRowsCategory ],
               
  function( list_of_vertices, category )
    local quiver_rows_object, s, L, v, vertex, current;
    
    quiver_rows_object := rec( );
    
    ## create normal form of list_of_vertices
    ## every object will be constructed via this constructor, thus,
    ## every object can be assumed to be in normal form
    ## [ [ vertex, multiplicity ], ... ]
    ## multiplicites > 0
    
    ## get rid of zeros (and negative integers)
    list_of_vertices := Filtered( list_of_vertices, l -> IsPosInt( l[2] ) );
    
    ## collect consecutive vertices
    s := Size( list_of_vertices );
    
    if s > 1 then
        
        L := [];
        
        current := ShallowCopy( list_of_vertices[1] );
        
        for v in [ 2 .. s ] do
            
            vertex := list_of_vertices[v];
            
            if vertex[1] = current[1] then
                
                current[2] := current[2] + vertex[2];
                
            else
                
                Add( L, current );
                
                current := ShallowCopy( vertex );
                
            fi;
            
        od;
        
        Add( L, current );
        
    else
        
        L := list_of_vertices;
        
    fi;
    
    ObjectifyObjectForCAPWithAttributes(
        quiver_rows_object, category,
        ListOfQuiverVertices, L
    );

    Add( category, quiver_rows_object );
    
    return quiver_rows_object;
    
end );

##
InstallMethod( QuiverRowsMorphism,
               [ IsQuiverRowsObject, IsList, IsQuiverRowsObject ],
               
  function( source, matrix, range )
    local quiver_rows_morphism, category;
    
    quiver_rows_morphism := rec( );
    
    category := CapCategory( source );

    ObjectifyMorphismForCAPWithAttributes( 
                             quiver_rows_morphism, category,
                             Source, source,
                             Range, range,
                             MorphismMatrix, matrix
    );

    Add( category, quiver_rows_morphism );
    
    return quiver_rows_morphism;
    
end );

##
InstallMethod( AsQuiverRowsObject,
               [ IsQuiverVertex, IsQuiverRowsCategory ],
               
  function( v, category )
    
    return QuiverRowsObject( [ [ v, 1 ] ], category );
    
end );

##
InstallMethod( AsQuiverRowsMorphism,
               [ IsQuiverAlgebraElement, IsQuiverRowsCategory ],
               
  function( m, category )
    local v, w, m_rep;
    
    if IsZero( m ) then
        
        Error( "cannot create a morphism form 0 since the information about source and range is not deducable\n" );
        
    fi;
    
    if not IsUniform( m ) then
        
        Error( "the given element is not uniform\n" );
        
    fi;
    
    if IsQuotientOfPathAlgebraElement( m ) then
        
        m_rep := Representative( m );
        
    else
        
        m_rep := m;
        
    fi;
    
    v := Source( LeadingPath( m_rep ) );
    
    w := Target( LeadingPath( m_rep ) );
    
    return QuiverRowsMorphism( AsQuiverRowsObject( v, category ), [ [ m ] ], AsQuiverRowsObject( w, category ) );
    
end );

##
InstallMethod( NrRows,
               [ IsQuiverRowsMorphism ],
               
  function( morphism )
    
    return NrSummands( Source( morphism ) );
    
end );

##
InstallMethod( NrColumns,
               [ IsQuiverRowsMorphism ],
               
  function( morphism )
    
    return NrSummands( Range( morphism ) );
    
end );

##
InstallMethod( \[\],
               [ IsQuiverRowsMorphism, IsInt ],
               
  function( morphism, i )
    local nr_cols, mat, zero;
    
    if not ( i >= 1 ) and ( i <= NrRows( morphism ) ) then
        
        Error( "bad index" );
        
    fi;
    
    nr_cols := NrColumns( morphism );
    
    if nr_cols = 0 then
        
        return [ ];
        
    fi;
    
    mat := MorphismMatrix( morphism );
    
    zero := Zero( UnderlyingQuiverAlgebra( CapCategory( morphism ) ) );
    
    if IsEmpty( mat ) then
        
        return List( [ 1 .. nr_cols ], i -> zero );
        
    fi;
    
    return mat[i];
    
end );

##
InstallMethod( NrSummands,
               [ IsQuiverRowsObject ],
               
    function( object )
      
      return Sum( List( ListOfQuiverVertices( object ), l -> l[2] ) );
      
end );

##
InstallMethod( \[\],
               [ IsQuiverRowsObject, IsInt ],
               
  function( object, i )
    local list, current, l;
    
    if not ( ( i >= 1 ) and ( i <= NrSummands( object ) ) ) then
        
        Error( "bad index" );
        
    fi;
    
    list := ListOfQuiverVertices( object );
    
    current := 0;
    
    for l in list do
        
        current := current + l[2];
        
        if current >= i then
            
            return l[1];
            
        fi;
        
    od;
    
    Error( "Bug in []-Operator for IsQuiverRowsObject" );
    
end );

##
InstallMethod( AsListListOfMatrices,
                [ IsQuiverRowsMorphism ],
  function( alpha )
    local list_source, list_range, row_intervals, boundary, i, col_intervals, listlist, intr, intc, mat, row;
    
    list_source := ListOfQuiverVertices( Source( alpha ) );
    
    if IsEmpty( list_source ) then
        
        return [];
        
    fi;
    
    list_range := ListOfQuiverVertices( Range( alpha ) );
    
    if IsEmpty( list_range ) then
        
        return [];
        
    fi;
    
    row_intervals := [];
    
    boundary := 1;
    
    for i in [ 1 .. Size( list_source ) ] do
        
        row_intervals[i] := [ boundary .. boundary + (list_source[i][2] - 1) ];
        
        boundary := boundary + list_source[i][2];
        
    od;
    
    col_intervals := [];
    
    boundary := 1;
    
    for i in [ 1 .. Size( list_range ) ] do
        
        col_intervals[i] := [ boundary .. boundary + (list_range[i][2] - 1) ];
        
        boundary := boundary + list_range[i][2];
        
    od;
    
    mat := MorphismMatrix( alpha );
    
    listlist := [];
    
    for intr in row_intervals do
        
        row := [];
        
        for intc in col_intervals do
            
            Add( row, List( mat{intr}, r -> r{intc} ) );
            
        od;
        
        Add( listlist, row );
        
    od;
    
    return listlist;
    
end );

##
InstallMethod( PermutationToSortedRepresentative,
               [ IsQuiverRowsObject ],
               
  function( object )
    local list;
    
    list := ListOfQuiverVertices( object );
    
    return SortingPerm( List( list, l -> l[1] ) );
    
end );

##
InstallMethod( SortedRepresentative,
               [ IsQuiverRowsObject ],
                
  function( object )
    local perm, list;
    
    perm := PermutationToSortedRepresentative( object );
    
    list := ListOfQuiverVertices( object );
    
    return QuiverRowsObject( Permuted( list, perm ), CapCategory( object ) );
    
end );

####################################
##
## Basic operations
##
####################################


InstallGlobalFunction( INSTALL_FUNCTIONS_FOR_QUIVER_ROWS,
  
  function( category, over_Z )
    local algebra, quiver, zero, IDENTITY_MATRIX_QUIVER_ROWS, ZERO_MATRIX_QUIVER_ROWS,
          vertices, basis, basis_paths_by_vertex_index, path, MATRIX_FOR_ALGEBROID_HOMSTRUCTURE, hom_structure_algebroid,
          object_constructor, ring, morphism_constructor, hom_structure_range_category, hom_structure_on_morphisms_for_pure_components,
          distinguished_object, representative_func;
    
    algebra := UnderlyingQuiverAlgebra( category );
    
    ring := CommutativeRingOfLinearCategory( category );
    
    quiver := UnderlyingQuiver( category );
    
    zero := Zero( algebra );
    
    ## prepare the homomorphism structure
    
    ## storing the basis paths
    ## basis_paths_by_vertex_index[ v_index ][ w_index ] = [ p_1:v -> w, p_2:v -> w, ... ]
    vertices := Vertices( quiver );
    
    basis := BasisPaths( CanonicalBasis( algebra ) );
    
    basis_paths_by_vertex_index := List( vertices, i -> List( vertices, i -> [ ] ) );
    
    for path in basis do
        
        Add( basis_paths_by_vertex_index[ VertexIndex( Source( path ) ) ][ VertexIndex( Target( path ) ) ], path );
        
    od;
    
    ## precomputing matrices for the hom structure of the algebroid
    ## hom_structure_algebroid[ v_index ][ w_index ][ v'_index ][ w'_index ][ path_1_index ][ path_2_index ] = [ Hom(v,w) -> Hom(v',w'): x -> path_1 * x * path_2 ]
    ## in particular: (path_1: v' -> v), (path_2: w -> w')
    
    MATRIX_FOR_ALGEBROID_HOMSTRUCTURE := function( v, w, vp, wp, path_1, path_2 )
        local mat, hom_v_w, hom_vp_wp, alpha, beta, path;
        
        mat := [];
        
        hom_v_w := basis_paths_by_vertex_index[ VertexIndex( v ) ][ VertexIndex( w ) ];
        
        if IsEmpty( hom_v_w ) then
            
            return mat;
            
        fi;
        
        hom_vp_wp := basis_paths_by_vertex_index[ VertexIndex( vp ) ][ VertexIndex( wp ) ];
        
        if IsEmpty( hom_vp_wp ) then
            
            return mat;
            
        fi;
        
        alpha := PathAsAlgebraElement( algebra, path_1 );
        
        beta := PathAsAlgebraElement( algebra, path_2 );
        
        if IsQuotientOfPathAlgebra( algebra ) then
            
            for path in hom_v_w do
                
                Add( mat,
                  CoefficientsOfPaths( hom_vp_wp, Representative( alpha * PathAsAlgebraElement( algebra, path ) * beta ) )
                );
                
            od;
            
        else
            
            for path in hom_v_w do
                
                Add( mat,
                  CoefficientsOfPaths( hom_vp_wp, ( alpha * PathAsAlgebraElement( algebra, path ) * beta ) )
                );
                
            od;
            
        fi;
        
        return mat;
        
    end;
    
    hom_structure_algebroid :=
        List( vertices, v ->
            List( vertices, w ->
                List( vertices, vp ->
                    List( vertices, wp ->
                        List( basis_paths_by_vertex_index[ VertexIndex( vp ) ][ VertexIndex( v ) ], path_1 ->
                            List( basis_paths_by_vertex_index[ VertexIndex( w ) ][ VertexIndex( wp ) ], path_2 ->
                                MATRIX_FOR_ALGEBROID_HOMSTRUCTURE( v, w, vp, wp, path_1, path_2 )
                            )
                        )
                    )
                )
            )
        );
    
    ## object constructor for hom structure
    
    if over_Z then
        
        hom_structure_range_category := CategoryOfRows( ring );
        
        ##
        object_constructor := function( n )
            
            return CategoryOfRowsObject( n, hom_structure_range_category );
            
        end;
        
        ##
        morphism_constructor := function( source, mat, range )
            local matrix;
            
            if IsEmpty( mat ) then
                
                matrix := HomalgZeroMatrix( RankOfObject( source ), RankOfObject( range ), ring );
                
            else
                
                matrix := HomalgMatrix( mat, RankOfObject( source ), RankOfObject( range ), ring );
                
            fi;
            
            return CategoryOfRowsMorphism( source, matrix, range );
            
        end;
        
        distinguished_object := CategoryOfRowsObject( 1, hom_structure_range_category );
        
    else
        
        hom_structure_range_category := MatrixCategory( ring );
        
        ##
        object_constructor := function( n )
            
            return VectorSpaceObject( n, ring );
            
        end;
        
        ##
        morphism_constructor := function( source, mat, range )
            
            return VectorSpaceMorphism( source, mat, range );
            
        end;
        
        distinguished_object := TensorUnit( hom_structure_range_category );
        
    fi;
    
    SetRangeCategoryOfHomomorphismStructure( category, hom_structure_range_category );
    
    ##
    if IsQuotientOfPathAlgebra( algebra ) then
        
        representative_func := Representative;
        
    else
        
        representative_func := IdFunc;
        
    fi;
    
    ##
    ZERO_MATRIX_QUIVER_ROWS := function( nr_rows, nr_cols )
        
        if nr_rows = 0 or nr_cols = 0 then
            
            return [];
            
        fi;
        
        return NullMat( nr_rows, nr_cols, algebra );
        
    end;
    
    ##
    IDENTITY_MATRIX_QUIVER_ROWS := function( object )
        local size, list, l, mat, row, counter, v, id, j;
        
        size := NrSummands( object );
        
        if size = 0 then
            
            return [];
            
        fi;
        
        list := ListOfQuiverVertices( object );
        
        mat := [];
        
        counter := 1;
        
        for l in list do
            
            v := l[1];
            
            id := PathAsAlgebraElement( algebra, v );
            
            for j in [ counter .. counter + (l[2] - 1) ] do
                
                row := List( [ 1 .. size ], i -> zero );
                
                row[j] := id;
                
                Add( mat, row );
                
            od;
            
            counter := counter + l[2];
            
        od;
        
        return mat;
        
    end;
    
    ##
    AddIsEqualForCacheForObjects( category,
      IsIdenticalObj );
    
    ##
    AddIsEqualForCacheForMorphisms( category,
      IsIdenticalObj );
    
    ## Well-defined for objects and morphisms
    ##
    AddIsWellDefinedForObjects( category,
      function( object )
        local list;
        
        list := ListOfQuiverVertices( object );
        
        if IsEmpty( list ) then
            
            return true;
            
        fi;
        
        if not ForAll( list, l -> IsList( l ) and Size( l ) = 2 ) then
            
            return false;
            
        fi;
        
        if not ForAll( list, l -> IsQuiverVertex( l[1] ) and IsPosInt( l[2] ) ) then
            
            return false;
            
        fi;
        
        if not ForAll( list, l -> l[1] in quiver ) then
            
            return false;
            
        fi;
        
        # all tests passed, so it is well-defined
        return true;
        
    end );
    
    ##
    AddIsWellDefinedForMorphisms( category,
      function( morphism )
        local matrix, nr_rows, nr_cols, source, range, i, j, m, v, w;
        
        matrix := MorphismMatrix( morphism );
        
        nr_rows := NrRows( morphism );
        
        nr_cols := NrColumns( morphism );
        
        if nr_rows = 0 or nr_cols = 0 then
            
            return IsEmpty( matrix );
            
        fi;
        
        if not Size( matrix ) = nr_rows then
            
            return false;
            
        fi;
        
        if not ForAll( matrix, row -> Size( row ) = nr_cols ) then
            
            return false;
            
        fi;
        
        source := Source( morphism );
        
        range := Range( morphism );
        
        for i in [ 1 .. nr_rows ] do
            
            for j in [ 1 .. nr_cols ] do
                
                m := matrix[i][j];
                
                ##TODO: in operator does not distinguish between quotient and non-quotient algebra
                if not (m in algebra) then
                    Print( "1");
                    return false;
                    
                fi;
                
                if not IsZero( m ) then
                    
                    if not IsUniform( m ) then
                        
                        return false;
                        
                    fi;
                    
                    if IsQuotientOfPathAlgebraElement( m ) then
                        
                        m := Representative( m );
                        
                    fi;
                    
                    v := Source( LeadingPath( m ) ); 
                        
                    if not ( source[i] = v ) then
                        
                        return false;
                        
                    fi;
                    
                    w := Target( LeadingPath( m ) );
                    
                    if not ( range[j] = w ) then
                        
                        return false;
                        
                    fi;
                    
                    if over_Z and not ForAll( Coefficients( m ), IsInt ) then
                        
                        return false;
                        
                    fi;
                fi;
                
            od;
            
        od;
        
        # all tests passed, so it is well-defined
        return true;
        
    end );
    
    ## Equality Basic Operations for Objects and Morphisms
    ##
    AddIsEqualForObjects( category,
      function( A, B )
        
        return ListOfQuiverVertices( A ) = ListOfQuiverVertices( B );
      
    end );
    
    ##
    AddIsCongruentForMorphisms( category,
      function( alpha, beta )
        
        return MorphismMatrix( alpha ) = MorphismMatrix( beta );
        
    end );
    
    ## Basic Operations for a Category
    
    ##
    AddIdentityMorphism( category,
      
      function( object )
        
        return QuiverRowsMorphism( object, IDENTITY_MATRIX_QUIVER_ROWS( object ), object );
        
    end );
    
    ##
    AddZeroMorphism( category,
      function( source, range )
        
        return QuiverRowsMorphism( source, ZERO_MATRIX_QUIVER_ROWS( NrSummands( source ), NrSummands( range ) ), range );
        
    end );
    
    ##
    AddPreCompose( category,
      function( alpha, beta )
        local A, B, C, mat;
        
        A := Source( alpha );
        
        B := Range( alpha );
        
        C := Range( beta );
        
        if NrSummands( A ) = 0 or NrSummands( B ) = 0 or NrSummands( C ) = 0 then
            
            return QuiverRowsMorphism( A, [], C );
            
        fi;
        
        mat := MorphismMatrix( alpha ) * MorphismMatrix( beta );
        
        return QuiverRowsMorphism( A, mat, C );
        
    end );
    
    #
    AddMultiplyWithElementOfCommutativeRingForMorphisms( category,
      function( r, morphism )
        
        return QuiverRowsMorphism( Source( morphism ), r * MorphismMatrix( morphism ), Range( morphism ) );
        
    end );
    
    ## Basic Operations for an Additive Category
    ##
    AddIsZeroForMorphisms( category,
      function( alpha )
        local matrix, r, c;
        
        matrix := MorphismMatrix( alpha );
        
        if IsEmpty( matrix ) then
            
            return true;
            
        fi;
        
        for r in matrix do
            
            for c in r do
                
                if not IsZero( c ) then
                    
                    return false;
                    
                fi;
                
            od;
            
        od;
        
        return true;
        
    end );
    
    ##
    AddAdditionForMorphisms( category,
      function( alpha, beta )
        
        return QuiverRowsMorphism( Source( alpha ),
                                   MorphismMatrix( alpha ) + MorphismMatrix( beta ),
                                   Range( beta ) );
        
    end );
    
    ##
    AddAdditiveInverseForMorphisms( category,
      function( alpha )
        
        return QuiverRowsMorphism( Source( alpha ),
                                   -MorphismMatrix( alpha ),
                                   Range( alpha ) );
        
    end );
    
    ##
    AddZeroObject( category,
      function( )
        
        return QuiverRowsObject( [ ], category );
        
    end );
    
    ##
    AddUniversalMorphismIntoZeroObjectWithGivenZeroObject( category,
      function( sink, zero_object )
        
        return QuiverRowsMorphism( sink, [ ], zero_object );
        
    end );
    
    ##
    AddUniversalMorphismFromZeroObjectWithGivenZeroObject( category,
      function( source, zero_object )
        
        return QuiverRowsMorphism( zero_object, [ ], source );
        
    end );
    
    ##
    AddDirectSum( category,
      function( list )
        
        return QuiverRowsObject( Concatenation( List( list, ListOfQuiverVertices ) ), category );
        
    end );
    
    ##
    AddProjectionInFactorOfDirectSumWithGivenDirectSum( category,
      function( list, projection_number, direct_sum_object )
        local range, nr_cols, pre_matrix, id_matrix, post_matrix;
        
        range := list[projection_number];
        
        nr_cols := NrSummands( range );
        
        if NrSummands( direct_sum_object ) = 0 or nr_cols = 0 then
            
            return QuiverRowsMorphism( direct_sum_object, [], range );
            
        fi;
        
        pre_matrix := 
            ZERO_MATRIX_QUIVER_ROWS( 
                Sum( list{ [ 1 .. projection_number - 1 ] }, i -> NrSummands( i ) ),
                nr_cols
            );
        
        id_matrix := IDENTITY_MATRIX_QUIVER_ROWS( range );
        
        post_matrix := 
            ZERO_MATRIX_QUIVER_ROWS( 
                Sum( list{ [projection_number + 1 .. Size( list ) ] }, i -> NrSummands( i ) ),
                nr_cols
            );
        
        return QuiverRowsMorphism( direct_sum_object,
                                   Concatenation( pre_matrix, id_matrix, post_matrix ),
                                   range );
        
    end );
    
    ##
    AddInjectionOfCofactorOfDirectSumWithGivenDirectSum( category,
      function( list, injection_number, direct_sum_object )
        local source, nr_cols, pre_matrix, id_matrix, post_matrix;
        
        source := list[injection_number];
        
        nr_cols := NrSummands( source );
        
        if NrSummands( direct_sum_object ) = 0 or nr_cols = 0 then
            
            return QuiverRowsMorphism( source, [], direct_sum_object );
            
        fi;
        
        pre_matrix := 
            ZERO_MATRIX_QUIVER_ROWS( 
                Sum( list{ [ 1 .. injection_number - 1 ] }, i -> NrSummands( i ) ),
                nr_cols
            );
        
        id_matrix := IDENTITY_MATRIX_QUIVER_ROWS( source );
        
        post_matrix := 
            ZERO_MATRIX_QUIVER_ROWS( 
                Sum( list{ [injection_number + 1 .. Size( list ) ] }, i -> NrSummands( i ) ),
                nr_cols
            );
        
        return QuiverRowsMorphism( source,
                                   Transpose( Concatenation( pre_matrix, id_matrix, post_matrix ) ),
                                   direct_sum_object );
        
    end );
    
    # ##
    AddUniversalMorphismIntoDirectSumWithGivenDirectSum( category,
      function( diagram, source, direct_sum )
        local test_object, mat, nr_rows;
        
        test_object := Source( source[1] );
        
        nr_rows := NrSummands( test_object );
        
        if NrSummands( direct_sum ) = 0 or nr_rows = 0 then
            
            return QuiverRowsMorphism( test_object, [], direct_sum );
            
        fi;
        
        mat := List( [ 1 .. nr_rows ], i -> Concatenation( List( source, tau -> tau[i] ) ) );
        
        return QuiverRowsMorphism( test_object, mat, direct_sum );
        
    end );
    
    ##
    AddUniversalMorphismFromDirectSumWithGivenDirectSum( category,
      function( diagram, sink, direct_sum )
        local test_object, mat;
        
        test_object := Range( sink[1] );
        
        if NrSummands( direct_sum ) = 0 or NrSummands( test_object ) = 0 then
            
            return QuiverRowsMorphism( direct_sum, [], test_object );
            
        fi;
        
        mat := Concatenation( List( sink, MorphismMatrix ) );
        
        return QuiverRowsMorphism( direct_sum, mat, test_object );
        
    end );
    
    AddHomomorphismStructureOnObjects( category,
      function( A, B )
        local listA, listB, rank, a, b;
        
        listA := ListOfQuiverVertices( A );
        
        listB := ListOfQuiverVertices( B );
        
        rank := 0;
        
        for a in listA do
            
            for b in listB do
                
                rank := rank + Size( basis_paths_by_vertex_index[ VertexIndex( a[1] ) ][ VertexIndex( b[1] ) ] ) * a[2] * b[2] ;
                
            od;
            
        od;
        
        return object_constructor( rank );
        
    end );
    
    ## expects only non-zero cases
    hom_structure_on_morphisms_for_pure_components := function( alpha, beta, listi, listj, listk, listl )
        local j, k, i, l, a, b, c, d, alpha_ij, beta_kl, row, entry, row_counts, col_counts,
              basis_vp_v, basis_w_wp, basis_v_w, m, basis_vp_wp, n, mat, vp, v, w, wp, coeffs_alpha, coeffs_beta, p, q;
        
        a := listj[2];
        
        b := listk[2];
        
        c := listi[2];
        
        d := listl[2];
        
        vp := listi[1];
        
        v := listj[1];
        
        w := listk[1];
        
        wp := listl[1];
        
        basis_vp_v := basis_paths_by_vertex_index[ VertexIndex(vp) ][ VertexIndex( v )];
        
        basis_w_wp := basis_paths_by_vertex_index[ VertexIndex(w) ][ VertexIndex( wp )];
        
        basis_v_w := basis_paths_by_vertex_index[ VertexIndex(v) ][ VertexIndex( w )];
        
        m := Size( basis_v_w );
        
        basis_vp_wp := basis_paths_by_vertex_index[ VertexIndex(vp) ][ VertexIndex( wp )];
        
        n := Size( basis_vp_wp );
        
        mat := [];
        
        for j in [ 1 .. a ] do
            
            for k in [ 1 .. b ] do
                
                row := [];
                
                for i in [ 1 .. c ] do
                    
                    for l in [ 1 .. d ] do
                        
                        ## create dummy zero mat
                        entry := NullMat( m, n );
                        
                        alpha_ij := alpha[i][j];
                        
                        if not IsZero( alpha_ij ) then
                            
                            beta_kl := beta[k][l];
                            
                            if not IsZero( beta_kl ) then
                                
                                coeffs_alpha := CoefficientsOfPaths( basis_vp_v, alpha_ij );
                                
                                coeffs_beta := CoefficientsOfPaths( basis_w_wp, beta_kl );
                                
                                for p in [ 1 .. Size( basis_vp_v ) ] do
                                    
                                    for q in [ 1 .. Size( basis_w_wp ) ] do
                                        
                                        entry := entry + 
                                            coeffs_alpha[p] * coeffs_beta[q] *
                                            hom_structure_algebroid[ VertexIndex(v) ][ VertexIndex(w) ][ VertexIndex(vp) ][ VertexIndex(wp) ][ p ][ q ];
                                        
                                    od;
                                    
                                od;
                                
                            fi;
                            
                        fi;
                        
                        Add( row, entry );
                        
                    od;
                    
                od;
                
                Add( mat, row );
                
            od;
            
        od;
        
        row_counts := List( mat, r -> Size( r[1] ) );
        
        col_counts := List( mat[1], m -> Size( m[1] ) );
        
        return CAP_INTERNAL_MORPHISM_BETWEEN_DIRECT_SUMS_LIST_LIST( row_counts, mat, col_counts );
        
    end;
    
    ##
    AddHomomorphismStructureOnMorphismsWithGivenObjects( category,
      function( hom_source, alpha, beta, hom_range )
        local listj, listk, listi, listl, listjk, listil, mat, j, k, row, i, l, row_counts, col_counts, alpham, betam, entry;
        
        listi := ListOfQuiverVertices( Source( alpha ) );
        
        listj := ListOfQuiverVertices( Range( alpha ) );
        
        listk := ListOfQuiverVertices( Source( beta ) );
        
        listl := ListOfQuiverVertices( Range( beta ) );
        
        ##
        row_counts := [];
        
        for j in [ 1 .. Size( listj ) ] do
            
            for k in [ 1 .. Size( listk ) ] do
                
                Add( row_counts, listj[j][2] * listk[k][2] * Size( basis_paths_by_vertex_index[ VertexIndex( listj[j][1] ) ][ VertexIndex( listk[k][1] ) ] ) );
                
            od;
            
        od;
        
        col_counts := [];
        
        for i in [ 1 .. Size( listi ) ] do
            
            for l in [ 1 .. Size( listl ) ] do
                
                Add( col_counts, listi[i][2] * listl[l][2] * Size( basis_paths_by_vertex_index[ VertexIndex( listi[i][1] ) ][ VertexIndex( listl[l][1] ) ] ) );
                
            od;
            
        od;
        
        ##
        alpham := AsListListOfMatrices( alpha );
        
        betam := AsListListOfMatrices( beta );
        
        mat := [];
        
        for j in [ 1 .. Size( listj ) ] do
            
            for k in [ 1 .. Size( listk ) ] do
                
                row := [];
                
                if row_counts[(j-1)*Size( listk ) + k] > 0 then
                    
                    for i in [ 1 .. Size( listi ) ] do
                        
                        for l in [ 1 .. Size( listl ) ] do
                            
                            entry := [];
                            
                            if col_counts[(i-1)*Size( listl ) + l] > 0 then
                                
                                entry := hom_structure_on_morphisms_for_pure_components(
                                    alpham[i][j], betam[k][l], listi[i], listj[j], listk[k], listl[l]
                                );
                                
                            fi;
                            
                            Add( row, entry );
                            
                        od;
                        
                    od;
                    
                fi;
                
                Add( mat, row );
                
            od;
            
        od;
        
        mat := CAP_INTERNAL_MORPHISM_BETWEEN_DIRECT_SUMS_LIST_LIST(
            row_counts, mat, col_counts
        );
        
        return morphism_constructor( hom_source, mat, hom_range );
        
    end );
    
    ##
    AddDistinguishedObjectOfHomomorphismStructure( category,
      function( )
        
        return distinguished_object;
        
    end );
    
    ##
    AddInterpretMorphismAsMorphismFromDinstinguishedObjectToHomomorphismStructure( category,
      function( alpha )
        local listlist, lists, listr, row, i, j, submat, basis, c, a;
        
        listlist := AsListListOfMatrices( alpha );
        
        lists := ListOfQuiverVertices( Source( alpha ) );
        
        listr := ListOfQuiverVertices( Range( alpha ) );
        
        row := [];
        
        for i in [ 1 .. Size( lists ) ] do
            
            for j in [ 1 .. Size( listr ) ] do
                
                submat := listlist[i][j];
                
                basis := basis_paths_by_vertex_index[ VertexIndex( lists[i][1] ) ][ VertexIndex( listr[j][1] ) ];
                
                for c in [ 1 .. lists[i][2] ] do
                    
                    for a in [ 1 .. listr[j][2] ] do
                        
                        Append( row, CoefficientsOfPaths( basis, representative_func( submat[c][a] ) ) );
                        
                    od;
                    
                od;
                
            od;
            
        od;
        
        return morphism_constructor( distinguished_object, row, object_constructor( Size( row ) ) );
        
    end );
    
    ##
    AddInterpretMorphismFromDinstinguishedObjectToHomomorphismStructureAsMorphism( category,
      function( A, B, morphism )
        local coeffs, lists, listr, mat, pos, i, row, j, submat, basis, c, submatrow, a,
              entry, row_counts, col_counts;
        
        ## this works for range categories with attribute UnderlyingMatrix
        coeffs := EntriesOfHomalgMatrix( UnderlyingMatrix( morphism ) );
        
        lists := ListOfQuiverVertices( A );
        
        listr := ListOfQuiverVertices( B );
        
        mat := [];
        
        pos := 1;
        
        for i in [ 1 .. Size( lists ) ] do
            
            row := [];
            
            for j in [ 1 .. Size( listr ) ] do
                
                submat := [];
                
                basis := basis_paths_by_vertex_index[ VertexIndex( lists[i][1] ) ][ VertexIndex( listr[j][1] ) ];
                
                for c in [ 1 .. lists[i][2] ] do
                    
                    submatrow := [];
                    
                    for a in [ 1 .. listr[j][2] ] do
                        
                        entry := coeffs{ [ pos .. pos + ( Size( basis ) - 1 ) ] };
                        
                        entry := QuiverAlgebraElement( algebra, entry, basis );
                        
                        Add( submatrow, entry );
                        
                        pos := pos + Size( basis );
                        
                    od;
                    
                    Add( submat, submatrow );
                    
                od;
                
                Add( row, submat );
                
            od;
            
            Add( mat, row );
            
        od;
        
        row_counts := List( lists, i -> i[2] );
        
        col_counts := List( listr, i -> i[2] );
        
        mat := CAP_INTERNAL_MORPHISM_BETWEEN_DIRECT_SUMS_LIST_LIST(
            row_counts, mat, col_counts
        );
        
        return QuiverRowsMorphism( A, mat, B );
        
    end );
    
end );


####################################
##
## Helper
##
####################################

InstallGlobalFunction( CAP_INTERNAL_MORPHISM_BETWEEN_DIRECT_SUMS_LIST_LIST,
  function( row_counts, matrix, col_counts )
    local nr_rows, nr_cols, row_count_indices, col_count_indices, result_mat, r;
    
    nr_rows := Size( row_counts );
    
    nr_cols := Size( col_counts );
    
    row_count_indices := Filtered( [ 1 .. nr_rows ], i -> row_counts[i] > 0 );
    
    if IsEmpty( row_count_indices ) then
        
        return [];
        
    fi;
    
    col_count_indices := Filtered( [ 1 .. nr_cols ], i -> col_counts[i] > 0 );
    
    if IsEmpty( col_count_indices ) then
        
        return [];
        
    fi;
    
    matrix := matrix{row_count_indices};
    
    matrix := List( matrix, r -> r{col_count_indices} );
    
    nr_rows := Size( row_count_indices );
    
    nr_cols := Size( col_count_indices );
    
    result_mat := [];
    
    for r in [ 1 .. nr_rows ] do
        
        Append( result_mat,
                List( [ 1 .. row_counts[row_count_indices[r]] ],
                i -> Concatenation( List( matrix[r], mat -> mat[i] ) ) )
        );
        
    od;
    
    return result_mat;
    
end );

####################################
##
## View
##
####################################

##
InstallMethod( Display,
               [ IsQuiverRowsObject ],
               
  function( object )
    
    Display( ListOfQuiverVertices( object ) );
    
end );

##
InstallMethod( Display,
               [ IsQuiverRowsMorphism ],
               
  function( morphism )
    
    Print( "Source: ");
    Display( Source( morphism ) );
    Print( "  |\n");
    Print( "  |\n");
    Print( "Matrix: ");
    Display( MorphismMatrix( morphism ) );
    Print( "  |\n");
    Print( "  v\n");
    Print( "Range : ");
    Display( Range( morphism ) );
    
end );