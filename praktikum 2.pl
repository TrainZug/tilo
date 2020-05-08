% Aufgabe 1

% a)

% leere liste
linListe(nil).
% nicht leere listen
linListe(list(_,Xs)) :- linListe(Xs).

% b)

% member(X,Ys) :- Ys enthält das Element X
% member(test,list(a,list(test,list(c,nil)))).
member(X,list(X,Xs)).
member(X,list(_,Xs)) :- member(X,Xs).

% infix(Xs,Ys) :- Ys enthält die Liste Xs.
% infix(list(b,nil),list(a,list(b,nil))).   
% infix(nil,list(a,list(b,nil))).
infix(Xs,Ys) :- append(Rs,_,Ys),append(_,Xs,Rs),linListe(Ys),linListe(Xs).

% attach(Xs,X,Ys) :- Ys ist Xs verlängert um das Element X.
% attach(list(a,list(b,nil)),c,Zs). => Zs = list(a, list(b, list(c, nil))). 
attach(Xs,X,Ys) :- append(Xs,list(X,nil),Ys),linListe(Ys),linListe(Xs).

% append(Xs,Ys,Rs) :- Rs ist Ys angehänht an Xs
append(nil,Ys,Ys).
append(list(X,Xs),Ys,list(X,Rs)) :-append(Xs,Ys,Rs).

% rev(Xs,Ys) :- Ys ist das gespiegelte Xs.
% rev(list(a,list(b,nil)), list(b,list(a,nil))).
% rev(list(a,list(b,nil)),Z). => Z = list(b, list(a, nil)).
rev(nil,nil).
rev(list(X,Xs),Ys) :- rev(Xs,Hs),append(Hs,list(X,nil),Ys).


% Aufgabe 2
binbaum(empty).
binbaum(node(_,Lb,Rb)) :- binbaum(Lb),binbaum(Rb).


% construct(wurzel,node(links,empty,empty),node(rechts,empty,empty),Z). => Z = node(wurzel, node(links, empty, empty), node(rechts, empty, empty)).
% construct(wurzel,node(links,node(linkslinks,empty,empty),node(linksrechts,empty,empty)),node(rechts,node(rechtslinks,empty,empty),node(rechtsrechts,empty,empty)),Z).
% => Z = node(wurzel, node(links, node(linkslinks, empty, empty), node(linksrechts, empty, empty)), node(rechts, node(rechtslinks, empty, empty), node(rechtsrechts, empty, empty))).
construct(Root,Lb,Rb,node(Root,Lb,Rb)) :- binbaum(Lb),binbaum(Rb).


natSymb(o).
natSymb(s(X)) :- natSymb(X).
add(X,o,X) :- natSymb(X).
add(X,s(Y),s(E)) :- add(X,Y,E).


% knotenanz(node(links,empty,empty), s(o)).
% knotenanz(node(links,empty,node(test,empty,empty)),s(s(o))).
% knotenanz(node(links,empty,node(test,empty,node(test,node(test,empty,empty),empty))),Z).  => Z = s(s(s(s(o)))) ;
knotenanz(empty,o).
knotenanz(node(_,Lb,Rb),N) :- knotenanz(Lb,Nl),knotenanz(Rb,Nr),add(Nl,s(Nr),N).