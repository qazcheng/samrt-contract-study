%Agreement process
told(ub,ida,t_a,certa,qa).
told(ua,idb,t_b,certb,qb).%t_b为Tb

%Initialization assumption

poss(ua,ida).
poss(ua,da).
bel(ua,fresh(ta)).
bel(ua,fresh(du)).
poss(ua,k1((ta,p),tb)).
poss(ua,k2(da,qb)).
poss(ua,sum(ta,da)).
told(ua,idb).
told(ua,t_b).
told(ua,qb).
told(ua,sum(t_b,qb)).
:- dynamic bel/2.

poss(A,X):-
	told(A,X).%P1
poss(A,(X,Y)):-
		poss(A,X),poss(A,Y).%P2	
poss(A,sum(X,Y)):-
	poss(A,X),poss(A,Y).%P2
% poss(A,k1(X,Y)):-
% 	poss(A,X),poss(A,Y).%P2
poss(A,k2(X,Y)):-
	poss(A,X),poss(A,Y).%P2	
poss(A,k3(X,Y)):-
	poss(A,X),poss(A,Y).%P2
poss(A,k3(X,Y)):-
	poss(A,X),poss(A,Y).%P4
bel(A,fresh(X,Y)):-
	bel(A,fresh(X)),poss(A,Y).%F1
bel(A,fresh(k1(X,Y))):-
	bel(A,fresh(X,Y)).%F1


%bel(ua,fresh(k1(ta,t_b),(k3(sum(ta,da),sum(t_b,qb)),((ida,idb),k2(da,qb))))).
