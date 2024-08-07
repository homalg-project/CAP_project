# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Declarations
#
# THIS FILE IS AUTOMATICALLY GENERATED, SEE CAP_project/CAP/gap/MethodRecord.gi

#! @Chapter Cocartesian Categories

#! @Section Add-methods

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation `CocartesianAssociatorLeftToRight`.
#! $F: ( a, b, c ) \mapsto \mathtt{CocartesianAssociatorLeftToRight}(a, b, c)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCocartesianAssociatorLeftToRight",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCocartesianAssociatorLeftToRight",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCocartesianAssociatorLeftToRight",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCocartesianAssociatorLeftToRight",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation `CocartesianAssociatorLeftToRightWithGivenCoproducts`.
#! $F: ( s, a, b, c, r ) \mapsto \mathtt{CocartesianAssociatorLeftToRightWithGivenCoproducts}(s, a, b, c, r)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCocartesianAssociatorLeftToRightWithGivenCoproducts",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCocartesianAssociatorLeftToRightWithGivenCoproducts",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCocartesianAssociatorLeftToRightWithGivenCoproducts",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCocartesianAssociatorLeftToRightWithGivenCoproducts",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation `CocartesianAssociatorRightToLeft`.
#! $F: ( a, b, c ) \mapsto \mathtt{CocartesianAssociatorRightToLeft}(a, b, c)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCocartesianAssociatorRightToLeft",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCocartesianAssociatorRightToLeft",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCocartesianAssociatorRightToLeft",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCocartesianAssociatorRightToLeft",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation `CocartesianAssociatorRightToLeftWithGivenCoproducts`.
#! $F: ( s, a, b, c, r ) \mapsto \mathtt{CocartesianAssociatorRightToLeftWithGivenCoproducts}(s, a, b, c, r)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCocartesianAssociatorRightToLeftWithGivenCoproducts",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCocartesianAssociatorRightToLeftWithGivenCoproducts",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCocartesianAssociatorRightToLeftWithGivenCoproducts",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCocartesianAssociatorRightToLeftWithGivenCoproducts",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation `CocartesianCodiagonal`.
#! $F: ( a, n ) \mapsto \mathtt{CocartesianCodiagonal}(a, n)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCocartesianCodiagonal",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCocartesianCodiagonal",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCocartesianCodiagonal",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCocartesianCodiagonal",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation `CocartesianCodiagonalWithGivenCocartesianMultiple`.
#! $F: ( a, n, cocartesian_multiple ) \mapsto \mathtt{CocartesianCodiagonalWithGivenCocartesianMultiple}(a, n, cocartesian_multiple)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCocartesianCodiagonalWithGivenCocartesianMultiple",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCocartesianCodiagonalWithGivenCocartesianMultiple",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCocartesianCodiagonalWithGivenCocartesianMultiple",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCocartesianCodiagonalWithGivenCocartesianMultiple",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation `CocartesianLeftUnitor`.
#! $F: ( a ) \mapsto \mathtt{CocartesianLeftUnitor}(a)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCocartesianLeftUnitor",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCocartesianLeftUnitor",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCocartesianLeftUnitor",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCocartesianLeftUnitor",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation `CocartesianLeftUnitorInverse`.
#! $F: ( a ) \mapsto \mathtt{CocartesianLeftUnitorInverse}(a)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCocartesianLeftUnitorInverse",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCocartesianLeftUnitorInverse",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCocartesianLeftUnitorInverse",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCocartesianLeftUnitorInverse",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation `CocartesianLeftUnitorInverseWithGivenCoproduct`.
#! $F: ( a, r ) \mapsto \mathtt{CocartesianLeftUnitorInverseWithGivenCoproduct}(a, r)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCocartesianLeftUnitorInverseWithGivenCoproduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCocartesianLeftUnitorInverseWithGivenCoproduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCocartesianLeftUnitorInverseWithGivenCoproduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCocartesianLeftUnitorInverseWithGivenCoproduct",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation `CocartesianLeftUnitorWithGivenCoproduct`.
#! $F: ( a, s ) \mapsto \mathtt{CocartesianLeftUnitorWithGivenCoproduct}(a, s)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCocartesianLeftUnitorWithGivenCoproduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCocartesianLeftUnitorWithGivenCoproduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCocartesianLeftUnitorWithGivenCoproduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCocartesianLeftUnitorWithGivenCoproduct",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation `CocartesianRightUnitor`.
#! $F: ( a ) \mapsto \mathtt{CocartesianRightUnitor}(a)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCocartesianRightUnitor",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCocartesianRightUnitor",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCocartesianRightUnitor",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCocartesianRightUnitor",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation `CocartesianRightUnitorInverse`.
#! $F: ( a ) \mapsto \mathtt{CocartesianRightUnitorInverse}(a)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCocartesianRightUnitorInverse",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCocartesianRightUnitorInverse",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCocartesianRightUnitorInverse",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCocartesianRightUnitorInverse",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation `CocartesianRightUnitorInverseWithGivenCoproduct`.
#! $F: ( a, r ) \mapsto \mathtt{CocartesianRightUnitorInverseWithGivenCoproduct}(a, r)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCocartesianRightUnitorInverseWithGivenCoproduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCocartesianRightUnitorInverseWithGivenCoproduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCocartesianRightUnitorInverseWithGivenCoproduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCocartesianRightUnitorInverseWithGivenCoproduct",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation `CocartesianRightUnitorWithGivenCoproduct`.
#! $F: ( a, s ) \mapsto \mathtt{CocartesianRightUnitorWithGivenCoproduct}(a, s)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCocartesianRightUnitorWithGivenCoproduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCocartesianRightUnitorWithGivenCoproduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCocartesianRightUnitorWithGivenCoproduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCocartesianRightUnitorWithGivenCoproduct",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation `CoproductOnMorphisms`.
#! $F: ( alpha, beta ) \mapsto \mathtt{CoproductOnMorphisms}(alpha, beta)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCoproductOnMorphisms",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCoproductOnMorphisms",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCoproductOnMorphisms",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCoproductOnMorphisms",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation `CoproductOnMorphismsWithGivenCoproducts`.
#! $F: ( s, alpha, beta, r ) \mapsto \mathtt{CoproductOnMorphismsWithGivenCoproducts}(s, alpha, beta, r)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCoproductOnMorphismsWithGivenCoproducts",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCoproductOnMorphismsWithGivenCoproducts",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCoproductOnMorphismsWithGivenCoproducts",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCoproductOnMorphismsWithGivenCoproducts",
                  [ IsCapCategory, IsList ] );
