#############################################################################
##
##                                       ModulesOverLocalRingsForCAP
##
##  Copyright 2017, Sebastian Posur, University of Siegen
##
#############################################################################


InstallMethod( CategoryOfLeftModulePresentationsOverLocalRing,
               [ IsHomalgRing, IsList ],
               
  function( ring, prime_ideal_generators )
    local prime_ideal_matrix, membership_function, ideal_string;
    
    prime_ideal_matrix :=
      HomalgMatrix( [ prime_ideal_generators ], Size( prime_ideal_generators ), 1, ring );
    
    membership_function := function( module_presentation )
        local annihilator;
        
        annihilator := Annihilator( module_presentation );
        
        return not IsZero( DecideZeroRows( UnderlyingMatrix( annihilator ), prime_ideal_matrix ) );
        
    end;
    
    ideal_string := String( prime_ideal_generators );
    
    RemoveCharacters( ideal_string, "\"" );
    
    return SerreQuotientCategoryByCospans( LeftPresentations( ring ), membership_function,
    Concatenation( "presentations not supported in ", ideal_string ) );
    
end );

