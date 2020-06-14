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
lvonM(Ws) :- start(Z), ende(K), zustand(Zneu),es_plus(Z, Ws, [K], Zneu, [], []).

% Einzelschrittrelationen
% (z, aw, gs, z' , w, s's) ∈ +M falls (z, a, g, z' , s' ) ∈ δ
es(Z, [W|Ws], [T|KRs], Zneu, Ws, KNs) :- delta(Z, W, T, Zneu, KA), append(KA, KRs, KNs).
% (z, w, gs, z' , w, s's) ∈ +M falls (z, nix, g, z' , s' ) ∈ δ
es(Z, Ws, [T|KRs], Zneu, Ws, KNs) :- delta(Z, nix, T, Zneu, KA), append(KA, KRs, KNs).

% Transitiver Abschluss
es_plus(Z, Ws, Ks, Zneu, Wsneu, Kneu) :- es(Z, Ws, Ks, Zneu, Wsneu, Kneu).
es_plus(Z, Ws, Ks, Zneu, Wsneu, Kneu) :- es(Z, Ws, Ks, Z1, Ws1, K1), es_plus(Z1, Ws1, K1, Zneu, Wsneu, Kneu).

% sigma_stern(Ws) :- Ws ist die Menge der Wörter über Sigma
% wie in Praktikum 4
sigma_stern([]).
sigma_stern([X|Xs]) :- sigma(X), sigma_stern(Xs).