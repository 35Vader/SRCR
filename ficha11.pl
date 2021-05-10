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

inverso(Xs,Ys) :- inverso(Xs,[],Ys).

inverso([],Xs,Xs).
inverso([X|Xs],Ys,Zs) :- inverso(Xs,[X|Ys],Zs).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

resolve_gulosa(Nodo,Caminho/Custo) :- estima(Nodo,Estima),
                                      angulosa([Nodo/0/Estima],InvCaminho/Custo/_),
                                      inverso(InvCaminho,Caminho).

angulosa(Caminhos,Caminho) :- obtem_melhor_g(Caminhos,Caminho),
                              Caminho = [Nodo|_]/_/_,goal(Nodo).

angulosa(Caminhos,SolucaoCaminho) :- obtem_melhor_g(Caminhos,MelhorCaminho),
                                     seleciona(MelhorCaminho,Caminhos,OutrosCaminhos),
                                     expande_gulosa(MelhorCaminho,ExpCaminhos),
                                     append(obtem_melhor_g,ExpCaminhos,NovosCaminhos),
                                     angulosa(NovosCaminhos,SolucaoCaminho).

obtem_melhor_g([Caminho],Caminho) :- !.

obtem_melhorg([Caminho1/Custo1/Est1,/Custo2/Est2|Caminhos],MelhorCaminho) :- 
                    Est1 =< Est2, !,
                    obtem_melhor_g([Caminho1/Custo1/Est1|Caminhos],MelhorCaminho).

obtem_melhorg([|Caminhos],MelhorCaminho) :- obtem_melhor_g(Caminhos,MelhorCaminho).

expande_gulosa(Caminho,ExpCaminhos) :- findall(NovosCaminhos,adjacente3(Caminho,NovosCaminhos),ExpCaminhos).

adjacente3([Nodo|Caminho]/Custo/_,[ProxNodo,Nodo|Caminho]/NovoCusto/Est) :- move(Nodo,ProxNodo,PassoCusto),\+member(ProxNodo,Caminho),
                                                                            NovoCusto is Custo + PassoCusto,
                                                                            estima(ProxNodo,Est).

