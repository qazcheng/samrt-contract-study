% Stage 1 Function：CAStore(ID, EU , QA, QB , Ppub, PA, PB)
% Define Function cAStore
:- use_module(library(clpfd)).
cAStore(Id, EU, Ppub, RCAU) :-
    % Check if the Storaged property of InforMap[id] is true.
    (inforMap(Id, Storaged), Storaged = true ->
        % If true, return "Fail".
        write('Fail')
    ;
        % Otherwise, create a new structure called Infor.
        % Set Infor.Ppub to Ppub.
        assertz(infor_Ppub(Id, Ppub)),
        write(infor_Ppub(Id, Ppub)),nl,
        % Set Infor.RCA^U to Rca^U.
        assertz(infor_RCAU(Id, RCAU)),
        write(infor_RCAU(Id, RCAU)),nl,
        % Set Infor.eU to EU.
        assertz(infor_EU(Id, EU)),
        write(infor_EU(Id, EU)),nl,
        % Set Infor.Storaged to true.
        assertz(infor(Id, true)),
        write(infor(Id, true)),nl,
        % Update InforMap[id].
        retract(inforMap(Id, _)),
        assertz(inforMap(Id, Infor)),
        % Return "Success Store".
        write('Success Store')
    ).

% Define a function certVerifier(Id):
certVerifier(Id) :-
    % Check if the Storaged property of InforMap[id] is not equal to true.
    (inforMap(Id, Storaged), Storaged \= true ->
        % If not equal to true, return "Fail".
        write('Fail')
    ;
        % Otherwise, verify the equation and return the corresponding result.
        % Calculate the value of eU * (RU + RCAU) + Ppub.
        % Get the value of eU.
        infor_EU(Id, EU),
        Limit #> EU,
        % Get the value of RU.
        infor_RU(Id, RU),
        Limit #> RU,
        % Get the value of RCAU.
        infor_RCAU(Id, RCAU),
        Limit #> RCAU,
        % Get the value of Ppub.
        infor_Ppub(Id, Ppub),
        Limit #> Ppub,
        % Calculate the result of eU * (RU + RCAU) + Ppub.
        safe_plus(RU, RCAU, Result_1),
        safe_mult(EU, Result_1, Result_2),
        safe_plus(Result_2, Ppub, ExpressionResult),
        % ExpressionResult is EU * (RU + RCAU) + Ppub,
        % Get the value of QU.
        infor_QU(Id, QU),
        % Check if eU * (RU + RCAU) + Ppub is equal to QU.
        (ExpressionResult =:= QU ->
            % If they are equal, return true.
            write(true)
        ;
            % Otherwise, return false.
            write(false)
        )
    ).

% Custom predicate, check if an item is an unsigned integer.
is_unsigned_integer(X) :-
    integer(X),             % Check if it is an integer.
    X >= 0.                 % Greater than or equal to 0.

% Custom predicate, safe addition (safe_plus).
safe_plus(A, B, Result) :-
    Sum is A + B,
    nat_ble(A, Sum, Check1),
    nat_ble(B, Sum, Check2),
    Check1, Check2,
    Result is Sum.
safe_plus(_, _, error). % Return an error when the result overflows.

% Custom predicate, safe multiplication (safe_mult).
safe_mult(A, B, Result) :-
    A \= 0,
    Div is A * B / A,
    nat_beq(Div, B, Check),
    (   Check -> Result is A * B ;
        Result = error
    ).

% Used to check if one natural number is less than or equal to another natural number.
nat_ble(Nat1, Nat2, true) :-
    Nat1 =< Nat2.
nat_ble(_, _, false).

% Used to check if two natural numbers are equal.
nat_beq(Nat1, Nat2, true) :-
    Nat1 =:= Nat2.
nat_beq(_, _, false).

:- dynamic inforMap/2.
main(storage):-
    asserta(inforMap(cbake, false)),
    cAStore(cbake, 16, 7769, 2326).

main(verify):-
    asserta(infor_RU(cbake, 26)),
    asserta(infor_QU(Id, 45401)),
    Limit is 2^126,
    certVerifier(cbake).
