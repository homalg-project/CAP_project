
DeclareCategory( "IsHomalgCategory",
                 IsObject );

DeclareRepresentation( "IsHomalgCategoryRep",
                       IsAttributeStoringRep and IsHomalgCategory,
                       [ ] );

BindGlobal( "TheFamilyOfHomalgCategories",
        NewFamily( "TheFamilyOfHomalgCategories" ) );

BindGlobal( "TheTypeOfHomalgCategories",
        NewType( TheFamilyOfHomalgCategories,
                IsHomalgCategoryRep ) );

DeclareCategory( "IsHomalgCategoryObject",
                 IsObject );

DeclareCategory( "IsHomalgCategoryMorphism",
                 IsObject );

DeclareGlobalFunction( 
