# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Implementations
#
# backwards compatibility
BindGlobal( "IsCapCategoryTwoCellRep", IsCapCategoryTwoCell );

####################################
##
## Operations
##
####################################

InstallMethod( Target,
               [ IsCapCategoryTwoCell ],
               
  Range );

##
InstallMethod( Add,
               [ IsCapCategory, IsCapCategoryTwoCell ],
               
  function( category, twocell )
    local obj_filter, filter;
    
    filter := TwoCellFilter( category );
    
    if not filter( twocell ) then
        
        SetFilterObj( twocell, filter );
        
    fi;
    
    if HasCapCategory( twocell ) then
        
        if not IsIdenticalObj( CapCategory( twocell ), category ) then
            
            Error(
                Concatenation(
                    "a two cell that lies in the CAP-category with the name\n",
                    Name( CapCategory( twocell ) ),
                    "\n",
                    "was tried to be added to a different CAP-category with the name\n",
                    Name( category ), ".\n",
                    "(Please note that it is possible for different CAP-categories to have the same name)"
                )
            );
            
        fi;
        
    else
        
        SetCapCategory( twocell, category );
        
    fi;
    
    AddMorphism( category, Source( twocell ) );
    
    AddMorphism( category, Range( twocell ) );
    
end );

##
InstallMethod( AddTwoCell,
               [ IsCapCategory, IsObject ],
               
  function( category, twocell )
    
    SetFilterObj( twocell, IsCapCategoryTwoCell );
    
    Add( category, twocell );
    
end );

