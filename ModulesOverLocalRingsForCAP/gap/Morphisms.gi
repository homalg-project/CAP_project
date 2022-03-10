# SPDX-License-Identifier: GPL-2.0-or-later
# ModulesOverLocalRingsForCAP: Category of modules over a local ring modeled by Serre quotients for CAP
#
# Implementations
#

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
