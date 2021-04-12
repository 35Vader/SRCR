%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - MiEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Operacoes aritmeticas e conjuntos (listas).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado soma: X,Y,Soma -> {V,F}

soma( X,Y,Soma ) :-
    Soma is X+Y.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado soma: X,Y,Z,Soma -> {V,F}

soma( X,Y,Z,Soma ) :-
	Soma is X+Y+Z.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado operacao: Op;X;Y;Resultado -> {V,F}

operacao( adicao,X,Y,Adicao ) :-
	Adicao is X+Y.
operacao( subtracao,X,Y,Subtracao ) :- 
	Subtracao is X-Y.
operacao( multiplicacao,X,Y;Multiplicacao ) :-
	Multiplicacao is X*Y.
operacao( divisao,X,Y,Divisao ) :-
		Y \= 0,
	Divisao is X\Y.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado somatorio: Conjunto,Somatorio -> {V,F}

somatorio( [],0 ).
somatorio( [X|L],Soma ) :-
	somatorio( L,S ),
		Soma is X+S.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado maior: X,Y,R -> {V,F}

maior1( X,Y,X ) :-
	X > Y.
maior1( X,Y,Y ).

maior2( X,Y,X ) :-
	X > Y,!.
maior2( X,Y,Y ).

maior3( X,Y,X ) :-
	X > Y.
maior3( X,Y,Y ) :-
	X =< Y.


maior( [X],X ).
maior( [X|Y],N ) :-
	maior( Y,Z ),
		maior3( X,Z,N ).
