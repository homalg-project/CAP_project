# SPDX-License-Identifier: GPL-2.0-or-later
# FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
#
# Implementations
#

# additive_closure_object[i] => ObjectList( additive_closure_object )[i]
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "additive_closure_object", "index" ],
        variable_filters := [ IsAdditiveClosureObject, IsInt ],
        src_template := "additive_closure_object[index]",
        dst_template := "ObjectList( additive_closure_object )[index]",
    )
);

# additive_closure_morphism[i, j] => MorphismMatrix( additive_closure_morphism )[i, j]
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "additive_closure_morphism", "row", "column" ],
        variable_filters := [ IsAdditiveClosureMorphism, IsInt, IsInt ],
        src_template := "additive_closure_morphism[row, column]",
        dst_template := "MorphismMatrix( additive_closure_morphism )[row][column]",
    )
);

# NumberRows( additive_closure_morphism ) => Length( ObjectList( Source( additive_closure_morphism ) ) )
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "additive_closure_morphism" ],
        variable_filters := [ IsAdditiveClosureMorphism ],
        src_template := "NumberRows( additive_closure_morphism )",
        dst_template := "Length( ObjectList( Source( additive_closure_morphism ) ) )",
    )
);

# NumberColumns( additive_closure_morphism ) => Length( ObjectList( Range( additive_closure_morphism ) ) )
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "additive_closure_morphism" ],
        variable_filters := [ IsAdditiveClosureMorphism ],
        src_template := "NumberColumns( additive_closure_morphism )",
        dst_template := "Length( ObjectList( Range( additive_closure_morphism ) ) )",
    )
);

# UnionOfRowsListList
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "nr_cols", "listlist", "func" ],
        src_template := "List( UnionOfRowsListList( nr_cols, listlist ), row -> List( row, func ) )",
        dst_template := "UnionOfRowsListList( nr_cols, List( listlist, list -> List( list, new_row -> List( new_row, func ) ) ) )",
        new_funcs := [ [ "list" ], [ "new_row" ] ],
        needed_packages := [ [ "FreydCategoriesForCAP", ">= 2021.12-02" ] ],
    )
);

# UnionOfColumnsListList
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "nr_rows", "listlist", "func" ],
        src_template := "List( UnionOfColumnsListList( nr_rows, listlist ), row -> List( row, func ) )",
        dst_template := "UnionOfColumnsListList( nr_rows, List( listlist, list -> List( list, new_row -> List( new_row, func ) ) ) )",
        new_funcs := [ [ "list" ], [ "new_row" ] ],
        needed_packages := [ [ "FreydCategoriesForCAP", ">= 2021.12-02" ] ],
    )
);

# List( list, x -> const ) => ListWithIdenticalEntries
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "list", "const" ],
        src_template := "List( list, x -> const )",
        dst_template := "ListWithIdenticalEntries( Length( list ), const )",
    )
);

# ListWithIdenticalEntries( number, obj )[index] => obj
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "number", "obj", "index" ],
        src_template := "ListWithIdenticalEntries( number, obj )[index]",
        dst_template := "obj",
    )
);

# Length( ListWithIdenticalEntries( number, obj ) ) => number
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "number", "obj" ],
        src_template := "Length( ListWithIdenticalEntries( number, obj ) )",
        dst_template := "number",
    )
);

# List( ListWithIdenticalEntries( number, obj ), func ) => ListWithIdenticalEntries( number, func( obj ) )
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "number", "obj", "func" ],
        src_template := "List( ListWithIdenticalEntries( number, obj ), func )",
        dst_template := "ListWithIdenticalEntries( number, func( obj ) )",
    )
);

# Concatenation( ListWithIdenticalEntries( ..., ListWithIdenticalEntries ) )
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "number1", "number2", "obj" ],
        src_template := "Concatenation( ListWithIdenticalEntries( number1, ListWithIdenticalEntries( number2, obj ) ) )",
        dst_template := "ListWithIdenticalEntries( number1 * number2, obj )",
    )
);

# Sum( ListWithIdenticalEntries( number, 1 ) ) => number
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "number" ],
        src_template := "Sum( ListWithIdenticalEntries( number, 1 ) )",
        dst_template := "number",
    )
);

# ListWithIdenticalEntries( number, obj ){list} => ListWithIdenticalEntries( Length( list ), obj )
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "number", "obj", "list" ],
        src_template := "ListWithIdenticalEntries( number, obj ){list}",
        dst_template := "ListWithIdenticalEntries( Length( list ), obj )",
    )
);

# Length( [ 1 .. n ] ) => n
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "n" ],
        src_template := "Length( [ 1 .. n ] )",
        dst_template := "n",
    )
);

# n - 1 + 1 => n
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "n" ],
        src_template := "n - 1 + 1",
        dst_template := "n",
    )
);

# [ n .. n ] => [ n ]
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "n" ],
        src_template := "[ n .. n ]",
        dst_template := "[ n ]",
    )
);

# list{[ n ]} => [ list[n] ]
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "list", "index" ],
        src_template := "list{[ index ]}",
        dst_template := "[ list[index] ]",
    )
);

# List( list1, x -> List( list2, y -> List( list3, z -> [ entry ] ) ) )[index1][index2][1][1]
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "list1", "list2", "list3", "index1", "index2", "entry" ],
        src_template := "List( list1, x -> List( list2, y -> List( list3, z -> [ entry ] ) ) )[index1][index2][1][1]",
        dst_template := "(x -> (y -> (z -> entry)(list3[1]))(list2[index2]))(list1[index1])",
    )
);

# List( L, x -> x ) => L
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "list" ],
        src_template := "List( list, x -> x )",
        dst_template := "list",
    )
);

# EntriesOfHomalgMatrixAsListList( matrix )[row][col] => matrix[row][col]
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "matrix", "row", "col" ],
        src_template := "EntriesOfHomalgMatrixAsListList( matrix )[row][col]",
        dst_template := "matrix[row, col]",
        needed_packages := [ [ "MatricesForHomalg", ">= 2020.05.19" ] ],
    )
);

# HomalgMatrixListList( UnionOfRowsListList ) => UnionOfRows( HomalgMatrixListList )
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "nr_cols", "list", "nr_rows", "nr_cols2", "ring" ],
        src_template := "HomalgMatrixListList( UnionOfRowsListList( nr_cols, list ), nr_rows, nr_cols2, ring )",
        dst_template := "UnionOfRows( ring, nr_cols, List( list, l -> HomalgMatrixListList( l, Length( l ), nr_cols, ring ) ) )",
        new_funcs := [ [ "l" ] ],
        needed_packages := [ [ "MatricesForHomalg", ">= 2020.05.19" ] ],
    )
);

# HomalgMatrixListList( UnionOfColumnsListList ) => UnionOfColumns( HomalgMatrixListList )
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "nr_rows", "list", "nr_rows2", "nr_cols", "ring" ],
        src_template := "HomalgMatrixListList( UnionOfColumnsListList( nr_rows, list ), nr_rows2, nr_cols, ring )",
        dst_template := "UnionOfColumns( ring, nr_rows, List( list, l -> HomalgMatrixListList( l, nr_rows, Length( l[1] ), ring ) ) )", # WARNING: l[1] might not exist
        new_funcs := [ [ "l" ] ],
        needed_packages := [ [ "MatricesForHomalg", ">= 2020.05.19" ] ],
    )
);

# UnionOfRows( CoercedMatrix( R, S, M ) )
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "ring2", "nr_cols", "list", "ring1", "matrix" ],
        src_template := "UnionOfRows( ring2, nr_cols, List( list, l -> CoercedMatrix( ring1, ring2, matrix ) ) )",
        dst_template := "CoercedMatrix( ring1, ring2, UnionOfRows( ring1, nr_cols, List( list, l -> matrix ) ) )",
        needed_packages := [ [ "MatricesForHomalg", ">= 2020.05.19" ] ],
    )
);

# UnionOfColumns( CoercedMatrix( R, S, M ) )
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "ring2", "nr_rows", "list", "ring1", "matrix" ],
        src_template := "UnionOfColumns( ring2, nr_rows, List( list, l -> CoercedMatrix( ring1, ring2, matrix ) ) )",
        dst_template := "CoercedMatrix( ring1, ring2, UnionOfColumns( ring1, nr_rows, List( list, l -> matrix ) ) )",
        needed_packages := [ [ "MatricesForHomalg", ">= 2020.05.19" ] ],
    )
);

# UnionOfRows( CoefficientsWithGivenMonomials )
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "ring", "nr_cols", "list", "matrix", "monomials" ],
        variable_filters := [ IsObject, IsObject, IsObject, "IsHomalgMatrix", "IsHomalgMatrix" ],
        src_template := "UnionOfRows( ring, nr_cols, List( list, l -> CoefficientsWithGivenMonomials( matrix, monomials ) ) )",
        dst_template := "CoefficientsWithGivenMonomials( UnionOfRows( ring, NumberColumns( monomials ), List( list, l -> matrix ) ), monomials )",
        needed_packages := [ [ "MatricesForHomalg", ">= 2020.05.19" ] ],
    )
);

# UnionOfColumns( CoefficientsWithGivenMonomials )
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "ring", "nr_rows", "list", "matrix", "monomials" ],
        variable_filters := [ IsObject, IsObject, IsObject, "IsHomalgMatrix", "IsHomalgMatrix" ],
        src_template := "UnionOfColumns( ring, nr_rows, List( list, l -> CoefficientsWithGivenMonomials( matrix, monomials ) ) )",
        dst_template := "CoefficientsWithGivenMonomials( UnionOfColumns( ring, nr_rows, List( list, l -> matrix ) ), DiagMat( ring, List( list, x -> monomials ) ) )",
        new_funcs := [ [ "x" ] ],
        needed_packages := [ [ "MatricesForHomalg", ">= 2020.05.19" ] ],
    )
);

# COMPILATION_HELPER_HomalgMatrixFromRingElement
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "ring_element", "nr_rows", "nr_cols", "ring" ],
        variable_filters := [ "IsHomalgRingElement", "IsInt", "IsInt", "IsHomalgRing" ],
        src_template := "HomalgMatrixListList( [ [ ring_element ] ], nr_rows, nr_cols, ring )",
        dst_template := "COMPILATION_HELPER_HomalgMatrixFromRingElement( ring_element, ring )",
        needed_packages := [ [ "MatricesForHomalg", ">= 2020.06.27" ] ],
    )
);

# COMPILATION_HELPER_HomalgMatrixFromRingElement
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "ring_element", "ring" ],
        variable_filters := [ "IsHomalgRingElement", "IsHomalgRing" ],
        src_template := "HomalgMatrix( [ ring_element ], 1, 1, ring )",
        dst_template := "COMPILATION_HELPER_HomalgMatrixFromRingElement( ring_element, ring )",
        needed_packages := [ [ "MatricesForHomalg", ">= 2020.06.27" ] ],
    )
);

# COMPILATION_HELPER_HomalgMatrixFromRingElement( ring_element_to_pull_out * ring_element2 )
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "homalg_ring", "nr_cols", "list", "ring_element1", "ring_element2" ],
        variable_filters := [ IsObject, IsObject, IsObject, "IsHomalgRingElement", "IsHomalgRingElement" ],
        src_template := "UnionOfRows( homalg_ring, nr_cols, List( list, l -> COMPILATION_HELPER_HomalgMatrixFromRingElement( ring_element1 * ring_element2, homalg_ring ) ) )",
        dst_template := "ring_element1 * UnionOfRows( homalg_ring, nr_cols, List( list, l -> COMPILATION_HELPER_HomalgMatrixFromRingElement( ring_element2, homalg_ring ) ) )",
        needed_packages := [ [ "MatricesForHomalg", ">= 2020.05.19" ] ],
    )
);

# COMPILATION_HELPER_HomalgMatrixFromRingElement( ring_element_to_pull_out * ring_element2 )
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "homalg_ring", "nr_rows", "list", "ring_element1", "ring_element2" ],
        variable_filters := [ IsObject, IsObject, IsObject, "IsHomalgRingElement", "IsHomalgRingElement" ],
        src_template := "UnionOfColumns( homalg_ring, nr_rows, List( list, l -> COMPILATION_HELPER_HomalgMatrixFromRingElement( ring_element1 * ring_element2, homalg_ring ) ) )",
        dst_template := "ring_element1 * UnionOfColumns( homalg_ring, nr_rows, List( list, l -> COMPILATION_HELPER_HomalgMatrixFromRingElement( ring_element2, homalg_ring ) ) )",
        needed_packages := [ [ "MatricesForHomalg", ">= 2020.05.19" ] ],
    )
);

# COMPILATION_HELPER_HomalgMatrixFromRingElement( ring_element1 * ring_element_to_pull_out )
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "homalg_ring", "nr_cols", "list", "ring_element1", "ring_element2" ],
        variable_filters := [ IsObject, IsObject, IsObject, "IsHomalgRingElement", "IsHomalgRingElement" ],
        src_template := "UnionOfRows( homalg_ring, nr_cols, List( list, l -> COMPILATION_HELPER_HomalgMatrixFromRingElement( ring_element1 * ring_element2, homalg_ring ) ) )",
        dst_template := "UnionOfRows( homalg_ring, nr_cols, List( list, l -> COMPILATION_HELPER_HomalgMatrixFromRingElement( ring_element1, homalg_ring ) ) ) * ring_element2",
        needed_packages := [ [ "MatricesForHomalg", ">= 2020.05.19" ] ],
    )
);

# UnionOfRows( a * B ) => a * UnionOfRows( B )
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "homalg_ring", "nr_cols", "list", "ring_element", "matrix" ],
        variable_filters := [ IsObject, IsObject, IsObject, "IsHomalgRingElement", "IsHomalgMatrix" ],
        src_template := "UnionOfRows( homalg_ring, nr_cols, List( list, l -> ring_element * matrix ) )",
        dst_template := "ring_element * UnionOfRows( homalg_ring, nr_cols, List( list, l -> matrix ) )",
        needed_packages := [ [ "MatricesForHomalg", ">= 2020.05.19" ] ],
    )
);

# UnionOfRows( A * b ) => UnionOfRows( A ) * b
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "homalg_ring", "nr_cols", "list", "matrix", "ring_element" ],
        variable_filters := [ IsObject, IsObject, IsObject, "IsHomalgMatrix", "IsHomalgRingElement" ],
        src_template := "UnionOfRows( homalg_ring, nr_cols, List( list, l -> matrix * ring_element ) )",
        dst_template := "UnionOfRows( homalg_ring, nr_cols, List( list, l -> matrix ) ) * ring_element",
        needed_packages := [ [ "MatricesForHomalg", ">= 2020.05.19" ] ],
    )
);

# UnionOfColumns( a * B ) => a * UnionOfColumns( B )
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "homalg_ring", "nr_rows", "list", "ring_element", "matrix" ],
        variable_filters := [ IsObject, IsObject, IsObject, "IsHomalgRingElement", "IsHomalgMatrix" ],
        src_template := "UnionOfColumns( homalg_ring, nr_rows, List( list, l -> ring_element * matrix ) )",
        dst_template := "ring_element * UnionOfColumns( homalg_ring, nr_rows, List( list, l -> matrix ) )",
        needed_packages := [ [ "MatricesForHomalg", ">= 2020.05.19" ] ],
    )
);

# UnionOfColumns( A * b ) => UnionOfColumns( A ) * b
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "homalg_ring", "nr_rows", "list", "matrix", "ring_element" ],
        variable_filters := [ IsObject, IsObject, IsObject, "IsHomalgMatrix", "IsHomalgRingElement" ],
        src_template := "UnionOfColumns( homalg_ring, nr_rows, List( list, l -> matrix * ring_element ) )",
        dst_template := "UnionOfColumns( homalg_ring, nr_rows, List( list, l -> matrix ) ) * ring_element",
        needed_packages := [ [ "MatricesForHomalg", ">= 2020.05.19" ] ],
    )
);

# UnionwOfRows( UnionOfColumns( B[i,j] ) ) => B
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "ring", "nr_cols", "nr_rows", "matrix" ],
        variable_filters := [ "IsHomalgRing", "IsInt", "IsInt", "IsHomalgMatrix" ],
        src_template := """
            UnionOfRows( ring, nr_cols, List( [ 1 .. NrRows( matrix ) ], i ->
                UnionOfColumns( ring, nr_rows, List( [ 1 .. NrColumns( matrix ) ], j ->
                    COMPILATION_HELPER_HomalgMatrixFromRingElement( matrix[i,j], ring )
                ) )
            ) )
        """,
        dst_template := "matrix",
        needed_packages := [ [ "MatricesForHomalg", ">= 2020.06.27" ] ],
    )
);

# DualKroneckerMat( A, B )
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "ring", "nr_cols", "nr_rows", "matrix1", "matrix2" ],
        variable_filters := [ IsObject, IsObject, IsObject, "IsHomalgMatrix", "IsHomalgMatrix" ],
        src_template := """
            UnionOfRows( ring, nr_cols, List( [ 1 .. NrRows( matrix2 ) ], i ->
                UnionOfColumns( ring, nr_rows, List( [ 1 .. NrColumns( matrix2 ) ], j ->
                    matrix1 * matrix2[i,j]
                ) )
            ) )
        """,
        dst_template := "DualKroneckerMat( matrix1, matrix2 )",
        needed_packages := [ [ "MatricesForHomalg", ">= 2020.06.27" ] ],
    )
);

# KroneckerMat( TransposedMatrix( A ), B )
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "ring", "nr_cols", "nr_rows", "matrix1", "matrix2" ],
        variable_filters := [ IsObject, IsObject, IsObject, "IsHomalgMatrix", "IsHomalgMatrix" ],
        src_template := """
            UnionOfRows( ring, nr_cols, List( [ 1 .. NrColumns( matrix1 ) ], j ->
                UnionOfColumns( ring, nr_rows, List( [ 1 .. NrRows( matrix1 ) ], i ->
                    matrix1[i,j] * matrix2
                ) )
            ) )
        """,
        dst_template := "KroneckerMat( TransposedMatrix( matrix1 ), matrix2 )",
        needed_packages := [ [ "MatricesForHomalg", ">= 2020.05.19" ] ],
    )
);

# ConvertMatrixToRow( M )
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "ring", "nr_rows1", "nr_rows2", "matrix" ],
        variable_filters := [ "IsHomalgRing", "IsInt", "IsInt", "IsHomalgMatrix" ],
        src_template := """
            UnionOfColumns( ring, nr_rows1, List( [ 1 .. NrRows( matrix ) ], i ->
                UnionOfColumns( ring, nr_rows2, List( [ 1 .. NrColumns( matrix ) ], j ->
                    COMPILATION_HELPER_HomalgMatrixFromRingElement( matrix[i, j], ring )
                ) )
            ) )
        """,
        dst_template := "ConvertMatrixToRow( matrix )",
        needed_packages := [ [ "MatricesForHomalg", ">= 2020.06.27" ] ],
    )
);

# ConvertRowToMatrix( M )
# WARNING: only if NrRows( matrix ) = 1 and NrCols( matrix ) = nr_rows * nr_cols
# ConvertRowToMatrix checks those two conditions, so worst case is an error, not a wrong result -> we take the chance
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "nr_rows", "nr_cols", "matrix", "ring" ],
        variable_filters := [ "IsInt", "IsInt", "IsHomalgMatrix", "IsHomalgRing" ],
        src_template := """
            HomalgMatrixListList(
                List( [ 1 .. nr_rows ], i ->
                    List( [ 1 .. nr_cols ], j ->
                        matrix[1, nr_cols * (i - 1) + j]
                    )
                ),
                nr_rows,
                nr_cols,
                ring
            )
        """,
        dst_template := "ConvertRowToMatrix( matrix, nr_rows, nr_cols )",
        needed_packages := [ [ "MatricesForHomalg", ">= 2020.06.27" ] ],
    )
);
