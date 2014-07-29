#############################################################################
##
##                                               CategoriesForHomalg package
##
##  Copyright 2014, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#############################################################################

DeclareRepresentation( "IsHomalgCategoryTwoCellRep",
                       IsAttributeStoringRep and IsHomalgCategoryTwoCell,
                       [ ] );

BindGlobal( "TheFamilyOfHomalgCategoryTwoCells",
        NewFamily( "TheFamilyOfHomalgCategoryTwoCells" ) );

BindGlobal( "TheTypeOfHomalgCategoryTwoCells",
        NewType( TheFamilyOfHomalgCategoryTwoCells,
                IsHomalgCategoryTwoCellRep ) );

####################################
##
## Add function
##
####################################

##
InstallGlobalFunction( INSTALL_TODO_LIST_ENTRIES_FOR_TWOCELL,

  function( category, twocell )
    local entry;
    
    entry := ToDoListEntryToMaintainFollowingAttributes( [ [ twocell, "HomalgCategory" ] ],
                                                         [ category, twocell ],
                                                         CATEGORIES_FOR_HOMALG_CAN_COMPUTE_FILTER_LIST
                                                          );
    
    AddToToDoList( entry );
    
    if IsBound( category!.PROPAGATE_FILTERS_FROM_CATEGORY_TO_TWOCELL ) then
        
        entry := ToDoListEntryToMaintainFollowingAttributes( [ [ twocell, "HomalgCategory" ] ],
                                                             [ category, twocell ],
                                                             category!.PROPAGATE_FILTERS_FROM_CATEGORY_TO_TWOCELL
                                                              );
        
        AddToToDoList( entry );
        
    fi;
    
end );

##
InstallMethod( Add,
               [ IsHomalgCategory, IsHomalgCategoryTwoCell ],
               
  function( category, twocell )
    local obj_filter, filter;
    
    if HasHomalgCategory( twocell ) then
        
        if IsIdenticalObj( HomalgCategory( twocell ), category ) then
            
            return;
            
        else
            
            Error( "this 2-cell already has a category" );
            
        fi;
        
    fi;
    
    Add( category, Source( twocell ) );
    
    Add( category, Range( twocell ) );
    
    filter := TwoCellFilter( category );
    
    SetFilterObj( twocell, filter );
    
    SetHomalgCategory( twocell, category );

    INSTALL_TODO_LIST_ENTRIES_FOR_TWOCELL( category, twocell );
    
end );

##
InstallMethod( AddHorizontalPreCompose,
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    SetHorizontalPreComposeFunction( category, func );
    
    SetCanComputeHorizontalPreCompose( category, true );
    
    InstallMethodWithToDoForIsWellDefined( HorizontalPreCompose,
                                           [ IsHomalgCategoryTwoCell and TwoCellFilter( category ),
                                             IsHomalgCategoryTwoCell and TwoCellFilter( category ) ],
                            
      function( twocell_1, twocell_2 )
        local horizontal_composition;
        
        if not IsIdenticalObj( Range( Source( twocell_1 ) ), Source( Source( twocell_2 ) ) ) then
            
            Error( "2-cells are not horizontally composable" );
            
        fi;
        
        horizontal_composition := func( twocell_1, twocell_2 );
        
        Add( category, horizontal_composition );
        
        return horizontal_composition;
        
    end : InstallMethod := InstallMethodWithCache, Cache := GET_METHOD_CACHE( category, "HorizontalPreCompose", 2 ) );
    
end );

##
InstallMethod( AddVerticalPreCompose,
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    SetVerticalPreComposeFunction( category, func );
    
    SetCanComputeVerticalPreCompose( category, true );
    
    InstallMethodWithToDoForIsWellDefined( VerticalPreCompose,
                                           [ IsHomalgCategoryTwoCell and TwoCellFilter( category ),
                                             IsHomalgCategoryTwoCell and TwoCellFilter( category ) ],
                            
      function( twocell_1, twocell_2 )
        local vertical_composition;
        
        if not IsIdenticalObj( Range( twocell_1 ), Source( twocell_2 ) ) then
            
            Error( "2-cells are not vertically composable" );
            
        fi;
        
        vertical_composition := func( twocell_1, twocell_2 );
        
        Add( category, vertical_composition );
        
        return vertical_composition;
        
    end : InstallMethod := InstallMethodWithCache, Cache := GET_METHOD_CACHE( category, "VerticalPreCompose", 2 ) );
    
end );

##
InstallMethod( AddIdentityTwoCell,
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    SetIdentityTwoCellFunction( category, func );
    
    SetCanComputeIdentityTwoCell( category, true );
    
    InstallMethodWithToDoForIsWellDefined( IdentityTwoCell,
                                           [ IsHomalgCategoryMorphism and MorphismFilter( category ) ],
                   
      function( mor )
        local two_cell;
        
        two_cell := func( mor );
        
        Add( category, two_cell );
        
        return two_cell;
        
    end );
    
end );
