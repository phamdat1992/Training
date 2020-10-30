{$M 65520, 0, 655360}
{$R-}
Uses crt;
Const
     fi = 'doico.in0';
     fo = 'doico.out';
     max = 10001;
type
    element1 = record
               elo : integer;
               pos : integer;
               end;
    dat1 = array [1..max] of element1;
    dat2 = array [1..max] of integer;
var
   n    :       integer;
   a, b :       ^dat1;
   maxpoint     :    longint;
   result       :    dat2;
   Time         :       Longint absolute 0000: $0046c;
   LuuTime      :       Longint;
procedure readdata(finame: string);
var
   f    :       text;
   i    :       integer;
begin
assign(f, finame);
reset(f);
readln(f, n);
new(a);
new(b);
for i := 1 to n do
    begin
    readln(f, a^[i].elo, b^[i].elo);
    a^[i].pos := i;
    b^[i].pos := i;
    end;
close(f);
end;

procedure writeresult(filename: string);
var
   f            :       text;
   i            :       integer;
begin
assign(f, filename);
rewrite(f);
writeln(f, maxpoint);
for i := 1 to n do
    write(f, result[i], ' ');
close(f);
dispose(a);
dispose(b);
end;

Procedure swap(var a, b: element1);
var
   tmp  :       element1;
begin
tmp := a;
a := b;
b := tmp;
end;

procedure qsort(var dat: dat1; lo, hi: integer);
var
   i, j, mid    :       integer;
begin
i := lo;
j := hi;
mid := dat[(i + j) div 2].elo;
repeat
      while (dat[i].elo < mid) do inc(i);
      while dat[j].elo > mid do dec(j);
      if (i <= j) then begin swap(dat[i], dat[j]); inc(i); dec(j); end;
      until i > j;
if lo < j then qsort(dat, lo, j);
if hi > i then qsort(dat, i, hi);
end;

function diem(var sa, sb: dat1; first: integer): longint;
var
   i, j :       integer;
   s    :       longint;
begin
s := 0;
j := first;
for i := 1 to n do
    begin
    if sa[i].elo < sb[j].elo then inc(s, 2);
    if sa[i].elo = sb[j].elo then inc(s, 1);
    inc(j);
    if j > n then j := j - n;
    end;
diem := s;
end;

procedure solve;
var
   sa, sb               :       ^dat1;
   i, j, k, first       :       integer;
   tmp                  :       longint;
begin
new(sa); new(sb);
sa^ := a^;
sb^ := b^;
qsort(sa^, 1, n);
qsort(sb^, 1, n);
first := 1;
for i := 1 to n do
    begin
    tmp := diem(sa^, sb^, first);
    if tmp > maxpoint then
       begin
       maxpoint := tmp;
       k := first;
       begin result[sa^[i].pos] := sb^[k].pos; inc(k);
             if k > n then k := k - n;
             end;
       end;
    inc(first);
    end;
dispose(sa);
dispose(sb);
end;

begin
LuuTime := Time;
readdata(fi);
solve;
writeresult(fo);
Textcolor(red);
Writeln('          *********************************************************');
Writeln('          *                  Time Run: ', (Time - LuuTime)/18.21:8:2,'                   *');
Writeln('          *********************************************************');
Textcolor(11);
Writeln('                       Please any key to exit');
readln;
end.