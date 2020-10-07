CapJitAddLogicFunction( function( tree, jit_args )
  local pre_func, additional_arguments_func;
    
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, "Apply logic for HomalgMatrix." );
    
    pre_func := function( tree, func_stack )
      local args, list, func_id, ring_element, condition_func, right;
        
        # find HomalgMatrix( ... )
        if CapJitIsCallToGlobalFunction( tree, "HomalgMatrix" ) then
            
            args := tree.args;

            # check if ... = [ [ ... ], ... ]
            if args[1].type = "EXPR_LIST" then
                
                list := args[1].list;
                
                func_id := Last( func_stack).id;
                
                # check if all elements of the matrix are multiplied by the same ring element from the left
                if Length( list ) > 0 and ForAll( list, l -> l.type = "EXPR_PROD" and l.left = list[1].left ) then
                    
                    ring_element := list[1].left;
                    
                    # check if ring_element is independent of local variables
                    condition_func := function( tree, path )
                        
                        if PositionSublist( tree.type, "FVAR" ) <> fail and tree.func_id = func_id then
                            
                            return true;
                            
                        fi;
                        
                        return false;
                        
                    end;
                    
                    if CapJitFindNodeDeep( ring_element, condition_func ) = fail then
                        
                        tree := rec(
                            type := "EXPR_PROD",
                            left := ring_element,
                            right := StructuralCopy( tree ),
                        );
                        
                        tree.right.args[1].list := List( list, l -> l.right );

                        return tree;
                        
                    fi;
                    
                fi;
                
                # check if all elements of the matrix are multiplied by the same ring element from the right
                if Length( list ) > 0 and ForAll( list, l -> l.type = "EXPR_PROD" and l.right = list[1].right ) then
                    
                    ring_element := list[1].right;
                    
                    # check if ring_element is independent of local variables
                    condition_func := function( tree, path )
                        
                        if PositionSublist( tree.type, "FVAR" ) <> fail and tree.func_id = func_id then
                            
                            return true;
                            
                        fi;
                        
                        return false;
                        
                    end;
                    
                    if CapJitFindNodeDeep( ring_element, condition_func ) = fail then
                        
                        tree := rec(
                            type := "EXPR_PROD",
                            left := StructuralCopy( tree ),
                            right := ring_element,
                        );
                        
                        tree.left.args[1].list := List( list, l -> l.left );

                        return tree;
                        
                    fi;
                    
                fi;
                
            fi;

        fi;
            
        return tree;
        
    end;
    
    additional_arguments_func := function( tree, key, func_stack )
        
        if IsRecord( tree ) and tree.type = "EXPR_FUNC" then
            
            Assert( 0, IsBound( tree.id ) );
            
            return Concatenation( func_stack, [ tree ] );
            
        else
            
            return func_stack;
            
        fi;
        
    end;
    
    return CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, additional_arguments_func, [] );
    
end );

# if IsMatrixObj( ... ) then return ...; else return ...; fi;
CapJitAddLogicTemplate( rec(
    variable_names := [ "matrix", "if_value", "else_value" ],
    variable_filters := [ IsMatrixObj, IsObject, IsObject ],
    src_template := "if IsMatrixObj( matrix ) then return if_value; else return else_value; fi;",
    dst_template := "return if_value",
    returns_value := false,
) );


# List( Concatenation( List( L1, l1 -> List( L2, f ) ) ), g )
CapJitAddLogicTemplate( rec(
    variable_names := [ "list1", "list2", "outer_func", "inner_func" ],
    src_template := "List( Concatenation( List( list1, l1 -> List( list2, inner_func ) ) ), outer_func )",
    dst_template := "Concatenation( List( list1, l1 -> List( list2, x -> outer_func( inner_func( x ) ) ) ) )",
    new_funcs := [ [ "x" ] ],
    returns_value := true,
) );

# IsEmpty( List( [ 1 .. last ], func ) ) => last <= 0
CapJitAddLogicTemplate( rec(
    variable_names := [ "last", "func" ],
    src_template := "IsEmpty( List( [ 1 .. last ], func ) )",
    dst_template := "last <= 0",
    returns_value := true,
) );

# HACK: insert this at the beginning for performance reasons
# List( list, l -> List( [ 1 .. last ], func ) )[1] = [ ] => last <= 0
MakeReadWriteGlobal( "CAP_JIT_LOGIC_TEMPLATES" );
CAP_JIT_LOGIC_TEMPLATES := Concatenation( [
    rec(
        variable_names := [ "list", "last", "func" ],
        src_template := "IsEmpty( List( list, l -> List( [ 1 .. last ], func ) )[1] )",
        dst_template := "last <= 0",
        returns_value := true,
    )
], CAP_JIT_LOGIC_TEMPLATES );

# UnionOfRows( M * R )
CapJitAddLogicTemplate( rec(
    variable_names := [ "list", "matrix", "ring" ],
    variable_filters := [ IsObject, IsHomalgMatrix, IsHomalgRing ],
    src_template := "UnionOfRows( List( list, l -> matrix * ring ) )",
    dst_template := "UnionOfRows( List( list, l -> matrix ) ) * ring",
    returns_value := true,
    needed_packages := [ [ "MatricesForHomalg", ">= 2020.05.19" ] ],
) );

# UnionOfColumns( M * R )
CapJitAddLogicTemplate( rec(
    variable_names := [ "list", "matrix", "ring" ],
    variable_filters := [ IsObject, IsHomalgMatrix, IsHomalgRing ],
    src_template := "UnionOfColumns( List( list, l -> matrix * ring ) )",
    dst_template := "UnionOfColumns( List( list, l -> matrix ) ) * ring",
    returns_value := true,
    needed_packages := [ [ "MatricesForHomalg", ">= 2020.05.19" ] ],
) );

# UnionOfRows( CoefficientsWithGivenMonomials )
CapJitAddLogicTemplate( rec(
    variable_names := [ "list", "matrix", "monomials" ],
    variable_filters := [ IsObject, "IsHomalgMatrix", "IsHomalgMatrix" ],
    src_template := "UnionOfRows( List( list, l -> CoefficientsWithGivenMonomials( matrix, monomials ) ) )",
    dst_template := "CoefficientsWithGivenMonomials( UnionOfRows( List( list, l -> matrix ) ), monomials )",
    returns_value := true,
    needed_packages := [ [ "MatricesForHomalg", ">= 2020.05.19" ] ],
) );

# UnionOfColumns( CoefficientsWithGivenMonomials )
CapJitAddLogicTemplate( rec(
    variable_names := [ "list", "matrix", "monomials" ],
    variable_filters := [ IsObject, "IsHomalgMatrix", "IsHomalgMatrix" ],
    src_template := "UnionOfColumns( List( list, l -> CoefficientsWithGivenMonomials( matrix, monomials ) ) )",
    dst_template := "CoefficientsWithGivenMonomials( UnionOfColumns( List( list, l -> matrix ) ), DiagMat( List( list, x -> monomials ) ) )",
    new_funcs := [ [ "x" ] ],
    returns_value := true,
    needed_packages := [ [ "MatricesForHomalg", ">= 2020.05.19" ] ],
) );

# UnionOfRows( a * B )
CapJitAddLogicTemplate( rec(
    variable_names := [ "list", "ring_element", "matrix" ],
    variable_filters := [ IsObject, "IsHomalgRingElement", "IsHomalgMatrix" ],
    src_template := "UnionOfRows( List( list, l -> ring_element * matrix ) )",
    dst_template := "ring_element * UnionOfRows( List( list, l -> matrix ) )",
    returns_value := true,
    needed_packages := [ [ "MatricesForHomalg", ">= 2020.05.19" ] ],
) );

# UnionOfRows( A * b )
CapJitAddLogicTemplate( rec(
    variable_names := [ "list", "matrix", "ring_element" ],
    variable_filters := [ IsObject, "IsHomalgMatrix", "IsHomalgRingElement" ],
    src_template := "UnionOfRows( List( list, l -> matrix * ring_element ) )",
    dst_template := "UnionOfRows( List( list, l -> matrix ) ) * ring_element",
    returns_value := true,
    needed_packages := [ [ "MatricesForHomalg", ">= 2020.05.19" ] ],
) );

# UnionOfColumns( a * B )
CapJitAddLogicTemplate( rec(
    variable_names := [ "list", "ring_element", "matrix" ],
    variable_filters := [ IsObject, "IsHomalgRingElement", "IsHomalgMatrix" ],
    src_template := "UnionOfColumns( List( list, l -> ring_element * matrix ) )",
    dst_template := "ring_element * UnionOfColumns( List( list, l -> matrix ) )",
    returns_value := true,
    needed_packages := [ [ "MatricesForHomalg", ">= 2020.05.19" ] ],
) );

# UnionOfColumns( A * b )
CapJitAddLogicTemplate( rec(
    variable_names := [ "list", "matrix", "ring_element" ],
    variable_filters := [ IsObject, "IsHomalgMatrix", "IsHomalgRingElement" ],
    src_template := "UnionOfColumns( List( list, l -> matrix * ring_element ) )",
    dst_template := "UnionOfColumns( List( list, l -> matrix ) ) * ring_element",
    returns_value := true,
    needed_packages := [ [ "MatricesForHomalg", ">= 2020.05.19" ] ],
) );

# DualKroneckerMat( A, B )
CapJitAddLogicTemplate( rec(
    variable_names := [ "A", "B" ],
    variable_filters := [ "IsHomalgMatrix", "IsHomalgMatrix" ],
    src_template := """
        UnionOfRows( List( [ 1 .. NrRows( B ) ], i ->
            UnionOfColumns( List( [ 1 .. NrColumns( B ) ], j ->
                A * B[i,j]
            ) )
        ) )
    """,
    dst_template := "DualKroneckerMat( A, B )",
    returns_value := true,
    needed_packages := [ [ "MatricesForHomalg", ">= 2020.06.27" ] ],
) );

# KroneckerMat( TransposedMatrix( A ), B )
CapJitAddLogicTemplate( rec(
    variable_names := [ "A", "B" ],
    variable_filters := [ "IsHomalgMatrix", "IsHomalgMatrix" ],
    src_template := """
        UnionOfRows( List( [ 1 .. NrColumns( A ) ], j ->
            UnionOfColumns( List( [ 1 .. NrRows( A ) ], i ->
                A[i,j] * B
            ) )
        ) )
    """,
    dst_template := "KroneckerMat( TransposedMatrix( A ), B )",
    returns_value := true,
    needed_packages := [ [ "MatricesForHomalg", ">= 2020.05.19" ] ],
) );
