#############################################################################
##
##     FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
##
##  Copyright 2019, Sebastian Posur, University of Siegen
##
#! @Chapter Grade filtration
#!
#############################################################################

##
KeyDependentOperation( "GradeFiltrationNthNaturalTransformation",
                       IsCapCategory, IsInt, ReturnTrue );

##
KeyDependentOperation( "GradeFiltrationNthNaturalTransformationComponent",
                       IsAdelmanCategoryObject, IsInt, ReturnTrue );

##
KeyDependentOperation( "GradeFiltrationNthMonomorphism",
                       IsFreydCategoryObject, IsInt, ReturnTrue );
