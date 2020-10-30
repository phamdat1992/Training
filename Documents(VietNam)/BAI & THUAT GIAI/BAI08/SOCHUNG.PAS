        {***********************************************************}
        {*                   Nguyen Trong Quyen                    *}
        {*                       A2 K30 PBC                        *}
        {***********************************************************}
Program TQA2K30PBC;
Uses Crt;
Const
     Dl                 =       'Sochung.inp';
     Kq                 =       'Sochung.out';
     Maxn               =       256;
Type
    Arr1                =       Array [1..Maxn] of Byte;
    Mt                  =       Array [1..Maxn] of ^Arr1;
Var
   p                    :       Mt; {mang qhd}
   x, y                 :       string;
   s                    :       string;
   n                    :       Integer;
   f                    :       Text;
   Time                 :       Longint absolute 0000: $0046c;
   LuuTime              :       Longint;
   Pmark                :       pointer;

Procedure Input;
Var
   i, j         :       integer;
Begin
Assign(f, dl);
Reset(f);
Readln(f, x);
Readln(f, y);
Close(f);
Assign(f, kq);
Rewrite(f);
End;

Function max(a, b: byte): byte;
begin
if a < b then max := b
else max := a;
end;


Procedure KhoiTao;
Var
   i, j         :       Integer;
Begin
For i := 1 to length(x) + 1 do
    begin
    new(p[i]);
    fillchar(p[i]^, sizeof(p[i]^), 0);
    end;
{Tim mang quy hoach hong p}
For i := length(x) downto 1 do
    For j := length(y) downto 1 do
        begin
        if x[i] = y[j] then p[i]^[j] := p[i+1]^[j+1] + 1
        else                p[i]^[j] := max(p[i+1]^[j], p[i]^[j+1]);
        end;
End;


Procedure Xuli;
Var
   i, j         :       Integer;
   i1, j1, max  :       byte;
   k            :       char;
Begin
max := p[1]^[1]; i1 := 1; j1 := 1;
s := '';
repeat
      for k := '9' downto '0' do
          begin
          i := i1; j := j1;
          While (i < length(x)) and (x[i] <> k) do inc(i);
          While (j < length(y)) and (y[j] <> k) do inc(j);
          If p[i]^[j] = max then
             begin i1 := i + 1; j1 := j + 1; break; end;
          end;
      s := s + k;  {ket nap ki tu k vao s}
      dec(max);
      until max = 0;
End;

Procedure Output;
Var
   i, j         :       Integer;
Begin
If s = '' then          Writeln(f, 0)
Else
    Begin
    While s[1] = '0' do delete(s,1,1);
    Writeln(f, s);
    End;
Close(f);
End;

Begin
clrscr;
Mark(Pmark);
LuuTime := Time;
Input;
KhoiTao;
Xuli;
Output;
Release(Pmark);
Textcolor(red);
Writeln('          *********************************************************');
Writeln('          *                  Time Run: ', (Time - LuuTime)/18.21:8:2,'                   *');
Writeln('          *********************************************************');
Textcolor(11);
Writeln('                       Please any key to exit');
End.
19012304
034012