%Agreement process
told(ub,ida,t_a,certa,qa).
told(ua,idb,t_b,certb,qb).%t_b为Tb

%Initialization assumption
poss(ua,ida).
poss(ua,da).
bel(ua,reco(ta)).
bel(ua,reco(du)).
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

poss(A,k2(X,Y)):-
	poss(A,X),poss(A,Y).%P2	
poss(A,k3(X,Y)):-
	poss(A,X),poss(A,Y).%P2
poss(A,k3(X,Y)):-
	poss(A,X),poss(A,Y).%P4
bel(A,reco(X,Y)):-
	bel(A,reco(X)),poss(A,Y).%R1
bel(A,reco(k1(X,Y))):-
	bel(A,reco(X,Y)).%R1


%bel(ua,reco(k1(ta,t_b),(((ida,idb),k2(da,qb)),k3(sum(ta,da),sum(t_b,qb))))).
