#############################################################################
##
##                                               CAP package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#############################################################################

InstallValue( CATEGORIES_LOGIC_FILES,
              
  rec(
      
      Propositions := rec(
          General := [
                       Filename( DirectoriesPackageLibrary( "CAP", "LogicForCategories" ), "PropositionsForGeneralCategories.tex" )
                     ],
          IsEnrichedOverCommutativeRegularSemigroup := [
                                                         Filename( DirectoriesPackageLibrary( "CAP", "LogicForCategories" ), "PropositionsForCategoriesEnrichedOverCommutativeRegularSemigroups.tex" )
                                                       ],
          IsAbCategory := [
                            Filename( DirectoriesPackageLibrary( "CAP", "LogicForCategories" ), "PropositionsForAbCategories.tex" )
                          ],
          IsAdditiveCategory := [
                                  Filename( DirectoriesPackageLibrary( "CAP", "LogicForCategories" ), "PropositionsForAdditiveCategories.tex" )
                                ],
          IsPreAbelianCategory := [
                                    Filename( DirectoriesPackageLibrary( "CAP", "LogicForCategories" ), "PropositionsForPreabelianCategories.tex" )
                                  ],
          IsAbelianCategory := [
#                                  Filename( DirectoriesPackageLibrary( "CAP", "LogicForCategories" ), "PropositionsForAbelianCategories.tex" )
                               ] ),
      Predicates := rec(
          General := [
                       Filename( DirectoriesPackageLibrary( "CAP", "LogicForCategories" ), "PredicateImplicationsForGeneralCategories.tex" )
                     ],
          IsEnrichedOverCommutativeRegularSemigroup := [
                                                         Filename( DirectoriesPackageLibrary( "CAP", "LogicForCategories" ), "PredicateImplicationsForCategoriesEnrichedOverCommutativeRegularSemigroups.tex" )
                                                       ],
          IsAbCategory := [
                            Filename( DirectoriesPackageLibrary( "CAP", "LogicForCategories" ), "PredicateImplicationsForAbCategories.tex" )
                          ],
          IsAdditiveCategory := [
                                  Filename( DirectoriesPackageLibrary( "CAP", "LogicForCategories" ), "PredicateImplicationsForAdditiveCategories.tex" )
                                ],
          IsPreAbelianCategory := [
                                    Filename( DirectoriesPackageLibrary( "CAP", "LogicForCategories" ), "PredicateImplicationsForPreabelianCategories.tex" )
                                  ],
          IsAbelianCategory := [
                                 Filename( DirectoriesPackageLibrary( "CAP", "LogicForCategories" ), "PredicateImplicationsForAbelianCategories.tex" )
                               ] ),
      EvalRules := rec(
          General := [
                      Filename( DirectoriesPackageLibrary( "CAP", "LogicForCategories" ), "RelationsForGeneralCategories.tex" )
                     ],
          IsEnrichedOverCommutativeRegularSemigroup := [
                                                        Filename( DirectoriesPackageLibrary( "CAP", "LogicForCategories" ), "RelationsForCategoriesEnrichedOverCommutativeRegularSemigroups.tex" )
                                                       ],
          IsAbCategory := [
                           Filename( DirectoriesPackageLibrary( "CAP", "LogicForCategories" ), "RelationsForAbCategories.tex" )
                          ],
          IsAdditiveCategory := [
                                Filename( DirectoriesPackageLibrary( "CAP", "LogicForCategories" ), "RelationsForAdditiveCategories.tex" )
                                ],
          IsPreAbelianCategory := [
                                   Filename( DirectoriesPackageLibrary( "CAP", "LogicForCategories" ), "RelationsForPreabelianCategories.tex" )
                                  ],
          IsAbelianCategory := [
                                Filename( DirectoriesPackageLibrary( "CAP", "LogicForCategories" ), "RelationsForAbelianCategories.tex" )
                               ] ),
     ) );
