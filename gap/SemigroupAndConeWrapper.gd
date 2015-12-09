####################################################################################
##
##                  CAPCategoryOfProjectiveGradedModules package
##
##  Copyright 2015, Martin Bies,       ITP Heidelberg
##
#! @Chapter Wrapper for generators of semigroups and hyperplane constraints of cones
##
####################################################################################

############################################
##
#! @Section GAP Categories
##
############################################

#! @Description
#! The GAP category of lists of integer-valued lists, which encode subsemigroups of $Z^n$.
#! @Arguments object
DeclareCategory( "IsSemigroupGeneratorList",
                 IsObject );

#! @Description
#! The GAP category of lists of integer-valued lists, which encode H-presentations of cones in $Z^n$.
#! @Arguments object
DeclareCategory( "IsConeHPresentationList",
                 IsObject );

#! @Description
#! The GAP category of lists of integer-valued lists, which encode V-presentations of cones in $Z^n$.
#! @Arguments object
DeclareCategory( "IsConeVPresentationList",
                 IsObject );

#! @Description
#! The GAP category of affine semigroups $H$ in $\mathbb{Z}^n$. That means that there is a semigroup 
#! $G \subseteq \mathbb{Z}^n$ and $p \in \mathbb{Z}^n$ such that $H = p + G$.
#! @Arguments object
DeclareCategory( "IsAffineSemigroup",
                 IsObject );

#! @Description
#! The GAP category of affine semigroups $H$ of cones in $\mathbb{Z}^n$. This means that there is a cone
#! $C subseteq \mathbb{Z}^n$ and $p \in \mathbb{Z}^n$ such that $H = p + \left( C \cap \mathbb{Z}^n \right)$.
#! @Arguments object
DeclareCategory( "IsAffineConeSemigroup",
                 IsAffineSemigroup );

# affine cone semigroup always implies affine semigroup
InstallTrueMethod( IsAffineSemigroup, IsAffineConeSemigroup );


############################################
##
#! @Section Constructors
##
############################################

#! @Description
#! The argument is a list $L$. We then check if this list could be the list of generators of a subsemigroup of $Z^n$.
#! If so, we create the corresponding SemigroupGeneratorList.
#! @Returns a SemigroupGeneratorList
#! @Arguments L
DeclareOperation( "SemigroupGeneratorList",
                  [ IsList ] );

#! @Description
#! The argument is a list $L$. We then check if this list could be the list of hyperplane constraints of a cone in $Z^n$.
#! If so, we create the corresponding ConeHPresentationList.
#! @Returns a ConeHPresentationList
#! @Arguments L
DeclareOperation( "ConeHPresentationList",
                  [ IsList ] );

#! @Description
#! The argument is an NmzCone $C$. We then try to compute an H-presentation of $C$. In case this was successfully 
#! done, we construct the corresponding ConeHPresentationList.
#! @Returns a ConeHPresentationList
#! @Arguments C
DeclareOperation( "ConeHPresentationList",
                  [ IsNormalizCone ] );

#! @Description
#! The argument is a list $L$. We then check if this list could be the list of (ray) generators of a cone in $Z^n$.
#! If so, we create the corresponding ConeVPresentationList.
#! @Returns a ConeVPresentationList
#! @Arguments L
DeclareOperation( "ConeVPresentationList",
                  [ IsList ] );

#! @Description
#! The argument is an NmzCone $C$. We then try to compute a V-presentation of $C$. In case this was done successfully,
#! we construct the corresponding ConeVPresentationList.
#! @Returns a ConeVPresentationList
#! @Arguments C
DeclareOperation( "ConeVPresentationList",
                  [ IsNormalizCone ] );

#! @Description
#! The argument is an NmzCone $C$ and a point $p \in \mathbb{Z}^n$ encoded as list of integers. 
#! We then compute the semigroup of the affine cone $p + C$.
#! @Returns an AffineConeSemigroup
#! @Arguments C, p
DeclareOperation( "AffineConeSemigroup",
                  [ IsNormalizCone, IsList ] );

#! @Description
#! The argument is a ConeVPresentationList $L$ and a point $p \in \mathbb{Z}^n$ encoded as list of integers. 
#! We then compute the semigroup of the affine cone $p + C$, where $C$ is the cone encoded by $L$.
#! @Returns an AffineConeSemigroup
#! @Arguments C, p
DeclareOperation( "AffineConeSemigroup",
                  [ IsConeVPresentationList, IsList ] );

#! @Description
#! The argument is a ConeHPresentationList $L$ and a point $p \in \mathbb{Z}^n$ encoded as list of integers. 
#! We then compute the semigroup of the affine cone $p + C$, where $C$ is the cone encoded by $L$.
#! @Returns an AffineConeSemigroup
#! @Arguments L, p
DeclareOperation( "AffineConeSemigroup",
                  [ IsConeHPresentationList, IsList ] );

#! @Description
#! The argument is a ConeHPresentationList $L$ and a point $p \in \mathbb{Z}^n$ encoded as list of integers. 
#! We then compute the semigroup of the affine cone $p + C$, where $C$ is the cone encoded by $L$.
#! @Returns an AffineConeSemigroup
#! @Arguments L, p
DeclareOperation( "AffineSemigroup",
                  [ IsSemigroupGeneratorList, IsList ] );



############################################
##
#! @Section Attributes
##
############################################

#! @Description
#! The argument is a SemigroupGeneratorList $L$. We then return the embedding dimension of this semigroup.
#! @Arguments L
DeclareAttribute( "EmbeddingDimension",
                  IsSemigroupGeneratorList );

#! @Description
#! The argument is a SemigroupGeneratorList $L$. We then return the underlying list.
#! @Returns a list
#! @Arguments L
DeclareAttribute( "UnderlyingList",
                  IsSemigroupGeneratorList );

#! @Description
#! The argument is a ConeHPresentationList $L$. We then return the underlying list.
#! @Returns a list
#! @Arguments L
DeclareAttribute( "UnderlyingList",
                  IsConeHPresentationList );

#! @Description
#! The argument is a ConeHPresentationList $L$. We then return the embedding dimension of this cone.
#! @Arguments L
DeclareAttribute( "EmbeddingDimension",
                  IsConeHPresentationList );

#! @Description
#! The argument is a ConeVPresentationList $L$. We then return the underlying list.
#! @Returns a list
#! @Arguments L
DeclareAttribute( "UnderlyingList",
                  IsConeVPresentationList );

#! @Description
#! The argument is a ConeVPresentationList $L$. We then return the embedding dimension of this cone.
#! @Arguments L
DeclareAttribute( "EmbeddingDimension",
                  IsConeVPresentationList );

#! @Description
#! The argument is a SemigroupGeneratorList $L$. We try to convert $L$ into a ConeHPresentationList. If this
#! succeeds, the result will be a ConeHPresentationList. If the conversion is not possible
#! (because the given semigroup is not the semigroup of a cone or because Normaliz cannot perform the conversion), 
#! the result will be fail.
#! @Returns AConeHPresentationList or fail
#! @Arguments L
DeclareAttribute( "TurnIntoConeHPresentationList",
                  IsSemigroupGeneratorList );

#! @Description
#! The argument is a SemigroupGeneratorList $L$. We try to convert $L$ into a ConeVPresentationList. If this
#! succeeds, the result will be a ConeVPresentationList. If the conversion is not possible because the given semigroup 
#! is not the semigroup of a cone, the result will be fail.
#! @Returns AConeVPresentationList or fail
#! @Arguments L
DeclareAttribute( "TurnIntoConeVPresentationList",
                  IsSemigroupGeneratorList );

#! @Description
#! The argument is an AffineConeSemigroup $S$. We then return the underlying cone.
#! @Returns an NmzCone
#! @Arguments S
DeclareAttribute( "UnderlyingCone",
                  IsAffineConeSemigroup );

#! @Description
#! The argument is an AffineConeSemigroup $S$. This one is given as $S = p + \left( C \cap \mathbb{Z}^n \right)$ for a 
#! point $p \in \mathbb{Z}^n$ and a cone $C \subseteq \mathbb{Z}^n$. We then return the offset $p$.
#! @Returns a list of integers
#! @Arguments S
DeclareAttribute( "Offset",
                  IsAffineConeSemigroup );

#! @Description
#! The argument is an AffineConeSemigroup $S$. We then return the ConeHPresentationList of the underlying cone.
#! @Returns a ConeHPresentationList
#! @Arguments S
DeclareAttribute( "UnderlyingConeHPresentationList",
                  IsAffineConeSemigroup );

#! @Description
#! The argument is an AffineConeSemigroup $S$. We then return the ConeVPresentationList of the underlying cone.
#! @Returns a ConeVPresentationList
#! @Arguments S
DeclareAttribute( "UnderlyingConeVPresentationList",
                  IsAffineConeSemigroup );

#! @Description
#! The argument is an AffineConeSemigroup $S$. We then return the embedding dimension of this affine cone semigroup.
#! @Returns an NmzCone
#! @Arguments S
DeclareAttribute( "EmbeddingDimension",
                  IsAffineConeSemigroup );

#! @Description
#! The argument is an AffineSemigroup $S$. This one is given as $S = p + H$ for a 
#! point $p \in \mathbb{Z}^n$ and a semigroup $H \subseteq \mathbb{Z}^n$. We then return the offset $p$.
#! @Returns a list of integers
#! @Arguments S
DeclareAttribute( "Offset",
                  IsAffineSemigroup );

#! @Description
#! The argument is an AffineSemigroup $S$. This one is given as $S = p + H$ for a 
#! point $p \in \mathbb{Z}^n$ and a semigroup $H \subseteq \mathbb{Z}^n$. We then return the SemigroupGeneratorList of $H$.
#! @Returns a SemigroupGeneratorList
#! @Arguments S
DeclareAttribute( "UnderlyingSemigroupGeneratorList",
                  IsAffineConeSemigroup );

#! @Description
#! The argument is an AffineSemigroup $S$. We then return the embedding dimension of this affine semigroup.
#! @Returns an NmzCone
#! @Arguments S
DeclareAttribute( "EmbeddingDimension",
                  IsAffineSemigroup );

#! @Description
#! The argument is a SemigroupGeneratorList $L$. We try to convert $L$ into a ConeVPresentationList. If this
#! succeeds, the result will be a ConeVPresentationList. If the conversion is not possible because the given semigroup 
#! is not the semigroup of a cone, the result will be fail.
#! @Returns AConeVPresentationList or fail
#! @Arguments L
DeclareAttribute( "TurnIntoAffineConeSemigroup",
                  IsAffineSemigroup );



############################################
##
#! @Section Property
##
############################################

#! @Description
#! The argument is a SemigroupGeneratorList $L$. We then check if this is the semigroup of a cone. In this case we 
#! return true, otherwise false.
#! @Returns true or false
#! @Arguments L
DeclareProperty( "IsSemigroupOfCone",
                  IsSemigroupGeneratorList );

#! @Description
#! The argument is a AffineSemigroup $H$. We then check if this is the semigroup of a cone, i.e. if $H$ is an
#! affine cone semigroup. In this case we return true, otherwise false.
#! @Returns true or false
#! @Arguments H
DeclareProperty( "IsAffineSemigroupOfCone",
                  IsAffineSemigroup );