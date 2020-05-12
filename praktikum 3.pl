% Funktionen kopiert aus Vorlesungen und Übungen
% Ys ist Xs rückwärts
reverse([],[]).
reverse([X|Xs],Ys)  :- reverse(Xs,Hs), append(Hs,[X],Ys).

% Xs ist vorne in Ys enthalten
praefix([],_).
praefix([X|Xs],[X|Ys]) :- praefix(Xs,Ys).



% A1

% Ys endet mit der Liste Xs
% postfix([1,2,3],[0,1,2,3]). => true
% postfix([1,2,3,4,5,1,2,3,99],[1,2,3]). => false
% postfix([],[]). => true
% postfix([1,2,3,9],[1,2,3,99,5,5,1,2,3,9]). => true

% mit append
postfix(Xs,Ys) :- append(_,Xs,Ys).

% mit reverse und praefix ohne append
% beide listen reversen und gucken ob Xrs jetzt vorne bei Yrs ist
postfix(Xs,Ys) :- reverse(Xs,Xrs), reverse(Ys,Yrs), praefix(Xrs,Yrs).



% A2

% baum praktikum 2
binbaum(empty).
binbaum(node(_,Lb,Rb)) :- binbaum(Lb),binbaum(Rb).

% Baum Xb enthält den Eintrag X
% membertree(test,node(test1,node(test,empty,empty),node(test2,empty,empty))).  => true
% membertree(test,node(test1,node(test3,empty,empty),node(test2,empty,empty))). => false
% membertree(test,node(test1,node(test3,empty,empty),node(test2,node(test,empty,empty),empty))). => true
% membertree(test,test). => false
membertree(X,node(X,Lb,Rb)) :- binbaum(Lb), binbaum(Rb).
membertree(X,node(_,Lb,Rb)) :- binbaum(Lb), binbaum(Rb), membertree(X,Lb).
membertree(X,node(_,Lb,Rb)) :- binbaum(Rb), binbaum(Lb), membertree(X,Rb).



% A3

% Baum wird in preorder in die Liste Ys gespeichert 
% erst das aktuelle element, links dann rechts
% praeorder(node(42,node(13,node(6,empty,empty),node(36,empty,empty)),node(57,node(47,empty,empty),node(69,node(64,empty,empty),node(73,empty,empty)))),Z).  
% Z = [42, 13, 6, 36, 57, 47, 69, 64, 73]. 
praeorder(empty,[]).
praeorder(node(X,Xlb,Xrb), Ys) :- praeorder(Xlb,Yls), praeorder(Xrb,Yrs), append([X|Yls],Yrs,Ys).

% Baum wird in postorder in die Liste Ys gespeichert
% erst das linkeste, dann rechts und dann eins nach oben
% postorder(node(42,node(13,node(6,empty,empty),node(36,empty,empty)),node(57,node(47,empty,empty),node(69,node(64,empty,empty),node(73,empty,empty)))),Z). 
% Z = [6, 36, 13, 47, 64, 73, 69, 57, 42].
postorder(empty,[]).
postorder(node(X,Xlb,Xrb), Ys) :- postorder(Xlb,Yls), postorder(Xrb,Yrs), append(Yls,Yrs,Ts), append(Ts,[X],Ys).

% Y ist die Wurzel vom Baum 
root(node(Y,Lb,Rb),Y) :- binbaum(node(Y,Lb,Rb)).

% Von allen Bäumen in der Liste (Rb) wird die Wurzel in Ys gespeichert
% roots([node(root1,empty,node(blatt1,empty,empty)),node(root2,node(blatt2,node(blatt3,empty,empty),empty),empty),empty,node(root3,empty,empty)],Z).  => Z = [root1, root2, root3]
% roots([],Z). => Z = [].
roots([],[]).
roots([empty|Xs],Ys) :- roots(Xs,Ys).
roots([Rb|Xs],Ys) :- root(Rb,X), roots(Xs,Yns), append([X],Yns,Ys).