# SPDX-License-Identifier: GPL-2.0-or-later
# LinearAlgebraForCAP: Category of Matrices over a Field for CAP
#
# Implementations
#
BindGlobal( "MatrixCategoryPrecompiled", function ( field )
  local category_constructor, cat;
    
    category_constructor := 
        
        
        function ( field )
    return MATRIX_CATEGORY( field );
end;
        
        
    
    cat := category_constructor( field : FinalizeCategory := false );
    
    ##
    AddAdditionForMorphisms( cat,
        
        
        function ( cat, morphism_1, morphism_2 )
    return ObjectifyWithAttributes( rec(
           ), MorphismType( cat ), CapCategory, cat, Source, Source( morphism_1 ), Range, Range( morphism_2 ), UnderlyingFieldForHomalg, UnderlyingRing( cat ), UnderlyingMatrix, UnderlyingMatrix( morphism_1 ) + UnderlyingMatrix( morphism_2 ) );
end
        
        
    );
    
    ##
    AddPreCompose( cat,
        
        
        function ( cat, morphism_1, morphism_2 )
    return ObjectifyWithAttributes( rec(
           ), MorphismType( cat ), CapCategory, cat, Source, Source( morphism_1 ), Range, Range( morphism_2 ), UnderlyingFieldForHomalg, UnderlyingRing( cat ), UnderlyingMatrix, UnderlyingMatrix( morphism_1 ) * UnderlyingMatrix( morphism_2 ) );
end
        
        
    );
    
    ##
    AddKernelEmbedding( cat,
        
        
        function ( cat, morphism )
    local cap_jit_morphism_attribute;
    cap_jit_morphism_attribute := SyzygiesOfRows( UnderlyingMatrix( morphism ) );
    return ObjectifyWithAttributes( rec(
           ), MorphismType( cat ), CapCategory, cat, Source, ObjectifyWithAttributes( rec(
             ), ObjectType( cat ), CapCategory, cat, Dimension, NrRows( cap_jit_morphism_attribute ), UnderlyingFieldForHomalg, UnderlyingRing( cat ) ), Range, Source( morphism ), UnderlyingFieldForHomalg, UnderlyingRing( cat ), UnderlyingMatrix, cap_jit_morphism_attribute );
end
        
        
    );
    
    Finalize( cat );
    
    return cat;
    
end );
