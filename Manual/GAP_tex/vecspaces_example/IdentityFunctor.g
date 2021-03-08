## gapcolor ##
gap> id_functor := CapFunctor( "Identity of SQVec", SQVec, SQVec );
Identity of SQVec
gap> AddObjectFunction( id_functor, IdFunc );
gap> AddMorphismFunction( id_functor,
>   function( obj1, mor, obj2 ) return mor; end );
## endgapcolor ##