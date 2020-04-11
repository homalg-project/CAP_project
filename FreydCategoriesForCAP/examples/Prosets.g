LoadPackage("Freyd");

K := [ [1, 1, 1], [0, 1, 1], [0, 1, 1] ];
L := [ [1, 1, 0], [0, 1, 1], [0, 0, 1] ];


P_K := ProSetAsCategory(K);


#ProSetAsCategory(L);

a := ProSetAsCategoryObject(1, P_K);
b := ProSetAsCategoryObject(2, P_K);
c := ProSetAsCategoryObject(3, P_K);

d := ProSetAsCategoryObject(4, P_K);

delta := ProSetAsCategoryMorphism(b, a);

IsWellDefined(a);
IsWellDefined(d);
IsWellDefined(delta);

alpha := ProSetAsCategoryMorphism(a, b);
beta := ProSetAsCategoryMorphism(b, c);
gamma := ProSetAsCategoryMorphism(a, c);

gamma = PreCompose(alpha, beta);

id_a := IdentityMorphism(a);

IsWellDefined(Inverse(alpha));

PreCompose(beta, Inverse(beta)) = IdentityMorphism(b);

alpha = Lift(gamma, beta);
fail = Lift(beta, gamma);

Colift(alpha, gamma) = beta;


alpha = HomStructure(a, b, HomStructure(alpha));
