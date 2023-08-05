%阶段函数1：CAStore(ID, EU , QA, QB , Ppub, PA, PB)
% 定义函数 cAStore
:- use_module(library(clpfd)).
cAStore(Id, EU, Ppub, RCAU) :-
    % 检查 InforMap[id] 的 Storaged 属性是否为 true
    (inforMap(Id, Storaged), Storaged = true ->
        % 如果为 true，返回 "Fail"
        write('Fail')
    ;
        % 否则，创建一个新的结构 Infor
        % 设置 Infor.Ppub 为 Ppub
        assertz(infor_Ppub(Id, Ppub)),
        write(infor_Ppub(Id, Ppub)),nl,
        % 设置 Infor.RCA^U 为 Rca^U
        assertz(infor_RCAU(Id, RCAU)),
        write(infor_RCAU(Id, RCAU)),nl,
        % 设置 Infor.eU 为 EU
        assertz(infor_EU(Id, EU)),
        write(infor_EU(Id, EU)),nl,
        % 设置 Infor.Storaged 为 true
        assertz(infor(Id, true)),
        write(infor(Id, true)),nl,
        % 更新 InforMap[id]
        retract(inforMap(Id, _)),
        assertz(inforMap(Id, Infor)),
        % 返回 "Success Store"
        write('Success Store')
    ).

%定义函数 certVerifier(Id):
certVerifier(Id) :-
    % 检查 InforMap[id] 的 Storaged 属性是否不等于 true
    (inforMap(Id, Storaged), Storaged \= true ->
        % 如果不等于 true，返回 "Fail"
        write('Fail')
    ;
        % 否则，验证等式并返回相应的结果
        % 计算 eU * (RU + RCAU) + Ppub 的值
        % 获取 eU 的值
        infor_EU(Id, EU),
        Limit #> EU,
        % 获取 RU 的值
        infor_RU(Id, RU),
        Limit #> RU,
        % 获取 RCAU 的值
        infor_RCAU(Id, RCAU),
        Limit #> RCAU,
        % 获取 Ppub 的值
        infor_Ppub(Id, Ppub),
        Limit #> Ppub,
        % 计算 eU * (RU + RCAU) + Ppub 的结果
        safe_plus(RU, RCAU, Result_1),
        safe_mult(EU, Result_1, Result_2),
        safe_plus(Result_2, Ppub, ExpressionResult),
        %ExpressionResult is EU * (RU + RCAU) + Ppub,
        % 获取 QU 的值
        infor_QU(Id, QU),
        % 检查 eU * (RU + RCAU) + Ppub 是否等于 QU
        (ExpressionResult =:= QU ->
            % 如果相等，返回 true
            write(true)
        ;
            % 否则，返回 false
            write(false)
        )
    ).

% 自定义谓词，检查一个项是否为无符号整数
is_unsigned_integer(X) :-
    integer(X),             % 检查是否为整数
    X >= 0.                 % 大于等于 0

% 自定义谓词，安全加法 (safe_plus)
safe_plus(A, B, Result) :-
    Sum is A + B,
    nat_ble(A, Sum, Check1),
    nat_ble(B, Sum, Check2),
    Check1, Check2,
    Result is Sum.
safe_plus(_, _, error). % 结果溢出时返回错误

% 自定义谓词，安全乘法 (safe_mult)
safe_mult(A, B, Result) :-
    A \= 0,
    Div is A * B / A,
    nat_beq(Div, B, Check),
    (   Check -> Result is A * B ;
        Result = error
    ).

% 用于检查一个自然数是否小于等于另一个自然数
nat_ble(Nat1, Nat2, true) :-
    Nat1 =< Nat2.
nat_ble(_, _, false).

% 用于检查两个自然数是否相等
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
