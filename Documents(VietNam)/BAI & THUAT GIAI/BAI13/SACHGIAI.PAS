{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R+,S+,T-,V+,X+}
{$M 16384,0,655360}
uses crt;
const
     inp        =       'chanel.in3210';
     out        =       'chanel.out';
type
    ban         =       record
                        t, s, e :       byte;
                        end;
var
   f            :       text;
   Na, Nb, i, j :       integer;
   k, l, t      :       integer;
   a            :       array[1..200] of ban;
   b            :       array[1..200,0..200] of byte;
   Time         :       Longint absolute 0000: $0046c;
   LuuTime      :       Longint;
procedure nhap;
begin
fillchar(a, sizeof(a), 0);
fillchar(b, sizeof(b), 0);
nb := 0;
assign(f, inp);
reset(f);
readln(f, na);
for i := 1 to na do
    begin
    readln(f, a[i].s, a[i].e);
    a[i].t := i;
    end;
close(f);
end;

procedure sort;
var
   t            :       ban;
begin
for i := 1 to na - 1 do
    for j := i + 1 to na do
        if (a[i].s > a[j].s) or ((a[i].s = a[j].s) and (a[i].e < a[j].e)) then
           begin
           t := a[i];
           a[i] := a[j];
           a[j] := t;
           end;
end;

function pos(nu: integer): integer;
var
   i            :       integer;
begin
for i := 1 to na do
    if a[i].t = nu then break;
pos := i;
end;

procedure main;
var
   bool         :       boolean;
begin
sort;
for i := 1 to na do
    begin
    bool := true;
    for j := 1 to nb do
        begin
        t := pos(b[j,b[j,0]]);
        if a[i].s >= a[t].e then
           begin
           k := j;
           Bool := false;
           break;
           end;
        end;
    if bool then
       begin
       inc(nb);
       b[nb,0] := 1;
       b[nb,1] := a[i].t;
       end
    else
       begin
       inc(b[k,0]);
       b[k,b[k,0]] := a[i].t;
       end;
    end;
end;

procedure xuat;
begin
assign(f, out);
rewrite(f);
writeln(f, nb);
for i := 1 to nb do
    begin
    for j := 1 to b[i,0] do
        write(f, b[i,j], ' ');
    writeln(f);
    end;
close(f);
end;

begin
luutime := time;
nhap;
main;
xuat;
Textcolor(red);
Writeln('          *********************************************************');
Writeln('          *                  Time Run: ', (Time - LuuTime)/18.21:8:2,'                   *');
Writeln('          *********************************************************');
Textcolor(11);
Writeln('                       Please any key to exit');
Readln;
end.