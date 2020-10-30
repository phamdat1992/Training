uses crt;
var
   a, b: array[1..100,1..100] of byte;
   tho,viec,truoc: array[1..100] of integer;
   k,m,n,x0,y0,max:integer;
   PathFound, stop: boolean;

procedure Sinh;
var x,y:integer;
begin
    write(' Cho m, n = ');readln(m,n);
    fillchar(a,sizeof(a),1);
    writeln('MA TRAN KE: ');
    for x:=1 to n do
    begin
        for y:=1 to n do write(a[x,y]:2);
        writeln;
    end;
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
var x,i,j:integer;
begin
    writeln('Cach phan cong:');
    for x:=1 to n do
       if viec[x]<>0 then
          writeln('Tho ',x:3,' thuc hien viec ',viec[x]:3);
    writeln('Tong so cong viec duoc thuc hien: ',max);

    for i:=1 to n do b[k,i]:= viec[i];
    writeln('Dong thu ',k);
    for i:=1 to n do write(b[k,i]:4); writeln;
    for i:=1 to n do
       for j:=1 to n do a[i,b[k,i]]:=0;
end;

procedure Indl;
var i,j: integer;
    f: text;
begin
    assign(f,'LREC.IN0'); rewrite(f);
    writeln(f,m,' ',n, ' ',random(n-m)+1);
    for i:=1 to m do
    begin
        for j:=1 to n-1 do write(f,b[i,j],' ');
        writeln(f, b[i,n]);
    end;
    close(f);
end;


BEGIN
    Sinh;
    k:=0;
    repeat
       k:=k+1;
       Matching;
       Inkq;
    until k=m;
    Indl;
END.



4 4
1 3 4
2 4
1
2 4





