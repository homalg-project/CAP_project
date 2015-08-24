## gapcolor ##
gap> id_functor := CapFunctor( "Identity of vecspaces", vecspaces, vecspaces );
Identity of vecspaces
gap> AddObjectFunction( id_functor, IdFunc );
gap> AddMorphismFunction( id_functor, function( obj1, mor, obj2 )
> return mor; end );
## endgapcolor ##