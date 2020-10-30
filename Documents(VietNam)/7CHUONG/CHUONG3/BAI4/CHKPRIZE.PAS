Program ChkPrize;
  uses crt;
  Const
    fin: string = 'PRIZE.IN0';
    fou: string = 'PRIZE.OUT';
    dapso1: array['0'..'9'] of longint =
    (1,
     6,
     10,
     17,
     36,
     0,
     196,
     207,
     537,
     900
    );
    dapso2: array['a'..'f'] of longint =
    ( 9984, 15168, 8798208, 14745600, 0, 471859200);
Var
    diem: integer;
    f: text;
    chon: char;
    ans: longint;


procedure Cham;
var  ds: longint;
begin
    Assign (F, fou);ReSet (F);
    Readln (F, ans);
    close(F);
    diem:=0;
    if chon in ['0'..'9'] then ds:= dapso1[chon]
    else ds:= dapso2[chon];
    if ans<> ds then
    begin
        writeln('         ?????????????????????????????????????????');
        writeln('                ERROR: Khong dung dap so:');
        writeln('                     Tim duoc: ', ans);
        writeln('                     Dap so  : ', ds);
        writeln('         ?????????????????????????????????????????');
        exit;
    end;
    writeln('          #############################');
    writeln('                 C O R R E C T !');
    writeln('          #############################');
    diem:=1;
end;

BEGIN
    clrscr;
    writeln('                      CHUONG TRINH CHAM PRIZE');
    writeln('               ======================================');
    write  ('                      Cho ten file du lieu: PRIZE.IN');
    chon:=readkey; writeln(chon);
    fin:= 'PRIZE.IN'+chon;
    writeln; writeln; writeln;
    Cham;
    writeln; writeln; writeln;
    writeln('                    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$');
    writeln('                             Diem: ', diem);
    writeln('                    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$');
    readln;
END.


Ans to Test 1
6
a3 a4 a5 a6 b2 b7 c1 c8 d1 d8 e1 e8 f1 f8 g2 g7 h3 h4 h5 h6
Ans to Test 2
10
c3 c4 c5 c6 d3 d4 d5 d6 e3 e4 e5 e6 f3 f4 f5 f6
Ans to Test 3
17
a1 a8 h1 h8
Ans to Test 4
36
b4 b5 d2 d7 e2 e7 g4 g5
Ans to Test 5
0
Ans to Test 6
196
b3 b6 c2 c7 f2 f7 g3 g6
Ans to Test 7
207
b4 b5 d2 d7 e2 e7 g4 g5
Ans to Test 8
537
a1 a8 h1 h8
Ans to Test 9
900
c4 c5 d3 d6 e3 e6 f4 f5

Ans to Test 0
1
a1 a2 a3 a4 a5 a6 a7 a8 b1 b2 b3 b4 b5 b6 b7 b8 c1 c2 c3 c4 c5 c6 c7 c8 d1 d2 d3 d4 d5 d6 d7 d8 e1 e2 e3 e4 e5 e6 e7 e8 f1 f2 f3 f4 f5 f6 f7 f8 g1 g2 g3 g4 g5 g6 g7 g8 h1 h2 h3 h4 h5 h6 h7 h8

Ans to Test a
9984
a2 a7 b1 b8 g1 g8 h2 h7
Ans to Test b
15168
d4 d5 e4 e5
Ans to Test c
8798208
a1 a8 h1 h8

Ans to Test d
14745600
c4 c5 d3 d6 e3 e6 f4 f5
Ans to Test e
0
Ans to Test f
471859200
c4 c5 d3 d6 e3 e6 f4 f5