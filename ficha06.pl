%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Programacao em logica estendida

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% PROLOG: Declaracoes iniciais

:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- set_prolog_flag( unknown,fail ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% PROLOG: definicoes iniciais

:- dynamic '-'/1.
:- dynamic mamifero/1.
:- dynamic morcego/1.

:- op( 1100,xfy,'??' ).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -

voa( X ) :-
    ave( X ).
-voa( tweety ).
-voa( X ) :-
    mamifero( X ).


voa( X ) :-
	ave( X ),nao( excecao( voa( X ) ) ).

-voa( tweety ).
-voa( X ) :- 
	mamifero( X ),nao(excecao( -voa( X ) ) ).

-voa( X ) :-
	excecao( voa( X ) ).
voa( X ) :-
	excecao( -voa( X ) ).

excecao( voa( X ) ) :-
	avestruz( X ).

excecao( voa( X ) ) :-
	pinguim( X ).
excecao( -voa( X ) ) :-
	morcego( X ).

ave( X ) :-
	canario( X ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado nao: Questao -> {V,F}

nao( Questao ) :-
    Questao, !, fail.
nao( Questao ).

Questao ?? verdadeiro :-
	Questao.
Questao ?? falso :-
	-Questao.
Questao ?? desconhecido :-
	nao( Questao ),
	nao( -Questao ).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado si: Questao,Resposta -> {V,F}
%								 Resposta = { verdadeiro,falso,desconhecido }

si( Questao,verdadeiro ) :-
	Questao.
si( Questao,falso ) :-
	-Questao.
si( Questao,desconhecido ) :-
	nao( Questao ),
	nao( -Questao ).
