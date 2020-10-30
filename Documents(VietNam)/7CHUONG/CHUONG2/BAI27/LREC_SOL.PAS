(*   Giai bai: Xay dung bang  *)
uses crt;
const
    fin: string = 'LREC.IN0';
    fou: string = 'LREC.OUT';
var
   a, b: array[1..100,1..100] of byte;
   tho,viec,truoc: array[1..100] of integer;
   k,m,n,x0,y0,max:integer;
   PathFound, stop: boolean;
   f: text;

procedure Nhapdl;
var i, j, t: integer;
    f: text;
begin
    fillchar(a, sizeof(a), 1);
    assign(f,fin); reset(f);
    readln(f,m,n,k);
    for i:=1 to m do
       for j:=1 to n do
       begin
         read(f,t);
         a[j,t]:=0;
         b[i,j]:=t;
       end;
    close(f);
end;

procedure Tang;
var   t,x,y:integer;
begin
    max:=max+1;
    y:=y0;
    while truoc[y]<>x0 do
    begin
        x:=truoc[y];
        tho[y]:=x;
        t:=viec[x];
        viec[x]:=y;
        y:=t;
    end;
    tho[y]:=x0; viec[x0]:=y;
end;


procedure FindPath(x:integer);
var y:integer;
begin
    for y:=1 to n do
       if (truoc[y]=0) and (a[x,y]=1) then
       begin
           truoc[y]:=x;
           if tho[y]=0 then
           begin
               y0:=y;
               Pathfound:=true;
               exit;
           end
           else FindPath(Tho[y]);
           if PathFound then exit;
       end;
end;

procedure Matching;
var x,y:integer;
begin
    for x:=1 to n do Viec[x]:=0;
    for y:=1 to n do Tho[y]:=0;
    max:=0;
    stop:=false;
    while not stop do
    begin
        PathFound:=false;
        for y:=1 to n do truoc[y]:=0;
        x:=1;
        while not Pathfound and (x<=n) do
        begin
           if viec[x]=0 then
           begin
               x0:=x;
               FindPath(x);
           end;
           x:=x+1;
        end;
       if pathfound then Tang else stop:=true;
    end;
end;

procedure Inkq;
var i,j:integer;
begin
    assign(f,fou); rewrite(f);
    for i:=m-k+1 to m do
    begin
        for j:=1 to n-1 do write(f,b[i,j],' ');
        writeln(f,b[i,n]);
    end;
    close(f);
end;

procedure Solve;
var kb, i, j: integer;
begin
    kb:=0;
    repeat
       kb:=kb+1;
       Matching;
       for j:=1 to n do a[j,viec[j]]:=0;
       m:=m+1;
       for j:=1 to n do b[m,j]:=viec[j];
    until kb=k;
end;

BEGIN
    Nhapdl;
    Solve;
    Inkq;
    writeln('Ket qua da ghi ra file: ',fou);
{    readln;}
END.



4 4
1 3 4
2 4
1
2 4





2 4 1
1 2 3 4
4 3 2 1