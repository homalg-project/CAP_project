# SPDX-License-Identifier: GPL-2.0-or-later
# Toposes: Elementary toposes
#

gap> LoadPackage( "FinSetsForCAP", false );
true
gap> Length( ListInstalledOperationsOfCategory( SkeletalFinSets ) );
252
gap> BooleanAlgebras := Opposite( SkeletalFinSets );
Opposite of SkeletalFinSets
gap> Length( ListInstalledOperationsOfCategory( BooleanAlgebras ) );
228
gap> Opposite( BooleanAlgebras );
SkeletalFinSets
gap> FS := Opposite( WrapperCategory( BooleanAlgebras, rec( ) ) );
Opposite of WrapperCategory( Opposite of SkeletalFinSets )
gap> Length( ListInstalledOperationsOfCategory( FS ) );
228
