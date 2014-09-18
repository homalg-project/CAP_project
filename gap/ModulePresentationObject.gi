#############################################################################
##
##                                       ModulePresentationsForHomalg package
##
##  Copyright 2014, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#############################################################################

DeclareRepresentation( "IsLeftPresentationRep",
                       IsLeftPresentation and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfLeftPresentations",
            NewFamily( "TheFamilyOfLeftPresentations" ) );

BindGlobal( "TheTypeOfLeftPresentations",
            NewType( TheFamilyOfLeftPresentations,
                     IsLeftPresentationRep ) );


DeclareRepresentation( "IsRightPresentationRep",
                       IsRightPresentation and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfRightPresentations",
            NewFamily( "TheFamilyOfRightPresentations" ) );

BindGlobal( "TheTypeOfRightPresentations",
            NewType( TheFamilyOfRightPresentations,
                     IsRightPresentationRep ) );



