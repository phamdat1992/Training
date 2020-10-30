        {***********************************************************}
        {*                   Nguyen Trong Quyen                    *}
        {*                       A2 K30 PBC                        *}
        {***********************************************************}
Program TQA2K30PBC;
Uses Crt;
Const
     Dl         =       'Mahoa.in0p';
     Kq         =       'Mahoa.out';
     Maxn       =       100;
Type
    String100   =       String[100];
    Arr1        =       Array [1..maxn] of string100;
    Arr2        =       Array [1..maxn] of integer;
Var
   a, tg        :       arr1;
   dd           :       arr2;
   s            :       string100;
   n, k         :       Integer;
   f, g         :       Text;
   Time         :       Longint absolute 0000: $0046c;
   LuuTime      :       Longint;

Procedure Input;
Var
   i, j         :       integer;
Begin
Assign(f, dl);
Reset(f);
Assign(g, kq);
Rewrite(g);
End;


procedure QuickSort(Lo, Hi: Integer);
{Sap xep day cac string a[i]}
var
   y            :       string100;
          procedure Sort(l, r: Integer);
          var
          i, j          :       integer;
          x             :       string100;
          begin
          i := l; j := r; x := a[(l+r) DIV 2];
          repeat
                while a[i] < x do i := i + 1;
                while x < a[j] do j := j - 1;
                if i <= j then
                   begin
                   y := a[i]; a[i] := a[j]; a[j] := y;
                   i := i + 1; j := j - 1;
                   end;
                until i > j;
          if l < j then Sort(l, j);
          if i < r then Sort(i, r);
          end;
begin {QuickSort};
  Sort(Lo,Hi);
end;


function xaucantim(s: string100; k: integer): string100;
var
   i, j         :       integer;
   d            :       string100;
   dem          :       integer;
begin
n := length(s);
dem := 0;
fillchar(a, sizeof(a), 0);
repeat
      inc(dem);
      for i := 1 to n do
          a[i] := s[i] + a[i];
      {tg := a;
      {Sap xep lai a
      for i := 1 to n do
          a[dd[i]] := tg[i];}
      quicksort(1, n);
      until dem = n;
xaucantim := a[k];
end;



Procedure Xuli;
Var
   i, j         :       Integer;
Begin
While not eof(f) do
      begin
      readln(f, s);
      readln(f, k);
      writeln(g, xaucantim(s, k));
      end;
End;

Procedure Output;
Var
   i, j         :       Integer;
Begin
Close(f);
Close(g);
End;

Begin
clrscr;
LuuTime := Time;
Input;
Xuli;
Output;
Textcolor(red);
Writeln('          *********************************************************');
Writeln('          *                  Time Run: ', (Time - LuuTime)/18.21:8:2,'                   *');
Writeln('          *********************************************************');
Textcolor(11);
Writeln('                       Please any key to exit');
Readln;
End.
NNBAAA
4