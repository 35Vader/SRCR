%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - MiEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Programacao em logica 
% Resolu��o de problemas de pesquisa (Ficha 11)

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Representacao de grafos por arestas
%
%clausula-aresta: aresta(a,b)

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

move(s,a,2).
move(a,b,2).
move(b,c,2).
move(c,d,3).
move(d,t,3).
move(s,e,2).
move(e,f,5).
move(f,g,2).
move(g,t,2).

%Add no fim para testar 
%move(b,f,2).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

estima(a,5).
estima(b,4).
estima(c,4).
estima(d,3).
estima(e,7).
estima(f,4).
estima(g,2).
estima(s,10).
estima(a,5).
estima(t,0).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%resolve_pp(inicio,Caminho) - ? resolve_pp(s,T).

resolve_pp(Nodo,[Nodo|Caminho]) :- profundidadeprimeiro1(Nodo,[Nodo],Caminho).

goal(t).
profundidadeprimeiro1(Nodo,_,[]) :- goal(Nodo).

profundidadeprimeiro1(Nodo,Historico,[ProxNodo|Caminho]) :- adjacente(Nodo,ProxNodo),
                                                            nao(membro(ProxNodo,Historico)),
                                                            profundidadeprimeiro1(ProxNodo,[ProxNodo|Historico],Caminho).

adjacente(Nodo,ProxNodo) :- move(Nodo,ProxNodo,_).

adjacente(Nodo,ProxNodo) :- move(ProxNodo,Nodo,_).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

resolve_pp_h(Origem,Destino;Caminho) :- profundidade(Origem,Destino,[Origem],Caminho).

profundidade(Destino,Destino,H,D) :- inverso(H,D).

profundidade(Origem,Destino,His,C) :- adjacente_h(Origem,Prox),
                                      nao(membro(Prox,His)),
                                      profundidade(Prox,Destino,[Prox|His],C).

adjacente_h(Nodo,ProxNodo) :- move(Nodo,ProxNodo,_).
adjacente_h(Nodo,ProxNodo) :- move(ProxNodo,Nodo,_).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

resolve_pp_c(Nodo,[Nodo|Caminho],C) :- profundidadeprimeiro(Nodo,[Nodo],Caminho,C).

profundidadeprimeiro(Nodo,Historico,[ProxNodo|Caminho],C) :- adjacente2(Nodo,ProxNodo,C1),
                                                             nao(membro(ProxNodo,Historico)),
                                                             profundidadeprimeiro(ProxNodo,[ProxNodo|Historico],Caminho,C2), C is C1 + C2.

adjacente2(Nodo,ProxNodo,C) :- move(Nodo,ProxNodo,C).
adjacente2(Nodo,ProxNodo,C) :- move(ProxNodo,Nodo,C).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado nao: Questao -> {V,F}

nao( Questao ) :-
    Questao, !, fail.
nao( Questao ).

membro(X, [X|_]).
membro(X, [_|Xs]):-
	membro(X, Xs).
