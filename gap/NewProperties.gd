#############################################################################
##
##                  CAPCategoryOfProjectiveGradedModules package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##                  Martin Bies,       ITP Heidelberg
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
#! The argument is a CAP category $C$. Be $a \in C$ an object. Then one can consider the direct sum of $a$ and the zero object $0$ in 
#! $C$. Given that $a \oplus 0$ is identically the same object as $a$ (i.e. not merely isomorphic) this attribute is true, otherwise
#! it is false. For the category of projective graded left and right modules, this attribute is true.
#! @Returns true or false
#! @Arguments C
DeclareProperty( "IsAdditionWithZeroObjectIdenticalObject",
                  IsCapCategory );

#! @Description
#! The presentation categories build in this package can only be constructed over categories that are additive, have weak kernels,
#! weak lifts, a monoidal structure and are such that the direct sum with the zero object is identical to the original object
#! (and not merely isomorphic). This method checks if a given CapCategory $C$ satisfies these requirements.
#!  It returns true if this is the case and false otherwise.
#! @Returns true or false
#! @Arguments C
DeclareProperty( "IsProjCategory",
                 IsCapCategory );
