# SPDX-License-Identifier: GPL-2.0-or-later
# LinearAlgebraForCAP: Category of Matrices over a Field for CAP
#
# Implementations
#

# HomalgIdentityMatrix( size, ring ) * matrix -> matrix
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "size", "ring", "matrix" ],
        src_template := "HomalgIdentityMatrix( size, ring ) * matrix",
        dst_template := "matrix",
        needed_packages := [ [ "MatricesForHomalg", ">= 2020.05.19" ] ],
    )
);

# matrix * HomalgIdentityMatrix( size, ring ) -> matrix
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "size", "ring", "matrix" ],
        src_template := "matrix * HomalgIdentityMatrix( size, ring )",
        dst_template := "matrix",
        needed_packages := [ [ "MatricesForHomalg", ">= 2020.05.19" ] ],
    )
);

# NrRows( HomalgIdentityMatrix( size, R ) ) -> size
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "size", "ring" ],
        src_template := "NrRows( HomalgIdentityMatrix( size, ring ) )",
        dst_template := "size",
        needed_packages := [ [ "MatricesForHomalg", ">= 2020.05.19" ] ],
    )
);

# NrCols( HomalgIdentityMatrix( size, R ) ) -> size
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "size", "ring" ],
        src_template := "NrCols( HomalgIdentityMatrix( size, ring ) )",
        dst_template := "size",
        needed_packages := [ [ "MatricesForHomalg", ">= 2020.05.19" ] ],
    )
);

# matrix1 + (- matrix2) -> matrix1 - matrix2
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "matrix1", "matrix2" ],
        variable_filters := [ "IsHomalgMatrix", "IsHomalgMatrix" ],
        src_template := "matrix1 + (- matrix2)",
        dst_template := "matrix1 - matrix2",
        needed_packages := [ [ "MatricesForHomalg", ">= 2020.05.19" ] ],
    )
);

# Length( [ 1 .. n ] ) -> n
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "n" ],
        src_template := "Length( [ 1 .. n ] )",
        dst_template := "n"
    )
);

# TransposedMatrix( HomalgIdentityMatrix( size, ring ) ) -> HomalgIdentityMatrix( size, ring )
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "size", "ring" ],
        src_template := "TransposedMatrix( HomalgIdentityMatrix( size, ring ) )",
        dst_template := "HomalgIdentityMatrix( size, ring )",
        needed_packages := [ [ "MatricesForHomalg", ">= 2020.05.19" ] ],
    )
);

# TransposedMatrix( HomalgZeroMatrix( 0, size, ring ) ) -> HomalgZeroMatrix( size, 0, ring )
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "size", "ring" ],
        src_template := "TransposedMatrix( HomalgZeroMatrix( 0, size, ring ) )",
        dst_template := "HomalgZeroMatrix( size, 0, ring )",
        needed_packages := [ [ "MatricesForHomalg", ">= 2020.05.19" ] ],
    )
);

# TransposedMatrix( HomalgZeroMatrix( size, 0, ring ) ) -> HomalgZeroMatrix( 0, size, ring )
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "size", "ring" ],
        src_template := "TransposedMatrix( HomalgZeroMatrix( size, 0, ring ) )",
        dst_template := "HomalgZeroMatrix( 0, size, ring )",
        needed_packages := [ [ "MatricesForHomalg", ">= 2020.05.19" ] ],
    )
);

# KroneckerMat( HomalgZeroMatrix( size, 0, ring ), matrix ) -> HomalgZeroMatrix( size * NumberRows( matrix ), 0, ring )
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "size", "matrix", "ring" ],
        src_template := "KroneckerMat( HomalgZeroMatrix( size, 0, ring ), matrix )",
        dst_template := "HomalgZeroMatrix( size * NumberRows( matrix ), 0, ring )",
        needed_packages := [ [ "MatricesForHomalg", ">= 2020.05.19" ] ],
    )
);

# KroneckerMat( HomalgZeroMatrix( 0, size, ring ), matrix ) -> HomalgZeroMatrix( 0, size * NumberColumns( matrix ), ring )
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "size", "matrix", "ring" ],
        src_template := "KroneckerMat( HomalgZeroMatrix( 0, size, ring ), matrix )",
        dst_template := "HomalgZeroMatrix( 0, size * NumberColumns( matrix ), ring )",
        needed_packages := [ [ "MatricesForHomalg", ">= 2020.05.19" ] ],
    )
);

# KroneckerMat( matrix, HomalgZeroMatrix( size, 0, ring ) ) -> HomalgZeroMatrix( NumberRows( matrix ) * size, 0, ring )
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "size", "matrix", "ring" ],
        src_template := "KroneckerMat( matrix, HomalgZeroMatrix( size, 0, ring ) )",
        dst_template := "HomalgZeroMatrix( NumberRows( matrix ) * size, 0, ring )",
        needed_packages := [ [ "MatricesForHomalg", ">= 2020.05.19" ] ],
    )
);

# KroneckerMat( matrix, HomalgZeroMatrix( 0, size, ring ) ) -> HomalgZeroMatrix( 0, NumberColumns( matrix ) * size, ring )
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "size", "matrix", "ring" ],
        src_template := "KroneckerMat( matrix, HomalgZeroMatrix( 0, size, ring ) )",
        dst_template := "HomalgZeroMatrix( 0, NumberColumns( matrix ) * size, ring )",
        needed_packages := [ [ "MatricesForHomalg", ">= 2020.05.19" ] ],
    )
);

# KroneckerMat( HomalgIdentityMatrix( 0, ring ), matrix ) -> HomalgIdentityMatrix( 0, ring )
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "matrix", "ring" ],
        src_template := "KroneckerMat( HomalgIdentityMatrix( 0, ring ), matrix )",
        dst_template := "HomalgIdentityMatrix( 0, ring )",
        needed_packages := [ [ "MatricesForHomalg", ">= 2020.05.19" ] ],
    )
);

# KroneckerMat( matrix, HomalgIdentityMatrix( 0, ring ) ) -> HomalgIdentityMatrix( 0, ring )
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "matrix", "ring" ],
        src_template := "KroneckerMat( matrix, HomalgIdentityMatrix( 0, ring ) )",
        dst_template := "HomalgIdentityMatrix( 0, ring )",
        needed_packages := [ [ "MatricesForHomalg", ">= 2020.05.19" ] ],
    )
);

# KroneckerMat( HomalgIdentityMatrix( m, ring ) , HomalgIdentityMatrix( n ring ) ) -> HomalgIdentityMatrix( m*n, ring )
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "m", "n", "ring" ],
        src_template := "KroneckerMat( HomalgIdentityMatrix( m, ring ), HomalgIdentityMatrix( n, ring ) )",
        dst_template := "HomalgIdentityMatrix( m*n, ring )",
        needed_packages := [ [ "MatricesForHomalg", ">= 2020.05.19" ] ],
    )
);

# TODO?
# KroneckerMat( HomalgIdentityMatrix( m, ring ), matrix ) -> DiagMat( ring, ListWithIdenticalEntries( m, matrix ) )
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "m", "matrix", "ring" ],
        src_template := "KroneckerMat( HomalgIdentityMatrix( m, ring ), matrix )",
        dst_template := "DiagMat( ring, ListWithIdenticalEntries( m, matrix ) )",
        needed_packages := [ [ "MatricesForHomalg", ">= 2020.05.19" ] ],
    )
);

# DiagMat( ring, [ ] ) -> HomalgIdentityMatrix( 0, ring )
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "ring" ],
        src_template := "DiagMat( ring, [ ] )",
        dst_template := "HomalgIdentityMatrix( 0, ring )",
    )
);

# ReducedSyzygiesOfRows( matrix, HomalgIdentityMatrix( 0, ring ) ) -> ReducedSyzygiesOfRows( matrix )
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "matrix", "ring" ],
        src_template := "ReducedSyzygiesOfRows( matrix, HomalgIdentityMatrix( 0, ring ) )",
        dst_template := "ReducedSyzygiesOfRows( matrix )",
        needed_packages := [ [ "MatricesForHomalg", ">= 2020.05.19" ] ],
    )
);

# ReducedSyzygiesOfColumns( matrix, HomalgIdentityMatrix( 0, ring ) ) -> ReducedSyzygiesOfColumns( matrix )
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "matrix", "ring" ],
        src_template := "ReducedSyzygiesOfColumns( matrix, HomalgIdentityMatrix( 0, ring ) )",
        dst_template := "ReducedSyzygiesOfColumns( matrix )",
        needed_packages := [ [ "MatricesForHomalg", ">= 2020.05.19" ] ],
    )
);

# ReducedSyzygiesOfRows( matrix, HomalgZeroMatrix( m, n, ring ) ) -> ReducedSyzygiesOfRows( matrix )
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "matrix", "m", "n", "ring" ],
        src_template := "ReducedSyzygiesOfRows( matrix, HomalgZeroMatrix( m, n, ring ) )",
        dst_template := "ReducedSyzygiesOfRows( matrix )",
        needed_packages := [ [ "MatricesForHomalg", ">= 2020.05.19" ] ],
    )
);

# ReducedSyzygiesOfColumns( matrix, HomalgZeroMatrix( m, n, ring ) ) -> ReducedSyzygiesOfColumns( matrix )
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "matrix", "m", "n", "ring" ],
        src_template := "ReducedSyzygiesOfColumns( matrix, HomalgZeroMatrix( m, n, ring ) )",
        dst_template := "ReducedSyzygiesOfColumns( matrix )",
        needed_packages := [ [ "MatricesForHomalg", ">= 2020.05.19" ] ],
    )
);

# ReducedSyzygiesOfRows( HomalgZeroMatrix( 0, m, ring ) ) -> HomalgZeroMatrix( 0, 0, ring )
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "m", "ring" ],
        src_template := "ReducedSyzygiesOfRows( HomalgZeroMatrix( 0, m, ring ) )",
        dst_template := "HomalgZeroMatrix( 0, 0, ring )",
        needed_packages := [ [ "MatricesForHomalg", ">= 2020.05.19" ] ],
    )
);

# ReducedSyzygiesOfRows( HomalgZeroMatrix( m, 0, ring ) ) -> HomalgIdentityMatrix( m, ring )
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "m", "ring" ],
        src_template := "ReducedSyzygiesOfRows( HomalgZeroMatrix( m, 0, ring ) )",
        dst_template := "HomalgIdentityMatrix( m, ring )",
        needed_packages := [ [ "MatricesForHomalg", ">= 2020.05.19" ] ],
    )
);

# ReducedSyzygiesOfColumns( HomalgZeroMatrix( 0, m, ring ) ) -> HomalgIdentityMatrix( m, ring )
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "m", "ring" ],
        src_template := "ReducedSyzygiesOfColumns( HomalgZeroMatrix( 0, m, ring ) )",
        dst_template := "HomalgIdentityMatrix( m, ring )",
        needed_packages := [ [ "MatricesForHomalg", ">= 2020.05.19" ] ],
    )
);

# ReducedSyzygiesOfColumns( HomalgZeroMatrix( m, 0, ring ) ) -> HomalgZeroMatrix( 0, 0, ring )
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "m", "ring" ],
        src_template := "ReducedSyzygiesOfColumns( HomalgZeroMatrix( m, 0, ring ) )",
        dst_template := "HomalgZeroMatrix( 0, 0, ring )",
        needed_packages := [ [ "MatricesForHomalg", ">= 2020.05.19" ] ],
    )
);

# TODO
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "matrix_B", "matrix_A", "matrix_L", "ring", "nr_cols_A", "nr_rows_L" ],
        src_template := "CertainColumns( RightDivide( matrix_B, UnionOfRows( ring, nr_cols_A, [ matrix_L, matrix_A ] ) ), [ NumberRows( matrix_L ) + 1 .. NumberRows( matrix_L ) + 1 - 1 + nr_rows_L ] ) ",
        dst_template := "RightDivide( matrix_B, matrix_A, matrix_L )",
    )
);

# TODO
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "matrix_A", "matrix_B", "matrix_L", "ring", "nr_rows_A", "nr_cols_L" ],
        src_template := "CertainRows( LeftDivide( UnionOfColumns( ring, nr_rows_A, [ matrix_L, matrix_A ] ), matrix_B ), [ NumberColumns( matrix_L ) + 1 .. NumberColumns( matrix_L ) + 1 - 1 + nr_cols_L ] )",
        dst_template := "LeftDivide( matrix_A, matrix_B, matrix_L )",
    )
);

# # Does not have an effect
#
# # RightDivide( HomalgIdentityMatrix( number, ring ), HomalgIdentityMatrix( number, ring ), matrix_L ) -> HomalgIdentityMatrix( number, ring )
# CapJitAddLogicTemplate(
#     rec(
#         variable_names := [ "matrix_L", "ring", "number" ],
#         src_template := "RightDivide( HomalgIdentityMatrix( number, ring ), HomalgIdentityMatrix( number, ring ), matrix_L )",
#         dst_template := "HomalgIdentityMatrix( number, ring )",
#     )
# );

# # Does not have an effect
#
# # LeftDivide( HomalgIdentityMatrix( number, ring ), HomalgIdentityMatrix( number, ring ), matrix_L ) -> HomalgIdentityMatrix( number, ring )
# CapJitAddLogicTemplate(
#     rec(
#         variable_names := [ "matrix_L", "ring", "number" ],
#         src_template := "LeftDivide( HomalgIdentityMatrix( number, ring ), HomalgIdentityMatrix( number, ring ), matrix_L )",
#         dst_template := "HomalgIdentityMatrix( number, ring )",
#     )
# );

# ReducedSyzygiesOfRows( HomalgIdentityMatrix( number, ring ), M2 ) -> ReducedBasisOfRowModule( M2 )
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "M2", "ring", "number" ],
        src_template := "ReducedSyzygiesOfRows( HomalgIdentityMatrix( number, ring ), M2 )",
        dst_template := "ReducedBasisOfRowModule( M2 )",
    )
);

# ReducedSyzygiesOfColumns( HomalgIdentityMatrix( number, ring ), M2 ) -> ReducedBasisOfColumnModule( M2 )
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "M2", "ring", "number" ],
        src_template := "ReducedSyzygiesOfColumns( HomalgIdentityMatrix( number, ring ), M2 )",
        dst_template := "ReducedBasisOfColumnModule( M2 )",
    )
);

# ReducedBasisOfRowModule( DiagMat( ring, ListWithIdenticalEntries( number, matrix ) ) ) -> DiagMat( ring, ListWithIdenticalEntries( number, ReducedBasisOfRowModule( matrix ) ) )
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "matrix", "ring", "number" ],
        src_template := "ReducedBasisOfRowModule( DiagMat( ring, ListWithIdenticalEntries( number, matrix ) ) )",
        dst_template := "DiagMat( ring, ListWithIdenticalEntries( number, ReducedBasisOfRowModule( matrix ) ) )",
    )
);

# ReducedBasisOfColumnModule( DiagMat( ring, ListWithIdenticalEntries( number, matrix ) ) ) -> DiagMat( ring, ListWithIdenticalEntries( number, ReducedBasisOfColumnModule( matrix ) ) )
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "matrix", "ring", "number" ],
        src_template := "ReducedBasisOfColumnModule( DiagMat( ring, ListWithIdenticalEntries( number, matrix ) ) )",
        dst_template := "DiagMat( ring, ListWithIdenticalEntries( number, ReducedBasisOfColumnModule( matrix ) ) )",
    )
);

# ListWithIdenticalEntries( 0, a ) = [ ]
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "a" ],
        src_template := "ListWithIdenticalEntries( 0, a )",
        dst_template := "[ ]",
    )
);

# [ 1 .. 2 - 1 ] -> [ 1 ]
CapJitAddLogicTemplate(
    rec(
        variable_names := [ ],
        src_template := "[ 1 .. 2 - 1 ]",
        dst_template := "[ 1 ]",
    )
);

# [ a, b ]{ [ 1 ] } -> [ a ]
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "a", "b" ],
        src_template := "[ a, b ]{ [ 1 ] }",
        dst_template := "[ a ]",
    )
);

# Sum( [ a ] ) -> a
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "a" ],
        src_template := "Sum( [ a ] )",
        dst_template := "a",
    )
);

# 0 * a = 0
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "a" ],
        src_template := "0 * a",
        dst_template := "0",
    )
);

# a * 0 = 0
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "a" ],
        src_template := "a * 0",
        dst_template := "0",
    )
);
