#############################################################################
##
##                                               CAP package
##
##  Copyright 2018, Sebastian Gutsche, University of Siegen
##                  Sebastian Posur,   University of Siegen
##
##
#############################################################################

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