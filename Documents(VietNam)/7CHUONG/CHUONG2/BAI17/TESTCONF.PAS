(****************************************************************)
(**           Chuong trinh cham bai To chuc Hoi thao           **)
(****************************************************************)
uses crt;
const
   max = 110;
   Finp: string = 'CONF.IN';
   Fout: string = 'CONF.OUT';
   dapso: array['1'..'6'] of integer = (505, 404, 349,231, 156, 27);
type
   arr1 =  array [1..max] of byte;
   arr2 =  array [1..max] of longint;
var
    f            : text;
    name         : string[20];
    diem, sA,sB,sC,i,j,k,n,m,s,t: integer;
    chon         : char;
    predA, PredB, PredC : arr1;
    cost, disA, disB, disC  : arr2;
    a, b   : array [1..max,1..max] of integer;
    final: array [1..max] of boolean;
    min: longint;

procedure ReadFile;
var i,j,k,t: integer;
begin
   assign(f,finp);reset(f);readln(f,n,m);
   for i:= 1 to n do
      for j:= 1 to n do a[i,j]:=maxint;
   for k:=1 to m do
   begin
      read(f,i,j,t); a[i,j]:=t; a[j,i]:=t;
   end;
   for i:=1 to n do a[i,i]:=0;
   readln(f,sA,sB, sC);
   close(f);
end;

procedure DFS(v: integer);
var i: integer;
begin
    predA[v]:=1;
    for i:=1 to n do
       if (predA[i]=0) and (b[v,i]=1) then DFS(i);
end;

procedure Eval;
var i,j,k,u,v: integer;
    scp, s1: longint;
begin
    diem:=0;
    readfile;
    assign(f,fout); reset(f);
    readln(f,scp,k);
    if scp>dapso[chon] then
    begin
        writeln('ERROR: Khong toi uu: ',scp,' > ',dapso[chon]);
        readln; close(f); exit;
    end;
    fillchar(b,sizeof(b),0); s1:=0;
    for i:=1 to k do
    begin
        readln(f,u,v);
        if (u<=0) or (u>n) or (v<=0) or (v>n) or (a[u,v]=maxint) then
        begin
            writeln('ERROR:  Khong co kenh ',u,' --> ',v);
            readln; close(f); exit;
        end;
        b[u,v]:=1; b[v,u]:=1;s1:=s1+a[u,v];
    end;
    close(f);
    if s1<>scp then
    begin
        writeln('ERROR:  Tinh tong chi phi khong khop!!! ',scp,' <> ',s1);
        readln; exit;
    end;
    fillchar(predA,sizeof(predA),0);
    DFS(sA);
    if predA[sB]=0 then
    begin
        writeln('ERROR: Khong co duong truyen tin tu ',sA,' den ',sb);
        writeln('       tren he thong kenh duoc chon!!!');
        readln; exit;
    end;
    if predA[sC]=0 then
    begin
        writeln('ERROR: Khong co duong truyen tin tu ',sA,' den ',sC);
        writeln('       tren he thong kenh duoc chon!!!');
        readln; exit;
    end;
    diem:=2;
end;

BEGIN
   clrscr;
   writeln('        CHUONG TRINH CHAM BAI TO CHUC HOI THAO');
   writeln('               ********************');
   write('Cho ten file test: CONF.IN');
   chon:=readkey; writeln(chon);
   finp:='CONF.IN'+chon;
   Eval;
   writeln;
   writeln('***************************');
   writeln('      Diem:  ', diem);
   writeln('***************************');readln;

END.

8  12
1 2 20
2 3 8
2 4 3
2 5 3
2 6 6
3 5 2
3 6 9
4 7 5
5 6 1
5 7 7
6 8 4
7 8 6
1 4 6
