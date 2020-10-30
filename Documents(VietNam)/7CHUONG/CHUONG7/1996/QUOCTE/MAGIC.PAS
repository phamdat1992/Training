{$A+,B-,D+,E+,F+,G+,I+,L+,N+,O-,P-,Q+,R-,S-,T-,V+,X+}
{$M 65520,0,655360}
PROGRAM Magic;
  USES
    TIME;
  CONST
    GT : array[0..8] of longint = (1,1,2,6,24,120,720,5040,40320);
  TYPE
    MyIndex = array[1..8] of byte;
    Rotates = (A, B, C);
  Var
    S, D, X : MyIndex;
    K       : array[1..40320] of byte;
    NS, ND  : word;
    TEMP    : MyIndex;
    N       : word;
    p       : Rotates;
    F1, L1, F2, L2 : word;
    Q1, Q2 : array[1..6000] of word;

  PROCEDURE Input;
    Const
      FileName = 'magic.inp';
    Var
      f : text;
      i : byte;
    Begin
      Assign(f, filename); reset(f);
      for i := 1 to 8 do
        Begin
          read(f, s[i]);
          d[i] := i;
        End;
      close(f);
    End;

  PROCEDURE Rotate( RT : rotates; Times : byte);
    Var
      i, t, u, v, n : byte;
    Begin
      Case Rt of
        A : for i := 1 to 4 do
              Begin
                t := TEMP[i];
                TEMP[i] := TEMP[9 - i];
                TEMP[9 - i] := t;
              End;
        B : For n := 1 to Times do
              Begin
                u := TEMP[4];
                v := TEMP[5];
                for i := 4 downto 2 do
                  Begin
                    TEMP[i] := TEMP[i - 1];
                    TEMP[9 - i]  := TEMP[9 - i + 1];
                  End;
                TEMP[1] := u;
                TEMP[8] := v;
              End;
        C : For n := 1 to Times do
              Begin
                t := TEMP[2];
                TEMP[2] := TEMP[7];
                TEMP[7] := TEMP[6];
                TEMP[6] := TEMP[3];
                TEMP[3] := t;
              End;
      End;
    End;

  PROCEDURE Process;
    Var used : array[0..8] of boolean;
    Procedure NumberToIndex(Number : Word; Var Index : Myindex);
      Var
        t, j, i : byte;
      Begin
        dec(number);
        fillchar(used, sizeof(used), false);
        For t := 1 to 8 do
          begin
            i := 0;
            while (i * gt[8 - t] <= number) do
              inc(i);
            dec(i);
            number := number - (i) * Gt[8-t];
            for j := 1 to 8 do
              if not used[j] then
                begin
                  if i = 0 then break;
                  dec(i);
                end;
            index[t] := j;
            used[index[t]] := true;
          end;
      End;
    Var f : array[1..8] of byte;
    Procedure IndexToNumBer(Index : Myindex; Var Number : Word);
      Var
        i, j : byte;
      Begin
        Number := 1;
        Fillchar(f, sizeof(f), 0);
        For i := 1 to 8 do
          for j := i+1  to 8 do
            if index[i] > index[j] then Inc(f[i]);
        For i := 1 to 8 do
          Number := Number + GT[ 8 - i ] * f[i];
      End;

    Procedure Output(index: word; left, right : byte);
      Const
        FileName = 'magic.out';
      Var
        S : String; i : byte;
        f : text;   l : word;
      Begin
        S := '';
        NumberToIndex(index, temp);
        l := index;
        k[index] := left;
        Repeat
          Case k[index] of
          1 : begin
                rotate(a, 1);
                IndextoNumber(temp, index);
                s := 'A' + s;
              end;
          2 : begin
                rotate(b, 3);
                IndextoNumber(temp, index);
                s := 'B' + s;
              end;
          3 : begin
                rotate(c, 3);
                IndextoNumber(temp, index);
                s := 'C' + s;
              end;
          End;
        Until index = NS;
        index := l;
        k[index] := right;
        NumberToIndex(index, temp);
        Repeat
          Case k[index] of
          4 : begin
                rotate(a, 1);
                IndextoNumber(temp, index);
                s := s + 'A';
              end;
          5 : begin
                rotate(b, 1);
                IndextoNumber(temp, index);
                s := s + 'B';
              end;
          6 : begin
                rotate(c, 1);
                IndextoNumber(temp, index);
                s := s + 'C';
              end;
          End;
        Until index = ND;

        Assign(f, filename); rewrite(f);
        writeln(f, length(s));
        for i := 1 to length(s) do writeln(f, s[i]);
        close(f);
        Writeln(' Eslaped time : ', Timenow);
        Halt;
      End;

    Begin
      Fillchar(k, sizeof(k), 0);
      F1 := 1; L1 := 0;
      F2 := 1; L2 := 0;
      IndexToNumber(S, NS);
      IndexToNumber(D, ND);
      Inc(L1); Q1[L1] := NS;
      Inc(L2); Q2[L2] := Nd;
      Repeat
        N := Q1[F1];
        Inc(F1);
        NumberToIndex(N, X);
        For P := A to C do
          Begin
            TEMP := X;
            Rotate(p, 1);
            IndexToNumber(TEMP, N);
            Case K[N] of
              0    : Begin
                       Inc(L1); Q1[L1] := N;
                       K[n] := ord(p) + 1;
                     End;
              4..6 : Output(n, ord(p)+1, k[n]);
            End;
          End;

        N := Q2[F2];
        Inc(F2);
        NumberToIndex(N, X);
        For P := A to C do
          Begin
            TEMP := X;
            Rotate(p, 3);
            IndexToNumber(TEMP, N);
            Case K[N] of
              0    : Begin
                       Inc(L2); Q2[L2] := N;
                       K[n] := ord(p) + 4;
                     End;
              1..3 : Output(n, k[n], ord(p)+4);
            End;
          End;
      Until ( (F1>L1) and (F2>L2)) or (K[NS] > 3)
            or ((K[ND] >0) and (K[ND] < 4));
      If K[NS] > 3 then Output(NS, 0, K[NS]);
      If ((K[ND] > 0) and (K[ND] < 4)) then Output(ND, K[ND], 0);
    End;

  Begin
    Input;
    Process;
  End.