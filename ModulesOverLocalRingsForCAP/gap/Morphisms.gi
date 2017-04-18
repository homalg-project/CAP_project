############################################################################
##
##                                       ModulesOverLocalRingsForCAP package
##
##  Copyright 2017, Sebastian Posur,  University of Siegen
##
#############################################################################

####################################
##
## Attributes
##
####################################

##
InstallMethod( StepOfMinimalFreeResolutionOfKernel,
               [ IsCategoryOfModulePresentationsOverLocalRingMorphism ], 
               
  function( morphism )
    local category, kernel_embedding, differential, cover;
    
    category := CapCategory( morphism );
    
    kernel_embedding := KernelEmbedding( morphism );
    
    differential := PreCompose( MinimalGeneratorsModel( Source( kernel_embedding ) ), kernel_embedding );
    
    cover := CoverByFreeModule( Source( differential ) );
    
    return PreCompose( cover, differential );
    
end );