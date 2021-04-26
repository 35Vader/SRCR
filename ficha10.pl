%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - MiEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Programacao em logica 
% Resolu��o de problemas de pesquisa (Ficha 10)


%---------------------------------  dados do problema ---------

% estado inicial
inicial(jarros(0, 0)).

% estados finais
final(jarros(4, _)).
final(jarros(_, 4)).

% transi��es poss�veis transicao: EixOpXEf

transicao(jarros(V1, V2), encher(1), jarros(8, V2)):- V1 < 8.
transicao(jarros(V1, V2), encher(2), jarros(V1, 5)):- V2 < 5.

transicao(jarros(V1, V2), vazio(1), jarros(0, V2)):- V1 > 0.
transicao(jarros(V1, V2), vazio(2), jarros(V1, 0)):- V2 > 0.

transicao(jarros(V1, V2), encher(1, 2), jarros(NV1, NV2)):- 
	V1 > 0,
	NV1 is max(V1 - 5 + V2, 0), 
	NV1 < V1, 
	NV2 is V2 + V1 - NV1.

transicao(jarros(V1, V2), encher(2, 1), jarros(NV1, NV2)):- 
	V2 > 0,
	NV2 is max(V2 - 5 + V1, 0), 
	NV2 < V2, 
	NV1 is V1 + V2 - NV2.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -   

resolvedf(Solucao) :- inicial(InicialEstado),
                      resolvedf(InicialEstado,[InicialEstado],Solucao).

resolvedf(Estado,_,[]) :- final(Estado),!.

resolvedf(Estado,Historico,[Move|Solucao]) :- transicao(Estado,Move,Estado1),
                                              nao(membro(Estado1,Historico)),
                                              resolvedf(Estado1,[Estado1|Historico],Solucao).

todos(L) :- findall((S,C),(resolvedf(S),length(S,C),L).

melhor(S,Custo) :- findall((S,C),(resolvedf(S),length(S,C)),L),
                   minimo(L,(S,Custo)).

minimo([P,X],(P,X)).
minimo([(Px,X)|L],(Py,Y)) :- minimo(L,(Py,Y)), X > Y.
minimo([(Px,X)|L],(Px,X)) :- minimo(L,(Py,Y)), X =< Y.

%--------------------------------- - - - - - - - - - -  -  -  -  -   - 

resolve_bfs(NodeS,NodeD,Sol) :- breadthfirst([[NodeS]],NodeD,Sol).

breadthfirst([[Node|Path]|_],Node,[Node|Path]).

breadthfirst([Path|Path],NodeD,Sol) :- extend(Path,NewPaths),
                                       concat(Paths,NewPaths,Paths1),
                                       breadthfirst(Paths1,NodeD,Sol).

extend([Node|Path],NewPaths) :- findall([NewPaths,Node|Path],aresta(Node,NewNode),
                                \+member(NewNode,[Node|Path]),NewPaths).

%--------------------------------- - - - - - - - - - -  -  -  -  -   - 

membro(X, [X|_]).
membro(X, [_|Xs]):-
	membro(X, Xs).

membros([X|Xs],Members) :- membro(X,Members),
                           membros(Xs,Members).

inverso(Xs,Ys) :- inicial(Xs,[],Ys).

inverso([],Xs,Xs).
inverso([X|Xs],Ys,Zs) :- inverso(Xs,[X|Ys],Zs).

nao( Questao ) :-
    Questao, !, fail.
nao( Questao ).

escrever([]).
escrever([X|L]) :- write(x),nl,escrever(l).
