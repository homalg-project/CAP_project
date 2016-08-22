############################################################################
##
##                                ActionsForCAP package
##
##  Copyright 2016, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @Chapter Semisimple Categories
##
#############################################################################

####################################
##
## Basic operations
##
####################################

InstallGlobalFunction( CAP_INTERNAL_INSTALL_OPERATIONS_FOR_SEMISIMPLE_CATEGORY,
  function( category )
    local field, membership_function;
    
    field := UnderlyingCategoryForSemisimpleCategory( category )!.field_for_matrix_category;
    
    membership_function := MembershipFunctionForSemisimpleCategory( category );
    
    ##
    AddIsEqualForCacheForObjects( category,
      IsIdenticalObj );
    
    ##
    AddIsEqualForCacheForMorphisms( category,
      IsIdenticalObj );
    
    ## Equality Basic Operations for Objects and Morphisms
    ##
    AddIsEqualForObjects( category,
      function( object_1, object_2 )
        local object_1_list, object_2_list, size;
        
        object_1_list := SemisimpleCategoryObjectList( object_1 );
        
        object_2_list := SemisimpleCategoryObjectList( object_2 );
        
        size := Size( object_1_list );
        
        if not size = Size( object_2_list ) then
            
            return false;
            
        fi;
        
        return ForAll( [ 1 .. size ], i ->
                 ( object_1_list[i][1] = object_2_list[i][1] ) and ( object_1_list[i][2] = object_2_list[i][2] )
               );
      
    end );
    
    ##
    AddIsCongruentForMorphisms( category,
      function( morphism_1, morphism_2 )
        local morphism_1_list, morphism_2_list, size;
        
        morphism_1_list := SemisimpleCategoryMorphismList( morphism_1 );
        
        morphism_2_list := SemisimpleCategoryMorphismList( morphism_2 );
        
        size := Size( morphism_1_list );
        
        return ForAll( [ 1 .. size ], i -> IsCongruentForMorphisms( morphism_1_list[i][1], morphism_2_list[i][1] ) );
        
    end );
    
    ##
    AddIsWellDefinedForObjects( category,
      function( object )
        local object_list, last_irr, elem;
        
        object_list := SemisimpleCategoryObjectList( object );
        
        ## representing the zero object
        if IsEmpty( object_list ) then
            
            return true;
            
        fi;
        
        if not ForAll( object_list, elem ->
          IsList( elem ) and Size( elem ) = 2 and IsInt( elem[1] ) and elem[1] > 0 and membership_function( elem[2] ) ) then
            
            Error( "the semisimple category object list does not have the correct form" );
            
            return false;
            
        fi;
        
        last_irr := object_list[1][2];
        
        ## is it sorted without duplications?
        for elem in [ 2 .. Size( object_list ) ] do
            
            if not object_list[elem][2] > last_irr then
                
                Error( "the semisimple category object is not sorted without duplications" );
                
                return false;
                
            fi;
            
            last_irr := object_list[elem][2];
            
        od;
        
        return true;
        
    end );
    
    ##
    AddIsWellDefinedForMorphisms( category,
      function( morphism )
        local source, range, source_list, range_list, union, irr, morphism_list,
              irr_nr, dim_source, dim_range;
        
        source := Source( morphism );
        
        range := Range( morphism );
        
        source_list := SemisimpleCategoryObjectList( source );
        
        range_list := SemisimpleCategoryObjectList( range );
        
        union := Set( Concatenation( Support( source ), Support( range ) ) );
        
        morphism_list := SemisimpleCategoryMorphismList( morphism );
        
        if not ForAll( morphism_list, elem ->
          IsList( elem ) and Size( elem ) = 2 and IsVectorSpaceMorphism( elem[1] ) #and IsWellDefined( elem[1] ) 
          and membership_function( elem[2] ) ) then
            
            Error( "the semisimple category morphism list does not have the correct form" );
            
            return false;
            
        fi;
        
        for irr_nr in [ 1 .. Size( union ) ] do
            
            if not morphism_list[irr_nr][2] = union[irr_nr] then
                
                Error( "the support of the objects does not match the support of the morphism" );
                
                return false;
                
            fi;
            
            dim_source := First( source_list, elem -> elem[2] = union[irr_nr] );
            
            if not dim_source = fail then
                
                dim_source := dim_source[1];
                
            else
                
                dim_source := 0;
                
            fi;
            
            dim_range := First( range_list, elem -> elem[2] = union[irr_nr] );
            
            if not dim_range = fail then
                
                dim_range := dim_range[1];
                
            else
                
                dim_range := 0;
                
            fi;
            
            if not Dimension( Source( morphism_list[irr_nr][1] ) ) = dim_source then
                
                Error( "the source multiplicity does not match the matrices" );
                
                return false;
                
            fi;
            
            if not Dimension( Range( morphism_list[irr_nr][1] ) ) = dim_range then
                
                Error( "the range multiplicity does not match the matrices" );
                
                return false;
                
            fi;
            
        od;
        
        return true;
        
    end );
    
    ## Basic Operations for a Category
    ##
    AddIdentityMorphism( category,
      
      function( object )
        local object_list, morphism_list;
        
        object_list := SemisimpleCategoryObjectList( object );
        
        morphism_list := 
          List( object_list, elem -> [ IdentityMorphism( VectorSpaceObject( elem[1], field ) ), elem[2] ] );
        
        return SemisimpleCategoryMorphism( object, morphism_list, object );
        
    end );
    
    ##
    AddPreCompose( category,
      
      [ 
        [ function( morphism_1, morphism_2 )
            local mor_1_list, mor_2_list, union, composition_list, irr, mor_1, mor_2;
            
            mor_1_list := SemisimpleCategoryMorphismList( morphism_1 );
            
            mor_2_list := SemisimpleCategoryMorphismList( morphism_2 );
            
            union := Set( Concatenation( Support( morphism_1 ), Support( morphism_2 ) ) );
            
            composition_list := [ ];
            
            for irr in union do
                
                mor_1 := First( mor_1_list, elem -> elem[2] = irr );
                
                mor_2 := First( mor_2_list, elem -> elem[2] = irr );
                
                if mor_1 = fail then
                    
                    Add( composition_list,
                         [ UniversalMorphismFromZeroObject( Range( mor_2[1] ) ), irr ] );
                    
                elif mor_2 = fail then
                    
                    Add( composition_list,
                         [ UniversalMorphismIntoZeroObject( Source( mor_1[1] ) ), irr ] );
                    
                else
                    
                    Add( composition_list,
                         [ PreCompose( mor_1[1], mor_2[1] ), irr ] );
                    
                fi;
                
            od;
            
            return SemisimpleCategoryMorphism( Source( morphism_1 ), composition_list, Range( morphism_2 ) );
            
          end, [ , ] ],
        
        [ function( left_morphism, identity_morphism )
            
            return left_morphism;
            
          end, [ , IsIdenticalToIdentityMorphism ] ],
        
        [ function( identity_morphism, right_morphism )
            
            return right_morphism;
            
          end, [ IsIdenticalToIdentityMorphism, ] ],
        
      ]
    
    );
    
    ## Basic Operations for an Additive Category
    ##
    AddIsZeroForMorphisms( category,
      function( morphism )
        local morphism_list;
        
        morphism_list := SemisimpleCategoryMorphismList( morphism );
        
        return ForAll( morphism_list, elem -> IsZeroForMorphisms( elem[1] ) );
        
    end );
    
    ##
    AddAdditionForMorphisms( category,
      function( morphism_1, morphism_2 )
        local source, range, morphism_1_list, morphism_2_list, result_morphism_list, size;
        
        source := Source( morphism_1 );
        
        range := Range( morphism_1 );
        
        morphism_1_list := SemisimpleCategoryMorphismList( morphism_1 );
        
        morphism_2_list := SemisimpleCategoryMorphismList( morphism_2 );
        
        size := Size( morphism_1_list );
        
        result_morphism_list := List( [ 1 .. size ], i -> [ morphism_1_list[i][1] + morphism_2_list[i][1], morphism_1_list[i][2] ] );
        
        return SemisimpleCategoryMorphism( source, result_morphism_list, range );
        
    end );
    
    ##
    AddAdditiveInverseForMorphisms( category,
      function( morphism )
        local source, range, morphism_list, result_morphism_list;
        
        source := Source( morphism );
        
        range := Range( morphism );
        
        morphism_list := SemisimpleCategoryMorphismList( morphism );
        
        result_morphism_list := List( morphism_list, elem -> [ AdditiveInverseForMorphisms( elem[1] ), elem[2] ] );
        
        return SemisimpleCategoryMorphism( source, result_morphism_list, range );
        
    end );
    
    ##
    AddZeroMorphism( category,
      function( source, range )
        local union, morphism_list, source_list, range_list, irr, dim_source, dim_range;
        
        union := Set( Concatenation( Support( source ), Support( range ) ) );
        
        morphism_list := [ ];
        
        source_list := SemisimpleCategoryObjectList( source );
        
        range_list := SemisimpleCategoryObjectList( range );
        
        for irr in union do
            
            dim_source := First( source_list, elem -> elem[2] = irr );
            
            if not dim_source = fail then
                
                dim_source := dim_source[1];
                
            else
                
                dim_source := 0;
                
            fi;
            
            dim_range := First( range_list, elem -> elem[2] = irr );
            
            if not dim_range = fail then
                
                dim_range := dim_range[1];
                
            else
                
                dim_range := 0;
                
            fi;
            
            Add( morphism_list, [ ZeroMorphism( VectorSpaceObject( dim_source, field ), VectorSpaceObject( dim_range, field ) ), irr ] );
            
        od;
        
        return SemisimpleCategoryMorphism( source, morphism_list, range );
        
    end );
    
    ##
    AddZeroObject( category,
      function( )
        
        return SemisimpleCategoryObject( [ ], category );
        
    end );
    
    ##
    AddUniversalMorphismIntoZeroObjectWithGivenZeroObject( category,
      function( sink, zero_object )
        local sink_object_list, result_morphism_list;
        
        sink_object_list := SemisimpleCategoryObjectList( sink );
        
        result_morphism_list := List( sink_object_list, elem ->
          [ UniversalMorphismIntoZeroObject( VectorSpaceObject( elem[1], field ) ), elem[2] ] );
        
        return SemisimpleCategoryMorphism( sink, result_morphism_list, zero_object )  ;
        
    end );
    
    ##
    AddUniversalMorphismFromZeroObjectWithGivenZeroObject( category,
      function( source, zero_object )
        local source_object_list, result_morphism_list;
        
        source_object_list := SemisimpleCategoryObjectList( source );
        
        result_morphism_list := List( source_object_list, elem ->
          [ UniversalMorphismFromZeroObject( VectorSpaceObject( elem[1], field ) ), elem[2] ] );
        
        return SemisimpleCategoryMorphism( zero_object, result_morphism_list, source )  ;
        
    end );
    
    ##
    AddDirectSum( category,
      function( semisimple_objects_list )
      local object_list;
      
      object_list := List( semisimple_objects_list, SemisimpleCategoryObjectList );
      
      if Size( object_list ) > 1 then
          
          object_list := CallFuncList( Concatenation, object_list );
          
      else
          
          object_list := object_list[1];
          
      fi;
      
      return SemisimpleCategoryObject( object_list, category );
      
    end );
    
    ##
    AddProjectionInFactorOfDirectSumWithGivenDirectSum( category,
      function( semisimple_objects_list, projection_number, direct_sum_object )
        local support, morphism_list, irr, objects_list, elem;
        
        support := Support( direct_sum_object );
        
        morphism_list := [ ];
        
        for irr in support do
            
            objects_list := [ ];
            
            for elem in semisimple_objects_list do
                
                Add( objects_list, VectorSpaceObject( Multiplicity( elem, irr ), field ) );
                
            od;
            
            Add( morphism_list, [ ProjectionInFactorOfDirectSum( objects_list, projection_number ), irr ] );
            
        od;
        
        return SemisimpleCategoryMorphism( direct_sum_object, morphism_list, semisimple_objects_list[ projection_number ] );
        
    end );
#     
#     ##
#     AddUniversalMorphismIntoDirectSumWithGivenDirectSum( category,
#       function( diagram, sink, direct_sum )
#         local underlying_matrix_of_universal_morphism, morphism;
#         
#         underlying_matrix_of_universal_morphism := UnderlyingMatrix( sink[1] );
#         
#         for morphism in sink{ [ 2 .. Length( sink ) ] } do
#           
#           underlying_matrix_of_universal_morphism := 
#             UnionOfColumns( underlying_matrix_of_universal_morphism, UnderlyingMatrix( morphism ) );
#           
#         od;
#         
#         return VectorSpaceMorphism( Source( sink[1] ), underlying_matrix_of_universal_morphism, direct_sum );
#       
#     end );
#     
    ##
    AddInjectionOfCofactorOfDirectSumWithGivenDirectSum( category,
      function( semisimple_objects_list, injection_number, direct_sum_object )
        local support, morphism_list, irr, objects_list, elem;
        
        support := Support( direct_sum_object );
        
        morphism_list := [ ];
        
        for irr in support do
            
            objects_list := [ ];
            
            for elem in semisimple_objects_list do
                
                Add( objects_list, VectorSpaceObject( Multiplicity( elem, irr ), field ) );
                
            od;
            
            Add( morphism_list, [ InjectionOfCofactorOfDirectSum( objects_list, injection_number ), irr ] );
            
        od;
        
        return SemisimpleCategoryMorphism( semisimple_objects_list[ injection_number ], morphism_list, direct_sum_object );
        
    end );
#     
#     ##
#     AddUniversalMorphismFromDirectSumWithGivenDirectSum( category,
#       function( diagram, sink, coproduct )
#         local underlying_matrix_of_universal_morphism, morphism;
#         
#         underlying_matrix_of_universal_morphism := UnderlyingMatrix( sink[1] );
#         
#         for morphism in sink{ [ 2 .. Length( sink ) ] } do
#           
#           underlying_matrix_of_universal_morphism := 
#             UnionOfRows( underlying_matrix_of_universal_morphism, UnderlyingMatrix( morphism ) );
#           
#         od;
#         
#         return VectorSpaceMorphism( coproduct, underlying_matrix_of_universal_morphism, Range( sink[1] ) );
#         
#     end );
#     
#     ## Basic Operations for an Abelian category
#     ##
#     AddKernelObject( category,
#       function( morphism )
#         local homalg_matrix;
#         
#         homalg_matrix := UnderlyingMatrix( morphism );
#         
#         return VectorSpaceObject( NrRows( homalg_matrix ) - RowRankOfMatrix( homalg_matrix ), homalg_field );
#         
#     end );
#     
#     ##
#     AddKernelEmbedding( category,
#       function( morphism )
#         local kernel_emb, kernel_object;
#         
#         kernel_emb := SyzygiesOfRows( UnderlyingMatrix( morphism ) );
#         
#         kernel_object := VectorSpaceObject( NrRows( kernel_emb ), homalg_field );
#         
#         return VectorSpaceMorphism( kernel_object, kernel_emb, Source( morphism ) );
#         
#     end );
#     
#     ##
#     AddKernelEmbeddingWithGivenKernelObject( category,
#       function( morphism, kernel )
#         local kernel_emb;
#         
#         kernel_emb := SyzygiesOfRows( UnderlyingMatrix( morphism ) );
#         
#         return VectorSpaceMorphism( kernel, kernel_emb, Source( morphism ) );
#         
#     end );
#     
#     ##
#     AddLiftAlongMonomorphism( category,
#       function( monomorphism, test_morphism )
#         local right_divide;
#         
#         right_divide := RightDivide( UnderlyingMatrix( test_morphism ), UnderlyingMatrix( monomorphism ) );
#         
#         if right_divide = fail then
#           
#           return fail;
#           
#         fi;
#         
#         return VectorSpaceMorphism( Source( test_morphism ),
#                                     right_divide,
#                                     Source( monomorphism ) );
#         
#     end );
#     
#     ##
#     AddCokernelObject( category,
#       function( morphism )
#         local homalg_matrix;
#         
#         homalg_matrix := UnderlyingMatrix( morphism );
#         
#         return VectorSpaceObject( NrColumns( homalg_matrix ) - RowRankOfMatrix( homalg_matrix ), homalg_field );
#         
#     end );
#     
#     ##
#     AddCokernelProjection( category,
#       function( morphism )
#         local cokernel_proj, cokernel_obj;
#         
#         cokernel_proj := SyzygiesOfColumns( UnderlyingMatrix( morphism ) );
#         
#         cokernel_obj := VectorSpaceObject( NrColumns( cokernel_proj ), homalg_field );
#         
#         return VectorSpaceMorphism( Range( morphism ), cokernel_proj, cokernel_obj );
#         
#     end );
#     
#     ##
#     AddCokernelProjectionWithGivenCokernelObject( category,
#       function( morphism, cokernel )
#         local cokernel_proj;
#         
#         cokernel_proj := SyzygiesOfColumns( UnderlyingMatrix( morphism ) );
#         
#         return VectorSpaceMorphism( Range( morphism ), cokernel_proj, cokernel );
#         
#     end );
#     
#     ##
#     AddColiftAlongEpimorphism( category,
#       function( epimorphism, test_morphism )
#         local left_divide;
#         
#         left_divide := LeftDivide( UnderlyingMatrix( epimorphism ), UnderlyingMatrix( test_morphism ) );
#         
#         if left_divide = fail then
#           
#           return fail;
#           
#         fi;
#         
#         return VectorSpaceMorphism( Range( epimorphism ),
#                                     left_divide,
#                                     Range( test_morphism ) );
#         
#     end );
#     
#     ## Basic Operation Properties
#     ##
#     AddIsZeroForObjects( category,
#       function( object )
#       
#         return Dimension( object ) = 0;
#       
#       end );
#     
#     ##
#     AddIsMonomorphism( category,
#       function( morphism )
#       
#         return RowRankOfMatrix( UnderlyingMatrix( morphism ) ) = Dimension( Source( morphism ) );
#       
#     end );
#     
#     ##
#     AddIsEpimorphism( category,
#       function( morphism )
#         
#         return ColumnRankOfMatrix( UnderlyingMatrix( morphism ) ) = Dimension( Range( morphism ) );
#         
#     end );
#     
#     ##
#     AddIsIsomorphism( category,
#       function( morphism )
#         
#         return Dimension( Range( morphism ) ) = Dimension( Source( morphism ) )
#                and ColumnRankOfMatrix( UnderlyingMatrix( morphism ) ) = Dimension( Range( morphism ) );
#         
#     end );
#     
#     ## Basic Operations for Monoidal Categories
#     ##
#     AddTensorProductOnObjects( category,
#       [ 
#         [ function( object_1, object_2 )
#             
#             return VectorSpaceObject( Dimension( object_1 ) * Dimension( object_2 ), homalg_field );
#             
#           end,
#           
#           [ ] ],
#         
#         [ function( object_1, object_2 )
#             
#             return object_1;
#             
#           end,
#           
#           [ IsZero, ] ],
#          
#         [ function( object_1, object_2 )
#             
#             return object_2;
#             
#           end,
#           
#           [ , IsZero ] ]
#       ]
#     
#     );
#     
#     ##
#     AddTensorProductOnMorphismsWithGivenTensorProducts( category,
#       
#       function( new_source, morphism_1, morphism_2, new_range )
#         
#         return VectorSpaceMorphism( new_source,
#                                     KroneckerMat( UnderlyingMatrix( morphism_1 ), UnderlyingMatrix( morphism_2 ) ),
#                                     new_range );
#         
#     end );
#     
#     ##
#     AddTensorUnit( category,
#       
#       function( )
#         
#         return VectorSpaceObject( 1, homalg_field );
#         
#     end );
#     
#     ##
#     AddBraidingWithGivenTensorProducts( category,
#       function( object_1_tensored_object_2, object_1, object_2, object_2_tensored_object_1 )
#         local permutation_matrix, dim, dim_1, dim_2;
#         
#         dim_1 := Dimension( object_1 );
#         
#         dim_2 := Dimension( object_2 );
#         
#         dim := Dimension( object_1_tensored_object_2 );
#         
#         permutation_matrix := PermutationMat( 
#                                 PermList( List( [ 1 .. dim ], i -> ( RemInt( i - 1, dim_2 ) * dim_1 + QuoInt( i - 1, dim_2 ) + 1 ) ) ),
#                                 dim 
#                               );
#         
#         return VectorSpaceMorphism( object_1_tensored_object_2,
#                                     HomalgMatrix( permutation_matrix, dim, dim, homalg_field ),
#                                     object_2_tensored_object_1
#                                   );
#         
#     end );
#     
#     ##
#     AddDualOnObjects( category, space -> space );
#     
#     ##
#     AddDualOnMorphismsWithGivenDuals( category,
#       function( dual_source, morphism, dual_range )
#         
#         return VectorSpaceMorphism( dual_source,
#                                     Involution( UnderlyingMatrix( morphism ) ),
#                                     dual_range );
#         
#     end );
#     
#     ##
#     AddEvaluationForDualWithGivenTensorProduct( category,
#       function( tensor_object, object, unit )
#         local dimension, column, zero_column, i;
#         
#         dimension := Dimension( object );
#         
#         column := [ ];
#         
#         zero_column := List( [ 1 .. dimension ], i -> 0 );
#         
#         for i in [ 1 .. dimension - 1 ] do
#           
#           Add( column, 1 );
#           
#           Append( column, zero_column );
#           
#         od;
#         
#         if dimension > 0 then 
#           
#           Add( column, 1 );
#           
#         fi;
#         
#         return VectorSpaceMorphism( tensor_object,
#                                     HomalgMatrix( column, Dimension( tensor_object ), 1, homalg_field ),
#                                     unit );
#         
#     end );
#     
#     ##
#     AddCoevaluationForDualWithGivenTensorProduct( category,
#       
#       function( unit, object, tensor_object )
#         local dimension, row, zero_row, i;
#         
#         dimension := Dimension( object );
#         
#         row := [ ];
#         
#         zero_row := List( [ 1 .. dimension ], i -> 0 );
#         
#         for i in [ 1 .. dimension - 1 ] do
#           
#           Add( row, 1 );
#           
#           Append( row, zero_row );
#           
#         od;
#         
#         if dimension > 0 then 
#           
#           Add( row, 1 );
#           
#         fi;
#         
#         return VectorSpaceMorphism( unit,
#                                     HomalgMatrix( row, 1, Dimension( tensor_object ), homalg_field ),
#                                     tensor_object );
#         
#     end );
#     
#     ##
#     AddMorphismToBidualWithGivenBidual( category,
#       function( object, bidual_of_object )
#         
#         return VectorSpaceMorphism( object,
#                                     HomalgIdentityMatrix( Dimension( object ), homalg_field ),
#                                     bidual_of_object
#                                   );
#         
#     end );
    
end );



####################################
##
## Constructors
##
####################################

##
InstallMethod( SemisimpleCategory,
               [ IsFieldForHomalg, IsFunction ],
               
  function( homalg_field, membership_function )
    local name;
    
    name := NameFunction( membership_function );
    
    return SemisimpleCategory( 
             homalg_field, membership_function, Concatenation( "membership function ", name ) );
    
end );

##
InstallMethod( SemisimpleCategory,
               [ IsFieldForHomalg, IsFunction, IsString ],
               
  function( homalg_field, membership_function, membership_function_name )
    local name, semisimple_category, underlying_category;
    
    underlying_category := MatrixCategory( homalg_field );
    
    name := Name( underlying_category );
    
    name := Concatenation( "The semisimple category with irreducibles given by ", membership_function_name, 
                           ", with underlying category: ", name );
    
    semisimple_category := CreateCapCategory( name );
    
    SetUnderlyingCategoryForSemisimpleCategory( semisimple_category, underlying_category );
    
    SetMembershipFunctionForSemisimpleCategory( semisimple_category, membership_function );
    
    CAP_INTERNAL_INSTALL_OPERATIONS_FOR_SEMISIMPLE_CATEGORY( semisimple_category );
    
    Finalize( semisimple_category );
    
    return semisimple_category;
    
end );

