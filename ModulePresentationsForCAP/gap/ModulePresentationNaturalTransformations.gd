#############################################################################
##
##                                       ModulePresentationsForCAP package
##
##  Copyright 2014, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @Chapter Module Presentations
##
#############################################################################

#######################################
##
#! @Section Natural Transformations
##
#######################################

#! @Description
#! The argument is a homalg ring $R$.
#! The output is the natural morphism from the identity functor
#! to the left standard module functor.
#! @Returns a natural transformation $\mathrm{Id} \rightarrow \mathrm{StandardModuleLeft}$
#! @Arguments R
DeclareAttribute( "NaturalIsomorphismFromIdentityToStandardModuleLeft",
                  IsHomalgRing );

#! @Description
#! The argument is a homalg ring $R$.
#! The output is the natural morphism from the identity functor
#! to the right standard module functor.
#! @Returns a natural transformation $\mathrm{Id} \rightarrow \mathrm{StandardModuleRight}$
#! @Arguments R
DeclareAttribute( "NaturalIsomorphismFromIdentityToStandardModuleRight",
                  IsHomalgRing );
