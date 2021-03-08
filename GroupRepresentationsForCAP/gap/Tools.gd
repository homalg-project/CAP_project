# SPDX-License-Identifier: GPL-2.0-or-later
# GroupRepresentationsForCAP: Skeletal category of group representations for CAP
#
# Declarations
#
#! @Chapter Tools

##
DeclareAttribute( "MultiplicityArray", IsGroup );

##
DeclareAttribute( "MultiplicityTripleArray", IsGroup );

#! @Section Helper functions

#! @Description
#! The argument is a list <A>L</A> defining an object `c` in a semisimple category.
#! The output is a LaTeX string (without enclosing dollar signs) that may be used to print out `c` nicely.
#! @Returns a string
#! @Arguments L
DeclareGlobalFunction( "LaTeXStringOfSemisimpleCategoryObjectList" );
