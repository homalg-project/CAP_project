LoadPackage( "CAP" );
LoadPackage( "CAP" );
grps := CreateCapCategory( "groups" );
AddPreCompose( grps, \* );
identity_func := grp -> GroupHomomorphismByImages( grp, grp );
AddIdentityMorphism( grps, identity_func );
Finalize( grps );