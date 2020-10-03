#
# WrapperCategories: Construct an equivalent wrapper category out of a CAP category
#
# Declarations
#

#! @Chapter Create wrapper hulls of a category

####################################
#
#! @Section Info class
#
####################################

DeclareInfoClass( "InfoWrapperCategory" );

####################################
#
#! @Section GAP categories
#
####################################

#! @Description
#!  The &GAP; category of a wrapper CAP category.
DeclareCategory( "IsWrapperCapCategory",
        IsCapCategory );

#! @Description
#!  The &GAP; category of cells in a wrapper CAP category.
DeclareCategory( "IsWrapperCapCategoryCell",
        IsCapCategoryCell );

#! @Description
#!  The &GAP; category of objects in a wrapper CAP category.
DeclareCategory( "IsWrapperCapCategoryObject",
        IsWrapperCapCategoryCell and IsCapCategoryObject );

#! @Description
#!  The &GAP; category of morphisms in a wrapper CAP category.
DeclareCategory( "IsWrapperCapCategoryMorphism",
        IsWrapperCapCategoryCell and IsCapCategoryMorphism );

####################################
#
#! @Section Global variables
#
####################################

#!
DeclareGlobalVariable( "RECORD_OF_COMPACT_NAMES_OF_CATEGORICAL_OPERATIONS" );

####################################
#
#! @Section Attributes
#
####################################

#!
DeclareAttribute( "UnderlyingCategory",
        IsWrapperCapCategory );

#!
DeclareAttribute( "GenesisOfCellOperation",
        IsWrapperCapCategoryCell );
#!
DeclareAttribute( "GenesisOfCellArguments",
        IsWrapperCapCategoryCell );
#!
DeclareAttribute( "ListOfEvaluationNodes",
        IsWrapperCapCategoryCell );

#!
DeclareAttribute( "DigraphOfEvaluation",
        IsWrapperCapCategoryCell );

#!
DeclareAttribute( "EvaluatedCell",
        IsWrapperCapCategoryCell );

####################################
#
#! @Section Constructors
#
####################################

DeclareOperation( "AsObjectInWrapperCategory",
                  [ IsWrapperCapCategory, IsCapCategoryObject ] );

DeclareOperation( "AsObjectInWrapperCategory",
                  [ IsWrapperCapCategory, IsString, IsList ] );

DeclareOperation( "AsMorphismInWrapperCategory",
                  [ IsWrapperCapCategory, IsCapCategoryMorphism ] );

DeclareOperation( "AsMorphismInWrapperCategory",
                  [ IsWrapperCapCategoryObject, IsCapCategoryMorphism, IsWrapperCapCategoryObject ] );

DeclareOperation( "AsMorphismInWrapperCategory",
                  [ IsWrapperCapCategoryObject, IsString, IsList, IsWrapperCapCategoryObject ] );

#!
DeclareOperation( "\/",
                [ IsCapCategoryCell, IsWrapperCapCategory ] );

#!
DeclareOperation( "WrapperCategory",
                  [ IsCapCategory ] );

####################################
#
#! @Section Operations
#
####################################

#!
DeclareOperation( "SetLabel",
                [ IsWrapperCapCategoryCell, IsString ] );

#!
DeclareOperation( "IsEqualForCells",
                  [ IsObject, IsObject ] );

#!
DeclareOperation( "Visualize",
                  [ IsWrapperCapCategoryCell ] );

####################################
#
#! @Section Tools
#
####################################

DeclareGlobalFunction( "AreEqualForWrapperCells" );

DeclareGlobalFunction( "PositionsOfChildrenOfAWrapperCell" );

DeclareGlobalFunction( "CAP_INTERNAL_COMPACT_NAME_OF_CATEGORICAL_OPERATION" );
