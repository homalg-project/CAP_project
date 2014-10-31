#############################################################################
##
##                                               CategoriesForHomalg package
##
##  Copyright 2014, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#############################################################################

InstallGlobalFunction( PARSE_THEOREM_FROM_LATEX,
                       
  function( theorem_string )
    local variable_part, source_part, range_part;
    
    variable_part := PosititionSublist( theorem_string, "~|~" );
    
    if variable_part = fail then
        
        Error( "No declaration part found" );
        
    fi;
    
    

