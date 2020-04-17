LoadPackage("Freyd");

#! @Example
K := [ [1, 1, 1], [0, 1, 1], [0, 1, 1] ];;
L := [ [1, 1, 0], [0, 1, 1], [0, 0, 1] ];;


P_K := ProSetAsCategory(K);;


#ProSetAsCategory(L);

a := ProSetAsCategoryObject(1, P_K);;
b := ProSetAsCategoryObject(2, P_K);;
c := ProSetAsCategoryObject(3, P_K);;

d := ProSetAsCategoryObject(4, P_K);;

delta := ProSetAsCategoryMorphism(b, a);;

IsWellDefined(a);
#! true
IsWellDefined(d);
#! false
IsWellDefined(delta);
#! false

alpha := ProSetAsCategoryMorphism(a, b);;
beta := ProSetAsCategoryMorphism(b, c);;
gamma := ProSetAsCategoryMorphism(a, c);;

gamma = PreCompose(alpha, beta);
#! true
id_a := IdentityMorphism(a);;
IsWellDefined(Inverse(alpha));
#! false
PreCompose(beta, Inverse(beta)) = IdentityMorphism(b);
#! true
alpha = Lift(gamma, beta);
#! true
fail = Lift(beta, gamma);
#! true
Colift(alpha, gamma) = beta;
#! true
alpha = HomStructure(a, b, HomStructure(alpha));
#!true
#! @EndExample
