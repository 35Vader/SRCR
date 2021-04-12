%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - MiEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Operacoes sobre listas.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado pertence: Elemento,Lista -> {V,F}

pertence( X,[X|L] ).
pertence( X,[Y|L] ) :-
    X \= Y,
    pertence( X,L ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado comprimento: Lista,Comprimento -> {V,F}

comprimento( [],0 ).
comprimento( [X|L],N ) :-
    comprimento( L,N1 ),
    N is N1+1.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado quantos: Lista,Comprimento -> {V,F}

quantos( [],0 ).
quantos( [X|L],N ) :-
	pertence( X,L ),
	quantos(L,N ).
quantos( [X|L],N1 ) :-
	nao( pertence( X,L ) ),
	quantos( L,N ),
		N is N+1.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado apagar: Elemento,Lista,Resultado -> {V,F}

apagar( X,[X|R],R ).
apagar( X,[Y|R],[Y|L] ) :-
	X \= Y,
	apagar( X,R,L ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado apagatudo: Elemento,Lista,Resultado -> {V,F}

apagatudo( X,[],[] ).
apagatudo( X,[X|R],L ) :-
	apagatudo( X,R,L ).
apagatudo( X,[Y|R],[Y|L] ) :-
	X \= Y,
	apagatudo( X,R,L ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado adicionar: Elemento,Lista,Resultado -> {V,F}

adicionar( X,L,L ) :-
	pertence( X,L ).
adicionar( X,L,[X|L] ) :-
	nao( pertence ( X,L ) ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado concatenar: Lista1,Lista2,Resultado -> {V,F}

concatenar( [],L2,L2 ).
concatenar( [X|R],L2,[X|L] ) :-
	concatenar( R,L2,L ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado inverter: Lista,Resultado -> {V,F}

inverter( [],[] ).
inverter( [H|T],R ) :-
	inverter( T,Ys ),
	concatenar( Ys,[H],R ).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado sublista: SubLista,Lista -> {V,F}

sublista( S,L ) :-
	concatenar( L1,L3,L ),
	concatenar( S,L2,L3 ).




