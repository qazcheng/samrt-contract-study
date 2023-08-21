%Agreement process
told(ub,ida,t_a,certa,qa).
told(ua,idb,t_b,certb,qb).%t_b为Tb
told(ua,hash(sk,h(certb))).%t_b为Tb

%Initialization assumption
told(ua,h(certb)).
bel(ua, share(ua,h(certb),ub)).
poss(ua,sk).%from goal1
bel(ua,fresh(sk)).%goal1
:- dynamic bel/2.

poss(A,X):-
	told(A,X).%P1
poss(A,(X,Y)):-
	poss(A,X),poss(A,Y).%P2	
bel(A,fresh(X,Y)):-
	bel(A,fresh(X)),poss(A,Y).%F1
bel(A,fresh(k1(X,Y))):-
	bel(A,fresh(X,Y)).%F1
bel1(A,said(B,(X,Y))):-
	told(A,hash(X,Y)),
	poss(A,(X,Y)),
	bel(A,share(A,Y,B)),
	bel(A,fresh(X,Y)).%I3
bel(A,said(B,X)):-
	bel1(A,said(B,(X,h(certb)))).%I7
bel(A,poss(B,X)):-
	bel(A,said(B,X)),
	bel(A,fresh(X)).%4：I6
%bel(ua,poss(ub,sk)).
