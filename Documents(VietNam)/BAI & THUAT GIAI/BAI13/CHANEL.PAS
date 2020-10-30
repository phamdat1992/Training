{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R+,S+,T-,V+,X+}
{$M 16384,0,655360}
        {***********************************************************}
        {*                   Nguyen Trong Quyen                    *}
        {*                       A2 K30 PBC                        *}
        {*                     30 - 4 - 2002                       *}
        {*                Phan Phoi Kenh - Trang 22                *}
        {*                     Xay Dung Do Thi                     *}
        {***********************************************************}
Program TQA2K30PBC;
Uses Crt;
Const
     Dl         =       'Chanel.in';
     Kq         =       'Chanel.ou';
     Maxn       =       5001;
Type
    rec         =       record
                        s, t  : longint;
                        end;
    Arr1        =       Array [1..Maxn] of Integer;
    Arr2        =       Array [1..Maxn] of rec;
    Arr3        =       Array [1..Maxn] of longint;
Var
   a            :       Arr2;
   ind, nhom    :       Arr1;
   t            :       ^Arr3;
   n            :       Integer;
   f            :       Text;
   Time         :       Longint absolute 0000: $0046c;
   LuuTime      :       Longint;
   Dem          :       integer;

Procedure Input;
Var
   i, j         :       integer;
Begin
Assign(f, dl);
Reset(f);
Readln(f, n);
fillchar(a, sizeof(a), 0);
For i := 1 to n do
    readln(f, a[i].s, a[i].t);
Close(f);
Assign(f, kq);
Rewrite(f);
End;

Procedure SapXep;
Var
   i, j         :       integer;
   x            :       rec;
   tg           :       Integer;
Begin
For i := 1 to n - 1 do
    For j := i + 1 to n do
        if (a[i].s > a[j].s) or ((a[i].s = a[j].s) and (a[i].t > a[j].t)) then
           begin
           x := a[i];     a[i] := a[j];     a[j] := x;
           tg := ind[i];  ind[i] :=ind[j];  ind[j] := tg;
           end;
End;



Procedure KhoiTao;
Var
   i, j         :       Integer;
Begin
For i := 1 to n do
    ind[i] := i;
SapXep;
New(t);
fillchar(t^, sizeof(t^), 0);
fillchar(nhom, sizeof(nhom), 0);
{nhom[i] luu cach phan cong nguoi khach i vao nhom thu nhom[i]}
{t[i] chi thoi gian t lon nhat su dung kenh ket thuc}
End;


Procedure Xuli;
Var
   i, j, u      :       Integer;
   found        :       boolean;
Begin
Dem := 0;
For i := 1 to n do
    Begin
    found := false;
    For j := 1 to dem do
        begin
        if t^[j] <= a[i].s then
           begin found := true; u := j; break; end;
        end;
    if found then
       begin
       nhom[i] := j;
       t^[j] := a[i].t;
       end
    else
       begin
       inc(dem);
       nhom[i] := dem;
       t^[dem] := a[i].t;
       end;
    End;
End;

Procedure Output;
Var
   i, j         :       Integer;
Begin
writeln(f, dem);
For i := 1 to dem do
    Begin
    For j := 1 to n do
        if nhom[j] = i then write(f, ind[j], ' ');
    writeln(f);
    End;
Dispose(t);
Close(f);
End;

Begin
clrscr;
LuuTime := Time;
Input;
KhoiTao;
Xuli;
Output;
Textcolor(red);
Writeln('          *********************************************************');
Writeln('          *                  Time Run: ', (Time - LuuTime)/18.21:8:2,'                   *');
Writeln('          *********************************************************');
Textcolor(11);
Writeln('                       Please any key to exit');
End.
