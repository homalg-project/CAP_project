# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Implementations
#

## This file contains installations for ToolsForCategories functions
## that can only be installed after all dependencies have been loaded.

if IsPackageMarkedForLoading( "Browse", ">=0" ) and IsBound( NCurses ) and IsBound( NCurses.BrowseDenseList ) then

    InstallGlobalFunction( BrowseCachingStatistic,
      
      function( category )
        local operations, current_cache_name, current_cache, value_matrix, names, cols, current_list;
        
        value_matrix := [ ];
        names := [ ];
        cols := [ [ "status", "hits", "misses", "stored" ] ];
        
        operations := ShallowCopy( RecNames( category!.caches ) );
        Sort( operations );
        
        for current_cache_name in operations do
            Add( names, [ current_cache_name ] );
            if not IsBound( category!.caches.(current_cache_name) ) then
                Add( value_matrix, [ "not installed", "-", "-", "-" ] );
                continue;
            fi;
            current_cache := category!.caches.(current_cache_name);
            if IsDisabledCache( current_cache ) then
                Add( value_matrix, [ "deactivated", "-", "-", "-" ] );
                continue;
            fi;
            current_list := [ ];
            if IsWeakCache( current_cache ) then
                Add( current_list, "weak" );
            elif IsCrispCache( current_cache ) then
                Add( current_list, "crisp" );
            fi;
            
            Append( current_list, [ current_cache!.hit_counter, current_cache!.miss_counter, Length( PositionsProperty( current_cache!.value, ReturnTrue ) ) ] );
            Add( value_matrix, current_list );
        od;
        
        NCurses.BrowseDenseList( value_matrix, rec( labelsCol := cols, labelsRow := names ) );
        
    end );

fi;

##
InstallGlobalFunction( CAP_INTERNAL_ASSERT_IS_CELL_OF_CATEGORY,
  
  function( cell, category, human_readable_identifier_getter )
    local generic_help_string;
    
    generic_help_string := " You can access the category cell and category via the local variables 'cell' and 'category' in a break loop.";
    
    if not IsCapCategoryCell( cell ) then
        Error( Concatenation( human_readable_identifier_getter(), " does not lie in the filter IsCapCategoryCell.", generic_help_string ) );
    fi;
    
    if not HasCapCategory( cell ) then
        Error( Concatenation( human_readable_identifier_getter(), " has no CAP category.", generic_help_string ) );
    fi;
    
    if category <> false and not IsIdenticalObj( CapCategory( cell ), category ) then
        Error( Concatenation( "The CapCategory of ", human_readable_identifier_getter(), " is not identical to the category named \033[1m", Name( category ), "\033[0m.", generic_help_string ) );
    fi;
    
    if category <> false and not CellFilter( category )( cell ) then
        Error( Concatenation( human_readable_identifier_getter(), " does not lie in the cell filter of the category named \033[1m", Name( category ), "\033[0m.", generic_help_string ) );
    fi;
    
end );

##
InstallGlobalFunction( CAP_INTERNAL_ASSERT_IS_OBJECT_OF_CATEGORY,
  
  function( object, category, human_readable_identifier_getter )
    local generic_help_string;
    
    generic_help_string := " You can access the object and category via the local variables 'object' and 'category' in a break loop.";
    
    if not IsCapCategoryObject( object ) then
        Error( Concatenation( human_readable_identifier_getter(), " does not lie in the filter IsCapCategoryObject.", generic_help_string ) );
    fi;
    
    if not HasCapCategory( object ) then
        Error( Concatenation( human_readable_identifier_getter(), " has no CAP category.", generic_help_string ) );
    fi;
    
    if category <> false and not IsIdenticalObj( CapCategory( object ), category ) then
        Error( Concatenation( "The CapCategory of ", human_readable_identifier_getter(), " is not identical to the category named \033[1m", Name( category ), "\033[0m.", generic_help_string ) );
    fi;
    
    if category <> false and not ObjectFilter( category )( object ) then
        Error( Concatenation( human_readable_identifier_getter(), " does not lie in the object filter of the category named \033[1m", Name( category ), "\033[0m.", generic_help_string ) );
    fi;
    
end );

##
InstallGlobalFunction( CAP_INTERNAL_ASSERT_IS_MORPHISM_OF_CATEGORY,
  
  function( morphism, category, human_readable_identifier_getter )
    local generic_help_string;
    
    generic_help_string := " You can access the morphism and category via the local variables 'morphism' and 'category' in a break loop.";
    
    if not IsCapCategoryMorphism( morphism ) then
        Error( Concatenation( human_readable_identifier_getter(), " does not lie in the filter IsCapCategoryMorphism.", generic_help_string ) );
    fi;
    
    if not HasCapCategory( morphism ) then
        Error( Concatenation( human_readable_identifier_getter(), " has no CAP category.", generic_help_string ) );
    fi;
    
    if category <> false and not IsIdenticalObj( CapCategory( morphism ), category ) then
        Error( Concatenation( "the CAP-category of ", human_readable_identifier_getter(), " is not identical to the category named \033[1m", Name( category ), "\033[0m.", generic_help_string ) );
    fi;
    
    if category <> false and not MorphismFilter( category )( morphism ) then
        Error( Concatenation( human_readable_identifier_getter(), " does not lie in the morphism filter of the category named \033[1m", Name( category ), "\033[0m.", generic_help_string ) );
    fi;
    
    if not HasSource( morphism ) then
        Error( Concatenation( human_readable_identifier_getter(), " has no source.", generic_help_string ) );
    fi;
    
    CAP_INTERNAL_ASSERT_IS_OBJECT_OF_CATEGORY( Source( morphism ), category, function( ) return Concatenation( "the source of ", human_readable_identifier_getter() ); end );
    
    if not HasRange( morphism ) then
        Error( Concatenation( human_readable_identifier_getter(), " has no range.", generic_help_string ) );
    fi;
    
    CAP_INTERNAL_ASSERT_IS_OBJECT_OF_CATEGORY( Range( morphism ), category, function( ) return Concatenation( "the range of ", human_readable_identifier_getter() ); end );
    
end );

##
InstallGlobalFunction( CAP_INTERNAL_ASSERT_IS_TWO_CELL_OF_CATEGORY,
  
  function( two_cell, category, human_readable_identifier_getter )
    local generic_help_string;
    
    generic_help_string := " You can access the 2-cell and category via the local variables 'two_cell' and 'category' in a break loop.";
    
    if not IsCapCategoryTwoCell( two_cell ) then
        Error( Concatenation( human_readable_identifier_getter(), " does not lie in the filter IsCapCategoryTwoCell.", generic_help_string ) );
    fi;
    
    if not HasCapCategory( two_cell ) then
        Error( Concatenation( human_readable_identifier_getter(), " has no CAP category.", generic_help_string ) );
    fi;
    
    if category <> false and not IsIdenticalObj( CapCategory( two_cell ), category ) then
        Error( Concatenation( "the CapCategory of ", human_readable_identifier_getter(), " is not identical to the category named \033[1m", Name( category ), "\033[0m.", generic_help_string ) );
    fi;
    
    if category <> false and not TwoCellFilter( category )( two_cell ) then
        Error( Concatenation( human_readable_identifier_getter(), " does not lie in the 2-cell filter of the category named \033[1m", Name( category ), "\033[0m.", generic_help_string ) );
    fi;
    
    if not HasSource( two_cell ) then
        Error( Concatenation( human_readable_identifier_getter(), " has no source.", generic_help_string ) );
    fi;
    
    CAP_INTERNAL_ASSERT_IS_MORPHISM_OF_CATEGORY( Source( two_cell ), category, function( ) return Concatenation( "the source of ", human_readable_identifier_getter() ); end );
    
    if not HasRange( two_cell ) then
        Error( Concatenation( human_readable_identifier_getter(), " has no range.", generic_help_string ) );
    fi;
    
    CAP_INTERNAL_ASSERT_IS_MORPHISM_OF_CATEGORY( Range( two_cell ), category, function( ) return Concatenation( "the range of ", human_readable_identifier_getter() ); end );
    
end );
