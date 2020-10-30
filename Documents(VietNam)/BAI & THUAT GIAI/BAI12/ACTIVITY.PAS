        {***********************************************************}
        {*                   Nguyen Trong Quyen                    *}
        {*                       A2 K30 PBC                        *}
        {***********************************************************}
Program TQA2K30PBC;
Uses Crt;
Const
     Dl         =       'Activity.inp';
     Kq         =       'Activity.out';
     Maxn       =       32000;
     Cons       =       32;
Type
    Arr1        =       Array [0..Maxn] of integer;
    Arr2        =       Array [0..Maxn] of byte;
Var
   Tr           :       Arr1;  {Luu gia tri dau (Ai)}
   Trx          :       ^Arr1; {Luu i div 32}
   Try          :       ^Arr1; {Luu i mod 32}
   Luu          :       ^Arr1;
   max, Ghan    :       integer;
   n            :       Longint;
   f            :       Text;
   Time         :       Longint absolute 0000: $0046c;
   LuuTime      :       Longint;
   PMark        :       Pointer;


Procedure Capnhat(u: longint; d, c: integer);
Var
   i, j         :       integer;
Begin
If (tr[c] = 0) or (tr[c] < d) then
   Begin
   tr[c] := d;
   trx^[c] := u div cons;
   try^[c] := u mod cons;
   End;
End;

Procedure Input;
Var
   d, c         :       integer;
   i            :       longint;
Begin
Assign(f, dl);
Reset(f);
Readln(f, n);
Ghan := 0;
Fillchar(Tr, sizeof(Tr), 0);
New(Trx); New(Try);
Trx^ := Tr;
Fillchar(Try^, sizeof(Try^), 0);
For i := 1 to n do
    Begin
    Readln(f, d, c);
    If Ghan < c then Ghan := c;
    Capnhat(i, d, c);
    End;
Close(f);
Assign(f, kq);
Rewrite(f);
End;


Procedure Xuli;
Var
   i, j         :       Integer;
Begin
New(Luu);
Fillchar(Luu^, sizeof(Luu^), 0);
Max := 0;
i := 1; j := 1;
Repeat
      Inc(i);
      If tr[i] >= j then
         Begin
         Inc(Max); Luu^[Max] := i; j := i;
         End;
      Until i = Ghan;
End;

Procedure Output;
Var
   i, j         :       Integer;
   t            :       longint;
Begin
Writeln(f, Max);
For i := 1 to Max do
    Begin
    t := trx^[luu^[i]];
    t := t * cons;
    t := t + try^[luu^[i]];
    if t < 0 then Writeln(t);
    Write(f, t, ' ');
    End;
Close(f);
End;

Begin
clrscr;
Mark(PMark);
LuuTime := Time;
Input;
Xuli;
Output;
Release(PMark);
Textcolor(red);
Writeln('          *********************************************************');
Writeln('          *                  Time Run: ', (Time - LuuTime)/18.21:8:2,'                   *');
Writeln('          *********************************************************');
Textcolor(11);
Writeln('                       Please any key to exit');
End.
5
1 3
2 4
1 6
3 5
7 9