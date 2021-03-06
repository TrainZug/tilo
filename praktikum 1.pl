% Fakten

weiblich(gerhild).
weiblich(elisa).
weiblich(mathilda).
weiblich(katrina).
weiblich(heidi).
weiblich(julia).
weiblich(melissa).
weiblich(susanne).
weiblich(jana).
weiblich(lena).

männlich(john).
männlich(robert).
männlich(richard).
männlich(stefan).
männlich(georg).
männlich(hans).
männlich(peter).
männlich(james).


elternteil(john,katrina).
elternteil(john,mathilda).
elternteil(john,peter).
elternteil(gerhild,katrina).
elternteil(gerhild,mathilda).
elternteil(gerhild,peter).

elternteil(georg,heidi).
elternteil(georg,james).
elternteil(mathilda,heidi).
elternteil(mathilda,james).

elternteil(peter,stefan).
elternteil(peter,melissa).
elternteil(jana,stefan).
elternteil(jana,melissa).

elternteil(robert,jana).
elternteil(robert,hans).
elternteil(elisa,jana).
elternteil(elisa,hans).

elternteil(hans,lena).
elternteil(susanne,lena).

elternteil(lena,julia).
elternteil(richard,julia).


% Regeln

% mutter(X,Y) :- X ist Mutter von Y                       
mutter(X,Y) :- elternteil(X,Y),weiblich(X).

% vater(X,Y) :- X ist Vater von Y
vater(X,Y) :- elternteil(X,Y),männlich(X).

% kind(X,Y) :- X ist Kind von Y
kind(X,Y) :- elternteil(Y,X).

% sohn(X,Y) :- X ist Sohn von Y
sohn(X,Y) :- elternteil(Y,X),männlich(X).

% tochter(X,Y) :- X ist Tochter von Y
tochter(X,Y) :- elternteil(Y,X),weiblich(X).

% bruder(X,Y) :- X ist Bruder von Y
%bruder(X,Y) :- X\==Y,elternteil(H,X),elternteil(H,Y),männlich(X).
bruder(X,Y) :- vater(H,X),vater(H,Y),mutter(J,X),mutter(J,Y),männlich(X),X\==Y.

% schwester(X,Y) :- X ist Schwester von Y
schwester(X,Y) :- vater(H,X),vater(H,Y),mutter(J,X),mutter(J,Y),weiblich(X),X\==Y.

% onkel(X,Y) :- X ist Onkel von Y
% wenn Y ein Kind von H und H der Bruder von X
onkel(X,Y):-kind(Y,H),bruder(X,H),männlich(X).

% cousine(X,Y) :- X ist Cousine von Y
% wenn X ein Kind von H und H Schwester/Bruder von I und Y ein Kind von I
cousine(X,Y) :- weiblich(X),kind(X,H),schwester(H,I),kind(Y,I).
cousine(X,Y) :- weiblich(X),kind(X,H),bruder(H,I),kind(Y,I).

% großvater(X,Y) :- X ist Großvater von Y
% Y ist Kind von H und H ist Kind von X und X ist männlich
großvater(X,Y) :- kind(Y, H), kind(H,X),männlich(X).

