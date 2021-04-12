%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - MiEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

%--------------------------------- - - - - - - - - - -  -  -  -  -   -



%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado par: N -> {V,F}

par( 0 ).
par( X ) :-
    N is X-2,
    N >= 0,
    par( N ).
	
%par(N):- N mod 2 =:= 0.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado impar: N -> {V,F}

impar( 1 ).
impar( X ) :-
    N is X-2,
    N >= 1,
    impar( N ).

%impar(N):- N mod 2 =:= 1.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado nao: Questao -> {V,F}

nao( Questao ) :-
    Questao, !, fail.
nao( Questao ).
