const
  MaxL = 20;
  MaxN = 4000;
type
  Words    = string[MaxL];
  matrix   = array [0..MaxL,0..MaxL] of word;
var
   f,g:text;
   sai3,kc1,kc2,dem,sai1,sai2,m,n,i,j,k,t,sotu:integer;
   lex:array[1..maxL] of words;
   s1,s,s2:words;ok:boolean;
procedure Cham;
begin
sotu:=0;
while (not(eof(f)))and(not(eof(g))) do
begin
inc(sotu);
readln(f,kc1);readln(g,kc2);
if kc1<>kc2 then inc(sai1);
readln(f,m);readln(g,n);
for j:=1 to n do readln(g,lex[j]);
if m<>n then inc(sai2);
for i:=1 to m do
    begin
     ok:=false;
     readln(f,s1);
     for j:=1 to n do if s1=lex[j] then begin ok:=true;break;end;
     if not(ok) then inc(sai3);
    end;{for}
end;{while}
end;
BEGIN
write('test thu ');readln(t);str(t,s);
sai1:=0;sai2:=0;sai3:=0;
assign(f,'nearest.sol');reset(f);
assign(g,'near'+s+'.sol');reset(g);
cham;
close(f);close(g);
writeln('Ket qua: ',(200-sai1*10-(sai2+sai3)*5):10);
readln;
END.