% PDA erkennt Palindrome über 0 und 1
% ?- lvonM(Zs).
% Zs = [] ;
% Zs = [0] ;
% Zs = [1] ;
% Zs = [0, 0] ;
% Zs = [0, 0, 0] ;
% Zs = [0, 1, 0] ;
% Zs = [0, 0, 0, 0] ;
% Zs = [0, 0, 0, 0, 0] ;
% Zs = [0, 0, 1, 0, 0] ;
% Zs = [0, 0, 0, 0, 0, 0] ;
% Zs = [0, 0, 0, 0, 0, 0, 0] ;
% Zs = [0, 0, 0, 1, 0, 0, 0].
% ?- lvonM([1,1,0,0,1,0,0,1,1]). => true ;

% a)

% z(Zustände) :- Zustände ist die endliche Zustandmenge
zustand(z0).

% Eingabealphabet
sigma(0).
sigma(1).

% Kelleralphabet
keller(0).
keller(1).
keller(#).

% start(A) :- A ist der Startzustand
start(z0).

% start(E) :- E ist der Endzustand
ende(#).

% Transitionsreltaion
delta(z0, 0, 0, z0, []).
delta(z0, 1, 1, z0, []).

delta(z0, nix, #, z0, []).
delta(z0, nix, #, z0, [0]).
delta(z0, nix, #, z0, [1]).
delta(z0, nix, #, z0, [0,#,0]).
delta(z0, nix, #, z0, [1,#,1]).


% b)

% lvonM(Ws) :- Ws ist ein Wort der Sprache
lvonM(Ws) :- start(Sz), ende(K), keller(K), es_plus(Sz, Ws, [K], _, _), sigma_stern(Ws).

% Einzelschrittrelationen
es(S, W, [K|Ks], Sn, Kn) :- delta(S, W, K, Sn, Kr), append(Kr, Ks, Kn).

% Transitiver Abschluss der Einzelschrittrelationen
es_plus(_, [], [], _, []).
es_plus(S, Ws, Ks, Sn, Kn) :- es(S, nix, Ks, Sn, Kn), es_plus(Sn, Ws, Kn, _, _).
es_plus(S, [W|Ws], Ks, Sn, Kn) :- es(S, W, Ks, Sn, Kn), es_plus(Sn, Ws, Kn, _, _).

% sigma_stern(Ws) :- Ws ist die Menge der Wörter über Sigma
% wie in Praktikum 4
sigma_stern([]).
sigma_stern([X|Xs]) :- sigma(X), sigma_stern(Xs).