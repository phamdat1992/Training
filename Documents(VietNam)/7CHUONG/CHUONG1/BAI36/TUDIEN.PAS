uses crt;
const
  MaxL = 20;
  MaxN = 4000;
type
  Words    = string[MaxL];
  matrix   = array [0..MaxL,0..MaxL] of word;
  SelMasiv = array [1..MaxL] of Boolean;
  PRecStr  = ^RecStr;
  RecStr   = record
               Str  : Words;
               next : PRecStr;
             end;
  PointerMasiv = array[1..MaxN] of Word;
var
  s1,s2,result       : Words;
  d,i,j,min,num      : word;
  name               : string;
  datf,out,inf       : text;
  Distance           : matrix;
  color1,color2      : SelMasiv;
  first,now,last     : PRecStr;
  Solution           : PointerMasiv;
  SolNum             : word;
function Change (a,b: char): word;
begin
  if (a=b) then
    Change:=0
  else Change:=1;
end;
function DelChar (a: char ): word;
begin
  DelChar:=1;
end;
function InsertChar (b:char): word;
begin
  InsertChar:=1;
end;
function CheckDistance (var A: Words; var B: Words): word;
  var
    i,j,t  : word;
    nA,nB  : byte;
    m1,m2  : word;
begin
  FillChar(Distance,sizeof(Distance),0);
  Distance[0,0]:=0;
  nA:=Length(A);
  nB:=Length(B);
  for i:=1 to nA do
    Distance[i,0]:=Distance[i-1,0]+DelChar(A[i]);
  for i:=1 to nB do
    Distance[0,i]:=Distance[0,i-1]+InsertChar(B[i]);
  for i:=1 to nA do
    for j:=1 to nB do
      begin
        Distance[i,j]:=Distance[i-1,j-1]+Change(A[i],B[j]);
        m1:=Distance[i-1,j]+DelChar(A[i]);
        m2:=Distance[i,j-1]+ InsertChar(B[j]);
        if (m1<Distance[i,j]) then
          Distance[i,j]:=m1;
        if (m2<Distance[i,j]) then
          Distance[i,j]:=m2;
        if (i>1) and (j>1) and (A[i]<>B[j]) then
          begin
            if (A[i]=B[j-1]) then
              begin
                t:=i-1;
                while (t>0) and (B[j]<>A[t]) do
                  dec(t);
                if (t>0) and (Distance[i,j]>Distance[t-1,j-2]+(i-t)) then
                  Distance[i,j]:=Distance[t-1,j-2]+(i-t);
              end;
            if (A[i-1]=B[j]) then
              begin
                t:=j-1;
                while (t>0) and (B[t]<>A[i]) do
                  dec(t);
                if (t>0) and (Distance[i,j]>Distance[i-2,t-1]+(j-t)) then
                  Distance[i,j]:=Distance[i-2,t-1]+(j-t);
              end;
          end;
      end;
  CheckDistance:=Distance[nA,nB];
end;
procedure SetPairs (var s1: Words; var s2: Words;
                    var sA: SelMasiv; var sB: SelMasiv);
  var
    i,j   : word;
begin
  FillChar(sA,sizeof(sB),0);
  FillChar(sA,sizeof(sB),0);
  i:=Length(s1);
  j:=Length(s2);
  while (i<>0) and (j<>0) do
      if (Distance[i,j]=Distance[i-1,j]+DelChar(s1[i])) then
        i:=i-1
      else
        if (Distance[i,j]=Distance[i,j-1]+InsertChar(s2[j])) then
          j:=j-1
        else
          begin
            sA[i]:=true; sB[j]:=true;
            dec(i); dec(j);
          end;
end;
BEGIN
  FillChar(Distance,sizeof(Distance),0);
  clrscr;
  assign(inf,'text.dat');
  reset(inf);
  assign(datf,'lex.dat');
  assign(out,'nearest.sol');
  rewrite(out);
while not(seekeof(inf)) do
begin
  while not(eoln(f)) do
  begin
  readln(inf,s1);
repeat
  reset(datf);
  readln(datf,num);
  writeln;
  min:=MaxL+1;
  SolNum:=0;
  for i:=1 to num do
    begin
      readln(datf,s2);
      d:=CheckDistance(s1,s2);
      if d=min then
        begin
          inc(SolNum);
          Solution[SolNum]:=i;
        end
      else
        if d<min then
          begin
            SolNum:=1;
            Solution[SolNum]:=i;
            min:=d;
          end;
    end;
  Close(datf);
  writeln(out,min);
  writeln(out,SolNum);
  reset(datf);
  j:=1;
  readln(datf,num);
  i:=1;
  while (j<=SolNum) and (i<=num) do
    begin
      readln(datf,s2);
      if (i=Solution[j]) then
        begin
          inc(j);
          writeln(out,s2);
        end;
      inc(i);
    end;
until eof(inf);
   end;
   readln(inf)'
end;
   Close(out);
END.
