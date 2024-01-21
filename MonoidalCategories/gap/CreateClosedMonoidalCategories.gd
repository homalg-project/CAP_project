# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Declarations
#

####################################
##
#! @Chapter Code Generation for Monodial Categories
##
#! @Section Closed Monoidal Categories
##
####################################

DeclareGlobalFunction( "CAP_INTERNAL_FUNC_FOR_CLOSED_MONOIDAL_STRUCTURES" );

#! @Description
#!  This functions uses the dictionary <A>key_val_rec</A> to create a new closed monoidal structure.
#!  It generates the necessary files in the package <A>package_name</A> using
#!  the file-correspondence table <A>files_rec</A>.
#!  See the implementation for details.
#! @Returns nothing
#! @Arguments key_val_rec, package_name, files_rec
DeclareGlobalFunction( "WriteFileForClosedMonoidalStructure" );
