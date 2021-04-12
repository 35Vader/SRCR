%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - MiEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Invariantes

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% PROLOG: Declaracoes iniciais

:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- set_prolog_flag( unknown,fail ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% PROLOG: definicoes iniciais

:- op( 900,xfy,'::' ).
:- dynamic filho/2.
:- dynamic pai/2

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado filho: Filho,Pai -> {V,F,D}

nao( Questao ) :-
	Questao,!,fail.
nao( Questao ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
solucoes( X;Y;Z ) :-
	findall( X,Y,Z ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado filho: Filho,Pai -> {V,F,D}

filho( joao,jose ).
filho( jose,manuel ).
filho( carlos,jose ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado idade: Pessoa,Idade -> {V,F}

idade( joao,21 ).
idade( jose,42 ).
idade( manuel,63 ).
idade( carlos,19 ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Invariante Estrutural:  nao permitir a insercao de conhecimento
%                         repetido

+filho( F,P ) :: (solucoes( (F,P),(filho( F,P )),S ),
                  comprimento( S,N ), 
				  N == 1 ).

% Invariante Referencial: nao admitir mais do que 2 progenitores
%                         para um mesmo individuo

+filho( F,P ) :: ( solucoes( (Ps),(filho( F,Ps )),S ),
				   comprimento( S,N ),
				   N =< 2 ).

% Invariante Referencial: nao e possivel remover filhos para
%						  os quais existia registo de idade

-filho( F,P ) :: ( solucoes( (F),(idade( F,I )),S ),
				   comprimento( S,N ),
				   N == 0 ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado que permite a evolucao do conhecimento

evolucao( Termo ) :-
	solucoes( Invariante,+Termo :: Invariante,Lista ),
	insercao( Termo ),
	teste( Lista ).

insercao( Termo ) :-
	assert( Termo ).
insercao( Termo ) :-
	retract( Termo ),!,fail.

teste( [] ).
teste( [R|LR] ) :-
	R,
	teste( LR ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado que permite a involucao do conhecimento

involucao( Termo ) :-
	solucoes( Invariante,-Termo :: Invariante,Lista ),
	remocao( Termo ),
	teste( Lista ).

remocao( Termo ) :-
	retract( Termo ).
remocao( Termo ) :-
	assert( Termo ),!,fail.
