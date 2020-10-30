{$M 16384,0,655360}
        {***********************************************************}
        {*                   Nguyen Trong Quyen                    *}
        {*                       A2 K30 PBC                        *}
        {*                       30 - 4 - V                        *}
        {***********************************************************}
Program TQA2K30PBC;
Uses Crt;
Const
     Dl         =       'Chess.in2p';
     tmp        =       'Chess.tmp';
     Kq         =       'Chess.out';
     h          :       array [0..3] of integer = (-4, -1, 1, 4);
                                        {0 - len tren}
                                        {1 - sang trai}
                                        {2 - sang phai}
                                        {3 - xuong duoi}
Type
    Arr2        =       array [1..16] of byte;
    arr3        =       array [1..2*maxint] of byte;
Var
   tr           :       ^arr3;
   tr1          :       ^arr3;
   n            :       word;
   i, k         :       byte;
   f            :       Text;
   Time         :       Longint absolute 0000: $0046c;
   LuuTime      :       Longint;
   s, t         :       word;


Procedure BatBit(var x: word; i: byte);
Begin
x := x or (1 shl (i - 1));
End;

Procedure TatBit(var x: word; i: byte);
Begin
x := x and (not (1 shl (i - 1)));
End;

Function LayBit(x: word; i: byte): byte;
Begin
Laybit := (x shr (i-1)) and 1;
End;

Procedure Input;
Var
   i, j         :       integer;
   k            :       char;
Begin
Assign(f, dl);
Reset(f);
s := 0;
t := 0;
for i := 1 to 4 do
    begin
    for j := 1 to 4 do
        begin
        read(f, k);
        if k = '1' then batbit(s, 4 * (i - 1) + j);
        end;
    readln(f);
    end;

for i := 1 to 4 do
    begin
    for j := 1 to 4 do
        begin
        read(f, k);
        if k = '1' then batbit(t, 4 * (i - 1) + j);
        end;
    readln(f);
    end;
Close(f);
Assign(f, kq);
Rewrite(f);
End;


Procedure Loangr(s, t: word);
var
   i, u         :       word;
   sl, j, k     :       byte;
   dau, cuoi    :       word;
   d1, c1       :       word;
   ok           :       boolean;
   bit          :       arr2;
   {---------------------}
   procedure tinh(k: integer);
   var
      tg        :       integer;
   begin
   if bit[sl] = 0 then
      begin
      u := i;     batbit(u,sl);     tatbit(u,j);
{      for tg := 16 downto 1 do        write(laybit(i,tg));     write('    ');
      for tg := 16 downto 1 do        write(laybit(u,tg));     write('    ');
      write(j, '  ', sl, '  ', k, '    ');
      for tg := 16 downto 1 do        write(laybit(t,tg));     writeln;}
      if tr^[u] = 0 then
         begin
         ok := false;
         tr^[u] := sl * 4 + 3 - k; {luu bit sl va phep bien doi 3 - k - phep nguoc}
         if d1 > u then d1 := u
         else    if c1 < u then c1 := u;
         end;
      end;
   end;

begin
new(tr);
fillchar(tr^, sizeof(tr^), 0);
dau := s;
if dau > t then dau := t;
cuoi := s;
tr^[s] := 1;
repeat
      ok := true;
      d1 := dau;
      c1 := cuoi;
      for i := dau to cuoi do
          if tr^[i] <> 0 then
             begin
             for j := 1 to 16 do bit[j] := laybit(i,j);
             for j := 1 to 16 do
                 if bit[j] = 1 then
                    begin
                    {phep bien doi 0 - len tren}
                    if j > 4 then
                       begin
                       sl := j - 4;   tinh(0);   if u = t then exit;
                       end;
                    {phep bien doi 1 - sang trai}
                    if j mod 4 <> 1 then
                       begin
                       sl := j - 1;   tinh(1);   if u = t then exit;
                       end;
                    {phep bien doi 2 - sang phai}
                    if j mod 4 <> 0 then
                       begin
                       sl := j + 1;   tinh(2);   if u = t then exit;
                       end;
                    {phep bien doi 3 - xuong duoi}
                    if j < 13 then
                       begin
                       sl := j + 4;   tinh(3);   if u = t then exit;
                       end;
                    end;
             end;
          dau := d1;
          cuoi := c1;
          Until  ok;
end;


Procedure Output;
Var
   bit,pbdoi    :       byte;        {bit va phep bien doi}
   i            :       word;
   g            :       text;
   x1, x2       :       word;
   y1, y2       :       word;
   dem          :       longint;
   u, v         :       word;
Begin
if tr^[s] = 0 then begin writeln(f, -1); close(f); exit; end;

assign(g, tmp);
rewrite(g);
u := s;
dem := 0;
repeat
      bit := tr^[u] div 4;
      pbdoi := tr^[u] mod 4;
      v := u; tatbit(v,bit);batbit(v,bit + h[pbdoi]);
      inc(dem);
      x1 := (bit - 1) div 4 + 1;
      y1 := bit mod 4;
      if y1 = 0 then y1 := 4;
      x2 := (bit + h[pbdoi] - 1) div 4 + 1;
      y2 := (bit + h[pbdoi]) mod 4;
      if y2 = 0 then y2 := 4;
      writeln(g, x1, ' ', y1, ' ', x2, ' ', y2 );

{      for i := 16 downto 1 do  write(laybit(u,i));      writeln;
      for i := 16 downto 1 do  write(laybit(v,i));      writeln;
      write(x1, ' ', y1, ' ', x2, ' ', y2, '     ', bit, ' ', bit+h[pbdoi] );
      readln;}

      u := v;
      until (u = t) or (tr^[u] = 0);


writeln(f, dem);
close(g);
assign(g, tmp);
reset(g);
for i := 1 to dem do
    begin
    readln(g, x1, y1, x2, y2);
    writeln(f, x1, ' ', y1, ' ', x2, ' ', y2 );
    end;
Close(g);
Close(f);
End;

Begin
clrscr;
{n := 65280;
for i := 1 to 16 do write(laybit(n,i));
readln;
n := 65040;
for i := 1 to 16 do write(laybit(n,i));
readln;}

LuuTime := Time;
Input;
Loangr(t, s);
Output;
Textcolor(red);
Writeln('          *********************************************************');
Writeln('          *                  Time Run: ', (Time - LuuTime)/18.21:8:2,'                   *');
Writeln('          *********************************************************');
Textcolor(11);
Writeln('                       Please any key to exit');
Readln;
End.
1111
1111
0000
0000
0000
0000
1111
1111