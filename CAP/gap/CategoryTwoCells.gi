#############################################################################
##
##                                               CAP package
##
##  Copyright 2014, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#############################################################################

DeclareRepresentation( "IsCapCategoryTwoCellRep",
                       IsAttributeStoringRep and IsCapCategoryTwoCell,
                       [ ] );

BindGlobal( "TheFamilyOfCapCategoryTwoCells",
        NewFamily( "TheFamilyOfCapCategoryTwoCells" ) );

BindGlobal( "TheTypeOfCapCategoryTwoCells",
        NewType( TheFamilyOfCapCategoryTwoCells,
                IsCapCategoryTwoCellRep ) );

####################################
##
## Add function
##
####################################

##
InstallGlobalFunction( INSTALL_TODO_LIST_ENTRIES_FOR_TWOCELL,

  function( category, twocell )
    local entry;
    
#     entry := ToDoListEntryToMaintainFollowingAttributes( [ [ twocell, "CapCategory" ] ],
#                                                          [ category, twocell ],
#                                                          CAP_INTERNAL_CAN_COMPUTE_FILTER_LIST
#                                                           );
#     
#     AddToToDoList( entry );
    
    if IsBound( category!.PROPAGATE_FILTERS_FROM_CATEGORY_TO_TWOCELL ) then
        
        entry := ToDoListEntryToMaintainFollowingAttributes( [ [ twocell, "CapCategory" ] ],
                                                             [ category, twocell ],
                                                             category!.PROPAGATE_FILTERS_FROM_CATEGORY_TO_TWOCELL
                                                              );
        
        AddToToDoList( entry );
        
    fi;
    
end );

##
InstallMethod( Add,
               [ IsCapCategory, IsCapCategoryTwoCell ],
               
  function( category, twocell )
    local obj_filter, filter;
    
    if HasCapCategory( twocell ) then
        
        if IsIdenticalObj( CapCategory( twocell ), category ) then
            
            return;
            
        else
            
            Error( "this 2-cell already has a category" );
            
        fi;
        
    fi;
    
    Add( category, Source( twocell ) );
    
    Add( category, Range( twocell ) );
    
    filter := TwoCellFilter( category );
    
    SetFilterObj( twocell, filter );
    
    SetCapCategory( twocell, category );

    INSTALL_TODO_LIST_ENTRIES_FOR_TWOCELL( category, twocell );
    
end );

##
InstallMethod( AddForTwoCells,
               [ IsCapCategory, IsObject ],
               
  function( category, twocell )
    
    SetFilterObj( twocell, IsCapCategoryTwoCell );
    
    Add( category, twocell );
    
end );

###########################
##
## IsWellDefined
##
###########################

##
InstallMethod( AddIsWellDefinedForTwoCells,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    AddIsWellDefinedForTwoCells( category, func, 100 );
    
end );

##
InstallMethod( AddIsWellDefinedForTwoCells,
               [ IsCapCategory, IsFunction, IsInt ],
               
  function( category, func, weight )
    
    SetCanComputeIsWellDefinedForTwoCells( category, true );
    
    SetIsWellDefinedForTwoCellsFunction( category, func );
    
    InstallMethod( IsWellDefined,
                   [ IsCapCategoryTwoCell and TwoCellFilter( category ) ],
                   
      function( twocell )
        
        if not( IsWellDefined( Source( twocell ) ) and IsWellDefined( Range( twocell ) ) ) then
          
          return false;
          
        fi;
        
        return func( twocell );
        
    end );
    
    AddPrimitiveOperation( category!.derivations_weight_list, "IsWellDefinedForTwoCells", weight );
    
end );

##
InstallMethod( IsWellDefinedForTwoCells,
               [ IsCapCategoryTwoCell ],
               
  IsWellDefined
);

