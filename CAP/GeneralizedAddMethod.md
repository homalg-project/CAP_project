## Structure of a generalized Add method.

Common structure at the moment:



InstallMethod( Add*F*,
    [ IsCAPCategory, IsFunction ] -> [ IsCAPCategory, IsList ], wobei das zweite Argument eine Liste von Bitupeln ist, welche aus [ func, addtional_filter ] besteht.
    
    function( category, func_list )
        
        Set*F*Function -> Deprecated, wird nur noch bei Initial, Terminal und ZeroObject benötigt, da diese Funktionen nicht direkt installiert werden.
        
        SetCanCompute*F* -> Beibehalten, um damit Funktionalität zu anderen Kategorien zu propagieren und die Anzeigemethode benutzen zu können.
        
        func := function( func, filters )
        
        InstallMethod( <install_name>,
        
        Optional: ## Weiterleitung
          
          Weiterleitungsfunktion, falls Erfolgreich, gebe [ true, <result> ] zurück, [ false ] sonst.
        
        
        Optional: ## Pre-Function abhängig vom Namen.
          
          Funktion, welche als Argumente die Eingabe der installierten Funktion erhält, und [ true ] oder [ false, <Fehlermeldung> ] zurückgibt.
          Falls [ false, <Fehlermeldung> ], Error( <Fehlermeldung> ).
        
        ## Function call -> result
          
        ## Füge result zur Kategorie hinzu
        
        Optional (falls WithGiven existiert): Source/Range, Diagrammnamen *ObjectFunction*Diagram, WasCreatedAs*ObjectFunction*.
                                              ## Setze evtl. Quelle/Senke der zugehörigen Methode (Derivierbar aus WithGiven...) und Range/Source Info
                                              ## Setze Filter für Objekt. (Vereinheitliche Filter oder setze Namen des Filters ins Record
                                              ## Setze Diagramm
        
        end;
        
        for i in func_list do
        
          filter_cosmetics,
        
          func( i[ 1 ], i[ 2 ] );
        
        od;
    
end;
        
        
## Differences between general Add-Method and the former implementation:
- KernelEmbedding/ KernelEmbeddingWithGivenKernel: 
  SetIsMonomorphism( kernel_emb, true );

- CokernelProjection/ CokernelProjectionWithGivenCokernel
  SetIsEpimorphism( cokernel_proj, true );
  
- InjectionOfCofactorOfCoproduct/ InjectionOfCofactorOfCoproductWithGivenCoproduct
  ## FIXME: it suffices that the category knows that it has a zero object
  if HasCanComputeZeroObject( category ) and CanComputeZeroObject( category ) then
    
    SetIsSplitMonomorphism( injection_of_cofactor, true );
    
  fi;

- ProjectionInFactorOfDirectProduct/ ProjectionInFactorOfDirectProductWithGivenDirectProduct
  ## FIXME: it suffices that the category knows that it has a zero object
  if HasCanComputeZeroObject( category ) and CanComputeZeroObject( category ) then
    
    SetIsSplitEpimorphism( projection_in_factor, true );
    
  fi;
  
- ImageEmbedding
  ##Implication (by definition of an image)
  SetIsMonomorphism( image_embedding, true );

- IdentityMorphism
  SetIsOne( ret_val, true );
  SetInverse( ret_val, ret_val );
  
- ZeroMorphism
  SetIsZero( return_value, true );