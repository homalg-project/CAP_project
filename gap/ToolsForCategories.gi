#############################################################################
##
##                                               CategoriesForHomalg package
##
##  Copyright 2014, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
##
#############################################################################

InstallGlobalFunction( InstallMethodWithToDoForIsWellDefined,
                       
  function( arg )
    local orig_func, new_func, name, install_func;
    
    orig_func := arg[ Length( arg ) ];
    
    name := NameFunction( arg[ 1 ] );
    
    new_func := function( arg )
        local val, entry, i;
        
        val := CallFuncList( orig_func, arg );
        
        entry := ToDoListEntry( List( arg, i -> [ i, "IsWellDefined", true ] ), val, "IsWellDefined", true );
        
        SetDescriptionOfImplication( entry, Concatenation( "Well defined propagation from ", name ) );
        
        AddToToDoList( entry );
        
        for i in arg do
            
            entry := ToDoListEntry( [ [ i, "IsWellDefined", false ] ], val, "IsWellDefined", false );
            
            SetDescriptionOfImplication( entry, Concatenation( "Well defined propagation from ", name ) );
            
            AddToToDoList( entry );
            
        od;
        
        return val;
        
    end;
    
    arg[ Length( arg ) ] := new_func;
    
    install_func := ValueOption( "InstallMethod" );
    
    if install_func = fail then
        
        install_func := InstallMethod;
        
    fi;
    
    CallFuncList( install_func, arg );
    
end );
