# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Implementations
#

##
InstallMethod( DummyCategory,
        "for a record of options",
        [ IsRecord ],
        
  function( options )
    local category_constructor_options, dummy_function, C;
    
    category_constructor_options := ShallowCopy( options );
    category_constructor_options.category_filter := IsDummyCategory;
    category_constructor_options.category_object_filter := IsDummyCategoryObject;
    category_constructor_options.category_morphism_filter := IsDummyCategoryMorphism;
    category_constructor_options.supports_empty_limits := true;
    
    dummy_function := { operation_name, dummy } -> """
        function( input_arguments... )
            
            Error( "this is a dummy category without actual implementation" );
            
        end
    """;
    
    category_constructor_options.create_func_bool := dummy_function;
    category_constructor_options.create_func_object := dummy_function;
    category_constructor_options.create_func_object_or_fail := dummy_function;
    category_constructor_options.create_func_morphism := dummy_function;
    category_constructor_options.create_func_morphism_or_fail := dummy_function;
    
    C := CategoryConstructor( category_constructor_options );
    
    Finalize( C );
    
    return C;
    
end );
