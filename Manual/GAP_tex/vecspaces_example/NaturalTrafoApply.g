## gapcolor ##
gap> ApplyNaturalTransformation( double_swap_components, V2 );
A morphism in SQVec with underlying matrix:
[ [  0,  0,  1,  0 ],
  [  0,  0,  0,  1 ],
  [  1,  0,  0,  0 ],
  [  0,  1,  0,  0 ] ]

gap> h_composition :=
>   HorizontalPreCompose( double_swap_components, double_swap_components );
Vertical composition of Horizontal composition of natural transformation double swap components and functor DoubleOfVecspaces and Horizontal compositio\
n of functor DoubleOfVecspaces and natural transformation double swap components
gap> ApplyNaturalTransformation( h_composition, V2 );
A morphism in SQVec with underlying matrix:
[ [  0,  0,  0,  0,  0,  0,  1,  0 ],
  [  0,  0,  0,  0,  0,  0,  0,  1 ],
  [  0,  0,  0,  0,  1,  0,  0,  0 ],
  [  0,  0,  0,  0,  0,  1,  0,  0 ],
  [  0,  0,  1,  0,  0,  0,  0,  0 ],
  [  0,  0,  0,  1,  0,  0,  0,  0 ],
  [  1,  0,  0,  0,  0,  0,  0,  0 ],
  [  0,  1,  0,  0,  0,  0,  0,  0 ] ]

gap> v_composition :=
>   VerticalPreCompose( double_swap_components, double_swap_components );
Vertical composition of double swap components and double swap components
gap> ApplyNaturalTransformation( v_composition, V2 );
A morphism in SQVec with underlying matrix:
[ [  1,  0,  0,  0 ],
  [  0,  1,  0,  0 ],
  [  0,  0,  1,  0 ],
  [  0,  0,  0,  1 ] ]

## endgapcolor ##