# SPDX-License-Identifier: GPL-2.0-or-later
# Toposes: Elementary toposes
#

gap> LoadPackage( "FinSetsForCAP", false );
true
gap> Length( ListInstalledOperationsOfCategory( FinSets ) );
215
gap> BooleanAlgebras := Opposite( FinSets );
Opposite of FinSets
gap> Length( ListInstalledOperationsOfCategory( BooleanAlgebras ) );
192
gap> Opposite( BooleanAlgebras );
FinSets
gap> FS := Opposite( WrapperCategory( BooleanAlgebras, rec( ) ) );
Opposite of WrapperCategory( Opposite of FinSets )
gap> Length( ListInstalledOperationsOfCategory( FS ) );
192
