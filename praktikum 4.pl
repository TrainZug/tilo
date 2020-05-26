% a)
% Sprache: 0 oder unendlich viele a eingeschlossen von b
% 
% ?- lvonN(Zs).    
% Zs = [b, b] ;
% Zs = [b, a, b] ;
% Zs = [b, a, a, b] ;
% Zs = [b, a, a, a, b] ;
% Zs = [b, a, a, a, a, b] ;
% Zs = [b, a, a, a, a, a, b] ;
% Zs = [b, a, a, a, a, a, a, b] ;
% Zs = [b, a, a, a, a, a, a, a, b] ;


% z(Zustände) :- Zustände ist die endliche Zustandmenge
z(z0).
z(z1).

% sigma(S) :- S ist Eingabealphabet
sigma(a).
sigma(b).

% delta(J,W,N) :- J jetziger Zustand, W ist der Übergangswert, N ist der nächste Zustand
delta(z0,b,z1).
delta(z1,a,z1).
delta(z1,b,z0).

% start(A) :- A ist der Startzustand
start(z0).

% start(E) :- E ist der Endzustand
ende(z0).


% b)

% lvonN(Ws) :- Ws ist ein Wort der Sprache aus a)
lvonN(Ws) :- start(Zstart), ende(Zende), delta_stern(Zstart,Ws,Zende).

% delta_stern(Zakt,Ws,Zneu) :- Erweiterung von delta
delta_stern(Zakt,[X],Zneu) :- delta(Zakt,X,Zneu).
delta_stern(Zakt,[X|Xs],Zneu) :- delta(Zakt,X,Zneu2), delta_stern(Zneu2,Xs,Zneu).

% sigma_stern(Ws) :- Ws ist ein Wort
sigma_stern([]).
sigma_stern([X|Xs]) :- sigma(X), sigma_stern(Xs).