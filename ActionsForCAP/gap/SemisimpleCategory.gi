############################################################################
##
##                                ActionsForCAP package
##
##  Copyright 2016, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @Chapter Semisimple Categories
##
#############################################################################

####################################
##
## Installation method
##
####################################

InstallGlobalFunction( CAP_INTERNAL_INSTALL_OPERATIONS_FOR_SEMISIMPLE_CATEGORY,
  function( semisimple_category )

end );



####################################
##
## Constructors
##
####################################

##
InstallMethod( SemisimpleCategory,
               [ IsFieldForHomalg, IsFunction, IsFunction, IsFunction ],
               
  function( homalg_field, membership_function, lower_equal_function, equality_function )
    local name;
    
    name := NameFunction( membership_function );
    
    return SemisimpleCategory( 
             homalg_field, membership_function, lower_equal_function, equality_function, Concatenation( "membership function ", name ) );
    
end );

##
InstallMethod( SemisimpleCategory,
               [ IsFieldForHomalg, IsFunction, IsFunction, IsFunction, IsString ],
               
  function( homalg_field, membership_function, lower_equal_function, equality_function, membership_function_name )
    local name, semisimple_category, underlying_category;
    
    underlying_category := MatrixCategory( homalg_field );
    
    name := Name( underlying_category );
    
    name := Concatenation( "The semisimple category with irreducibles given by ", membership_function_name, 
                           ", with underlying category: ", name );
    
    semisimple_category := CreateCapCategory( name );
    
    SetUnderlyingCategoryForSemisimpleCategory( semisimple_category, underlying_category );
    
    SetMembershipFunctionForSemisimpleCategory( semisimple_category, membership_function );
    
    SetLowerEqualFunctionForSemisimpleCategory( semisimple_category, lower_equal_function );
    
    SetEqualityFunctionForSemisimpleCategory( semisimple_category, equality_function );
    
    CAP_INTERNAL_INSTALL_OPERATIONS_FOR_SEMISIMPLE_CATEGORY( semisimple_category );
    
    Finalize( semisimple_category );
    
    return semisimple_category;
    
end );

