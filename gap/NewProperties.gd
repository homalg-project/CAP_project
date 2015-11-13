#############################################################################
##
##                  CAPCategoryOfProjectiveGradedModules package
##
##  Copyright 2015, Martin Bies,       ITP Heidelberg
##
#! @Chapter Additional properties of Proj-categories
##
#############################################################################

############################################
##
#! @Section New properties of Cap_categories
##
############################################

#! @Description
#! The argument is a CAP category $C$. Be $a \in C$ an object and $C$ an additive category. 
#! Then one can consider the direct sum of $a$ and the zero object $0$ in 
#! $C$. Given that $a \oplus 0$ is identically the same object as $a$ (i.e. not merely isomorphic) this property is true, 
#! otherwise it is false. For the category of projective graded left and right modules, this property is true.
#! @Returns true or false
#! @Arguments C
DeclareProperty( "IsAdditionWithZeroObjectIdenticalObject",
                  IsCapCategory );

#! @Description
#! Presentation categories can only be constructed over categories that are additive, have weak kernels,
#! weak lifts and admit a monoidal structure. This method checks if a given CapCategory $C$ satisfies these requirements.
#!  It returns true if this is the case and false otherwise.
#! @Returns true or false
#! @Arguments C
DeclareProperty( "IsProjCategory",
                 IsCapCategory );
