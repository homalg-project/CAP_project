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

#
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "n", "ring" ],
        src_template := "TransposedMatrix( HomalgIdentityMatrix( n, ring ) )",
        dst_template := "HomalgIdentityMatrix( n, ring )",
    )
);

#
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "n", "ring" ],
        src_template := "HomalgMatrix( PermutationMat( PermList( [ 1 .. n ] ), n ), n, n, ring )",
        dst_template := "HomalgIdentityMatrix( n, ring )",
    )
);

#
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "ring" ],
        src_template := "HomalgMatrix( PermutationMat( PermList( [ 1 ] ), 1 ), 1, 1, ring )",
        dst_template := "HomalgIdentityMatrix( 1, ring )",
    )
);

#
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "ring" ],
        src_template := "ConvertMatrixToRow( HomalgIdentityMatrix( 1, ring ) )",
        dst_template := "HomalgIdentityMatrix( 1, ring )",
    )
);

#
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "ring" ],
        src_template := "ConvertMatrixToColumn( HomalgIdentityMatrix( 1, ring ) )",
        dst_template := "HomalgIdentityMatrix( 1, ring )",
    )
);

# 0 + n -> n
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "n" ],
        src_template := "0 + n",
        dst_template := "n"
    )
);

# n - 1 + 1 -> n
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "n" ],
        src_template := "n - 1 + 1",
        dst_template := "n"
    )
);

# 0 * n -> 0
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "n" ],
        variable_filters := [ "IsInt" ],
        src_template := "0 * n",
        dst_template := "0"
    )
);

# 1 * n -> n
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "n" ],
        src_template := "1 * n",
        dst_template := "n"
    )
);

# n * 1 -> n
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "n" ],
        src_template := "n * 1",
        dst_template := "n"
    )
);

# QUO_INT( n, 1 ) -> n
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "n" ],
        src_template := "QUO_INT( n, 1 )",
        dst_template := "n"
    )
);

# REM_INT( n, 1 ) -> n
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "n" ],
        src_template := "REM_INT( n, 1 )",
        dst_template := "0"
    )
);

# List( [ 1 .. n ], i -> REM_INT( i - 1, n ) + QUO_INT( i - 1, n ) + 1 ) -> [ 1 .. n ]
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "n" ],
        src_template := "List( [ 1 .. n ], i -> REM_INT( i - 1, n ) + QUO_INT( i - 1, n ) + 1 )",
        dst_template := "[ 1 .. n ]"
    )
);
