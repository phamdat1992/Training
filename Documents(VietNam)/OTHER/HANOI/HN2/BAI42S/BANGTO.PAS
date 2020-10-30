Uses crt;
const nt:array[1..15] of byte=(2,3,5,7,11,13,17,19,23,29,31,37,41,43,47);
      fi='inp.b49';
      fo='bangto.out';
var   m,n,max:longint;
      a:array[0..250,0..250] of byte;
      luu,spt:array[0..50] of byte;
      dd,be1,be2,fin1,fin2:longint;
      maxso:longint;
      tap:set of byte;

function  ok(i,j:byte):boolean;
var   k,d,dem:byte;
      b:array[1..15] of byte;
begin
   ok:=true;
   fillchar(b,sizeof(b),0);
   k:=j; d:=0; dem:=0;
   while k>0 do
    begin
      inc(b[luu[k]]);
      if luu[k]=i then inc(dem);
      k:=k-nt[luu[k]];
    end;
    if dem=0 then exit;
    if dem=2 then begin ok:=false;exit;end;
    if dem=1 then
     for k:=1 to 15 do
      if b[k]=2 then begin ok:=false;exit;end;
end;

procedure init;
begin
   fillchar(spt,sizeof(spt),0);
   luu:=spt;
   spt[0]:=1;max:=0;
   spt[2]:=2;spt[3]:=2;spt[4]:=3;
   luu[2]:=1;luu[3]:=2;luu[4]:=1;
end;

procedure taomang;
var  i,j:byte;
begin
 init;
 for i:=5 to 50 do
  for j:=1 to 15 do
   if (nt[j]<=i)  and (spt[i-nt[j]]>0)  then
    if ok(j,i-nt[j]) then
     if spt[i]<=spt[i-nt[j]]+1 then
      begin
        spt[i]:=spt[i-nt[j]]+1;
        luu[i]:=j;
      end;
end;

procedure readfile;
var  i,j,k:byte;
      f:text;
begin
  taomang;
  tap:=[];
  fillchar(a,sizeof(a),0);
  assign(f,fi);
  reset(f);
  readln(f,m,n);
  for i:=1 to m do
   for j:=1 to n do
    begin
     read(f,k);
     a[i,j]:=spt[k]-1;
     if a[i,j]>max then max:=a[i,j];
     if not (a[i,j] in tap) then tap:=tap+[a[i,j]];
    end;
    close(f);
end;

procedure  xuli;
var  i,j,min,sta,k:longint;
     sl1,sl:array[1..250] of byte;
begin
  i:=1;maxso:=0;
   fillchar(sl1,sizeof(sl1),0);
  while i<=m do
   begin
     fillchar(sl,sizeof(sl),0);
     j:=1;
     while j<=n do
      begin
        min:=250;
        if a[i,j]=dd then
        begin
          sta:=j;
          while (a[i,j]=dd) and (j<=n) do
             begin
               sl[j]:=1;
               if a[i-1,j]=dd then inc(sl[j],sl1[j]);
               if sl[j]<min then min:=sl[j];
               inc(j);
             end;
             dec(j);
             if maxso<(j-sta+1)*min then
             begin
               maxso:=(j-sta+1)*min;
               be1:=i-min+1;
               be2:=sta;
               fin1:=i;
               fin2:=j;
             end;
        end;
        inc(j);
      end;
      inc(i);
      sl1:=sl;
  end;
end;

begin  clrscr;
 readfile;
 for dd:=1 to max do
  if dd in tap then
    begin
    xuli;
    end;
    writeln(maxso);
    writeln('  ',be1,'  ',be2,'  ',fin1,'  ',fin2);
 readln
end.

3 4
2 3 8 7
3 6 8 7
2 5 9 7
10 10
15 10 14 11 11 11 13 10 10 14
15 13 15 13 14 14 13 14 14 12
10 12 12 12 15 15 12 11 11 13
15 11 15 10 15 11 10 10 12 13
13 12 14 13 11 13 10 14 14 12
11 15 13 13 12 13 10 12 13 15
15 11 12 13 13 10 11 15 13 15
14 14 11 12 12 15 12 14 13 13
14 15 11 11 11 15 10 14 10 12
11 13 11 12 15 10 10 11 15 15

