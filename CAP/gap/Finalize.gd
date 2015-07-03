#############################################################################
##
##                                               CAP package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @Chapter Finalize
##
#############################################################################

DeclareGlobalVariable( "CAP_INTERNAL_FINAL_DERIVATION_LIST" );


DeclareOperation( "AddFinalDerivation",
                  [ IsFunction, IsDenseList, IsDenseList, IsDenseList ] );

DeclareOperation( "AddFinalDerivation",
                  [ IsFunction, IsDenseList, IsDenseList, IsFunction ] );

DeclareOperation( "AddFinalDerivation",
                  [ IsFunction, IsDenseList, IsDenseList ] );

DeclareOperation( "AddFinalDerivation",
                  [ IsFunction, IsDenseList, IsFunction ] );


DeclareProperty( "IsFinalized",
                  IsCapCategory );

DeclareOperation( "Finalize",
                  [ IsCapCategory ] );

