{$A+,B-,D+,E-,F-,G+,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 16384,0,655360}

uses crt;

const
    dolech=1e-4;
    maxdiem=1000;
    maxdoan=10000;
    maxtren=500;
    maxdoancon=2000;
    fi='map.in1';
    fo='map.out';

type
    t_diem=array[1..2]of integer;

var f:text;
    n,sdc,dem,sodiem,sodoan:integer;
    t,key:array[1..maxtren]of integer;
    d:array[1..maxdiem]of t_diem;
    dt:array[1..maxdoan+1]of t_diem;
    bo:array[1..maxdoan]of boolean;
    dc:array[1..maxdoancon]of t_diem;

procedure themcanh(x,y:integer);
begin
   inc(sodoan);
   dt[sodoan,1]:=x;
   dt[sodoan,2]:=y;
end;

procedure bocanh(i:integer);
begin
   move(dt[i+1],dt[i],(sodoan-i)*sizeof(dt[1]));
   dec(sodoan);
end;

function tendiem(x,y:integer):integer;
var i:integer;
begin
   for i:=1 to sodiem do
      if (d[i,1]=x) and (d[i,2]=y) then
         begin
            tendiem:=i;
            exit;
         end;
   inc(sodiem);
   tendiem:=sodiem;
   d[sodiem,1]:=x;
   d[sodiem,2]:=y;
end;

procedure themdagiac;
var x,y,tg1,tg2,phu:integer;
begin
   read(f,x,y);
   tg1:=tendiem(x,y);
   phu:=tg1;
   while not seekeoln(f) do
      begin
         read(f,x,y);
         tg2:=tendiem(x,y);
         themcanh(tg1,tg2);
         tg1:=tg2;
      end;
   themcanh(tg2,phu);
   readln(f);
end;

procedure nhap;
var i:integer;
begin
   assign(f,fi);
   reset(f);
   readln(f,n);
   for i:=1 to n do themdagiac;
   close(f);
end;

procedure doanthang(x1,y1,x2,y2:extended;var a,b,c:extended);
begin
   a:=y2-y1;
   b:=x1-x2;
   c:=-a*x1-b*y1;
end;

function tren(d:t_diem;a,b,c:extended):boolean;
begin
   tren:=abs(a*d[1]+b*d[2]+c)<dolech;
end;

function giua(d1,d2,d3:t_diem):boolean;
begin
   giua:=true;
   if (d1[1]=d3[1]) and (d3[1]=d2[1]) then
      begin
         if (d1[2]<d3[2]) and (d3[2]<d2[2]) then exit;
         if (d2[2]<d3[2]) and (d3[2]<d1[2]) then exit;
      end
   else
      begin
         if (d1[1]<d3[1]) and (d3[1]<d2[1]) then exit;
         if (d2[1]<d3[1]) and (d3[1]<d1[1]) then exit;
      end;
   giua:=false;
end;

procedure doi(var x,y:integer);
var z:integer;
begin
   z:=x;
   x:=y;
   y:=z;
end;

procedure quicksort(l,r:integer);
var i, j ,g : integer;
begin
   if l<r then
      begin
         i:=l;
         j:=r;
         g:=key[(l+r) div 2];
         repeat
            while key[i]<g do inc(i);
            while key[j]<g do dec(j);
            if i<=j then
               begin
                  doi(key[i],key[j]);
                  doi(t[i],t[j]);
                  inc(i);
                  dec(j);
               end;
         until i>j;
         quicksort(l,j);
         quicksort(i,r);
      end;
end;

function kc(x1,y1,x2,y2:extended):extended;
begin
   kc:=sqrt(sqr(x1-x2)+sqr(y1-y2));
end;

function khoangcanh(d1,d2:t_diem):extended;
begin
   khoangcanh:=kc(d1[1],d1[2],d2[1],d2[2]);
end;

procedure chianho;
var i,j:integer;
    a,b,c:extended;
    phu:t_diem;
begin
   for i:=1 to sodoan do
      begin
         dem:=0;
         doanthang(d[dt[i,1],1],d[dt[i,1],2],d[dt[i,2],1],d[dt[i,2],2],a,b,c);
         for j:=1 to sodiem do
            if tren(d[j],a,b,c) and giua(d[dt[i,1]],d[dt[i,2]],d[j]) then
               begin
                  inc(dem);
                  t[dem]:=j;
               end;
         if d[dt[i,1],1]=d[dt[i,2],1] then
            for j:=1 to dem do key[j]:=d[t[j],2]
         else
            for j:=1 to dem do key[j]:=d[t[j],1];
         quicksort(1,dem);
         if dem>0 then
            begin
               phu:=dt[i];
               bocanh(i);
               for j:=1 to dem-1 do themcanh(t[j],t[j+1]);
               if khoangcanh(d[phu[1]],d[t[1]])<khoangcanh(d[phu[1]],d[t[dem]]) then
                  begin
                     themcanh(phu[1],t[1]);
                     themcanh(phu[2],t[dem]);
                  end
               else
                  begin
                     themcanh(phu[1],t[dem]);
                     themcanh(phu[2],t[1]);
                  end
            end;

      end;
end;

function trung(x,y:integer):boolean;
begin
   trung:=((dt[x,1]=dt[y,1]) and (dt[x,2]=dt[y,2])) or ((dt[x,2]=dt[y,1]) and (dt[x,1]=dt[y,2]));
end;

procedure loaicanh;
var i,j:integer;
begin
   for i:=1 to sodoan do
      if not bo[i] then
         for j:=i+1 to sodoan do
            if trung(i,j) then
               begin
                  bo[j]:=true;
                  bo[i]:=true;
               end;
end;

procedure xuly;
begin
   chianho;
   loaicanh;
end;

procedure inra(i:integer);
var j:integer;
begin
   inc(dem);
   for j:=2 to sdc do
      if bo[j] then
         if dc[j,1]=i then
            begin
               bo[j]:=false;
               inra(dc[j,2]);
               write(f,d[i,1],' ',d[i,2],' ');
               exit;
            end
         else
            if dc[j,2]=i then
               begin
                  bo[j]:=false;
                  inra(dc[j,1]);
                  write(f,d[i,1],' ',d[i,2],' ');
                  exit;
               end;
   writeln(f,dem);
   write(f,d[dc[1,1],1],' ',d[dc[1,1],2],' ');
end;

procedure inkq;
var i:integer;
begin
   assign(f,fo);
   rewrite(f);

   for i:=1 to sodoan do
      if not bo[i] then
         begin
            inc(sdc);
            dc[sdc]:=dt[i];
         end;
   fillchar(bo,sizeof(bo),1);
   inra(dc[1,2]);
   close(f);
end;

Begin
   clrscr;
   nhap;
   xuly;
   inkq;
End.

3
4 3 2 5 5 6 7 4 6 3
4 1 2 2 4 3
4 1 4 3 6 3 7 4 7 1

4
0 0 2 3 2 6 1 5
2 3 4 5 2 6
2 3 4 3 4 5
2 3 4 2 4 3

2
0 0   0 1   3 1   3 0
1 1   1 2   2 2   2 1

2
1 2   1 3   3 3   3 2
1 1   1 2   4 2   4 1

