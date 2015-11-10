########################################
##
#! Check for being a projective category
##
########################################

InstallMethod( IsProjCategory,
               " for CAP categories",
               [ IsCapCategory ],
               
  function( category )
    local weight_list, list_of_methods, can_compute, current_weight, i;

    # extract the weight list of the given category
    weight_list := category!.derivations_weight_list;

    # list all methods available in CAP
    list_of_methods := Operations( CAP_INTERNAL_DERIVATION_GRAPH );    
    list_of_methods := AsSortedList( list_of_methods );
    
    # initialise variables
    can_compute := [ ];
    
    # work out which methods the given category can compute
    for i in list_of_methods do
        
        current_weight := CurrentOperationWeight( weight_list, i );
        
        if current_weight < infinity then
            Add( can_compute, i );
        fi;
        
    od;

    # now we can check if the given category is a proj category, to this end recall that (by definition) a proj
    # category has the following properties
    # (1) it is an additive category
    # (2) it has (weak) lifts
    # (3) it has (weak) kernels
    # (4) is RigidSymmetricClosedMonoidalCategory
    
    # FIX ME FIX ME
    # AdditionWithZeroObjectIsIdenticalObject needed?
    # StrictMonoidalCategory needed?
    # How to improve presentation category in this case?
    
    # thus let us check this
    if not IsAdditiveCategory( category ) then
    
      return false;

    elif Position( can_compute, "Lift" ) = fail then
    
      return false;
      
    elif Position( can_compute, "KernelEmbedding" ) = fail then
    
      return false;
    
    elif not IsRigidSymmetricClosedMonoidalCategory( category ) then
    
      return false;
      
    else 
    
      return true;
      
    fi;
    
end );