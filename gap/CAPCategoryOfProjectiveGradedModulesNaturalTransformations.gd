#############################################################################
##
##                  CAPCategoryOfProjectiveGradedModules package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##                  Martin Bies,       ITP Heidelberg
##
#! @Chapter Natural transformations
##
#############################################################################


####################################################################################
##
#! @Section Natural transformation from truncation functor to identity functor
##
####################################################################################

# a function that computes the natural transformation |_C => id for both
# left and right presentations
DeclareGlobalFunction( "NaturalTransformationFromTruncationToIdentity" );

#! @Description
#! The argument is a homalg graded ring $S$ and a cone $C$ in the degree group of $S$. 
#! The output is the natural transformation from the left truncation functor (to $C$) to the
#! identity functor.
#! @Returns a natural transformation $\left. \cdot \right|_C \Rightarrow \mathrm{id}$
#! @Arguments S
DeclareOperation( "NaturalTransformationFromTruncationToIdentityLeft",
                  [ IsHomalgGradedRing, IsList ] );

#! @Description
#! The argument is a homalg graded ring $S$ and a cone $C$ in the degree group of $S$. 
#! The output is the natural transformation from the right truncation functor (to $C$) to the
#! identity functor.
#! @Returns a natural transformation $\left. \cdot \right|_C \Rightarrow \mathrm{id}$
#! @Arguments S
DeclareOperation( "NaturalTransformationFromTruncationToIdentityRight",
                  [ IsHomalgGradedRing, IsList ] );
